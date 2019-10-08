// Read data from flash memory into SDRAM
// and read it black slowly showing in on leds.
module ramtest (
  input             clk_25M,    // 25 MHz clock

  // SDRAM
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

  // Flash memory
  output            flash_sck,
  output            flash_csn,
  output            flash_mosi,
  input             flash_miso,

  input             button,

  // Diagnostics
  output reg [15:0] diag,       // diagnostic leds
  output      [2:0] led         // colored leds
);

  parameter FLASH_ADDRESS = 'h70000;
  parameter FLASH_SIZE = 16384;

  // 64Mhz clock from PLL
  reg clk;
  reg locked;

  pll pll_i (
    .clock_in(clk_25M),
    .clock_out(clk),
    .locked(locked)
  );

  // 8Mhz clock
  reg       clk8;
  reg [3:0] div = 0;

  always @(posedge clk) begin
    div <= div + 1'd1;
    clk8   <= (div[2:0] == 0);
  end

  // Reset generation
  reg [8:0] reset_count;
  reg btn_dly;
  reg reload;
  reg [23:0] reloaded; // Used for reload led

  // Reload when button is released
  always @ (posedge clk8) begin
    if (!(&reset_count)) reset_count <= reset_count + 1;
    btn_dly <= button;
    reload = (button == 1'b1 && btn_dly == 1'b0);
    if (reload) reloaded <= 24'hffffff;
    if (reloaded > 0) reloaded <= reloaded -1;
  end

  wire reset = !(&reset_count) || reload;

  // Set SDRAM clock to 64Mhz and clock enable true
  assign sd_clk = clk;
  assign sd_cke = 1;

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
  reg [24:0] count; // Adjust width for speed of reading
  reg        oe;
  reg [19:0] addr;
  reg [15:0] din;

  assign led = ~{reloaded > 0, flashmem_valid, load_done};

  // 1 clock cycle of 8Mhz clock is a read or write
  // Write on even counts
  // Read on count 0
  // Refresh on other counts
  always @(posedge clk8) begin
    if (reset) begin
      addr <= 0;
      count <= 0;
    end else begin
      count <= count + 1;
      oe <= (count == 0 && load_done);
      if (count == 7 && load_done) addr <= addr + 1;
    end
  end

  // Retro 8Mhz SDRAM interface
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
    .ds(2'b11),
    .we(!load_done && sdram_write_stage > 0),
    .oe(oe),
    .addr(load_done ? addr : load_addr),
    .din(load_write_data),
    .dout(din)
  );

  // SDRAM wrire stage during load fom flash:
  // 0 = not writing, 1 = waiting for first sync
  // 2 = writing and waiting for second sync
  reg   [1:0] sdram_write_stage;
  
  reg         flashmem_valid;
  reg  [16:0] load_addr;
  reg         load_done;

  wire        flashmem_ready;
  wire [23:0] flashmem_addr = FLASH_ADDRESS | {load_addr, 1'b0};
  wire [15:0] load_write_data;

  // Flash memory load interface
  always @(posedge clk) begin
    diag <= din;
    if (reset) begin
      load_done <= 1'b0;
      load_addr <= 0;
      flashmem_valid = 1'b1;
      sdram_write_stage <= 1'b0;
    end else if (!load_done) begin
      if (sdram_write_stage > 0) begin
        if (clk8) sdram_write_stage <= sdram_write_stage + 1;
        if (sdram_write_stage == 2 && clk8) begin
	  sdram_write_stage <= 0;
          if (load_addr == (FLASH_SIZE -1)) begin
            load_done <= 1'b1;
          end else begin
            load_addr <= load_addr + 1'b1;
	    flashmem_valid <= 1;
          end
        end
      end
      if (flashmem_ready) begin
        sdram_write_stage <= 1;
	flashmem_valid <= 0;
      end
    end
  end

  icosoc_flashmem flash_i (
    .clk(clk),
    .reset(reset),
    .valid(flashmem_valid && !load_done),
    .ready(flashmem_ready),
    .addr(flashmem_addr),
    .rdata(load_write_data),

    .spi_cs(flash_csn),
    .spi_sclk(flash_sck),
    .spi_mosi(flash_mosi),
    .spi_miso(flash_miso)
 );

endmodule

