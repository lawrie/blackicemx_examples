////////////////////////////////////////////////////////////////////////////////
//
// Filename: 	wbsdram.v
//
// Project:	ZipSTORM-MX, an iCE40 ZipCPU demonstration project
//
// Purpose:	Provide 32-bit wishbone access to the SDRAM memory on a XuLA2
//		LX-25 board.  Specifically, on each access, the controller will
//	activate an appropriate bank of RAM (the SDRAM has four banks), and
//	then issue the read/write command.  In the case of walking off the
//	bank, the controller will activate the next bank before you get to it.
//	Upon concluding any wishbone access, all banks will be precharged and
//	returned to idle.
//
//	This particular implementation represents a second generation version
//	because my first version was too complex.  To speed things up, this
//	version includes an extra wait state where the wishbone inputs are
//	clocked into a flip flop before any action is taken on them.
//
// Creator:	Dan Gisselquist, Ph.D.
//		Gisselquist Technology, LLC
//
////////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2019, Gisselquist Technology, LLC
//
// This program is free software (firmware): you can redistribute it and/or
// modify it under the terms of the GNU General Public License as published
// by the Free Software Foundation, either version 3 of the License, or (at
// your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
// for more details.
//
// You should have received a copy of the GNU General Public License along
// with this program.  (It's in the $(ROOT)/doc directory.  Run make with no
// target there if the PDF file isn't present.)  If not, see
// <http://www.gnu.org/licenses/> for a copy.
//
// License:	GPL, v3, as defined and found on www.gnu.org,
//		http://www.gnu.org/licenses/gpl.html
//
//
////////////////////////////////////////////////////////////////////////////////
//
//
`default_nettype	none
//
`define	DMOD_GETINPUT	1'b0
`define	DMOD_PUTOUTPUT	1'b1
`define	RAM_OPERATIONAL	2'b00
`define	RAM_POWER_UP	2'b01
`define	RAM_SET_MODE	2'b10
`define	RAM_INITIAL_REFRESH	2'b11
//
module	wbsdram(i_clk,
		i_wb_cyc, i_wb_stb, i_wb_we, i_wb_addr, i_wb_data, i_wb_sel,
		o_wb_ack, o_wb_stall, o_wb_data,
		o_ram_cs_n, o_ram_cke, o_ram_ras_n, o_ram_cas_n, o_ram_we_n,
		o_ram_addr, o_ram_dmod,
		i_ram_data, o_ram_data, o_ram_dqm,
		o_debug,
		o_refresh_counts);
	parameter [31:0]	CLOCK_FREQUENCY_HZ = 32'd50_000_000;
	localparam	AW=21-2, DW=32;
	input	wire			i_clk;
	// Wishbone
	//	inputs
	input	wire			i_wb_cyc, i_wb_stb, i_wb_we;
	input	wire	[(AW-1):0]	i_wb_addr;
	input	wire	[(DW-1):0]	i_wb_data;
	input	wire	[(DW/8-1):0]	i_wb_sel;
	//	outputs
	output	wire		o_wb_ack;
	output	reg		o_wb_stall;
	output	reg [DW-1:0]	o_wb_data;
	// SDRAM control
	output	wire		o_ram_cs_n, o_ram_cke,
				o_ram_ras_n, o_ram_cas_n, o_ram_we_n;
	output	reg	[11:0]	o_ram_addr;
	output	reg		o_ram_dmod;
	input		[15:0]	i_ram_data;
	output	reg	[15:0]	o_ram_data;
	output	reg	[1:0]	o_ram_dqm;
	//
	output	wire [(DW-1):0]	o_debug;
	output	reg [(DW-1):0]	o_refresh_counts;

	reg	[31:0]	r_refresh_counts;
	always @(posedge i_clk)
	if (o_cmd == CMD_REFRESH)
		r_refresh_counts <= 0;
	else if (!(&r_refresh_counts))
		r_refresh_counts <= r_refresh_counts + 1;

	initial	o_refresh_counts = 0;
	always @(posedge i_clk)
	if (o_cmd == CMD_REFRESH)
		o_refresh_counts <= r_refresh_counts;
	else if (&r_refresh_counts)
		o_refresh_counts <= r_refresh_counts;

	//
	// Commands
	//
	localparam [3:0]	CMD_SET_MODE  = 4'h0;
	localparam [3:0]	CMD_REFRESH   = 4'h1;
	localparam [3:0]	CMD_PRECHARGE = 4'h2;
	localparam [3:0]	CMD_ACTIVATE  = 4'h3;
	localparam [3:0]	CMD_WRITE     = 4'h4;
	localparam [3:0]	CMD_READ      = 4'h5;
	localparam [3:0]	CMD_NOOP      = 4'h7;

	// Calculate some metrics

	//
	// CK_REFRESH is the number of clocks between refresh cycles
	//   Here we calculate it for 2048 refresh cycles every 32ms
	//   This is consistent with speed grade A1, and should come
	//   out to about 780 cycles between refreshes for a 50MHz clock
	localparam	CK_REFRESH = ((CLOCK_FREQUENCY_HZ/1000) * 16 / 2048)-1;
	// CAS_LATENCY is the clocks between the (read) command and the read
	// data.  There must be at least one idle cycle between write data
	// and read data.
	localparam	CAS_LATENCY = 2;	// tCAC
	localparam	ACTIVE_TO_RW = 4,	// tRCD
			CK_RCD = ACTIVE_TO_RW;
	localparam	RAS_LATENCY = 4;
	localparam	CK_RC  = 6; // Command period, REF to REF/ACT to ACT
	localparam	CK_RAS = 4; // Cmd period, ACT to PRE
	localparam	CK_RP  = 2; // Cmd period, PRE to ACT
	localparam	CK_RRD = 2; // Cmd period, ACT[0] to ACT[1]
	localparam	CK_DPL = 2; // Input data to precharge time
	localparam	CK_DAL = 2+CK_RP; // Input data to active/refresh cmd dly time
	localparam	CK_RQL = 3; // Precharge cmd to out in High Z time
	localparam	CK_QMD = 2; // DQM to output delay time (read)
	localparam	CK_MCD = 2; // Precharge cmd to out in High Z time
	//
	parameter	RDLY = CAS_LATENCY + 4;

	//
	// Register declarations
	//
	reg	[CK_RCD:0]	bank_active	[0:1];
	reg	[(RDLY-1):0]	r_barrell_ack;
	reg			r_pending, issued;
	reg			r_we;
	reg	[AW-1:0]	r_addr;
	reg	[DW-1:0]	r_data;
	reg	[DW/8-1:0]	r_sel;
	reg	[1:0]		nxt_sel;

	reg	[10:0]	bank_row	[0:1];
	reg		i_bank, r_bank, fwd_bank;
	reg	[7:0]	i_col,  r_col;
	reg	[10:0]	i_row,  r_row,  fwd_row;

	reg	[2:0]		clocks_til_idle;
	wire			bus_cyc;
	reg			nxt_dmod;
	wire			pending;
	reg	[AW-1:0]	fwd_addr;
	reg	[3:0]		o_cmd;

	////////////////////////////////////////////////////////////////////////
	//
	// Refresh logic
	//
	////////////////////////////////////////////////////////////////////////
	//
	//
	// First, do we *need* a refresh now --- i.e., must we break out of
	// whatever we are doing to issue a refresh command?
	//
	// The step size here must be such that 8192 charges may be done in
	// 64 ms.  Thus for a clock of:
	//	ClkRate(MHz)	(64ms/1000(ms/s)*ClkRate)/8192
	//	100 MHz		781
	//	 96 MHz		750
	//	 92 MHz		718
	//	 88 MHz		687
	//	 84 MHz		656
	//	 80 MHz		625
	//
	// However, since we do two refresh cycles everytime we need a refresh,
	// this standard is close to overkill--but we'll use it anyway.  At
	// some later time we should address this, once we are entirely
	// convinced that the memory is otherwise working without failure.  Of
	// course, at that time, it may no longer be a priority ...
	//
	// Second, do we *need* a precharge now --- must be break out of
	// whatever we are doing to issue a precharge command?
	//
	// Keep in mind, the number of clocks to wait has to be reduced by
	// the amount of time it may take us to go into a precharge state.
	// You may also notice that the precharge requirement is tighter
	// than this one, so ... perhaps this isn't as required?
	//

	assign	bus_cyc  = ((i_wb_cyc)&&(i_wb_stb)&&(!o_wb_stall));

	always @(*)
	begin
		issued = 0;
		if (!nxt_dmod && !refresh_stall
			&& r_bank_valid && &bank_active[r_bank][CK_RCD:1])
		begin
			if (r_we)
				issued = (clocks_til_idle <= 1);
			else
				issued = (clocks_til_idle < 5);
		end
		if (maintenance_mode || !r_pending || !i_wb_cyc)
			issued = 1'b0;
	end
	
	// Pre-process pending operations
	initial	r_pending = 1'b0;
	initial	r_addr = 0;
	
	always @(posedge i_clk)
	if (bus_cyc)
	begin
		r_pending <= 1'b1;
		r_we      <= i_wb_we;
		r_addr    <= i_wb_addr;
		r_data    <= i_wb_data;
		r_sel     <= i_wb_sel;
		fwd_addr  <= i_wb_addr + { {(AW-4){1'b0}}, 2'b11, 2'b00 };
	end else if (issued)
		r_pending <= 1'b0;
	else if (!i_wb_cyc)
		r_pending <= 1'b0;

	always @(*)
	begin
		i_row  = i_wb_addr[AW-1:8];	// 18:8
		i_bank = i_wb_addr[7];
		i_col  = { i_wb_addr[6:0], 1'b0 };
		r_row  = r_addr[AW-1:8];	// 18:8
		r_bank = r_addr[7];
		r_col  = { r_addr[6:0], 1'b0 };
		fwd_row = fwd_addr[AW-1:8];
		fwd_bank= fwd_addr[7];
	end
	
	reg	r_bank_valid;
	reg	fwd_bank_valid;
	always @(posedge i_clk)
	if (bus_cyc)
		r_bank_valid <=((bank_active[i_bank][CK_RCD])
			&&(bank_row[i_bank]==i_row));
	else
		r_bank_valid <= ((bank_active[r_bank][CK_RCD])
				&&(bank_row[r_bank]==r_row));
	initial	fwd_bank_valid = 0;
	always @(posedge i_clk)
		fwd_bank_valid <= ((bank_active[fwd_bank][CK_RCD])
				&&(bank_row[fwd_bank]==fwd_row));
	assign	pending = (r_pending)&&(o_wb_stall);
	//
	//
	// Maintenance mode (i.e. startup) wires and logic
	reg		maintenance_mode;
	reg	[3:0]	maintenance_cmd;
	reg	[11:0]	maintenance_addr;
	wire	[3:0]	refresh_cmd, reset_command;
	wire		reset_active, reset_addr10;
	wire		refresh_active, refresh_stall;
	//
	//
	//
	// Address MAP:
	//	23-bits bits in, 24-bits out
	//
	//	222 1111 1111 1100 0000 0000
	//	210 9876 5432 1098 7654 3210
	//	rrr rrrr rrrr rrBB cccc cccc 0
	//	                   8765 4321 0
	//
	initial r_barrell_ack = 0;
	initial	clocks_til_idle = 3'h0;
	initial o_wb_stall = 1'b1;
	initial	o_cmd = CMD_NOOP;
	initial	o_ram_dqm   = 2'b11;
	assign	o_ram_cke   = 1'b1;
	initial bank_active[0] = 0;
	initial bank_active[1] = 0;
	always @(posedge i_clk)
	if (maintenance_mode)
	begin
		bank_active[0] <= 0;
		bank_active[1] <= 0;
		r_barrell_ack[(RDLY-1):0] <= (r_barrell_ack >> 1);
		if (!i_wb_cyc)
			r_barrell_ack <= 0;
		o_wb_stall  <= 1'b1;
		o_cmd <= maintenance_cmd;
		o_ram_addr  <= maintenance_addr;
	end else begin
		o_ram_addr <= 0;
		o_wb_stall <= (r_pending && (o_cmd != CMD_READ) &&(o_cmd != CMD_WRITE))||(bus_cyc);
		r_barrell_ack <= r_barrell_ack >> 1;
		//
		// We assume that, whatever state the bank is in, that it
		// continues in that state and set up a series of shift
		// registers to contain that information.  If it will not
		// continue in that state, all that therefore needs to be
		// done is to set bank_active[?][2] below.
		//
		bank_active[0] <= { bank_active[0][CK_RCD], bank_active[0][CK_RCD:1] };
		bank_active[1] <= { bank_active[1][CK_RCD], bank_active[1][CK_RCD:1] };
		//
		if (|clocks_til_idle)
			clocks_til_idle <= clocks_til_idle - 3'h1;
		// Default command is a
		//	NOOP if (i_wb_cyc)
		//	Device deselect if (!i_wb_cyc)
		o_cmd <= CMD_NOOP;
		o_cmd[3] <= 1'b1; // Deselect CS
		if (r_pending && !r_bank_valid)
		begin
			o_ram_addr  <= { r_bank, r_row };
			if (bank_active[r_bank][0])
				// Precharge the selected bank
				o_ram_addr[10] <= 1'b0;
		end else if (issued)
		begin
			o_ram_addr <= { r_bank, 3'b0, r_col };
		end 
		if (refresh_stall)
			;
		else if ((r_pending)&&(!r_bank_valid))
		begin
			if (bank_active[r_bank]==0)
			begin // Need to activate the requested bank
				o_cmd <= CMD_ACTIVATE;
				bank_active[r_bank][CK_RCD] <= 1'b1;
				bank_row[r_bank] <= r_row;
			end else if ((&bank_active[r_bank])
				&& clocks_til_idle[2:0] < 3'h1)
			begin // Need to close an active bank
				o_cmd <= CMD_PRECHARGE;
				bank_active[r_bank][CK_RCD:CK_RP-1] <= 0;
			end
		end else if (pending && &bank_active[r_bank][CK_RCD:1]
				// && r_bank_valid
				&& ((!r_we && clocks_til_idle < 5)
				   ||(r_we && clocks_til_idle <= 1)))
		begin
			if (r_we)
			begin
				o_cmd <= CMD_WRITE;
				clocks_til_idle <= 2;
				r_barrell_ack[1] <= 1'b1;
			end else begin
				o_cmd <= CMD_READ;
				clocks_til_idle <= 5;
				r_barrell_ack[(RDLY-1)] <= 1'b1;
			end
			o_wb_stall <= 1'b0;
			o_cmd[3] <= !i_wb_cyc;
		end 
		if (refresh_stall)
			o_wb_stall <= 1;
		if (!i_wb_cyc)
			r_barrell_ack <= 0;
	end
	assign	o_ram_cs_n  = o_cmd[3];
	assign	o_ram_ras_n = o_cmd[2];
	assign	o_ram_cas_n = o_cmd[1];
	assign	o_ram_we_n  = o_cmd[0];
	localparam	CK_STARTUP_WAIT = CLOCK_FREQUENCY_HZ / 10_000;
	reg					startup_hold;
	reg	[$clog2(CK_STARTUP_WAIT)-1:0]	startup_idle;
	
	initial	startup_idle = CK_STARTUP_WAIT[$clog2(CK_STARTUP_WAIT)-1:0];
	initial	startup_hold = 1'b1;
	always @(posedge i_clk)
	if (|startup_idle)
		startup_idle <= startup_idle - 1'b1;
	always @(posedge i_clk)
		startup_hold <= |startup_idle;
	
	localparam [11:0] MODE_COMMAND =
			{ 5'b00000,	// Burst reads and writes
			CAS_LATENCY[2:0],// CAS latency (3 clocks)
			1'b0,		// Sequential (not interleaved)
			3'b001		// 32-bit burst length
			};
	genuctrl #(
		.CMDWIDTH(1+4+1),
		.LGDELAY(4),
		.LGNCMDS(4),
		.OPT_REPEAT(0),
		.COMMANDS({
		// Read these commands from the bottom up
		{ 1'b0, 1'b0, CMD_NOOP,      MODE_COMMAND[10] },
		{ 1'b0, 1'b0, CMD_NOOP,      MODE_COMMAND[10] },
		{ 1'b0, 1'b0, CMD_NOOP,      MODE_COMMAND[10] },
		{ 1'b0, 1'b0, CMD_NOOP,      MODE_COMMAND[10] },
		//
		// Need two cycles following SET_MODE before the first
		// command
		{ 1'b0, 1'b1, CMD_NOOP,      MODE_COMMAND[10] },
		{ 1'b0, 1'b1, CMD_SET_MODE,  MODE_COMMAND[10] },
		{ 1'b1, 2'b00, 4'h6 },
		{ 1'b0, 1'b1, CMD_NOOP,      MODE_COMMAND[10] },
		{ 1'b0, 1'b1, CMD_REFRESH,   MODE_COMMAND[10] },
		{ 1'b1, 2'b00, 4'h6 },
		{ 1'b0, 1'b1, CMD_NOOP,      MODE_COMMAND[10] },
		{ 1'b0, 1'b1, CMD_REFRESH,   MODE_COMMAND[10] },
		{ 1'b1, 2'b00, 4'h0 },
		{ 1'b0, 1'b1, CMD_NOOP,      MODE_COMMAND[10] },
		{ 1'b0, 1'b1, CMD_PRECHARGE, 1'b1 },
		// The command list starts here, with a no-op then precharge
		{ 1'b0, 1'b1, CMD_NOOP,      MODE_COMMAND[10] }
		})
	) reset_controller(i_clk, startup_hold,
		{ reset_active, reset_command, reset_addr10 });
	localparam	LGREF = $clog2(CK_REFRESH);
	// verilator lint_off WIDTH
	localparam [LGREF-1:0]	CK_WAIT_FOR_IDLE = 4,
			CK_PRECHARGE_TO_REFRESH = CK_RP-1,
			CK_REFRESH_NOOP_TO_ACTIVATE= CK_RC-2,
			CK_REMAINING=CK_REFRESH
				- CK_WAIT_FOR_IDLE
				- CK_PRECHARGE_TO_REFRESH
				- CK_REFRESH_NOOP_TO_ACTIVATE
				- 15;
	// verilator lint_on  WIDTH
	localparam [LGREF-6-1:0]	REF_ZEROS = 0;
	genuctrl #(
		.CMDWIDTH(1+4+1),
		.LGDELAY(LGREF),
		.LGNCMDS(4),
		.OPT_REPEAT(1),
		.COMMANDS({
		// Read these commands from the bottom up
		{ 1'b0, REF_ZEROS, 2'b00, CMD_NOOP },
		{ 1'b0, REF_ZEROS, 2'b00, CMD_NOOP },
		{ 1'b0, REF_ZEROS, 2'b00, CMD_NOOP },
		{ 1'b0, REF_ZEROS, 2'b00, CMD_NOOP },
		{ 1'b0, REF_ZEROS, 2'b00, CMD_NOOP },
		{ 1'b0, REF_ZEROS, 2'b00, CMD_NOOP },
		//
		{ 1'b1, CK_REFRESH_NOOP_TO_ACTIVATE },
		{ 1'b0, REF_ZEROS, 2'b11, CMD_NOOP },
		{ 1'b0, REF_ZEROS, 2'b11, CMD_REFRESH },
		{ 1'b1, CK_PRECHARGE_TO_REFRESH },
		{ 1'b0, REF_ZEROS, 2'b11, CMD_NOOP },
		{ 1'b0, REF_ZEROS, 2'b11, CMD_PRECHARGE },
		{ 1'b1, CK_WAIT_FOR_IDLE },
		{ 1'b0, REF_ZEROS, 2'b01, CMD_NOOP },
		{ 1'b1, CK_REMAINING },
		{ 1'b0, REF_ZEROS, 2'b00, CMD_NOOP }
		})
	) refresh_controller(i_clk, reset_active,
		{ refresh_active, refresh_stall, refresh_cmd });
	initial	maintenance_mode = 1;
	initial	maintenance_cmd = CMD_NOOP;
	always @(posedge i_clk)
	begin
		if (reset_active)
		begin
			maintenance_mode <= 1;
			maintenance_cmd  <= reset_command;
		end else if (refresh_active)
		begin
			maintenance_mode <= 1;
			maintenance_cmd  <= refresh_cmd;
		end else begin
			maintenance_mode <= 0;
			maintenance_cmd <= CMD_NOOP;
		end
		maintenance_addr <= MODE_COMMAND;
		maintenance_addr[10] <= (reset_active) ? reset_addr10
				: 1'b1;
	end
	initial	o_ram_dmod = `DMOD_GETINPUT;
	initial	nxt_dmod = `DMOD_GETINPUT;
	always @(posedge i_clk)
	if (issued && r_we)
	begin
		o_ram_dmod <= `DMOD_PUTOUTPUT;
		nxt_dmod <= `DMOD_PUTOUTPUT;
	end else begin
		nxt_dmod <= `DMOD_GETINPUT;
		o_ram_dmod <= nxt_dmod;
	end
	always @(posedge i_clk)
	if (nxt_dmod)
		o_ram_data <= r_data[15:0];
	else if (issued && r_we)
		o_ram_data <= r_data[DW-1:16];
	else
		o_ram_data <= 0;
	initial	nxt_sel = 2'b11;
	always @(posedge i_clk)
		nxt_sel <= r_sel[1:0];
	always @(posedge i_clk)
	if (maintenance_mode)
		o_ram_dqm <= 2'b11;
	else if (o_cmd == CMD_WRITE)
		o_ram_dqm <= ~nxt_sel;
	else if (!r_we)
		o_ram_dqm <= 2'b00;
	else if (bank_active[r_bank][CK_RCD]
			&& r_bank_valid && clocks_til_idle <= 1)
		o_ram_dqm <= ~r_sel[3:2];
	else
		o_ram_dqm <= 2'b00;
	assign	o_wb_ack  = r_barrell_ack[0];
	always @(posedge i_clk)
		o_wb_data <= { o_wb_data[15:0], i_ram_data };

endmodule
