module chip (
    input  clk,
    output reg [47:0] PMOD,
    input button1,
    input button2,
    output red_led,
    output yellow_led
  );

assign red_led = !button1State;
assign yellow_led = !button2State;

reg [5:0] currentBit = 0;
reg button1Pressed, button2Pressed;
reg button1State, button2State = 0;

PushButton_Debouncer debouncer1 (
  .clk(clk),
  .PB(button1),
  .PB_down(button1Pressed),
  .PB_state(button1State)
);

//PushButton_Debouncer debouncer2 (
//  .clk(clk),
//  .PB(button2),
//  .PB_down(button2Pressed),
//  .PB_state(button2State)
//);

always @(posedge clk) begin
  PMOD <= 0;

  PMOD[currentBit] <= 1;

  if (button1Pressed && currentBit < 48) begin
    currentBit <= currentBit + 1;
  end

//  if (button2Pressed && currentBit > 0) begin
//    currentBit <= currentBit - 1;
//  end

end

endmodule
