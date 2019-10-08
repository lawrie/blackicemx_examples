module ramtest (
  input clk_25M,

  inout      [15:0] sd_data,    // 16 bit bidirectional data bus
  output     [10:0] sd_addr,    // 11 bit multiplexed address bus
  output     [1:0]  sd_dqm,     // two byte masks
  output     [0:0]  sd_ba,      // two banks
  output            sd_cs,      // a single chip select
  output            sd_we,      // write enable
  output            sd_ras,     // row address select
  output            sd_cas,     // columns address select
  output            sd_cke,     // clock enable
  output            sd_clk,     // sdram clock

  output      [7:0] diag,       // diagnostic leds
  output      [3:0] led         // colored leds
);

  // 64Mhz clock from PLL
  reg clk;
  reg locked;

  pll pll_i (
    .clock_in(clk_25M),
    .clock_out(clk),
    .locked(locked)
  );

  // Set SDRAM clock to 64Mhz and clock enable true
  assign sd_clk = clk;
  assign sd_cke = 1;

  // 4Mhz clock for Gameboy CPU and 8Mhz clock for pixel clock
  reg       clk4;
  reg       clk8;
  reg [3:0] div = 0;

  always @(posedge clk) begin
    div <= div + 1'd1;
    clk8   <= !div[2:0];
    clk4   <= !div[3:0];
  end

  // Use SB_IO for tristate sd_data
  wire [15:0] sd_data_in;
  reg  [15:0] sd_data_out;
  reg         sd_data_dir;

  SB_IO #(
    .PIN_TYPE(6'b 1010_01),
    .PULLUP(1'b 0)
  ) ram [15:0] (
    .PACKAGE_PIN(sd_data),
    .OUTPUT_ENABLE(sd_data_dir),
    .D_OUT_0(sd_data_out),
    .D_IN_0(sd_data_in)
  );

  // RAM test 
  reg  [2:0] count;
  reg        we, oe;
  reg  [1:0] ds;
  reg [19:0] addr;
  reg [15:0] dout;
  reg [15:0] din;
  reg        reading = 0;
  reg        err = 0;
  reg        passed = 0;

  assign led = ~{err,  1'b0, passed, ~reading};
  assign diag = din[15:8];

  // 1 clock cycle of 8Mhz clock is a read or write
  // Write on even counts
  // Read on count 0
  // Refresh on other counts
  always @(posedge clk8) begin
    if (count > 0 && reading && din != addr[19:4]) begin 
      err <= 1;
    end
    ds <= 2'b11;
    count <= count + 1;
    dout <= addr[19:4]; // Set data to top of address
    we <= (count[0] == 0 && !reading);
    oe <= (count == 0 && reading);
    if (count == 7) begin
      addr <= addr + 1;
      if (&addr) begin 
        reading <= 1; // Switch to read when all ram is written to
	if (reading && !err) passed = 1;
      end
    end
  end

  // Gameboy SDRAM interface
  sdram ram(
    .sd_data_in(sd_data_in),
    .sd_data_out(sd_data_out),
    .sd_data_dir(sd_data_dir),
    .sd_addr(sd_addr),
    .sd_dqm(sd_dqm),
    .sd_ba(sd_ba),
    .sd_cs(sd_cs),
    .sd_we(sd_we),
    .sd_ras(sd_ras),
    .sd_cas(sd_cas),
    .clk(clk),
    .init(!locked),
    .sync(clk8),
    .ds(ds),
    .we(we),
    .oe(oe),
    .addr(addr),
    .din(dout),
    .dout(din)
  );

endmodule

