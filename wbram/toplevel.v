////////////////////////////////////////////////////////////////////////////////
//
// Filename:	./toplevel.v
//
// Project:	ZipSTORM-MX, an iCE40 ZipCPU demonstration project
//
// Creator:	Dan Gisselquist, Ph.D.
//		Gisselquist Technology, LLC
//
// Edited by Lawrie Griffiths to convert to an SDRAM tester
//
////////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2019, Gisselquist Technology, LLC
//
// This program is free software (firmware): you can redistribute it and/or
// modify it under the terms of  the GNU General Public License as published
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

module	toplevel(i_clk,
		// Top level SDRAM I/O ports
		o_ram_clk, o_ram_cke, o_ram_cs_n, o_ram_ras_n, o_ram_cas_n,
		o_ram_we_n, o_ram_addr, o_ram_udqm, o_ram_ldqm,
		io_ram_data,
	        o_diag, o_led);
	input	wire		i_clk;
	// SDRAM
	output	wire	o_ram_clk, o_ram_cke,
			o_ram_cs_n, o_ram_ras_n, o_ram_cas_n, o_ram_we_n;
	output	wire	[11:0]	o_ram_addr;
	output	wire		o_ram_udqm, o_ram_ldqm;
	inout	wire	[15:0]	io_ram_data;
	output  reg      [7:0]  o_diag;
	output  reg      [3:0]  o_led;

	//
	// Declaring component data, internal wires and registers
	//
	wire		s_clk, s_reset, pll_locked, clk_50mhz;
	// SDRAM data wires
	wire	[15:0]	w_ram_data, w_ram_data_pedge, w_ram_data_nedge,
			i_ram_data;
	wire		w_ram_drive_data,
			w_ram_cs_n, w_ram_ras_n, w_ram_cas_n, w_ram_we_n;
	wire	[11:0]	w_ram_addr;
	wire	[1:0]	w_ram_dqm;
	wire	[1:0]	w_ramclk_in_ignored;
	wire	[35:0]	w_ramctrl_in_ignored;

	SB_PLL40_CORE #(
		.FEEDBACK_PATH("SIMPLE"),
		.DELAY_ADJUSTMENT_MODE_FEEDBACK("FIXED"),
		.DELAY_ADJUSTMENT_MODE_RELATIVE("FIXED"),
		.PLLOUT_SELECT("GENCLK"),
		.FDA_FEEDBACK(4'b1111),
		.FDA_RELATIVE(4'b1111),
		.DIVR(4'd0),		// Divide by (DIVR+1)
		.DIVQ(3'd4),		// Divide by 2^(DIVQ)
		.DIVF(7'd40),		// Multiply by (DIVF+1)
		.FILTER_RANGE(3'b010)
	) plli (
		// .PACKAGEPIN     (i_clk     ),
		.REFERENCECLK   (i_clk     ),
		.PLLOUTCORE     (clk_50mhz ),
		.LOCK           (pll_locked),
		.BYPASS         (1'b0      ),
		.RESETB         (1'b1      )
	);

	SB_GB global_buffer(clk_50mhz, s_clk);

	// Wishbone master wire definitions
	reg		wb_cyc, wb_stb, wb_we;
	reg	[18:0]	wb_addr;
	reg	[31:0]	wb_data;
	reg	[3:0]	wb_sel;

	// Wishbone slave definitions for bus wb, slave sdram
	wire		sdram_sel, sdram_ack, sdram_stall;
	wire	[31:0]	sdram_data;

	// SDRAM
	//
	wire	[31:0]	sdram_debug;
	wire	[31:0]	sdram_refresh_counts;

	//
	// Tri-state logic for the SDRAM
	//
	iceioddr
	ramck(s_clk, 1'b1, 2'b01, w_ramclk_in_ignored, o_ram_clk);

	iceioddr #(.WIDTH(4+12+2))
	ramctrl(s_clk, 1'b1,
		{(2){ w_ram_cs_n, w_ram_ras_n, w_ram_cas_n, w_ram_we_n,
		w_ram_addr, w_ram_dqm }},
		w_ramctrl_in_ignored,
		{ o_ram_cs_n, o_ram_ras_n, o_ram_cas_n, o_ram_we_n,
		o_ram_addr, o_ram_udqm, o_ram_ldqm });

	iceioddr #(.WIDTH(16))
	ramio(s_clk, w_ram_drive_data, { w_ram_data, w_ram_data },
		{ w_ram_data_pedge, w_ram_data_nedge },
		io_ram_data);

	assign	i_ram_data = w_ram_data_nedge;

	reg        writing = 1;
	reg        err     = 0;
	reg        valid   = 0;
	reg [10:0] delay_counter = 0;
        reg [31:0] cycle_counter = 0;
	reg [31:0] start_count;

	// Write to ram and read back
	always @(posedge s_clk) begin
		cycle_counter <= cycle_counter + 1;
		o_led <= ~{err, 1'b0, valid, writing};
		if (wb_stb) begin // request in progress
			if (!sdram_stall) begin
				wb_stb <= 0;
				if (sdram_ack) wb_cyc <= 0;
			end
	        end else if (wb_cyc) begin // waiting
			if (sdram_ack) begin 
				wb_cyc <= 0;
				if (!writing) begin
					o_diag <= sdram_data[18:11];
				        if (sdram_data != wb_addr) err = 1;
				end
		        	wb_addr <= wb_addr + 1;
				if (&wb_addr) begin
					writing <= 0;
					if (!writing && !err) valid = 1;
				end
		        end
		end else begin // idle
			delay_counter <= delay_counter + 1;
			if (writing || &delay_counter) begin
				wb_cyc <= 1;
				wb_stb <= 1;
				wb_sel <= 4'b1111;
				wb_we <= writing;
				// Write the 19-bit address to each word
		        	wb_data <= wb_addr;
				// Switch to reading when all data written
				start_count <= cycle_counter;
			end
		end
	end

	assign sdram_sel = 1;

	wbsdram #(.CLOCK_FREQUENCY_HZ(64000000))
	sdram(s_clk,
		wb_cyc, (wb_stb)&&(sdram_sel),
		wb_we, wb_addr, wb_data, wb_sel,
		sdram_ack, sdram_stall, sdram_data,
		w_ram_cs_n, o_ram_cke, w_ram_ras_n, w_ram_cas_n, w_ram_we_n,
		w_ram_addr, w_ram_drive_data,
		i_ram_data, w_ram_data, w_ram_dqm,
		sdram_debug,
		sdram_refresh_counts);
endmodule

