// Generator : SpinalHDL v1.3.6    git head : ea8de9740082cfc7b6835180a19772d92fd98ba2
// Date      : 06/07/2019, 20:28:32
// Component : BlackiceMxSocSdram


`define UartStopType_defaultEncoding_type [0:0]
`define UartStopType_defaultEncoding_ONE 1'b0
`define UartStopType_defaultEncoding_TWO 1'b1

`define UartParityType_defaultEncoding_type [1:0]
`define UartParityType_defaultEncoding_NONE 2'b00
`define UartParityType_defaultEncoding_EVEN 2'b01
`define UartParityType_defaultEncoding_ODD 2'b10

`define UartCtrlTxState_defaultEncoding_type [2:0]
`define UartCtrlTxState_defaultEncoding_IDLE 3'b000
`define UartCtrlTxState_defaultEncoding_START 3'b001
`define UartCtrlTxState_defaultEncoding_DATA 3'b010
`define UartCtrlTxState_defaultEncoding_PARITY 3'b011
`define UartCtrlTxState_defaultEncoding_STOP 3'b100

`define UartCtrlRxState_defaultEncoding_type [2:0]
`define UartCtrlRxState_defaultEncoding_IDLE 3'b000
`define UartCtrlRxState_defaultEncoding_START 3'b001
`define UartCtrlRxState_defaultEncoding_DATA 3'b010
`define UartCtrlRxState_defaultEncoding_PARITY 3'b011
`define UartCtrlRxState_defaultEncoding_STOP 3'b100

`define AluBitwiseCtrlEnum_defaultEncoding_type [1:0]
`define AluBitwiseCtrlEnum_defaultEncoding_XOR_1 2'b00
`define AluBitwiseCtrlEnum_defaultEncoding_OR_1 2'b01
`define AluBitwiseCtrlEnum_defaultEncoding_AND_1 2'b10

`define ShiftCtrlEnum_defaultEncoding_type [1:0]
`define ShiftCtrlEnum_defaultEncoding_DISABLE_1 2'b00
`define ShiftCtrlEnum_defaultEncoding_SLL_1 2'b01
`define ShiftCtrlEnum_defaultEncoding_SRL_1 2'b10
`define ShiftCtrlEnum_defaultEncoding_SRA_1 2'b11

`define Src1CtrlEnum_defaultEncoding_type [1:0]
`define Src1CtrlEnum_defaultEncoding_RS 2'b00
`define Src1CtrlEnum_defaultEncoding_IMU 2'b01
`define Src1CtrlEnum_defaultEncoding_PC_INCREMENT 2'b10
`define Src1CtrlEnum_defaultEncoding_URS1 2'b11

`define AluCtrlEnum_defaultEncoding_type [1:0]
`define AluCtrlEnum_defaultEncoding_ADD_SUB 2'b00
`define AluCtrlEnum_defaultEncoding_SLT_SLTU 2'b01
`define AluCtrlEnum_defaultEncoding_BITWISE 2'b10

`define Src2CtrlEnum_defaultEncoding_type [1:0]
`define Src2CtrlEnum_defaultEncoding_RS 2'b00
`define Src2CtrlEnum_defaultEncoding_IMI 2'b01
`define Src2CtrlEnum_defaultEncoding_IMS 2'b10
`define Src2CtrlEnum_defaultEncoding_PC 2'b11

`define BranchCtrlEnum_defaultEncoding_type [1:0]
`define BranchCtrlEnum_defaultEncoding_INC 2'b00
`define BranchCtrlEnum_defaultEncoding_B 2'b01
`define BranchCtrlEnum_defaultEncoding_JAL 2'b10
`define BranchCtrlEnum_defaultEncoding_JALR 2'b11

`define JtagState_defaultEncoding_type [3:0]
`define JtagState_defaultEncoding_RESET 4'b0000
`define JtagState_defaultEncoding_IDLE 4'b0001
`define JtagState_defaultEncoding_IR_SELECT 4'b0010
`define JtagState_defaultEncoding_IR_CAPTURE 4'b0011
`define JtagState_defaultEncoding_IR_SHIFT 4'b0100
`define JtagState_defaultEncoding_IR_EXIT1 4'b0101
`define JtagState_defaultEncoding_IR_PAUSE 4'b0110
`define JtagState_defaultEncoding_IR_EXIT2 4'b0111
`define JtagState_defaultEncoding_IR_UPDATE 4'b1000
`define JtagState_defaultEncoding_DR_SELECT 4'b1001
`define JtagState_defaultEncoding_DR_CAPTURE 4'b1010
`define JtagState_defaultEncoding_DR_SHIFT 4'b1011
`define JtagState_defaultEncoding_DR_EXIT1 4'b1100
`define JtagState_defaultEncoding_DR_PAUSE 4'b1101
`define JtagState_defaultEncoding_DR_EXIT2 4'b1110
`define JtagState_defaultEncoding_DR_UPDATE 4'b1111

`define SdramCtrlBackendTask_defaultEncoding_type [2:0]
`define SdramCtrlBackendTask_defaultEncoding_MODE 3'b000
`define SdramCtrlBackendTask_defaultEncoding_PRECHARGE_ALL 3'b001
`define SdramCtrlBackendTask_defaultEncoding_PRECHARGE_SINGLE 3'b010
`define SdramCtrlBackendTask_defaultEncoding_REFRESH 3'b011
`define SdramCtrlBackendTask_defaultEncoding_ACTIVE 3'b100
`define SdramCtrlBackendTask_defaultEncoding_READ 3'b101
`define SdramCtrlBackendTask_defaultEncoding_WRITE 3'b110

`define SdramCtrlFrontendState_defaultEncoding_type [1:0]
`define SdramCtrlFrontendState_defaultEncoding_BOOT_PRECHARGE 2'b00
`define SdramCtrlFrontendState_defaultEncoding_BOOT_REFRESH 2'b01
`define SdramCtrlFrontendState_defaultEncoding_BOOT_MODE 2'b10
`define SdramCtrlFrontendState_defaultEncoding_RUN 2'b11

module BufferCC (
      input   io_initial,
      input   io_dataIn,
      output  io_dataOut,
      input   clock_out,
      input   clockCtrl_systemReset);
  reg  buffers_0;
  reg  buffers_1;
  assign io_dataOut = buffers_1;
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      buffers_0 <= io_initial;
      buffers_1 <= io_initial;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end

endmodule

module UartCtrlTx (
      input  [2:0] io_configFrame_dataLength,
      input  `UartStopType_defaultEncoding_type io_configFrame_stop,
      input  `UartParityType_defaultEncoding_type io_configFrame_parity,
      input   io_samplingTick,
      input   io_write_valid,
      output reg  io_write_ready,
      input  [7:0] io_write_payload,
      output  io_txd,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire  _zz_1_;
  wire [0:0] _zz_2_;
  wire [2:0] _zz_3_;
  wire [0:0] _zz_4_;
  wire [2:0] _zz_5_;
  reg  clockDivider_counter_willIncrement;
  wire  clockDivider_counter_willClear;
  reg [2:0] clockDivider_counter_valueNext;
  reg [2:0] clockDivider_counter_value;
  wire  clockDivider_counter_willOverflowIfInc;
  wire  clockDivider_tick;
  reg [2:0] tickCounter_value;
  reg `UartCtrlTxState_defaultEncoding_type stateMachine_state;
  reg  stateMachine_parity;
  reg  stateMachine_txd;
  reg  stateMachine_txd_regNext;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif

  assign _zz_1_ = (tickCounter_value == io_configFrame_dataLength);
  assign _zz_2_ = clockDivider_counter_willIncrement;
  assign _zz_3_ = {2'd0, _zz_2_};
  assign _zz_4_ = ((io_configFrame_stop == `UartStopType_defaultEncoding_ONE) ? (1'b0) : (1'b1));
  assign _zz_5_ = {2'd0, _zz_4_};
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      `UartStopType_defaultEncoding_ONE : io_configFrame_stop_string = "ONE";
      `UartStopType_defaultEncoding_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      `UartParityType_defaultEncoding_NONE : io_configFrame_parity_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : io_configFrame_parity_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : stateMachine_state_string = "IDLE  ";
      `UartCtrlTxState_defaultEncoding_START : stateMachine_state_string = "START ";
      `UartCtrlTxState_defaultEncoding_DATA : stateMachine_state_string = "DATA  ";
      `UartCtrlTxState_defaultEncoding_PARITY : stateMachine_state_string = "PARITY";
      `UartCtrlTxState_defaultEncoding_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  `endif

  always @ (*) begin
    clockDivider_counter_willIncrement = 1'b0;
    if(io_samplingTick)begin
      clockDivider_counter_willIncrement = 1'b1;
    end
  end

  assign clockDivider_counter_willClear = 1'b0;
  assign clockDivider_counter_willOverflowIfInc = (clockDivider_counter_value == (3'b100));
  assign clockDivider_tick = (clockDivider_counter_willOverflowIfInc && clockDivider_counter_willIncrement);
  always @ (*) begin
    if(clockDivider_tick)begin
      clockDivider_counter_valueNext = (3'b000);
    end else begin
      clockDivider_counter_valueNext = (clockDivider_counter_value + _zz_3_);
    end
    if(clockDivider_counter_willClear)begin
      clockDivider_counter_valueNext = (3'b000);
    end
  end

  always @ (*) begin
    stateMachine_txd = 1'b1;
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlTxState_defaultEncoding_START : begin
        stateMachine_txd = 1'b0;
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        stateMachine_txd = io_write_payload[tickCounter_value];
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
        stateMachine_txd = stateMachine_parity;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_write_ready = 1'b0;
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlTxState_defaultEncoding_START : begin
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        if(clockDivider_tick)begin
          if(_zz_1_)begin
            io_write_ready = 1'b1;
          end
        end
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
      end
      default : begin
      end
    endcase
  end

  assign io_txd = stateMachine_txd_regNext;
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      clockDivider_counter_value <= (3'b000);
      stateMachine_state <= `UartCtrlTxState_defaultEncoding_IDLE;
      stateMachine_txd_regNext <= 1'b1;
    end else begin
      clockDivider_counter_value <= clockDivider_counter_valueNext;
      case(stateMachine_state)
        `UartCtrlTxState_defaultEncoding_IDLE : begin
          if((io_write_valid && clockDivider_tick))begin
            stateMachine_state <= `UartCtrlTxState_defaultEncoding_START;
          end
        end
        `UartCtrlTxState_defaultEncoding_START : begin
          if(clockDivider_tick)begin
            stateMachine_state <= `UartCtrlTxState_defaultEncoding_DATA;
          end
        end
        `UartCtrlTxState_defaultEncoding_DATA : begin
          if(clockDivider_tick)begin
            if(_zz_1_)begin
              if((io_configFrame_parity == `UartParityType_defaultEncoding_NONE))begin
                stateMachine_state <= `UartCtrlTxState_defaultEncoding_STOP;
              end else begin
                stateMachine_state <= `UartCtrlTxState_defaultEncoding_PARITY;
              end
            end
          end
        end
        `UartCtrlTxState_defaultEncoding_PARITY : begin
          if(clockDivider_tick)begin
            stateMachine_state <= `UartCtrlTxState_defaultEncoding_STOP;
          end
        end
        default : begin
          if(clockDivider_tick)begin
            if((tickCounter_value == _zz_5_))begin
              stateMachine_state <= (io_write_valid ? `UartCtrlTxState_defaultEncoding_START : `UartCtrlTxState_defaultEncoding_IDLE);
            end
          end
        end
      endcase
      stateMachine_txd_regNext <= stateMachine_txd;
    end
  end

  always @ (posedge clock_out) begin
    if(clockDivider_tick)begin
      tickCounter_value <= (tickCounter_value + (3'b001));
    end
    if(clockDivider_tick)begin
      stateMachine_parity <= (stateMachine_parity ^ stateMachine_txd);
    end
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlTxState_defaultEncoding_START : begin
        if(clockDivider_tick)begin
          stateMachine_parity <= (io_configFrame_parity == `UartParityType_defaultEncoding_ODD);
          tickCounter_value <= (3'b000);
        end
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        if(clockDivider_tick)begin
          if(_zz_1_)begin
            tickCounter_value <= (3'b000);
          end
        end
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
        if(clockDivider_tick)begin
          tickCounter_value <= (3'b000);
        end
      end
      default : begin
      end
    endcase
  end

endmodule

module UartCtrlRx (
      input  [2:0] io_configFrame_dataLength,
      input  `UartStopType_defaultEncoding_type io_configFrame_stop,
      input  `UartParityType_defaultEncoding_type io_configFrame_parity,
      input   io_samplingTick,
      output  io_read_valid,
      output [7:0] io_read_payload,
      input   io_rxd,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire  _zz_1_;
  wire  bufferCC_4__io_dataOut;
  wire  _zz_2_;
  wire  _zz_3_;
  wire  _zz_4_;
  wire [0:0] _zz_5_;
  wire [2:0] _zz_6_;
  wire  sampler_synchroniser;
  wire  sampler_samples_0;
  reg  sampler_samples_1;
  reg  sampler_samples_2;
  reg  sampler_value;
  reg  sampler_tick;
  reg [2:0] bitTimer_counter;
  reg  bitTimer_tick;
  reg [2:0] bitCounter_value;
  reg `UartCtrlRxState_defaultEncoding_type stateMachine_state;
  reg  stateMachine_parity;
  reg [7:0] stateMachine_shifter;
  reg  stateMachine_validReg;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif

  assign _zz_2_ = (bitTimer_counter == (3'b000));
  assign _zz_3_ = (sampler_tick && (! sampler_value));
  assign _zz_4_ = (bitCounter_value == io_configFrame_dataLength);
  assign _zz_5_ = ((io_configFrame_stop == `UartStopType_defaultEncoding_ONE) ? (1'b0) : (1'b1));
  assign _zz_6_ = {2'd0, _zz_5_};
  BufferCC bufferCC_4_ ( 
    .io_initial(_zz_1_),
    .io_dataIn(io_rxd),
    .io_dataOut(bufferCC_4__io_dataOut),
    .clock_out(clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      `UartStopType_defaultEncoding_ONE : io_configFrame_stop_string = "ONE";
      `UartStopType_defaultEncoding_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      `UartParityType_defaultEncoding_NONE : io_configFrame_parity_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : io_configFrame_parity_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      `UartCtrlRxState_defaultEncoding_IDLE : stateMachine_state_string = "IDLE  ";
      `UartCtrlRxState_defaultEncoding_START : stateMachine_state_string = "START ";
      `UartCtrlRxState_defaultEncoding_DATA : stateMachine_state_string = "DATA  ";
      `UartCtrlRxState_defaultEncoding_PARITY : stateMachine_state_string = "PARITY";
      `UartCtrlRxState_defaultEncoding_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  `endif

  assign _zz_1_ = 1'b0;
  assign sampler_synchroniser = bufferCC_4__io_dataOut;
  assign sampler_samples_0 = sampler_synchroniser;
  always @ (*) begin
    bitTimer_tick = 1'b0;
    if(sampler_tick)begin
      if(_zz_2_)begin
        bitTimer_tick = 1'b1;
      end
    end
  end

  assign io_read_valid = stateMachine_validReg;
  assign io_read_payload = stateMachine_shifter;
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      sampler_samples_1 <= 1'b1;
      sampler_samples_2 <= 1'b1;
      sampler_value <= 1'b1;
      sampler_tick <= 1'b0;
      stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
      stateMachine_validReg <= 1'b0;
    end else begin
      if(io_samplingTick)begin
        sampler_samples_1 <= sampler_samples_0;
      end
      if(io_samplingTick)begin
        sampler_samples_2 <= sampler_samples_1;
      end
      sampler_value <= (((1'b0 || ((1'b1 && sampler_samples_0) && sampler_samples_1)) || ((1'b1 && sampler_samples_0) && sampler_samples_2)) || ((1'b1 && sampler_samples_1) && sampler_samples_2));
      sampler_tick <= io_samplingTick;
      stateMachine_validReg <= 1'b0;
      case(stateMachine_state)
        `UartCtrlRxState_defaultEncoding_IDLE : begin
          if(_zz_3_)begin
            stateMachine_state <= `UartCtrlRxState_defaultEncoding_START;
          end
        end
        `UartCtrlRxState_defaultEncoding_START : begin
          if(bitTimer_tick)begin
            stateMachine_state <= `UartCtrlRxState_defaultEncoding_DATA;
            if((sampler_value == 1'b1))begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
            end
          end
        end
        `UartCtrlRxState_defaultEncoding_DATA : begin
          if(bitTimer_tick)begin
            if(_zz_4_)begin
              if((io_configFrame_parity == `UartParityType_defaultEncoding_NONE))begin
                stateMachine_state <= `UartCtrlRxState_defaultEncoding_STOP;
                stateMachine_validReg <= 1'b1;
              end else begin
                stateMachine_state <= `UartCtrlRxState_defaultEncoding_PARITY;
              end
            end
          end
        end
        `UartCtrlRxState_defaultEncoding_PARITY : begin
          if(bitTimer_tick)begin
            if((stateMachine_parity == sampler_value))begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_STOP;
              stateMachine_validReg <= 1'b1;
            end else begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
            end
          end
        end
        default : begin
          if(bitTimer_tick)begin
            if((! sampler_value))begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
            end else begin
              if((bitCounter_value == _zz_6_))begin
                stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
              end
            end
          end
        end
      endcase
    end
  end

  always @ (posedge clock_out) begin
    if(sampler_tick)begin
      bitTimer_counter <= (bitTimer_counter - (3'b001));
      if(_zz_2_)begin
        bitTimer_counter <= (3'b100);
      end
    end
    if(bitTimer_tick)begin
      bitCounter_value <= (bitCounter_value + (3'b001));
    end
    if(bitTimer_tick)begin
      stateMachine_parity <= (stateMachine_parity ^ sampler_value);
    end
    case(stateMachine_state)
      `UartCtrlRxState_defaultEncoding_IDLE : begin
        if(_zz_3_)begin
          bitTimer_counter <= (3'b001);
        end
      end
      `UartCtrlRxState_defaultEncoding_START : begin
        if(bitTimer_tick)begin
          bitCounter_value <= (3'b000);
          stateMachine_parity <= (io_configFrame_parity == `UartParityType_defaultEncoding_ODD);
        end
      end
      `UartCtrlRxState_defaultEncoding_DATA : begin
        if(bitTimer_tick)begin
          stateMachine_shifter[bitCounter_value] <= sampler_value;
          if(_zz_4_)begin
            bitCounter_value <= (3'b000);
          end
        end
      end
      `UartCtrlRxState_defaultEncoding_PARITY : begin
        if(bitTimer_tick)begin
          bitCounter_value <= (3'b000);
        end
      end
      default : begin
      end
    endcase
  end

endmodule

module BufferCC_1_ (
      input   io_dataIn,
      output  io_dataOut,
      input   clock_out,
      input   clockCtrl_resetUnbuffered_regNext);
  reg  buffers_0;
  reg  buffers_1;
  assign io_dataOut = buffers_1;
  always @ (posedge clock_out) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end

endmodule

module StreamFifoLowLatency (
      input   io_push_valid,
      output  io_push_ready,
      input  [15:0] io_push_payload_data,
      input  [4:0] io_push_payload_context_context,
      output reg  io_pop_valid,
      input   io_pop_ready,
      output reg [15:0] io_pop_payload_data,
      output reg [4:0] io_pop_payload_context_context,
      input   io_flush,
      output [1:0] io_occupancy,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire [20:0] _zz_3_;
  wire  _zz_4_;
  wire [4:0] _zz_5_;
  wire [20:0] _zz_6_;
  reg  _zz_1_;
  reg  pushPtr_willIncrement;
  reg  pushPtr_willClear;
  reg [0:0] pushPtr_valueNext;
  reg [0:0] pushPtr_value;
  wire  pushPtr_willOverflowIfInc;
  wire  pushPtr_willOverflow;
  reg  popPtr_willIncrement;
  reg  popPtr_willClear;
  reg [0:0] popPtr_valueNext;
  reg [0:0] popPtr_value;
  wire  popPtr_willOverflowIfInc;
  wire  popPtr_willOverflow;
  wire  ptrMatch;
  reg  risingOccupancy;
  wire  empty;
  wire  full;
  wire  pushing;
  wire  popping;
  wire [20:0] _zz_2_;
  wire [0:0] ptrDif;
  reg [20:0] ram [0:1];
  assign _zz_4_ = (! empty);
  assign _zz_5_ = _zz_2_[20 : 16];
  assign _zz_6_ = {io_push_payload_context_context,io_push_payload_data};
  always @ (posedge clock_out) begin
    if(_zz_1_) begin
      ram[pushPtr_value] <= _zz_6_;
    end
  end

  assign _zz_3_ = ram[popPtr_value];
  always @ (*) begin
    _zz_1_ = 1'b0;
    if(pushing)begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    pushPtr_willIncrement = 1'b0;
    if(pushing)begin
      pushPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    pushPtr_willClear = 1'b0;
    if(io_flush)begin
      pushPtr_willClear = 1'b1;
    end
  end

  assign pushPtr_willOverflowIfInc = (pushPtr_value == (1'b1));
  assign pushPtr_willOverflow = (pushPtr_willOverflowIfInc && pushPtr_willIncrement);
  always @ (*) begin
    pushPtr_valueNext = (pushPtr_value + pushPtr_willIncrement);
    if(pushPtr_willClear)begin
      pushPtr_valueNext = (1'b0);
    end
  end

  always @ (*) begin
    popPtr_willIncrement = 1'b0;
    if(popping)begin
      popPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    popPtr_willClear = 1'b0;
    if(io_flush)begin
      popPtr_willClear = 1'b1;
    end
  end

  assign popPtr_willOverflowIfInc = (popPtr_value == (1'b1));
  assign popPtr_willOverflow = (popPtr_willOverflowIfInc && popPtr_willIncrement);
  always @ (*) begin
    popPtr_valueNext = (popPtr_value + popPtr_willIncrement);
    if(popPtr_willClear)begin
      popPtr_valueNext = (1'b0);
    end
  end

  assign ptrMatch = (pushPtr_value == popPtr_value);
  assign empty = (ptrMatch && (! risingOccupancy));
  assign full = (ptrMatch && risingOccupancy);
  assign pushing = (io_push_valid && io_push_ready);
  assign popping = (io_pop_valid && io_pop_ready);
  assign io_push_ready = (! full);
  always @ (*) begin
    if(_zz_4_)begin
      io_pop_valid = 1'b1;
    end else begin
      io_pop_valid = io_push_valid;
    end
  end

  assign _zz_2_ = _zz_3_;
  always @ (*) begin
    if(_zz_4_)begin
      io_pop_payload_data = _zz_2_[15 : 0];
    end else begin
      io_pop_payload_data = io_push_payload_data;
    end
  end

  always @ (*) begin
    if(_zz_4_)begin
      io_pop_payload_context_context = _zz_5_[4 : 0];
    end else begin
      io_pop_payload_context_context = io_push_payload_context_context;
    end
  end

  assign ptrDif = (pushPtr_value - popPtr_value);
  assign io_occupancy = {(risingOccupancy && ptrMatch),ptrDif};
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      pushPtr_value <= (1'b0);
      popPtr_value <= (1'b0);
      risingOccupancy <= 1'b0;
    end else begin
      pushPtr_value <= pushPtr_valueNext;
      popPtr_value <= popPtr_valueNext;
      if((pushing != popping))begin
        risingOccupancy <= pushing;
      end
      if(io_flush)begin
        risingOccupancy <= 1'b0;
      end
    end
  end

endmodule

module UartCtrl (
      input  [2:0] io_config_frame_dataLength,
      input  `UartStopType_defaultEncoding_type io_config_frame_stop,
      input  `UartParityType_defaultEncoding_type io_config_frame_parity,
      input  [11:0] io_config_clockDivider,
      input   io_write_valid,
      output  io_write_ready,
      input  [7:0] io_write_payload,
      output  io_read_valid,
      output [7:0] io_read_payload,
      output  io_uart_txd,
      input   io_uart_rxd,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire  tx_io_write_ready;
  wire  tx_io_txd;
  wire  rx_io_read_valid;
  wire [7:0] rx_io_read_payload;
  reg [11:0] clockDivider_counter;
  wire  clockDivider_tick;
  `ifndef SYNTHESIS
  reg [23:0] io_config_frame_stop_string;
  reg [31:0] io_config_frame_parity_string;
  `endif

  UartCtrlTx tx ( 
    .io_configFrame_dataLength(io_config_frame_dataLength),
    .io_configFrame_stop(io_config_frame_stop),
    .io_configFrame_parity(io_config_frame_parity),
    .io_samplingTick(clockDivider_tick),
    .io_write_valid(io_write_valid),
    .io_write_ready(tx_io_write_ready),
    .io_write_payload(io_write_payload),
    .io_txd(tx_io_txd),
    .clock_out(clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  UartCtrlRx rx ( 
    .io_configFrame_dataLength(io_config_frame_dataLength),
    .io_configFrame_stop(io_config_frame_stop),
    .io_configFrame_parity(io_config_frame_parity),
    .io_samplingTick(clockDivider_tick),
    .io_read_valid(rx_io_read_valid),
    .io_read_payload(rx_io_read_payload),
    .io_rxd(io_uart_rxd),
    .clock_out(clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_config_frame_stop)
      `UartStopType_defaultEncoding_ONE : io_config_frame_stop_string = "ONE";
      `UartStopType_defaultEncoding_TWO : io_config_frame_stop_string = "TWO";
      default : io_config_frame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_config_frame_parity)
      `UartParityType_defaultEncoding_NONE : io_config_frame_parity_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : io_config_frame_parity_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : io_config_frame_parity_string = "ODD ";
      default : io_config_frame_parity_string = "????";
    endcase
  end
  `endif

  assign clockDivider_tick = (clockDivider_counter == (12'b000000000000));
  assign io_write_ready = tx_io_write_ready;
  assign io_read_valid = rx_io_read_valid;
  assign io_read_payload = rx_io_read_payload;
  assign io_uart_txd = tx_io_txd;
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      clockDivider_counter <= (12'b000000000000);
    end else begin
      clockDivider_counter <= (clockDivider_counter - (12'b000000000001));
      if(clockDivider_tick)begin
        clockDivider_counter <= io_config_clockDivider;
      end
    end
  end

endmodule

module StreamFifo (
      input   io_push_valid,
      output  io_push_ready,
      input  [7:0] io_push_payload,
      output  io_pop_valid,
      input   io_pop_ready,
      output [7:0] io_pop_payload,
      input   io_flush,
      output [0:0] io_occupancy,
      output [0:0] io_availability,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire  io_push_m2sPipe_valid;
  wire  io_push_m2sPipe_ready;
  wire [7:0] io_push_m2sPipe_payload;
  reg  _zz_1_;
  reg [7:0] _zz_2_;
  assign io_push_ready = ((1'b1 && (! io_push_m2sPipe_valid)) || io_push_m2sPipe_ready);
  assign io_push_m2sPipe_valid = _zz_1_;
  assign io_push_m2sPipe_payload = _zz_2_;
  assign io_pop_valid = io_push_m2sPipe_valid;
  assign io_push_m2sPipe_ready = io_pop_ready;
  assign io_pop_payload = io_push_m2sPipe_payload;
  assign io_occupancy = io_pop_valid;
  assign io_availability = (! io_pop_valid);
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      _zz_1_ <= 1'b0;
    end else begin
      if(io_push_ready)begin
        _zz_1_ <= io_push_valid;
      end
      if(io_flush)begin
        _zz_1_ <= 1'b0;
      end
    end
  end

  always @ (posedge clock_out) begin
    if(io_push_ready)begin
      _zz_2_ <= io_push_payload;
    end
  end

endmodule


//StreamFifo_1_ remplaced by StreamFifo

module BufferCC_2_ (
      input  [7:0] io_dataIn,
      output [7:0] io_dataOut,
      input   clock_out,
      input   clockCtrl_systemReset);
  reg [7:0] buffers_0;
  reg [7:0] buffers_1;
  assign io_dataOut = buffers_1;
  always @ (posedge clock_out) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end

endmodule

module StreamFifoLowLatency_1_ (
      input   io_push_valid,
      output  io_push_ready,
      input   io_push_payload_error,
      input  [31:0] io_push_payload_inst,
      output reg  io_pop_valid,
      input   io_pop_ready,
      output reg  io_pop_payload_error,
      output reg [31:0] io_pop_payload_inst,
      input   io_flush,
      output [0:0] io_occupancy,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire  _zz_5_;
  wire [0:0] _zz_6_;
  reg  _zz_1_;
  reg  pushPtr_willIncrement;
  reg  pushPtr_willClear;
  wire  pushPtr_willOverflowIfInc;
  wire  pushPtr_willOverflow;
  reg  popPtr_willIncrement;
  reg  popPtr_willClear;
  wire  popPtr_willOverflowIfInc;
  wire  popPtr_willOverflow;
  wire  ptrMatch;
  reg  risingOccupancy;
  wire  empty;
  wire  full;
  wire  pushing;
  wire  popping;
  wire [32:0] _zz_2_;
  wire [32:0] _zz_3_;
  reg [32:0] _zz_4_;
  assign _zz_5_ = (! empty);
  assign _zz_6_ = _zz_2_[0 : 0];
  always @ (*) begin
    _zz_1_ = 1'b0;
    if(pushing)begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    pushPtr_willIncrement = 1'b0;
    if(pushing)begin
      pushPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    pushPtr_willClear = 1'b0;
    if(io_flush)begin
      pushPtr_willClear = 1'b1;
    end
  end

  assign pushPtr_willOverflowIfInc = 1'b1;
  assign pushPtr_willOverflow = (pushPtr_willOverflowIfInc && pushPtr_willIncrement);
  always @ (*) begin
    popPtr_willIncrement = 1'b0;
    if(popping)begin
      popPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    popPtr_willClear = 1'b0;
    if(io_flush)begin
      popPtr_willClear = 1'b1;
    end
  end

  assign popPtr_willOverflowIfInc = 1'b1;
  assign popPtr_willOverflow = (popPtr_willOverflowIfInc && popPtr_willIncrement);
  assign ptrMatch = 1'b1;
  assign empty = (ptrMatch && (! risingOccupancy));
  assign full = (ptrMatch && risingOccupancy);
  assign pushing = (io_push_valid && io_push_ready);
  assign popping = (io_pop_valid && io_pop_ready);
  assign io_push_ready = (! full);
  always @ (*) begin
    if(_zz_5_)begin
      io_pop_valid = 1'b1;
    end else begin
      io_pop_valid = io_push_valid;
    end
  end

  assign _zz_2_ = _zz_3_;
  always @ (*) begin
    if(_zz_5_)begin
      io_pop_payload_error = _zz_6_[0];
    end else begin
      io_pop_payload_error = io_push_payload_error;
    end
  end

  always @ (*) begin
    if(_zz_5_)begin
      io_pop_payload_inst = _zz_2_[32 : 1];
    end else begin
      io_pop_payload_inst = io_push_payload_inst;
    end
  end

  assign io_occupancy = (risingOccupancy && ptrMatch);
  assign _zz_3_ = _zz_4_;
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      risingOccupancy <= 1'b0;
    end else begin
      if((pushing != popping))begin
        risingOccupancy <= pushing;
      end
      if(io_flush)begin
        risingOccupancy <= 1'b0;
      end
    end
  end

  always @ (posedge clock_out) begin
    if(_zz_1_)begin
      _zz_4_ <= {io_push_payload_inst,io_push_payload_error};
    end
  end

endmodule

module FlowCCByToggle (
      input   io_input_valid,
      input   io_input_payload_last,
      input  [0:0] io_input_payload_fragment,
      output  io_output_valid,
      output  io_output_payload_last,
      output [0:0] io_output_payload_fragment,
      input   io_jtag_tck,
      input   clock_out,
      input   clockCtrl_resetUnbuffered_regNext);
  wire  bufferCC_4__io_dataOut;
  wire  outHitSignal;
  reg  inputArea_target = 0;
  reg  inputArea_data_last;
  reg [0:0] inputArea_data_fragment;
  wire  outputArea_target;
  reg  outputArea_hit;
  wire  outputArea_flow_valid;
  wire  outputArea_flow_payload_last;
  wire [0:0] outputArea_flow_payload_fragment;
  reg  outputArea_flow_m2sPipe_valid;
  reg  outputArea_flow_m2sPipe_payload_last;
  reg [0:0] outputArea_flow_m2sPipe_payload_fragment;
  BufferCC_1_ bufferCC_4_ ( 
    .io_dataIn(inputArea_target),
    .io_dataOut(bufferCC_4__io_dataOut),
    .clock_out(clock_out),
    .clockCtrl_resetUnbuffered_regNext(clockCtrl_resetUnbuffered_regNext) 
  );
  assign outputArea_target = bufferCC_4__io_dataOut;
  assign outputArea_flow_valid = (outputArea_target != outputArea_hit);
  assign outputArea_flow_payload_last = inputArea_data_last;
  assign outputArea_flow_payload_fragment = inputArea_data_fragment;
  assign io_output_valid = outputArea_flow_m2sPipe_valid;
  assign io_output_payload_last = outputArea_flow_m2sPipe_payload_last;
  assign io_output_payload_fragment = outputArea_flow_m2sPipe_payload_fragment;
  always @ (posedge io_jtag_tck) begin
    if(io_input_valid)begin
      inputArea_target <= (! inputArea_target);
      inputArea_data_last <= io_input_payload_last;
      inputArea_data_fragment <= io_input_payload_fragment;
    end
  end

  always @ (posedge clock_out) begin
    outputArea_hit <= outputArea_target;
    if(outputArea_flow_valid)begin
      outputArea_flow_m2sPipe_payload_last <= outputArea_flow_payload_last;
      outputArea_flow_m2sPipe_payload_fragment <= outputArea_flow_payload_fragment;
    end
  end

  always @ (posedge clock_out) begin
    if(clockCtrl_resetUnbuffered_regNext) begin
      outputArea_flow_m2sPipe_valid <= 1'b0;
    end else begin
      outputArea_flow_m2sPipe_valid <= outputArea_flow_valid;
    end
  end

endmodule

module StreamArbiter (
      input   io_inputs_0_valid,
      output  io_inputs_0_ready,
      input   io_inputs_0_payload_last,
      input  [0:0] io_inputs_0_payload_fragment_source,
      input  [0:0] io_inputs_0_payload_fragment_opcode,
      input  [12:0] io_inputs_0_payload_fragment_address,
      input  [1:0] io_inputs_0_payload_fragment_length,
      input  [31:0] io_inputs_0_payload_fragment_data,
      input  [3:0] io_inputs_0_payload_fragment_mask,
      input  [0:0] io_inputs_0_payload_fragment_context,
      input   io_inputs_1_valid,
      output  io_inputs_1_ready,
      input   io_inputs_1_payload_last,
      input  [0:0] io_inputs_1_payload_fragment_source,
      input  [0:0] io_inputs_1_payload_fragment_opcode,
      input  [12:0] io_inputs_1_payload_fragment_address,
      input  [1:0] io_inputs_1_payload_fragment_length,
      input  [31:0] io_inputs_1_payload_fragment_data,
      input  [3:0] io_inputs_1_payload_fragment_mask,
      input  [0:0] io_inputs_1_payload_fragment_context,
      output  io_output_valid,
      input   io_output_ready,
      output  io_output_payload_last,
      output [0:0] io_output_payload_fragment_source,
      output [0:0] io_output_payload_fragment_opcode,
      output [12:0] io_output_payload_fragment_address,
      output [1:0] io_output_payload_fragment_length,
      output [31:0] io_output_payload_fragment_data,
      output [3:0] io_output_payload_fragment_mask,
      output [0:0] io_output_payload_fragment_context,
      output [0:0] io_chosen,
      output [1:0] io_chosenOH,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire [1:0] _zz_3_;
  wire [1:0] _zz_4_;
  reg  locked;
  wire  maskProposal_0;
  wire  maskProposal_1;
  reg  maskLocked_0;
  reg  maskLocked_1;
  wire  maskRouted_0;
  wire  maskRouted_1;
  wire [1:0] _zz_1_;
  wire  _zz_2_;
  assign _zz_3_ = (_zz_1_ & (~ _zz_4_));
  assign _zz_4_ = (_zz_1_ - (2'b01));
  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0);
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1);
  assign _zz_1_ = {io_inputs_1_valid,io_inputs_0_valid};
  assign maskProposal_0 = io_inputs_0_valid;
  assign maskProposal_1 = _zz_3_[1];
  assign io_output_valid = ((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1));
  assign io_output_payload_last = (maskRouted_0 ? io_inputs_0_payload_last : io_inputs_1_payload_last);
  assign io_output_payload_fragment_source = (maskRouted_0 ? io_inputs_0_payload_fragment_source : io_inputs_1_payload_fragment_source);
  assign io_output_payload_fragment_opcode = (maskRouted_0 ? io_inputs_0_payload_fragment_opcode : io_inputs_1_payload_fragment_opcode);
  assign io_output_payload_fragment_address = (maskRouted_0 ? io_inputs_0_payload_fragment_address : io_inputs_1_payload_fragment_address);
  assign io_output_payload_fragment_length = (maskRouted_0 ? io_inputs_0_payload_fragment_length : io_inputs_1_payload_fragment_length);
  assign io_output_payload_fragment_data = (maskRouted_0 ? io_inputs_0_payload_fragment_data : io_inputs_1_payload_fragment_data);
  assign io_output_payload_fragment_mask = (maskRouted_0 ? io_inputs_0_payload_fragment_mask : io_inputs_1_payload_fragment_mask);
  assign io_output_payload_fragment_context = (maskRouted_0 ? io_inputs_0_payload_fragment_context : io_inputs_1_payload_fragment_context);
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready);
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready);
  assign io_chosenOH = {maskRouted_1,maskRouted_0};
  assign _zz_2_ = io_chosenOH[1];
  assign io_chosen = _zz_2_;
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      locked <= 1'b0;
    end else begin
      if(io_output_valid)begin
        locked <= 1'b1;
      end
      if(((io_output_valid && io_output_ready) && io_output_payload_last))begin
        locked <= 1'b0;
      end
    end
  end

  always @ (posedge clock_out) begin
    if(io_output_valid)begin
      maskLocked_0 <= maskRouted_0;
      maskLocked_1 <= maskRouted_1;
    end
  end

endmodule

module SdramCtrl (
      input   io_bus_cmd_valid,
      output reg  io_bus_cmd_ready,
      input  [19:0] io_bus_cmd_payload_address,
      input   io_bus_cmd_payload_write,
      input  [15:0] io_bus_cmd_payload_data,
      input  [1:0] io_bus_cmd_payload_mask,
      input  [4:0] io_bus_cmd_payload_context_context,
      output  io_bus_rsp_valid,
      input   io_bus_rsp_ready,
      output [15:0] io_bus_rsp_payload_data,
      output [4:0] io_bus_rsp_payload_context_context,
      output [10:0] io_sdram_ADDR,
      output [0:0] io_sdram_BA,
      input  [15:0] io_sdram_DQ_read,
      output [15:0] io_sdram_DQ_write,
      output  io_sdram_DQ_writeEnable,
      output [1:0] io_sdram_DQM,
      output  io_sdram_CASn,
      output  io_sdram_CKE,
      output  io_sdram_CSn,
      output  io_sdram_RASn,
      output  io_sdram_WEn,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire  _zz_23_;
  reg  _zz_24_;
  reg [10:0] _zz_25_;
  reg  _zz_26_;
  reg  _zz_27_;
  wire  chip_backupIn_fifo_io_push_ready;
  wire  chip_backupIn_fifo_io_pop_valid;
  wire [15:0] chip_backupIn_fifo_io_pop_payload_data;
  wire [4:0] chip_backupIn_fifo_io_pop_payload_context_context;
  wire [1:0] chip_backupIn_fifo_io_occupancy;
  wire  _zz_28_;
  wire  _zz_29_;
  wire  _zz_30_;
  wire [0:0] _zz_31_;
  wire [7:0] _zz_32_;
  wire [0:0] _zz_33_;
  wire [2:0] _zz_34_;
  wire  refresh_counter_willIncrement;
  wire  refresh_counter_willClear;
  reg [7:0] refresh_counter_valueNext;
  reg [7:0] refresh_counter_value;
  wire  refresh_counter_willOverflowIfInc;
  wire  refresh_counter_willOverflow;
  reg  refresh_pending;
  reg [10:0] powerup_counter;
  reg  powerup_done;
  wire [10:0] _zz_1_;
  reg  frontend_banks_0_active;
  reg [10:0] frontend_banks_0_row;
  reg  frontend_banks_1_active;
  reg [10:0] frontend_banks_1_row;
  wire [7:0] frontend_address_column;
  wire [0:0] frontend_address_bank;
  wire [10:0] frontend_address_row;
  wire [19:0] _zz_2_;
  reg  frontend_rsp_valid;
  wire  frontend_rsp_ready;
  reg `SdramCtrlBackendTask_defaultEncoding_type frontend_rsp_payload_task;
  wire [0:0] frontend_rsp_payload_bank;
  reg [10:0] frontend_rsp_payload_rowColumn;
  wire [15:0] frontend_rsp_payload_data;
  wire [1:0] frontend_rsp_payload_mask;
  wire [4:0] frontend_rsp_payload_context_context;
  reg `SdramCtrlFrontendState_defaultEncoding_type frontend_state;
  reg  frontend_bootRefreshCounter_willIncrement;
  wire  frontend_bootRefreshCounter_willClear;
  reg [2:0] frontend_bootRefreshCounter_valueNext;
  reg [2:0] frontend_bootRefreshCounter_value;
  wire  frontend_bootRefreshCounter_willOverflowIfInc;
  wire  frontend_bootRefreshCounter_willOverflow;
  wire  _zz_3_;
  wire [1:0] _zz_4_;
  wire  _zz_5_;
  wire  _zz_6_;
  wire  bubbleInserter_cmd_valid;
  wire  bubbleInserter_cmd_ready;
  wire `SdramCtrlBackendTask_defaultEncoding_type bubbleInserter_cmd_payload_task;
  wire [0:0] bubbleInserter_cmd_payload_bank;
  wire [10:0] bubbleInserter_cmd_payload_rowColumn;
  wire [15:0] bubbleInserter_cmd_payload_data;
  wire [1:0] bubbleInserter_cmd_payload_mask;
  wire [4:0] bubbleInserter_cmd_payload_context_context;
  reg  _zz_7_;
  reg `SdramCtrlBackendTask_defaultEncoding_type _zz_8_;
  reg [0:0] _zz_9_;
  reg [10:0] _zz_10_;
  reg [15:0] _zz_11_;
  reg [1:0] _zz_12_;
  reg [4:0] _zz_13_;
  wire  bubbleInserter_rsp_valid;
  wire  bubbleInserter_rsp_ready;
  wire `SdramCtrlBackendTask_defaultEncoding_type bubbleInserter_rsp_payload_task;
  wire [0:0] bubbleInserter_rsp_payload_bank;
  wire [10:0] bubbleInserter_rsp_payload_rowColumn;
  wire [15:0] bubbleInserter_rsp_payload_data;
  wire [1:0] bubbleInserter_rsp_payload_mask;
  wire [4:0] bubbleInserter_rsp_payload_context_context;
  reg  bubbleInserter_insertBubble;
  wire  _zz_14_;
  wire `SdramCtrlBackendTask_defaultEncoding_type _zz_15_;
  wire  bubbleInserter_timings_read_busy;
  reg [2:0] bubbleInserter_timings_write_counter;
  wire  bubbleInserter_timings_write_busy;
  reg [0:0] bubbleInserter_timings_banks_0_precharge_counter;
  wire  bubbleInserter_timings_banks_0_precharge_busy;
  reg [0:0] bubbleInserter_timings_banks_0_active_counter;
  wire  bubbleInserter_timings_banks_0_active_busy;
  reg [0:0] bubbleInserter_timings_banks_1_precharge_counter;
  wire  bubbleInserter_timings_banks_1_precharge_busy;
  reg [0:0] bubbleInserter_timings_banks_1_active_counter;
  wire  bubbleInserter_timings_banks_1_active_busy;
  wire  chip_cmd_valid;
  wire  chip_cmd_ready;
  wire `SdramCtrlBackendTask_defaultEncoding_type chip_cmd_payload_task;
  wire [0:0] chip_cmd_payload_bank;
  wire [10:0] chip_cmd_payload_rowColumn;
  wire [15:0] chip_cmd_payload_data;
  wire [1:0] chip_cmd_payload_mask;
  wire [4:0] chip_cmd_payload_context_context;
  reg [10:0] chip_sdram_ADDR;
  reg [0:0] chip_sdram_BA;
  reg [15:0] chip_sdram_DQ_read;
  reg [15:0] chip_sdram_DQ_write;
  reg  chip_sdram_DQ_writeEnable;
  reg [1:0] chip_sdram_DQM;
  reg  chip_sdram_CASn;
  reg  chip_sdram_CKE;
  reg  chip_sdram_CSn;
  reg  chip_sdram_RASn;
  reg  chip_sdram_WEn;
  wire  chip_remoteCke;
  wire  chip_readHistory_0;
  wire  chip_readHistory_1;
  wire  chip_readHistory_2;
  wire  chip_readHistory_3;
  wire  chip_readHistory_4;
  wire  chip_readHistory_5;
  wire  _zz_16_;
  reg  _zz_17_;
  reg  _zz_18_;
  reg  _zz_19_;
  reg  _zz_20_;
  reg  _zz_21_;
  reg [4:0] chip_cmd_payload_context_delay_1_context;
  reg [4:0] chip_cmd_payload_context_delay_2_context;
  reg [4:0] chip_cmd_payload_context_delay_3_context;
  reg [4:0] chip_cmd_payload_context_delay_4_context;
  reg [4:0] chip_contextDelayed_context;
  wire  chip_sdramCkeNext;
  reg  chip_sdramCkeInternal;
  reg  chip_sdramCkeInternal_regNext;
  wire  _zz_22_;
  wire  chip_backupIn_valid;
  wire  chip_backupIn_ready;
  wire [15:0] chip_backupIn_payload_data;
  wire [4:0] chip_backupIn_payload_context_context;
  `ifndef SYNTHESIS
  reg [127:0] frontend_rsp_payload_task_string;
  reg [111:0] frontend_state_string;
  reg [127:0] bubbleInserter_cmd_payload_task_string;
  reg [127:0] _zz_8__string;
  reg [127:0] bubbleInserter_rsp_payload_task_string;
  reg [127:0] _zz_15__string;
  reg [127:0] chip_cmd_payload_task_string;
  `endif

  assign _zz_28_ = (frontend_banks_0_active || frontend_banks_1_active);
  assign _zz_29_ = (_zz_3_ && (_zz_25_ != frontend_address_row));
  assign _zz_30_ = (! _zz_3_);
  assign _zz_31_ = refresh_counter_willIncrement;
  assign _zz_32_ = {7'd0, _zz_31_};
  assign _zz_33_ = frontend_bootRefreshCounter_willIncrement;
  assign _zz_34_ = {2'd0, _zz_33_};
  StreamFifoLowLatency chip_backupIn_fifo ( 
    .io_push_valid(chip_backupIn_valid),
    .io_push_ready(chip_backupIn_fifo_io_push_ready),
    .io_push_payload_data(chip_backupIn_payload_data),
    .io_push_payload_context_context(chip_backupIn_payload_context_context),
    .io_pop_valid(chip_backupIn_fifo_io_pop_valid),
    .io_pop_ready(io_bus_rsp_ready),
    .io_pop_payload_data(chip_backupIn_fifo_io_pop_payload_data),
    .io_pop_payload_context_context(chip_backupIn_fifo_io_pop_payload_context_context),
    .io_flush(_zz_23_),
    .io_occupancy(chip_backupIn_fifo_io_occupancy),
    .clock_out(clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  always @(*) begin
    case(frontend_address_bank)
      1'b0 : begin
        _zz_24_ = frontend_banks_0_active;
        _zz_25_ = frontend_banks_0_row;
      end
      default : begin
        _zz_24_ = frontend_banks_1_active;
        _zz_25_ = frontend_banks_1_row;
      end
    endcase
  end

  always @(*) begin
    case(bubbleInserter_cmd_payload_bank)
      1'b0 : begin
        _zz_26_ = bubbleInserter_timings_banks_0_precharge_busy;
        _zz_27_ = bubbleInserter_timings_banks_0_active_busy;
      end
      default : begin
        _zz_26_ = bubbleInserter_timings_banks_1_precharge_busy;
        _zz_27_ = bubbleInserter_timings_banks_1_active_busy;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(frontend_rsp_payload_task)
      `SdramCtrlBackendTask_defaultEncoding_MODE : frontend_rsp_payload_task_string = "MODE            ";
      `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_ALL : frontend_rsp_payload_task_string = "PRECHARGE_ALL   ";
      `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_SINGLE : frontend_rsp_payload_task_string = "PRECHARGE_SINGLE";
      `SdramCtrlBackendTask_defaultEncoding_REFRESH : frontend_rsp_payload_task_string = "REFRESH         ";
      `SdramCtrlBackendTask_defaultEncoding_ACTIVE : frontend_rsp_payload_task_string = "ACTIVE          ";
      `SdramCtrlBackendTask_defaultEncoding_READ : frontend_rsp_payload_task_string = "READ            ";
      `SdramCtrlBackendTask_defaultEncoding_WRITE : frontend_rsp_payload_task_string = "WRITE           ";
      default : frontend_rsp_payload_task_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(frontend_state)
      `SdramCtrlFrontendState_defaultEncoding_BOOT_PRECHARGE : frontend_state_string = "BOOT_PRECHARGE";
      `SdramCtrlFrontendState_defaultEncoding_BOOT_REFRESH : frontend_state_string = "BOOT_REFRESH  ";
      `SdramCtrlFrontendState_defaultEncoding_BOOT_MODE : frontend_state_string = "BOOT_MODE     ";
      `SdramCtrlFrontendState_defaultEncoding_RUN : frontend_state_string = "RUN           ";
      default : frontend_state_string = "??????????????";
    endcase
  end
  always @(*) begin
    case(bubbleInserter_cmd_payload_task)
      `SdramCtrlBackendTask_defaultEncoding_MODE : bubbleInserter_cmd_payload_task_string = "MODE            ";
      `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_ALL : bubbleInserter_cmd_payload_task_string = "PRECHARGE_ALL   ";
      `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_SINGLE : bubbleInserter_cmd_payload_task_string = "PRECHARGE_SINGLE";
      `SdramCtrlBackendTask_defaultEncoding_REFRESH : bubbleInserter_cmd_payload_task_string = "REFRESH         ";
      `SdramCtrlBackendTask_defaultEncoding_ACTIVE : bubbleInserter_cmd_payload_task_string = "ACTIVE          ";
      `SdramCtrlBackendTask_defaultEncoding_READ : bubbleInserter_cmd_payload_task_string = "READ            ";
      `SdramCtrlBackendTask_defaultEncoding_WRITE : bubbleInserter_cmd_payload_task_string = "WRITE           ";
      default : bubbleInserter_cmd_payload_task_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(_zz_8_)
      `SdramCtrlBackendTask_defaultEncoding_MODE : _zz_8__string = "MODE            ";
      `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_ALL : _zz_8__string = "PRECHARGE_ALL   ";
      `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_SINGLE : _zz_8__string = "PRECHARGE_SINGLE";
      `SdramCtrlBackendTask_defaultEncoding_REFRESH : _zz_8__string = "REFRESH         ";
      `SdramCtrlBackendTask_defaultEncoding_ACTIVE : _zz_8__string = "ACTIVE          ";
      `SdramCtrlBackendTask_defaultEncoding_READ : _zz_8__string = "READ            ";
      `SdramCtrlBackendTask_defaultEncoding_WRITE : _zz_8__string = "WRITE           ";
      default : _zz_8__string = "????????????????";
    endcase
  end
  always @(*) begin
    case(bubbleInserter_rsp_payload_task)
      `SdramCtrlBackendTask_defaultEncoding_MODE : bubbleInserter_rsp_payload_task_string = "MODE            ";
      `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_ALL : bubbleInserter_rsp_payload_task_string = "PRECHARGE_ALL   ";
      `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_SINGLE : bubbleInserter_rsp_payload_task_string = "PRECHARGE_SINGLE";
      `SdramCtrlBackendTask_defaultEncoding_REFRESH : bubbleInserter_rsp_payload_task_string = "REFRESH         ";
      `SdramCtrlBackendTask_defaultEncoding_ACTIVE : bubbleInserter_rsp_payload_task_string = "ACTIVE          ";
      `SdramCtrlBackendTask_defaultEncoding_READ : bubbleInserter_rsp_payload_task_string = "READ            ";
      `SdramCtrlBackendTask_defaultEncoding_WRITE : bubbleInserter_rsp_payload_task_string = "WRITE           ";
      default : bubbleInserter_rsp_payload_task_string = "????????????????";
    endcase
  end
  always @(*) begin
    case(_zz_15_)
      `SdramCtrlBackendTask_defaultEncoding_MODE : _zz_15__string = "MODE            ";
      `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_ALL : _zz_15__string = "PRECHARGE_ALL   ";
      `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_SINGLE : _zz_15__string = "PRECHARGE_SINGLE";
      `SdramCtrlBackendTask_defaultEncoding_REFRESH : _zz_15__string = "REFRESH         ";
      `SdramCtrlBackendTask_defaultEncoding_ACTIVE : _zz_15__string = "ACTIVE          ";
      `SdramCtrlBackendTask_defaultEncoding_READ : _zz_15__string = "READ            ";
      `SdramCtrlBackendTask_defaultEncoding_WRITE : _zz_15__string = "WRITE           ";
      default : _zz_15__string = "????????????????";
    endcase
  end
  always @(*) begin
    case(chip_cmd_payload_task)
      `SdramCtrlBackendTask_defaultEncoding_MODE : chip_cmd_payload_task_string = "MODE            ";
      `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_ALL : chip_cmd_payload_task_string = "PRECHARGE_ALL   ";
      `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_SINGLE : chip_cmd_payload_task_string = "PRECHARGE_SINGLE";
      `SdramCtrlBackendTask_defaultEncoding_REFRESH : chip_cmd_payload_task_string = "REFRESH         ";
      `SdramCtrlBackendTask_defaultEncoding_ACTIVE : chip_cmd_payload_task_string = "ACTIVE          ";
      `SdramCtrlBackendTask_defaultEncoding_READ : chip_cmd_payload_task_string = "READ            ";
      `SdramCtrlBackendTask_defaultEncoding_WRITE : chip_cmd_payload_task_string = "WRITE           ";
      default : chip_cmd_payload_task_string = "????????????????";
    endcase
  end
  `endif

  assign refresh_counter_willClear = 1'b0;
  assign refresh_counter_willOverflowIfInc = (refresh_counter_value == (8'b11111001));
  assign refresh_counter_willOverflow = (refresh_counter_willOverflowIfInc && refresh_counter_willIncrement);
  always @ (*) begin
    if(refresh_counter_willOverflow)begin
      refresh_counter_valueNext = (8'b00000000);
    end else begin
      refresh_counter_valueNext = (refresh_counter_value + _zz_32_);
    end
    if(refresh_counter_willClear)begin
      refresh_counter_valueNext = (8'b00000000);
    end
  end

  assign refresh_counter_willIncrement = 1'b1;
  assign _zz_1_[10 : 0] = (11'b11111111111);
  assign _zz_2_ = io_bus_cmd_payload_address;
  assign frontend_address_column = _zz_2_[7 : 0];
  assign frontend_address_bank = _zz_2_[8 : 8];
  assign frontend_address_row = _zz_2_[19 : 9];
  always @ (*) begin
    frontend_rsp_valid = 1'b0;
    case(frontend_state)
      `SdramCtrlFrontendState_defaultEncoding_BOOT_PRECHARGE : begin
        if(powerup_done)begin
          frontend_rsp_valid = 1'b1;
        end
      end
      `SdramCtrlFrontendState_defaultEncoding_BOOT_REFRESH : begin
        frontend_rsp_valid = 1'b1;
      end
      `SdramCtrlFrontendState_defaultEncoding_BOOT_MODE : begin
        frontend_rsp_valid = 1'b1;
      end
      default : begin
        if(refresh_pending)begin
          frontend_rsp_valid = 1'b1;
        end else begin
          if(io_bus_cmd_valid)begin
            frontend_rsp_valid = 1'b1;
          end
        end
      end
    endcase
  end

  always @ (*) begin
    frontend_rsp_payload_task = `SdramCtrlBackendTask_defaultEncoding_REFRESH;
    case(frontend_state)
      `SdramCtrlFrontendState_defaultEncoding_BOOT_PRECHARGE : begin
        frontend_rsp_payload_task = `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_ALL;
      end
      `SdramCtrlFrontendState_defaultEncoding_BOOT_REFRESH : begin
        frontend_rsp_payload_task = `SdramCtrlBackendTask_defaultEncoding_REFRESH;
      end
      `SdramCtrlFrontendState_defaultEncoding_BOOT_MODE : begin
        frontend_rsp_payload_task = `SdramCtrlBackendTask_defaultEncoding_MODE;
      end
      default : begin
        if(refresh_pending)begin
          if(_zz_28_)begin
            frontend_rsp_payload_task = `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_ALL;
          end else begin
            frontend_rsp_payload_task = `SdramCtrlBackendTask_defaultEncoding_REFRESH;
          end
        end else begin
          if(io_bus_cmd_valid)begin
            if(_zz_29_)begin
              frontend_rsp_payload_task = `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_SINGLE;
            end else begin
              if(_zz_30_)begin
                frontend_rsp_payload_task = `SdramCtrlBackendTask_defaultEncoding_ACTIVE;
              end else begin
                frontend_rsp_payload_task = (io_bus_cmd_payload_write ? `SdramCtrlBackendTask_defaultEncoding_WRITE : `SdramCtrlBackendTask_defaultEncoding_READ);
              end
            end
          end
        end
      end
    endcase
  end

  assign frontend_rsp_payload_bank = frontend_address_bank;
  always @ (*) begin
    frontend_rsp_payload_rowColumn = frontend_address_row;
    case(frontend_state)
      `SdramCtrlFrontendState_defaultEncoding_BOOT_PRECHARGE : begin
      end
      `SdramCtrlFrontendState_defaultEncoding_BOOT_REFRESH : begin
      end
      `SdramCtrlFrontendState_defaultEncoding_BOOT_MODE : begin
      end
      default : begin
        if(! refresh_pending) begin
          if(io_bus_cmd_valid)begin
            if(! _zz_29_) begin
              if(! _zz_30_) begin
                frontend_rsp_payload_rowColumn = {3'd0, frontend_address_column};
              end
            end
          end
        end
      end
    endcase
  end

  assign frontend_rsp_payload_data = io_bus_cmd_payload_data;
  assign frontend_rsp_payload_mask = io_bus_cmd_payload_mask;
  assign frontend_rsp_payload_context_context = io_bus_cmd_payload_context_context;
  always @ (*) begin
    io_bus_cmd_ready = 1'b0;
    case(frontend_state)
      `SdramCtrlFrontendState_defaultEncoding_BOOT_PRECHARGE : begin
      end
      `SdramCtrlFrontendState_defaultEncoding_BOOT_REFRESH : begin
      end
      `SdramCtrlFrontendState_defaultEncoding_BOOT_MODE : begin
      end
      default : begin
        if(! refresh_pending) begin
          if(io_bus_cmd_valid)begin
            if(! _zz_29_) begin
              if(! _zz_30_) begin
                io_bus_cmd_ready = frontend_rsp_ready;
              end
            end
          end
        end
      end
    endcase
  end

  always @ (*) begin
    frontend_bootRefreshCounter_willIncrement = 1'b0;
    case(frontend_state)
      `SdramCtrlFrontendState_defaultEncoding_BOOT_PRECHARGE : begin
      end
      `SdramCtrlFrontendState_defaultEncoding_BOOT_REFRESH : begin
        if(frontend_rsp_ready)begin
          frontend_bootRefreshCounter_willIncrement = 1'b1;
        end
      end
      `SdramCtrlFrontendState_defaultEncoding_BOOT_MODE : begin
      end
      default : begin
      end
    endcase
  end

  assign frontend_bootRefreshCounter_willClear = 1'b0;
  assign frontend_bootRefreshCounter_willOverflowIfInc = (frontend_bootRefreshCounter_value == (3'b111));
  assign frontend_bootRefreshCounter_willOverflow = (frontend_bootRefreshCounter_willOverflowIfInc && frontend_bootRefreshCounter_willIncrement);
  always @ (*) begin
    frontend_bootRefreshCounter_valueNext = (frontend_bootRefreshCounter_value + _zz_34_);
    if(frontend_bootRefreshCounter_willClear)begin
      frontend_bootRefreshCounter_valueNext = (3'b000);
    end
  end

  assign _zz_3_ = _zz_24_;
  assign _zz_4_ = ({1'd0,(1'b1)} <<< frontend_address_bank);
  assign _zz_5_ = _zz_4_[0];
  assign _zz_6_ = _zz_4_[1];
  assign frontend_rsp_ready = ((1'b1 && (! bubbleInserter_cmd_valid)) || bubbleInserter_cmd_ready);
  assign bubbleInserter_cmd_valid = _zz_7_;
  assign bubbleInserter_cmd_payload_task = _zz_8_;
  assign bubbleInserter_cmd_payload_bank = _zz_9_;
  assign bubbleInserter_cmd_payload_rowColumn = _zz_10_;
  assign bubbleInserter_cmd_payload_data = _zz_11_;
  assign bubbleInserter_cmd_payload_mask = _zz_12_;
  assign bubbleInserter_cmd_payload_context_context = _zz_13_;
  always @ (*) begin
    bubbleInserter_insertBubble = 1'b0;
    if(bubbleInserter_cmd_valid)begin
      case(bubbleInserter_cmd_payload_task)
        `SdramCtrlBackendTask_defaultEncoding_MODE : begin
          bubbleInserter_insertBubble = bubbleInserter_timings_banks_0_active_busy;
        end
        `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_ALL : begin
          bubbleInserter_insertBubble = ({bubbleInserter_timings_banks_1_precharge_busy,bubbleInserter_timings_banks_0_precharge_busy} != (2'b00));
        end
        `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_SINGLE : begin
          bubbleInserter_insertBubble = _zz_26_;
        end
        `SdramCtrlBackendTask_defaultEncoding_REFRESH : begin
          bubbleInserter_insertBubble = ({bubbleInserter_timings_banks_1_active_busy,bubbleInserter_timings_banks_0_active_busy} != (2'b00));
        end
        `SdramCtrlBackendTask_defaultEncoding_ACTIVE : begin
          bubbleInserter_insertBubble = _zz_27_;
        end
        `SdramCtrlBackendTask_defaultEncoding_READ : begin
          bubbleInserter_insertBubble = bubbleInserter_timings_read_busy;
        end
        default : begin
          bubbleInserter_insertBubble = bubbleInserter_timings_write_busy;
        end
      endcase
    end
  end

  assign _zz_14_ = (! bubbleInserter_insertBubble);
  assign bubbleInserter_cmd_ready = (bubbleInserter_rsp_ready && _zz_14_);
  assign _zz_15_ = bubbleInserter_cmd_payload_task;
  assign bubbleInserter_rsp_valid = (bubbleInserter_cmd_valid && _zz_14_);
  assign bubbleInserter_rsp_payload_task = _zz_15_;
  assign bubbleInserter_rsp_payload_bank = bubbleInserter_cmd_payload_bank;
  assign bubbleInserter_rsp_payload_rowColumn = bubbleInserter_cmd_payload_rowColumn;
  assign bubbleInserter_rsp_payload_data = bubbleInserter_cmd_payload_data;
  assign bubbleInserter_rsp_payload_mask = bubbleInserter_cmd_payload_mask;
  assign bubbleInserter_rsp_payload_context_context = bubbleInserter_cmd_payload_context_context;
  assign bubbleInserter_timings_read_busy = 1'b0;
  assign bubbleInserter_timings_write_busy = (bubbleInserter_timings_write_counter != (3'b000));
  assign bubbleInserter_timings_banks_0_precharge_busy = (bubbleInserter_timings_banks_0_precharge_counter != (1'b0));
  assign bubbleInserter_timings_banks_0_active_busy = (bubbleInserter_timings_banks_0_active_counter != (1'b0));
  assign bubbleInserter_timings_banks_1_precharge_busy = (bubbleInserter_timings_banks_1_precharge_counter != (1'b0));
  assign bubbleInserter_timings_banks_1_active_busy = (bubbleInserter_timings_banks_1_active_counter != (1'b0));
  assign chip_cmd_valid = bubbleInserter_rsp_valid;
  assign bubbleInserter_rsp_ready = chip_cmd_ready;
  assign chip_cmd_payload_task = bubbleInserter_rsp_payload_task;
  assign chip_cmd_payload_bank = bubbleInserter_rsp_payload_bank;
  assign chip_cmd_payload_rowColumn = bubbleInserter_rsp_payload_rowColumn;
  assign chip_cmd_payload_data = bubbleInserter_rsp_payload_data;
  assign chip_cmd_payload_mask = bubbleInserter_rsp_payload_mask;
  assign chip_cmd_payload_context_context = bubbleInserter_rsp_payload_context_context;
  assign io_sdram_ADDR = chip_sdram_ADDR;
  assign io_sdram_BA = chip_sdram_BA;
  assign io_sdram_DQ_write = chip_sdram_DQ_write;
  assign io_sdram_DQ_writeEnable = chip_sdram_DQ_writeEnable;
  assign io_sdram_DQM = chip_sdram_DQM;
  assign io_sdram_CASn = chip_sdram_CASn;
  assign io_sdram_CKE = chip_sdram_CKE;
  assign io_sdram_CSn = chip_sdram_CSn;
  assign io_sdram_RASn = chip_sdram_RASn;
  assign io_sdram_WEn = chip_sdram_WEn;
  assign _zz_16_ = (chip_cmd_valid && ((chip_cmd_payload_task == `SdramCtrlBackendTask_defaultEncoding_READ) || (chip_cmd_payload_task == `SdramCtrlBackendTask_defaultEncoding_WRITE)));
  assign chip_readHistory_0 = _zz_16_;
  assign chip_readHistory_1 = _zz_17_;
  assign chip_readHistory_2 = _zz_18_;
  assign chip_readHistory_3 = _zz_19_;
  assign chip_readHistory_4 = _zz_20_;
  assign chip_readHistory_5 = _zz_21_;
  assign chip_sdramCkeNext = (! (({chip_readHistory_5,{chip_readHistory_4,{chip_readHistory_3,{chip_readHistory_2,{chip_readHistory_1,chip_readHistory_0}}}}} != (6'b000000)) && (! io_bus_rsp_ready)));
  assign chip_remoteCke = chip_sdramCkeInternal_regNext;
  assign _zz_22_ = (! chip_readHistory_1);
  assign chip_backupIn_valid = (chip_readHistory_5 && chip_remoteCke);
  assign chip_backupIn_payload_data = chip_sdram_DQ_read;
  assign chip_backupIn_payload_context_context = chip_contextDelayed_context;
  assign chip_backupIn_ready = chip_backupIn_fifo_io_push_ready;
  assign io_bus_rsp_valid = chip_backupIn_fifo_io_pop_valid;
  assign io_bus_rsp_payload_data = chip_backupIn_fifo_io_pop_payload_data;
  assign io_bus_rsp_payload_context_context = chip_backupIn_fifo_io_pop_payload_context_context;
  assign chip_cmd_ready = chip_remoteCke;
  assign _zz_23_ = 1'b0;
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      refresh_counter_value <= (8'b00000000);
      refresh_pending <= 1'b0;
      powerup_counter <= (11'b00000000000);
      powerup_done <= 1'b0;
      frontend_banks_0_active <= 1'b0;
      frontend_banks_1_active <= 1'b0;
      frontend_state <= `SdramCtrlFrontendState_defaultEncoding_BOOT_PRECHARGE;
      frontend_bootRefreshCounter_value <= (3'b000);
      _zz_7_ <= 1'b0;
      bubbleInserter_timings_write_counter <= (3'b000);
      bubbleInserter_timings_banks_0_precharge_counter <= (1'b0);
      bubbleInserter_timings_banks_0_active_counter <= (1'b0);
      bubbleInserter_timings_banks_1_precharge_counter <= (1'b0);
      bubbleInserter_timings_banks_1_active_counter <= (1'b0);
      _zz_17_ <= 1'b0;
      _zz_18_ <= 1'b0;
      _zz_19_ <= 1'b0;
      _zz_20_ <= 1'b0;
      _zz_21_ <= 1'b0;
      chip_sdramCkeInternal <= 1'b1;
      chip_sdramCkeInternal_regNext <= 1'b1;
    end else begin
      refresh_counter_value <= refresh_counter_valueNext;
      if(refresh_counter_willOverflow)begin
        refresh_pending <= 1'b1;
      end
      if((! powerup_done))begin
        powerup_counter <= (powerup_counter + (11'b00000000001));
        if((powerup_counter == _zz_1_))begin
          powerup_done <= 1'b1;
        end
      end
      frontend_bootRefreshCounter_value <= frontend_bootRefreshCounter_valueNext;
      case(frontend_state)
        `SdramCtrlFrontendState_defaultEncoding_BOOT_PRECHARGE : begin
          if(powerup_done)begin
            if(frontend_rsp_ready)begin
              frontend_state <= `SdramCtrlFrontendState_defaultEncoding_BOOT_REFRESH;
            end
          end
        end
        `SdramCtrlFrontendState_defaultEncoding_BOOT_REFRESH : begin
          if(frontend_rsp_ready)begin
            if(frontend_bootRefreshCounter_willOverflowIfInc)begin
              frontend_state <= `SdramCtrlFrontendState_defaultEncoding_BOOT_MODE;
            end
          end
        end
        `SdramCtrlFrontendState_defaultEncoding_BOOT_MODE : begin
          if(frontend_rsp_ready)begin
            frontend_state <= `SdramCtrlFrontendState_defaultEncoding_RUN;
          end
        end
        default : begin
          if(refresh_pending)begin
            if(_zz_28_)begin
              if(frontend_rsp_ready)begin
                frontend_banks_0_active <= 1'b0;
                frontend_banks_1_active <= 1'b0;
              end
            end else begin
              if(frontend_rsp_ready)begin
                refresh_pending <= 1'b0;
              end
            end
          end else begin
            if(io_bus_cmd_valid)begin
              if(_zz_29_)begin
                if(frontend_rsp_ready)begin
                  if(_zz_5_)begin
                    frontend_banks_0_active <= 1'b0;
                  end
                  if(_zz_6_)begin
                    frontend_banks_1_active <= 1'b0;
                  end
                end
              end else begin
                if(_zz_30_)begin
                  if(frontend_rsp_ready)begin
                    if(_zz_5_)begin
                      frontend_banks_0_active <= 1'b1;
                    end
                    if(_zz_6_)begin
                      frontend_banks_1_active <= 1'b1;
                    end
                  end
                end
              end
            end
          end
        end
      endcase
      if(frontend_rsp_ready)begin
        _zz_7_ <= frontend_rsp_valid;
      end
      if((bubbleInserter_timings_write_busy && bubbleInserter_rsp_ready))begin
        bubbleInserter_timings_write_counter <= (bubbleInserter_timings_write_counter - (3'b001));
      end
      if((bubbleInserter_timings_banks_0_precharge_busy && bubbleInserter_rsp_ready))begin
        bubbleInserter_timings_banks_0_precharge_counter <= (bubbleInserter_timings_banks_0_precharge_counter - (1'b1));
      end
      if((bubbleInserter_timings_banks_0_active_busy && bubbleInserter_rsp_ready))begin
        bubbleInserter_timings_banks_0_active_counter <= (bubbleInserter_timings_banks_0_active_counter - (1'b1));
      end
      if((bubbleInserter_timings_banks_1_precharge_busy && bubbleInserter_rsp_ready))begin
        bubbleInserter_timings_banks_1_precharge_counter <= (bubbleInserter_timings_banks_1_precharge_counter - (1'b1));
      end
      if((bubbleInserter_timings_banks_1_active_busy && bubbleInserter_rsp_ready))begin
        bubbleInserter_timings_banks_1_active_counter <= (bubbleInserter_timings_banks_1_active_counter - (1'b1));
      end
      if(bubbleInserter_cmd_valid)begin
        case(bubbleInserter_cmd_payload_task)
          `SdramCtrlBackendTask_defaultEncoding_MODE : begin
            if(bubbleInserter_cmd_ready)begin
              if((bubbleInserter_timings_banks_0_active_counter <= (1'b1)))begin
                bubbleInserter_timings_banks_0_active_counter <= (1'b1);
              end
              if((bubbleInserter_timings_banks_1_active_counter <= (1'b1)))begin
                bubbleInserter_timings_banks_1_active_counter <= (1'b1);
              end
            end
          end
          `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_ALL : begin
            if(bubbleInserter_cmd_ready)begin
              if((bubbleInserter_timings_banks_0_active_counter <= (1'b0)))begin
                bubbleInserter_timings_banks_0_active_counter <= (1'b0);
              end
            end
          end
          `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_SINGLE : begin
            if(bubbleInserter_cmd_ready)begin
              if((bubbleInserter_cmd_payload_bank == (1'b0)))begin
                if((bubbleInserter_timings_banks_0_active_counter <= (1'b0)))begin
                  bubbleInserter_timings_banks_0_active_counter <= (1'b0);
                end
              end
              if((bubbleInserter_cmd_payload_bank == (1'b1)))begin
                if((bubbleInserter_timings_banks_1_active_counter <= (1'b0)))begin
                  bubbleInserter_timings_banks_1_active_counter <= (1'b0);
                end
              end
            end
          end
          `SdramCtrlBackendTask_defaultEncoding_REFRESH : begin
            if(bubbleInserter_cmd_ready)begin
              if((bubbleInserter_timings_banks_0_active_counter <= (1'b1)))begin
                bubbleInserter_timings_banks_0_active_counter <= (1'b1);
              end
              if((bubbleInserter_timings_banks_1_active_counter <= (1'b1)))begin
                bubbleInserter_timings_banks_1_active_counter <= (1'b1);
              end
            end
          end
          `SdramCtrlBackendTask_defaultEncoding_ACTIVE : begin
            if(bubbleInserter_cmd_ready)begin
              if((bubbleInserter_timings_write_counter <= (3'b000)))begin
                bubbleInserter_timings_write_counter <= (3'b000);
              end
              if((bubbleInserter_cmd_payload_bank == (1'b0)))begin
                if((bubbleInserter_timings_banks_0_precharge_counter <= (1'b0)))begin
                  bubbleInserter_timings_banks_0_precharge_counter <= (1'b0);
                end
              end
              if((bubbleInserter_cmd_payload_bank == (1'b1)))begin
                if((bubbleInserter_timings_banks_1_precharge_counter <= (1'b0)))begin
                  bubbleInserter_timings_banks_1_precharge_counter <= (1'b0);
                end
              end
              if((bubbleInserter_cmd_payload_bank == (1'b0)))begin
                if((bubbleInserter_timings_banks_0_active_counter <= (1'b1)))begin
                  bubbleInserter_timings_banks_0_active_counter <= (1'b1);
                end
              end
              if((bubbleInserter_cmd_payload_bank == (1'b1)))begin
                if((bubbleInserter_timings_banks_1_active_counter <= (1'b1)))begin
                  bubbleInserter_timings_banks_1_active_counter <= (1'b1);
                end
              end
            end
          end
          `SdramCtrlBackendTask_defaultEncoding_READ : begin
            if(bubbleInserter_cmd_ready)begin
              if((bubbleInserter_timings_write_counter <= (3'b100)))begin
                bubbleInserter_timings_write_counter <= (3'b100);
              end
            end
          end
          default : begin
            if(bubbleInserter_cmd_ready)begin
              if((bubbleInserter_cmd_payload_bank == (1'b0)))begin
                if((bubbleInserter_timings_banks_0_precharge_counter <= (1'b1)))begin
                  bubbleInserter_timings_banks_0_precharge_counter <= (1'b1);
                end
              end
              if((bubbleInserter_cmd_payload_bank == (1'b1)))begin
                if((bubbleInserter_timings_banks_1_precharge_counter <= (1'b1)))begin
                  bubbleInserter_timings_banks_1_precharge_counter <= (1'b1);
                end
              end
            end
          end
        endcase
      end
      if(chip_remoteCke)begin
        _zz_17_ <= _zz_16_;
      end
      if(chip_remoteCke)begin
        _zz_18_ <= _zz_17_;
      end
      if(chip_remoteCke)begin
        _zz_19_ <= _zz_18_;
      end
      if(chip_remoteCke)begin
        _zz_20_ <= _zz_19_;
      end
      if(chip_remoteCke)begin
        _zz_21_ <= _zz_20_;
      end
      chip_sdramCkeInternal <= chip_sdramCkeNext;
      chip_sdramCkeInternal_regNext <= chip_sdramCkeInternal;
    end
  end

  always @ (posedge clock_out) begin
    case(frontend_state)
      `SdramCtrlFrontendState_defaultEncoding_BOOT_PRECHARGE : begin
      end
      `SdramCtrlFrontendState_defaultEncoding_BOOT_REFRESH : begin
      end
      `SdramCtrlFrontendState_defaultEncoding_BOOT_MODE : begin
      end
      default : begin
        if(! refresh_pending) begin
          if(io_bus_cmd_valid)begin
            if(! _zz_29_) begin
              if(_zz_30_)begin
                if(_zz_5_)begin
                  frontend_banks_0_row <= frontend_address_row;
                end
                if(_zz_6_)begin
                  frontend_banks_1_row <= frontend_address_row;
                end
              end
            end
          end
        end
      end
    endcase
    if(frontend_rsp_ready)begin
      _zz_8_ <= frontend_rsp_payload_task;
      _zz_9_ <= frontend_rsp_payload_bank;
      _zz_10_ <= frontend_rsp_payload_rowColumn;
      _zz_11_ <= frontend_rsp_payload_data;
      _zz_12_ <= frontend_rsp_payload_mask;
      _zz_13_ <= frontend_rsp_payload_context_context;
    end
    if(chip_remoteCke)begin
      chip_cmd_payload_context_delay_1_context <= chip_cmd_payload_context_context;
    end
    if(chip_remoteCke)begin
      chip_cmd_payload_context_delay_2_context <= chip_cmd_payload_context_delay_1_context;
    end
    if(chip_remoteCke)begin
      chip_cmd_payload_context_delay_3_context <= chip_cmd_payload_context_delay_2_context;
    end
    if(chip_remoteCke)begin
      chip_cmd_payload_context_delay_4_context <= chip_cmd_payload_context_delay_3_context;
    end
    if(chip_remoteCke)begin
      chip_contextDelayed_context <= chip_cmd_payload_context_delay_4_context;
    end
    chip_sdram_CKE <= chip_sdramCkeNext;
    if(chip_remoteCke)begin
      chip_sdram_DQ_read <= io_sdram_DQ_read;
      chip_sdram_CSn <= 1'b0;
      chip_sdram_RASn <= 1'b1;
      chip_sdram_CASn <= 1'b1;
      chip_sdram_WEn <= 1'b1;
      chip_sdram_DQ_write <= chip_cmd_payload_data;
      chip_sdram_DQ_writeEnable <= 1'b0;
      chip_sdram_DQM[0] <= _zz_22_;
      chip_sdram_DQM[1] <= _zz_22_;
      if(chip_cmd_valid)begin
        case(chip_cmd_payload_task)
          `SdramCtrlBackendTask_defaultEncoding_PRECHARGE_ALL : begin
            chip_sdram_ADDR[10] <= 1'b1;
            chip_sdram_CSn <= 1'b0;
            chip_sdram_RASn <= 1'b0;
            chip_sdram_CASn <= 1'b1;
            chip_sdram_WEn <= 1'b0;
          end
          `SdramCtrlBackendTask_defaultEncoding_REFRESH : begin
            chip_sdram_CSn <= 1'b0;
            chip_sdram_RASn <= 1'b0;
            chip_sdram_CASn <= 1'b0;
            chip_sdram_WEn <= 1'b1;
          end
          `SdramCtrlBackendTask_defaultEncoding_MODE : begin
            chip_sdram_ADDR <= (11'b00000000000);
            chip_sdram_ADDR[2 : 0] <= (3'b000);
            chip_sdram_ADDR[3] <= 1'b0;
            chip_sdram_ADDR[6 : 4] <= (3'b011);
            chip_sdram_ADDR[8 : 7] <= (2'b00);
            chip_sdram_ADDR[9] <= 1'b0;
            chip_sdram_BA <= (1'b0);
            chip_sdram_CSn <= 1'b0;
            chip_sdram_RASn <= 1'b0;
            chip_sdram_CASn <= 1'b0;
            chip_sdram_WEn <= 1'b0;
          end
          `SdramCtrlBackendTask_defaultEncoding_ACTIVE : begin
            chip_sdram_ADDR <= chip_cmd_payload_rowColumn;
            chip_sdram_BA <= chip_cmd_payload_bank;
            chip_sdram_CSn <= 1'b0;
            chip_sdram_RASn <= 1'b0;
            chip_sdram_CASn <= 1'b1;
            chip_sdram_WEn <= 1'b1;
          end
          `SdramCtrlBackendTask_defaultEncoding_WRITE : begin
            chip_sdram_ADDR <= chip_cmd_payload_rowColumn;
            chip_sdram_ADDR[10] <= 1'b0;
            chip_sdram_DQ_writeEnable <= 1'b1;
            chip_sdram_DQ_write <= chip_cmd_payload_data;
            chip_sdram_DQM <= (~ chip_cmd_payload_mask);
            chip_sdram_BA <= chip_cmd_payload_bank;
            chip_sdram_CSn <= 1'b0;
            chip_sdram_RASn <= 1'b1;
            chip_sdram_CASn <= 1'b0;
            chip_sdram_WEn <= 1'b0;
          end
          `SdramCtrlBackendTask_defaultEncoding_READ : begin
            chip_sdram_ADDR <= chip_cmd_payload_rowColumn;
            chip_sdram_ADDR[10] <= 1'b0;
            chip_sdram_BA <= chip_cmd_payload_bank;
            chip_sdram_CSn <= 1'b0;
            chip_sdram_RASn <= 1'b1;
            chip_sdram_CASn <= 1'b0;
            chip_sdram_WEn <= 1'b1;
          end
          default : begin
            chip_sdram_BA <= chip_cmd_payload_bank;
            chip_sdram_ADDR[10] <= 1'b0;
            chip_sdram_CSn <= 1'b0;
            chip_sdram_RASn <= 1'b0;
            chip_sdram_CASn <= 1'b1;
            chip_sdram_WEn <= 1'b0;
          end
        endcase
      end
    end
  end

endmodule

module StreamArbiter_1_ (
      input   io_inputs_0_valid,
      output  io_inputs_0_ready,
      input   io_inputs_0_payload_last,
      input  [0:0] io_inputs_0_payload_fragment_source,
      input  [0:0] io_inputs_0_payload_fragment_opcode,
      input  [20:0] io_inputs_0_payload_fragment_address,
      input  [1:0] io_inputs_0_payload_fragment_length,
      input  [31:0] io_inputs_0_payload_fragment_data,
      input  [3:0] io_inputs_0_payload_fragment_mask,
      input  [0:0] io_inputs_0_payload_fragment_context,
      input   io_inputs_1_valid,
      output  io_inputs_1_ready,
      input   io_inputs_1_payload_last,
      input  [0:0] io_inputs_1_payload_fragment_source,
      input  [0:0] io_inputs_1_payload_fragment_opcode,
      input  [20:0] io_inputs_1_payload_fragment_address,
      input  [1:0] io_inputs_1_payload_fragment_length,
      input  [31:0] io_inputs_1_payload_fragment_data,
      input  [3:0] io_inputs_1_payload_fragment_mask,
      input  [0:0] io_inputs_1_payload_fragment_context,
      output  io_output_valid,
      input   io_output_ready,
      output  io_output_payload_last,
      output [0:0] io_output_payload_fragment_source,
      output [0:0] io_output_payload_fragment_opcode,
      output [20:0] io_output_payload_fragment_address,
      output [1:0] io_output_payload_fragment_length,
      output [31:0] io_output_payload_fragment_data,
      output [3:0] io_output_payload_fragment_mask,
      output [0:0] io_output_payload_fragment_context,
      output [0:0] io_chosen,
      output [1:0] io_chosenOH,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire [1:0] _zz_3_;
  wire [1:0] _zz_4_;
  reg  locked;
  wire  maskProposal_0;
  wire  maskProposal_1;
  reg  maskLocked_0;
  reg  maskLocked_1;
  wire  maskRouted_0;
  wire  maskRouted_1;
  wire [1:0] _zz_1_;
  wire  _zz_2_;
  assign _zz_3_ = (_zz_1_ & (~ _zz_4_));
  assign _zz_4_ = (_zz_1_ - (2'b01));
  assign maskRouted_0 = (locked ? maskLocked_0 : maskProposal_0);
  assign maskRouted_1 = (locked ? maskLocked_1 : maskProposal_1);
  assign _zz_1_ = {io_inputs_1_valid,io_inputs_0_valid};
  assign maskProposal_0 = io_inputs_0_valid;
  assign maskProposal_1 = _zz_3_[1];
  assign io_output_valid = ((io_inputs_0_valid && maskRouted_0) || (io_inputs_1_valid && maskRouted_1));
  assign io_output_payload_last = (maskRouted_0 ? io_inputs_0_payload_last : io_inputs_1_payload_last);
  assign io_output_payload_fragment_source = (maskRouted_0 ? io_inputs_0_payload_fragment_source : io_inputs_1_payload_fragment_source);
  assign io_output_payload_fragment_opcode = (maskRouted_0 ? io_inputs_0_payload_fragment_opcode : io_inputs_1_payload_fragment_opcode);
  assign io_output_payload_fragment_address = (maskRouted_0 ? io_inputs_0_payload_fragment_address : io_inputs_1_payload_fragment_address);
  assign io_output_payload_fragment_length = (maskRouted_0 ? io_inputs_0_payload_fragment_length : io_inputs_1_payload_fragment_length);
  assign io_output_payload_fragment_data = (maskRouted_0 ? io_inputs_0_payload_fragment_data : io_inputs_1_payload_fragment_data);
  assign io_output_payload_fragment_mask = (maskRouted_0 ? io_inputs_0_payload_fragment_mask : io_inputs_1_payload_fragment_mask);
  assign io_output_payload_fragment_context = (maskRouted_0 ? io_inputs_0_payload_fragment_context : io_inputs_1_payload_fragment_context);
  assign io_inputs_0_ready = (maskRouted_0 && io_output_ready);
  assign io_inputs_1_ready = (maskRouted_1 && io_output_ready);
  assign io_chosenOH = {maskRouted_1,maskRouted_0};
  assign _zz_2_ = io_chosenOH[1];
  assign io_chosen = _zz_2_;
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      locked <= 1'b0;
    end else begin
      if(io_output_valid)begin
        locked <= 1'b1;
      end
      if(((io_output_valid && io_output_ready) && io_output_payload_last))begin
        locked <= 1'b0;
      end
    end
  end

  always @ (posedge clock_out) begin
    if(io_output_valid)begin
      maskLocked_0 <= maskRouted_0;
      maskLocked_1 <= maskRouted_1;
    end
  end

endmodule

module BufferCC_3_ (
      input   io_dataIn,
      output  io_dataOut,
      input   clock_out);
  reg  buffers_0;
  reg  buffers_1;
  assign io_dataOut = buffers_1;
  always @ (posedge clock_out) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end

endmodule

module Apb3UartCtrl (
      input  [3:0] io_apb_PADDR,
      input  [0:0] io_apb_PSEL,
      input   io_apb_PENABLE,
      output  io_apb_PREADY,
      input   io_apb_PWRITE,
      input  [31:0] io_apb_PWDATA,
      output reg [31:0] io_apb_PRDATA,
      output  io_uart_txd,
      input   io_uart_rxd,
      output  io_interrupt,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire  _zz_3_;
  reg  _zz_4_;
  wire  _zz_5_;
  wire  uartCtrl_1__io_write_ready;
  wire  uartCtrl_1__io_read_valid;
  wire [7:0] uartCtrl_1__io_read_payload;
  wire  uartCtrl_1__io_uart_txd;
  wire  bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready;
  wire  bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid;
  wire [7:0] bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload;
  wire [0:0] bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy;
  wire [0:0] bridge_write_streamUnbuffered_queueWithOccupancy_io_availability;
  wire  uartCtrl_1__io_read_queueWithOccupancy_io_push_ready;
  wire  uartCtrl_1__io_read_queueWithOccupancy_io_pop_valid;
  wire [7:0] uartCtrl_1__io_read_queueWithOccupancy_io_pop_payload;
  wire [0:0] uartCtrl_1__io_read_queueWithOccupancy_io_occupancy;
  wire [0:0] uartCtrl_1__io_read_queueWithOccupancy_io_availability;
  wire [0:0] _zz_6_;
  wire [0:0] _zz_7_;
  wire [0:0] _zz_8_;
  wire  busCtrl_askWrite;
  wire  busCtrl_askRead;
  wire  busCtrl_doWrite;
  wire  busCtrl_doRead;
  wire [2:0] bridge_uartConfigReg_frame_dataLength;
  wire `UartStopType_defaultEncoding_type bridge_uartConfigReg_frame_stop;
  wire `UartParityType_defaultEncoding_type bridge_uartConfigReg_frame_parity;
  reg [11:0] bridge_uartConfigReg_clockDivider;
  reg  _zz_1_;
  wire  bridge_write_streamUnbuffered_valid;
  wire  bridge_write_streamUnbuffered_ready;
  wire [7:0] bridge_write_streamUnbuffered_payload;
  reg  bridge_interruptCtrl_writeIntEnable;
  reg  bridge_interruptCtrl_readIntEnable;
  wire  bridge_interruptCtrl_readInt;
  wire  bridge_interruptCtrl_writeInt;
  wire  bridge_interruptCtrl_interrupt;
  wire [7:0] _zz_2_;
  `ifndef SYNTHESIS
  reg [23:0] bridge_uartConfigReg_frame_stop_string;
  reg [31:0] bridge_uartConfigReg_frame_parity_string;
  `endif

  function [11:0] zz_bridge_uartConfigReg_clockDivider(input dummy);
    begin
      zz_bridge_uartConfigReg_clockDivider = (12'b000000000000);
      zz_bridge_uartConfigReg_clockDivider = (12'b000000011010);
    end
  endfunction
  wire [11:0] _zz_9_;
  assign _zz_6_ = io_apb_PWDATA[0 : 0];
  assign _zz_7_ = io_apb_PWDATA[1 : 1];
  assign _zz_8_ = ((1'b1) - bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy);
  UartCtrl uartCtrl_1_ ( 
    .io_config_frame_dataLength(bridge_uartConfigReg_frame_dataLength),
    .io_config_frame_stop(bridge_uartConfigReg_frame_stop),
    .io_config_frame_parity(bridge_uartConfigReg_frame_parity),
    .io_config_clockDivider(bridge_uartConfigReg_clockDivider),
    .io_write_valid(bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid),
    .io_write_ready(uartCtrl_1__io_write_ready),
    .io_write_payload(bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload),
    .io_read_valid(uartCtrl_1__io_read_valid),
    .io_read_payload(uartCtrl_1__io_read_payload),
    .io_uart_txd(uartCtrl_1__io_uart_txd),
    .io_uart_rxd(io_uart_rxd),
    .clock_out(clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  StreamFifo bridge_write_streamUnbuffered_queueWithOccupancy ( 
    .io_push_valid(bridge_write_streamUnbuffered_valid),
    .io_push_ready(bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready),
    .io_push_payload(bridge_write_streamUnbuffered_payload),
    .io_pop_valid(bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid),
    .io_pop_ready(uartCtrl_1__io_write_ready),
    .io_pop_payload(bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload),
    .io_flush(_zz_3_),
    .io_occupancy(bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy),
    .io_availability(bridge_write_streamUnbuffered_queueWithOccupancy_io_availability),
    .clock_out(clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  StreamFifo uartCtrl_1__io_read_queueWithOccupancy ( 
    .io_push_valid(uartCtrl_1__io_read_valid),
    .io_push_ready(uartCtrl_1__io_read_queueWithOccupancy_io_push_ready),
    .io_push_payload(uartCtrl_1__io_read_payload),
    .io_pop_valid(uartCtrl_1__io_read_queueWithOccupancy_io_pop_valid),
    .io_pop_ready(_zz_4_),
    .io_pop_payload(uartCtrl_1__io_read_queueWithOccupancy_io_pop_payload),
    .io_flush(_zz_5_),
    .io_occupancy(uartCtrl_1__io_read_queueWithOccupancy_io_occupancy),
    .io_availability(uartCtrl_1__io_read_queueWithOccupancy_io_availability),
    .clock_out(clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(bridge_uartConfigReg_frame_stop)
      `UartStopType_defaultEncoding_ONE : bridge_uartConfigReg_frame_stop_string = "ONE";
      `UartStopType_defaultEncoding_TWO : bridge_uartConfigReg_frame_stop_string = "TWO";
      default : bridge_uartConfigReg_frame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(bridge_uartConfigReg_frame_parity)
      `UartParityType_defaultEncoding_NONE : bridge_uartConfigReg_frame_parity_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : bridge_uartConfigReg_frame_parity_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : bridge_uartConfigReg_frame_parity_string = "ODD ";
      default : bridge_uartConfigReg_frame_parity_string = "????";
    endcase
  end
  `endif

  assign io_uart_txd = uartCtrl_1__io_uart_txd;
  assign io_apb_PREADY = 1'b1;
  always @ (*) begin
    io_apb_PRDATA = (32'b00000000000000000000000000000000);
    case(io_apb_PADDR)
      4'b0000 : begin
        io_apb_PRDATA[16 : 16] = (uartCtrl_1__io_read_queueWithOccupancy_io_pop_valid ^ 1'b0);
        io_apb_PRDATA[7 : 0] = uartCtrl_1__io_read_queueWithOccupancy_io_pop_payload;
      end
      4'b0100 : begin
        io_apb_PRDATA[16 : 16] = _zz_8_;
        io_apb_PRDATA[24 : 24] = uartCtrl_1__io_read_queueWithOccupancy_io_occupancy;
        io_apb_PRDATA[0 : 0] = bridge_interruptCtrl_writeIntEnable;
        io_apb_PRDATA[1 : 1] = bridge_interruptCtrl_readIntEnable;
        io_apb_PRDATA[8 : 8] = bridge_interruptCtrl_writeInt;
        io_apb_PRDATA[9 : 9] = bridge_interruptCtrl_readInt;
      end
      default : begin
      end
    endcase
  end

  assign busCtrl_askWrite = ((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PWRITE);
  assign busCtrl_askRead = ((io_apb_PSEL[0] && io_apb_PENABLE) && (! io_apb_PWRITE));
  assign busCtrl_doWrite = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && io_apb_PWRITE);
  assign busCtrl_doRead = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && (! io_apb_PWRITE));
  assign _zz_9_ = zz_bridge_uartConfigReg_clockDivider(1'b0);
  always @ (*) bridge_uartConfigReg_clockDivider = _zz_9_;
  assign bridge_uartConfigReg_frame_dataLength = (3'b111);
  assign bridge_uartConfigReg_frame_parity = `UartParityType_defaultEncoding_NONE;
  assign bridge_uartConfigReg_frame_stop = `UartStopType_defaultEncoding_ONE;
  always @ (*) begin
    _zz_1_ = 1'b0;
    case(io_apb_PADDR)
      4'b0000 : begin
        if(busCtrl_doWrite)begin
          _zz_1_ = 1'b1;
        end
      end
      4'b0100 : begin
      end
      default : begin
      end
    endcase
  end

  assign bridge_write_streamUnbuffered_valid = _zz_1_;
  assign bridge_write_streamUnbuffered_payload = _zz_2_;
  assign bridge_write_streamUnbuffered_ready = bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready;
  always @ (*) begin
    _zz_4_ = 1'b0;
    case(io_apb_PADDR)
      4'b0000 : begin
        if(busCtrl_doRead)begin
          _zz_4_ = 1'b1;
        end
      end
      4'b0100 : begin
      end
      default : begin
      end
    endcase
  end

  assign bridge_interruptCtrl_readInt = (bridge_interruptCtrl_readIntEnable && uartCtrl_1__io_read_queueWithOccupancy_io_pop_valid);
  assign bridge_interruptCtrl_writeInt = (bridge_interruptCtrl_writeIntEnable && (! bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid));
  assign bridge_interruptCtrl_interrupt = (bridge_interruptCtrl_readInt || bridge_interruptCtrl_writeInt);
  assign io_interrupt = bridge_interruptCtrl_interrupt;
  assign _zz_2_ = io_apb_PWDATA[7 : 0];
  assign _zz_3_ = 1'b0;
  assign _zz_5_ = 1'b0;
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      bridge_interruptCtrl_writeIntEnable <= 1'b0;
      bridge_interruptCtrl_readIntEnable <= 1'b0;
    end else begin
      case(io_apb_PADDR)
        4'b0000 : begin
        end
        4'b0100 : begin
          if(busCtrl_doWrite)begin
            bridge_interruptCtrl_writeIntEnable <= _zz_6_[0];
            bridge_interruptCtrl_readIntEnable <= _zz_7_[0];
          end
        end
        default : begin
        end
      endcase
    end
  end

endmodule

module Apb3Gpio2 (
      input  [7:0] io_gpio_read,
      output reg [7:0] io_gpio_write,
      output reg [7:0] io_gpio_writeEnable,
      input  [11:0] io_bus_PADDR,
      input  [0:0] io_bus_PSEL,
      input   io_bus_PENABLE,
      output  io_bus_PREADY,
      input   io_bus_PWRITE,
      input  [31:0] io_bus_PWDATA,
      output reg [31:0] io_bus_PRDATA,
      output  io_bus_PSLVERROR,
      output reg [7:0] io_interrupt,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire [7:0] bufferCC_4__io_dataOut;
  wire [0:0] _zz_17_;
  wire [0:0] _zz_18_;
  wire [0:0] _zz_19_;
  wire [0:0] _zz_20_;
  wire [0:0] _zz_21_;
  wire [0:0] _zz_22_;
  wire [0:0] _zz_23_;
  wire [0:0] _zz_24_;
  wire [0:0] _zz_25_;
  wire [0:0] _zz_26_;
  wire [0:0] _zz_27_;
  wire [0:0] _zz_28_;
  wire [0:0] _zz_29_;
  wire [0:0] _zz_30_;
  wire [0:0] _zz_31_;
  wire [0:0] _zz_32_;
  wire  mapper_askWrite;
  wire  mapper_askRead;
  wire  mapper_doWrite;
  wire  mapper_doRead;
  wire [7:0] syncronized;
  reg [7:0] last;
  reg  _zz_1_;
  reg  _zz_2_;
  reg  _zz_3_;
  reg  _zz_4_;
  reg  _zz_5_;
  reg  _zz_6_;
  reg  _zz_7_;
  reg  _zz_8_;
  reg  _zz_9_;
  reg  _zz_10_;
  reg  _zz_11_;
  reg  _zz_12_;
  reg  _zz_13_;
  reg  _zz_14_;
  reg  _zz_15_;
  reg  _zz_16_;
  reg [7:0] interrupt_enable_high;
  reg [7:0] interrupt_enable_low;
  reg [7:0] interrupt_enable_rise;
  reg [7:0] interrupt_enable_fall;
  wire [7:0] interrupt_valid;
  function [7:0] zz_io_interrupt(input dummy);
    begin
      zz_io_interrupt[0] = 1'b0;
      zz_io_interrupt[1] = 1'b0;
      zz_io_interrupt[2] = 1'b0;
      zz_io_interrupt[3] = 1'b0;
      zz_io_interrupt[4] = 1'b0;
      zz_io_interrupt[5] = 1'b0;
      zz_io_interrupt[6] = 1'b0;
      zz_io_interrupt[7] = 1'b0;
    end
  endfunction
  wire [7:0] _zz_33_;
  function [7:0] zz_interrupt_enable_rise(input dummy);
    begin
      zz_interrupt_enable_rise[0] = 1'b0;
      zz_interrupt_enable_rise[1] = 1'b0;
      zz_interrupt_enable_rise[2] = 1'b0;
      zz_interrupt_enable_rise[3] = 1'b0;
      zz_interrupt_enable_rise[4] = 1'b0;
      zz_interrupt_enable_rise[5] = 1'b0;
      zz_interrupt_enable_rise[6] = 1'b0;
      zz_interrupt_enable_rise[7] = 1'b0;
    end
  endfunction
  wire [7:0] _zz_34_;
  function [7:0] zz_interrupt_enable_fall(input dummy);
    begin
      zz_interrupt_enable_fall[0] = 1'b0;
      zz_interrupt_enable_fall[1] = 1'b0;
      zz_interrupt_enable_fall[2] = 1'b0;
      zz_interrupt_enable_fall[3] = 1'b0;
      zz_interrupt_enable_fall[4] = 1'b0;
      zz_interrupt_enable_fall[5] = 1'b0;
      zz_interrupt_enable_fall[6] = 1'b0;
      zz_interrupt_enable_fall[7] = 1'b0;
    end
  endfunction
  wire [7:0] _zz_35_;
  function [7:0] zz_interrupt_enable_high(input dummy);
    begin
      zz_interrupt_enable_high[0] = 1'b0;
      zz_interrupt_enable_high[1] = 1'b0;
      zz_interrupt_enable_high[2] = 1'b0;
      zz_interrupt_enable_high[3] = 1'b0;
      zz_interrupt_enable_high[4] = 1'b0;
      zz_interrupt_enable_high[5] = 1'b0;
      zz_interrupt_enable_high[6] = 1'b0;
      zz_interrupt_enable_high[7] = 1'b0;
    end
  endfunction
  wire [7:0] _zz_36_;
  function [7:0] zz_interrupt_enable_low(input dummy);
    begin
      zz_interrupt_enable_low[0] = 1'b0;
      zz_interrupt_enable_low[1] = 1'b0;
      zz_interrupt_enable_low[2] = 1'b0;
      zz_interrupt_enable_low[3] = 1'b0;
      zz_interrupt_enable_low[4] = 1'b0;
      zz_interrupt_enable_low[5] = 1'b0;
      zz_interrupt_enable_low[6] = 1'b0;
      zz_interrupt_enable_low[7] = 1'b0;
    end
  endfunction
  wire [7:0] _zz_37_;
  assign _zz_17_ = io_bus_PWDATA[0 : 0];
  assign _zz_18_ = io_bus_PWDATA[1 : 1];
  assign _zz_19_ = io_bus_PWDATA[2 : 2];
  assign _zz_20_ = io_bus_PWDATA[3 : 3];
  assign _zz_21_ = io_bus_PWDATA[4 : 4];
  assign _zz_22_ = io_bus_PWDATA[5 : 5];
  assign _zz_23_ = io_bus_PWDATA[6 : 6];
  assign _zz_24_ = io_bus_PWDATA[7 : 7];
  assign _zz_25_ = io_bus_PWDATA[0 : 0];
  assign _zz_26_ = io_bus_PWDATA[1 : 1];
  assign _zz_27_ = io_bus_PWDATA[2 : 2];
  assign _zz_28_ = io_bus_PWDATA[3 : 3];
  assign _zz_29_ = io_bus_PWDATA[4 : 4];
  assign _zz_30_ = io_bus_PWDATA[5 : 5];
  assign _zz_31_ = io_bus_PWDATA[6 : 6];
  assign _zz_32_ = io_bus_PWDATA[7 : 7];
  BufferCC_2_ bufferCC_4_ ( 
    .io_dataIn(io_gpio_read),
    .io_dataOut(bufferCC_4__io_dataOut),
    .clock_out(clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  assign io_bus_PREADY = 1'b1;
  always @ (*) begin
    io_bus_PRDATA = (32'b00000000000000000000000000000000);
    case(io_bus_PADDR)
      12'b000000000000 : begin
        io_bus_PRDATA[0 : 0] = syncronized[0];
        io_bus_PRDATA[1 : 1] = syncronized[1];
        io_bus_PRDATA[2 : 2] = syncronized[2];
        io_bus_PRDATA[3 : 3] = syncronized[3];
        io_bus_PRDATA[4 : 4] = syncronized[4];
        io_bus_PRDATA[5 : 5] = syncronized[5];
        io_bus_PRDATA[6 : 6] = syncronized[6];
        io_bus_PRDATA[7 : 7] = syncronized[7];
      end
      12'b000000000100 : begin
        io_bus_PRDATA[0 : 0] = _zz_1_;
        io_bus_PRDATA[1 : 1] = _zz_3_;
        io_bus_PRDATA[2 : 2] = _zz_5_;
        io_bus_PRDATA[3 : 3] = _zz_7_;
        io_bus_PRDATA[4 : 4] = _zz_9_;
        io_bus_PRDATA[5 : 5] = _zz_11_;
        io_bus_PRDATA[6 : 6] = _zz_13_;
        io_bus_PRDATA[7 : 7] = _zz_15_;
      end
      12'b000000001000 : begin
        io_bus_PRDATA[0 : 0] = _zz_2_;
        io_bus_PRDATA[1 : 1] = _zz_4_;
        io_bus_PRDATA[2 : 2] = _zz_6_;
        io_bus_PRDATA[3 : 3] = _zz_8_;
        io_bus_PRDATA[4 : 4] = _zz_10_;
        io_bus_PRDATA[5 : 5] = _zz_12_;
        io_bus_PRDATA[6 : 6] = _zz_14_;
        io_bus_PRDATA[7 : 7] = _zz_16_;
      end
      default : begin
      end
    endcase
  end

  assign io_bus_PSLVERROR = 1'b0;
  assign mapper_askWrite = ((io_bus_PSEL[0] && io_bus_PENABLE) && io_bus_PWRITE);
  assign mapper_askRead = ((io_bus_PSEL[0] && io_bus_PENABLE) && (! io_bus_PWRITE));
  assign mapper_doWrite = (((io_bus_PSEL[0] && io_bus_PENABLE) && io_bus_PREADY) && io_bus_PWRITE);
  assign mapper_doRead = (((io_bus_PSEL[0] && io_bus_PENABLE) && io_bus_PREADY) && (! io_bus_PWRITE));
  assign syncronized = bufferCC_4__io_dataOut;
  always @ (*) begin
    io_gpio_write[0] = _zz_1_;
    io_gpio_write[1] = _zz_3_;
    io_gpio_write[2] = _zz_5_;
    io_gpio_write[3] = _zz_7_;
    io_gpio_write[4] = _zz_9_;
    io_gpio_write[5] = _zz_11_;
    io_gpio_write[6] = _zz_13_;
    io_gpio_write[7] = _zz_15_;
  end

  always @ (*) begin
    io_gpio_writeEnable[0] = _zz_2_;
    io_gpio_writeEnable[1] = _zz_4_;
    io_gpio_writeEnable[2] = _zz_6_;
    io_gpio_writeEnable[3] = _zz_8_;
    io_gpio_writeEnable[4] = _zz_10_;
    io_gpio_writeEnable[5] = _zz_12_;
    io_gpio_writeEnable[6] = _zz_14_;
    io_gpio_writeEnable[7] = _zz_16_;
  end

  assign interrupt_valid = ((((interrupt_enable_high & syncronized) | (interrupt_enable_low & (~ syncronized))) | (interrupt_enable_rise & (syncronized & (~ last)))) | (interrupt_enable_fall & ((~ syncronized) & last)));
  assign _zz_33_ = zz_io_interrupt(1'b0);
  always @ (*) io_interrupt = _zz_33_;
  assign _zz_34_ = zz_interrupt_enable_rise(1'b0);
  always @ (*) interrupt_enable_rise = _zz_34_;
  assign _zz_35_ = zz_interrupt_enable_fall(1'b0);
  always @ (*) interrupt_enable_fall = _zz_35_;
  assign _zz_36_ = zz_interrupt_enable_high(1'b0);
  always @ (*) interrupt_enable_high = _zz_36_;
  assign _zz_37_ = zz_interrupt_enable_low(1'b0);
  always @ (*) interrupt_enable_low = _zz_37_;
  always @ (posedge clock_out) begin
    last <= syncronized;
    case(io_bus_PADDR)
      12'b000000000000 : begin
      end
      12'b000000000100 : begin
        if(mapper_doWrite)begin
          _zz_1_ <= _zz_17_[0];
          _zz_3_ <= _zz_18_[0];
          _zz_5_ <= _zz_19_[0];
          _zz_7_ <= _zz_20_[0];
          _zz_9_ <= _zz_21_[0];
          _zz_11_ <= _zz_22_[0];
          _zz_13_ <= _zz_23_[0];
          _zz_15_ <= _zz_24_[0];
        end
      end
      12'b000000001000 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      _zz_2_ <= 1'b0;
      _zz_4_ <= 1'b0;
      _zz_6_ <= 1'b0;
      _zz_8_ <= 1'b0;
      _zz_10_ <= 1'b0;
      _zz_12_ <= 1'b0;
      _zz_14_ <= 1'b0;
      _zz_16_ <= 1'b0;
    end else begin
      case(io_bus_PADDR)
        12'b000000000000 : begin
        end
        12'b000000000100 : begin
        end
        12'b000000001000 : begin
          if(mapper_doWrite)begin
            _zz_2_ <= _zz_25_[0];
            _zz_4_ <= _zz_26_[0];
            _zz_6_ <= _zz_27_[0];
            _zz_8_ <= _zz_28_[0];
            _zz_10_ <= _zz_29_[0];
            _zz_12_ <= _zz_30_[0];
            _zz_14_ <= _zz_31_[0];
            _zz_16_ <= _zz_32_[0];
          end
        end
        default : begin
        end
      endcase
    end
  end

endmodule

module VexRiscv (
      output  iBus_cmd_valid,
      input   iBus_cmd_ready,
      output [31:0] iBus_cmd_payload_pc,
      input   iBus_rsp_valid,
      input   iBus_rsp_payload_error,
      input  [31:0] iBus_rsp_payload_inst,
      input   debug_bus_cmd_valid,
      output reg  debug_bus_cmd_ready,
      input   debug_bus_cmd_payload_wr,
      input  [7:0] debug_bus_cmd_payload_address,
      input  [31:0] debug_bus_cmd_payload_data,
      output reg [31:0] debug_bus_rsp_data,
      output  debug_resetOut,
      output  dBus_cmd_valid,
      input   dBus_cmd_ready,
      output  dBus_cmd_payload_wr,
      output [31:0] dBus_cmd_payload_address,
      output [31:0] dBus_cmd_payload_data,
      output [1:0] dBus_cmd_payload_size,
      input   dBus_rsp_ready,
      input   dBus_rsp_error,
      input  [31:0] dBus_rsp_data,
      input   clock_out,
      input   clockCtrl_systemReset,
      input   clockCtrl_resetUnbuffered_regNext);
  reg [31:0] _zz_119_;
  reg [31:0] _zz_120_;
  wire  IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready;
  wire  IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid;
  wire  IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error;
  wire [31:0] IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst;
  wire [0:0] IBusSimplePlugin_rspJoin_rspBuffer_c_io_occupancy;
  wire  _zz_121_;
  wire  _zz_122_;
  wire  _zz_123_;
  wire  _zz_124_;
  wire  _zz_125_;
  wire [5:0] _zz_126_;
  wire  _zz_127_;
  wire [1:0] _zz_128_;
  wire [2:0] _zz_129_;
  wire [31:0] _zz_130_;
  wire [2:0] _zz_131_;
  wire [0:0] _zz_132_;
  wire [2:0] _zz_133_;
  wire [0:0] _zz_134_;
  wire [2:0] _zz_135_;
  wire [0:0] _zz_136_;
  wire [2:0] _zz_137_;
  wire [0:0] _zz_138_;
  wire [2:0] _zz_139_;
  wire [0:0] _zz_140_;
  wire [0:0] _zz_141_;
  wire [0:0] _zz_142_;
  wire [0:0] _zz_143_;
  wire [0:0] _zz_144_;
  wire [0:0] _zz_145_;
  wire [0:0] _zz_146_;
  wire [0:0] _zz_147_;
  wire [0:0] _zz_148_;
  wire [0:0] _zz_149_;
  wire [0:0] _zz_150_;
  wire [2:0] _zz_151_;
  wire [4:0] _zz_152_;
  wire [11:0] _zz_153_;
  wire [11:0] _zz_154_;
  wire [31:0] _zz_155_;
  wire [31:0] _zz_156_;
  wire [31:0] _zz_157_;
  wire [31:0] _zz_158_;
  wire [31:0] _zz_159_;
  wire [31:0] _zz_160_;
  wire [31:0] _zz_161_;
  wire [31:0] _zz_162_;
  wire [32:0] _zz_163_;
  wire [19:0] _zz_164_;
  wire [11:0] _zz_165_;
  wire [11:0] _zz_166_;
  wire  _zz_167_;
  wire  _zz_168_;
  wire [31:0] _zz_169_;
  wire [0:0] _zz_170_;
  wire [1:0] _zz_171_;
  wire [0:0] _zz_172_;
  wire [0:0] _zz_173_;
  wire  _zz_174_;
  wire [0:0] _zz_175_;
  wire [18:0] _zz_176_;
  wire [31:0] _zz_177_;
  wire [31:0] _zz_178_;
  wire [31:0] _zz_179_;
  wire [31:0] _zz_180_;
  wire [31:0] _zz_181_;
  wire [31:0] _zz_182_;
  wire  _zz_183_;
  wire  _zz_184_;
  wire  _zz_185_;
  wire [1:0] _zz_186_;
  wire [1:0] _zz_187_;
  wire  _zz_188_;
  wire [0:0] _zz_189_;
  wire [15:0] _zz_190_;
  wire [31:0] _zz_191_;
  wire [31:0] _zz_192_;
  wire [31:0] _zz_193_;
  wire [31:0] _zz_194_;
  wire [31:0] _zz_195_;
  wire [31:0] _zz_196_;
  wire  _zz_197_;
  wire [0:0] _zz_198_;
  wire [0:0] _zz_199_;
  wire  _zz_200_;
  wire [0:0] _zz_201_;
  wire [12:0] _zz_202_;
  wire [31:0] _zz_203_;
  wire [31:0] _zz_204_;
  wire [31:0] _zz_205_;
  wire  _zz_206_;
  wire [3:0] _zz_207_;
  wire [3:0] _zz_208_;
  wire  _zz_209_;
  wire [0:0] _zz_210_;
  wire [8:0] _zz_211_;
  wire  _zz_212_;
  wire [0:0] _zz_213_;
  wire [0:0] _zz_214_;
  wire  _zz_215_;
  wire  _zz_216_;
  wire [0:0] _zz_217_;
  wire [0:0] _zz_218_;
  wire [1:0] _zz_219_;
  wire [1:0] _zz_220_;
  wire  _zz_221_;
  wire [0:0] _zz_222_;
  wire [5:0] _zz_223_;
  wire [31:0] _zz_224_;
  wire [31:0] _zz_225_;
  wire [31:0] _zz_226_;
  wire [31:0] _zz_227_;
  wire [31:0] _zz_228_;
  wire [31:0] _zz_229_;
  wire [31:0] _zz_230_;
  wire [31:0] _zz_231_;
  wire [31:0] _zz_232_;
  wire [31:0] _zz_233_;
  wire [31:0] _zz_234_;
  wire  _zz_235_;
  wire [0:0] _zz_236_;
  wire [1:0] _zz_237_;
  wire [0:0] _zz_238_;
  wire [0:0] _zz_239_;
  wire  _zz_240_;
  wire [0:0] _zz_241_;
  wire [3:0] _zz_242_;
  wire [31:0] _zz_243_;
  wire [31:0] _zz_244_;
  wire [31:0] _zz_245_;
  wire  _zz_246_;
  wire [0:0] _zz_247_;
  wire [0:0] _zz_248_;
  wire [1:0] _zz_249_;
  wire [1:0] _zz_250_;
  wire  _zz_251_;
  wire [0:0] _zz_252_;
  wire [0:0] _zz_253_;
  wire [31:0] _zz_254_;
  wire [31:0] _zz_255_;
  wire [31:0] _zz_256_;
  wire [31:0] _zz_257_;
  wire [31:0] _zz_258_;
  wire [31:0] _zz_259_;
  wire [31:0] _zz_260_;
  wire [31:0] _zz_261_;
  wire [31:0] _zz_262_;
  wire [31:0] _zz_263_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_1_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_2_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_3_;
  wire  decode_MEMORY_ENABLE;
  wire  decode_SRC_LESS_UNSIGNED;
  wire `ShiftCtrlEnum_defaultEncoding_type decode_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_4_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_5_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_6_;
  wire  decode_SRC2_FORCE_ZERO;
  wire `Src1CtrlEnum_defaultEncoding_type decode_SRC1_CTRL;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_7_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_8_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_9_;
  wire `AluCtrlEnum_defaultEncoding_type decode_ALU_CTRL;
  wire `AluCtrlEnum_defaultEncoding_type _zz_10_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_11_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_12_;
  wire  decode_DO_EBREAK;
  wire  decode_RS1_USE;
  wire  decode_MEMORY_STORE;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire  execute_REGFILE_WRITE_VALID;
  wire `Src2CtrlEnum_defaultEncoding_type decode_SRC2_CTRL;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_13_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_14_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_15_;
  wire  decode_RS2_USE;
  wire `BranchCtrlEnum_defaultEncoding_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_16_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_17_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_18_;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire  execute_DO_EBREAK;
  wire  decode_IS_EBREAK;
  wire  _zz_19_;
  wire  execute_RS2_USE;
  wire  execute_RS1_USE;
  wire  execute_IS_FENCEI;
  reg [31:0] _zz_20_;
  wire  decode_IS_FENCEI;
  wire [31:0] execute_BRANCH_CALC;
  wire  execute_BRANCH_DO;
  wire [31:0] _zz_21_;
  wire [31:0] execute_RS1;
  wire `BranchCtrlEnum_defaultEncoding_type execute_BRANCH_CTRL;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_22_;
  wire  _zz_23_;
  wire `ShiftCtrlEnum_defaultEncoding_type execute_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_24_;
  wire  _zz_25_;
  wire [31:0] _zz_26_;
  wire [31:0] _zz_27_;
  wire  execute_SRC_LESS_UNSIGNED;
  wire  execute_SRC2_FORCE_ZERO;
  wire  execute_SRC_USE_SUB_LESS;
  wire `Src2CtrlEnum_defaultEncoding_type execute_SRC2_CTRL;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_28_;
  wire [31:0] _zz_29_;
  wire `Src1CtrlEnum_defaultEncoding_type execute_SRC1_CTRL;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_30_;
  wire [31:0] _zz_31_;
  wire  decode_SRC_USE_SUB_LESS;
  wire  decode_SRC_ADD_ZERO;
  wire  _zz_32_;
  wire [31:0] execute_SRC_ADD_SUB;
  wire  execute_SRC_LESS;
  wire `AluCtrlEnum_defaultEncoding_type execute_ALU_CTRL;
  wire `AluCtrlEnum_defaultEncoding_type _zz_33_;
  wire [31:0] _zz_34_;
  wire [31:0] execute_SRC2;
  wire [31:0] execute_SRC1;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type execute_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_35_;
  wire [31:0] _zz_36_;
  wire  _zz_37_;
  reg  _zz_38_;
  wire [31:0] _zz_39_;
  wire [31:0] _zz_40_;
  reg  decode_REGFILE_WRITE_VALID;
  wire  _zz_41_;
  wire  _zz_42_;
  wire  _zz_43_;
  wire  _zz_44_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_45_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_46_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_47_;
  wire  _zz_48_;
  wire  _zz_49_;
  wire  _zz_50_;
  wire  _zz_51_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_52_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_53_;
  wire  _zz_54_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_55_;
  wire  _zz_56_;
  reg [31:0] _zz_57_;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire [31:0] execute_MEMORY_READ_DATA;
  wire [31:0] _zz_58_;
  wire [31:0] execute_SRC_ADD;
  wire [1:0] _zz_59_;
  wire [31:0] execute_RS2;
  wire  execute_MEMORY_STORE;
  wire  execute_MEMORY_ENABLE;
  wire  execute_ALIGNEMENT_FAULT;
  wire [31:0] decode_PC;
  wire [31:0] _zz_60_;
  wire [31:0] _zz_61_;
  wire [31:0] _zz_62_;
  wire [31:0] decode_INSTRUCTION;
  wire [31:0] execute_PC;
  wire [31:0] execute_INSTRUCTION;
  reg  decode_arbitration_haltItself;
  wire  decode_arbitration_haltByOther;
  reg  decode_arbitration_removeIt;
  wire  decode_arbitration_flushIt;
  wire  decode_arbitration_flushNext;
  reg  decode_arbitration_isValid;
  wire  decode_arbitration_isStuck;
  wire  decode_arbitration_isStuckByOthers;
  wire  decode_arbitration_isFlushed;
  wire  decode_arbitration_isMoving;
  wire  decode_arbitration_isFiring;
  reg  execute_arbitration_haltItself;
  reg  execute_arbitration_haltByOther;
  reg  execute_arbitration_removeIt;
  reg  execute_arbitration_flushIt;
  reg  execute_arbitration_flushNext;
  reg  execute_arbitration_isValid;
  wire  execute_arbitration_isStuck;
  wire  execute_arbitration_isStuckByOthers;
  wire  execute_arbitration_isFlushed;
  wire  execute_arbitration_isMoving;
  wire  execute_arbitration_isFiring;
  wire [31:0] lastStageInstruction /* verilator public */ ;
  wire [31:0] lastStagePc /* verilator public */ ;
  wire  lastStageIsValid /* verilator public */ ;
  wire  lastStageIsFiring /* verilator public */ ;
  reg  IBusSimplePlugin_fetcherHalt;
  reg  IBusSimplePlugin_fetcherflushIt;
  reg  IBusSimplePlugin_incomingInstruction;
  wire  IBusSimplePlugin_pcValids_0;
  wire  IBusSimplePlugin_pcValids_1;
  wire  BranchPlugin_jumpInterface_valid;
  wire [31:0] BranchPlugin_jumpInterface_payload;
  reg  IBusSimplePlugin_injectionPort_valid;
  reg  IBusSimplePlugin_injectionPort_ready;
  wire [31:0] IBusSimplePlugin_injectionPort_payload;
  wire  IBusSimplePlugin_jump_pcLoad_valid;
  wire [31:0] IBusSimplePlugin_jump_pcLoad_payload;
  wire  IBusSimplePlugin_fetchPc_output_valid;
  wire  IBusSimplePlugin_fetchPc_output_ready;
  wire [31:0] IBusSimplePlugin_fetchPc_output_payload;
  reg [31:0] IBusSimplePlugin_fetchPc_pcReg /* verilator public */ ;
  reg  IBusSimplePlugin_fetchPc_corrected;
  reg  IBusSimplePlugin_fetchPc_pcRegPropagate;
  reg  IBusSimplePlugin_fetchPc_booted;
  reg  IBusSimplePlugin_fetchPc_inc;
  reg [31:0] IBusSimplePlugin_fetchPc_pc;
  wire  IBusSimplePlugin_iBusRsp_stages_0_input_valid;
  wire  IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_stages_0_input_payload;
  wire  IBusSimplePlugin_iBusRsp_stages_0_output_valid;
  wire  IBusSimplePlugin_iBusRsp_stages_0_output_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_stages_0_output_payload;
  reg  IBusSimplePlugin_iBusRsp_stages_0_halt;
  wire  IBusSimplePlugin_iBusRsp_stages_0_inputSample;
  wire  IBusSimplePlugin_iBusRsp_stages_1_input_valid;
  wire  IBusSimplePlugin_iBusRsp_stages_1_input_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_stages_1_input_payload;
  wire  IBusSimplePlugin_iBusRsp_stages_1_output_valid;
  wire  IBusSimplePlugin_iBusRsp_stages_1_output_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_stages_1_output_payload;
  wire  IBusSimplePlugin_iBusRsp_stages_1_halt;
  wire  IBusSimplePlugin_iBusRsp_stages_1_inputSample;
  wire  _zz_63_;
  wire  _zz_64_;
  wire  _zz_65_;
  wire  _zz_66_;
  reg  _zz_67_;
  reg  IBusSimplePlugin_iBusRsp_readyForError;
  wire  IBusSimplePlugin_iBusRsp_output_valid;
  wire  IBusSimplePlugin_iBusRsp_output_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_output_payload_pc;
  wire  IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
  wire [31:0] IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
  wire  IBusSimplePlugin_iBusRsp_output_payload_isRvc;
  wire  IBusSimplePlugin_injector_decodeInput_valid;
  wire  IBusSimplePlugin_injector_decodeInput_ready;
  wire [31:0] IBusSimplePlugin_injector_decodeInput_payload_pc;
  wire  IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  wire [31:0] IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  wire  IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  reg  _zz_68_;
  reg [31:0] _zz_69_;
  reg  _zz_70_;
  reg [31:0] _zz_71_;
  reg  _zz_72_;
  reg  IBusSimplePlugin_injector_nextPcCalc_valids_0;
  reg  IBusSimplePlugin_injector_nextPcCalc_valids_1;
  reg  IBusSimplePlugin_injector_nextPcCalc_valids_2;
  reg  IBusSimplePlugin_injector_decodeRemoved;
  reg [31:0] IBusSimplePlugin_injector_formal_rawInDecode;
  wire  IBusSimplePlugin_cmd_valid;
  wire  IBusSimplePlugin_cmd_ready;
  wire [31:0] IBusSimplePlugin_cmd_payload_pc;
  wire  IBusSimplePlugin_cmd_s2mPipe_valid;
  wire  IBusSimplePlugin_cmd_s2mPipe_ready;
  wire [31:0] IBusSimplePlugin_cmd_s2mPipe_payload_pc;
  reg  _zz_73_;
  reg [31:0] _zz_74_;
  reg [2:0] IBusSimplePlugin_pendingCmd;
  wire [2:0] IBusSimplePlugin_pendingCmdNext;
  reg [2:0] IBusSimplePlugin_rspJoin_discardCounter;
  wire  IBusSimplePlugin_rspJoin_rspBufferOutput_valid;
  wire  IBusSimplePlugin_rspJoin_rspBufferOutput_ready;
  wire  IBusSimplePlugin_rspJoin_rspBufferOutput_payload_error;
  wire [31:0] IBusSimplePlugin_rspJoin_rspBufferOutput_payload_inst;
  wire  iBus_rsp_takeWhen_valid;
  wire  iBus_rsp_takeWhen_payload_error;
  wire [31:0] iBus_rsp_takeWhen_payload_inst;
  wire [31:0] IBusSimplePlugin_rspJoin_fetchRsp_pc;
  reg  IBusSimplePlugin_rspJoin_fetchRsp_rsp_error;
  wire [31:0] IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst;
  wire  IBusSimplePlugin_rspJoin_fetchRsp_isRvc;
  wire  IBusSimplePlugin_rspJoin_join_valid;
  wire  IBusSimplePlugin_rspJoin_join_ready;
  wire [31:0] IBusSimplePlugin_rspJoin_join_payload_pc;
  wire  IBusSimplePlugin_rspJoin_join_payload_rsp_error;
  wire [31:0] IBusSimplePlugin_rspJoin_join_payload_rsp_inst;
  wire  IBusSimplePlugin_rspJoin_join_payload_isRvc;
  wire  IBusSimplePlugin_rspJoin_exceptionDetected;
  wire  IBusSimplePlugin_rspJoin_redoRequired;
  wire  _zz_75_;
  reg  _zz_76_;
  reg  execute_DBusSimplePlugin_skipCmd;
  reg [31:0] _zz_77_;
  reg [3:0] _zz_78_;
  wire [3:0] execute_DBusSimplePlugin_formalMask;
  reg [31:0] execute_DBusSimplePlugin_rspShifted;
  wire  _zz_79_;
  reg [31:0] _zz_80_;
  wire  _zz_81_;
  reg [31:0] _zz_82_;
  reg [31:0] execute_DBusSimplePlugin_rspFormated;
  wire [24:0] _zz_83_;
  wire  _zz_84_;
  wire  _zz_85_;
  wire  _zz_86_;
  wire  _zz_87_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_88_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_89_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_90_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_91_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_92_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_93_;
  wire [31:0] execute_RegFilePlugin_srcInstruction;
  wire [4:0] execute_RegFilePlugin_regFileReadAddress1;
  wire [4:0] execute_RegFilePlugin_regFileReadAddress2;
  wire [31:0] execute_RegFilePlugin_rs1Data;
  wire [31:0] execute_RegFilePlugin_rs2Data;
  wire  lastStageRegFileWrite_valid /* verilator public */ ;
  wire [4:0] lastStageRegFileWrite_payload_address /* verilator public */ ;
  wire [31:0] lastStageRegFileWrite_payload_data /* verilator public */ ;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] _zz_94_;
  reg [31:0] _zz_95_;
  wire  _zz_96_;
  reg [19:0] _zz_97_;
  wire  _zz_98_;
  reg [19:0] _zz_99_;
  reg [31:0] _zz_100_;
  reg [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  reg  execute_LightShifterPlugin_isActive;
  wire  execute_LightShifterPlugin_isShift;
  reg [4:0] execute_LightShifterPlugin_amplitudeReg;
  wire [4:0] execute_LightShifterPlugin_amplitude;
  reg [31:0] execute_LightShifterPlugin_shiftReg;
  wire [31:0] execute_LightShifterPlugin_shiftInput;
  wire  execute_LightShifterPlugin_done;
  reg [31:0] _zz_101_;
  wire  execute_BranchPlugin_eq;
  wire [2:0] _zz_102_;
  reg  _zz_103_;
  reg  _zz_104_;
  wire [31:0] execute_BranchPlugin_branch_src1;
  wire  _zz_105_;
  reg [10:0] _zz_106_;
  wire  _zz_107_;
  reg [19:0] _zz_108_;
  wire  _zz_109_;
  reg [18:0] _zz_110_;
  reg [31:0] _zz_111_;
  wire [31:0] execute_BranchPlugin_branch_src2;
  wire [31:0] execute_BranchPlugin_branchAdder;
  reg  _zz_112_;
  reg  _zz_113_;
  wire  _zz_114_;
  reg  _zz_115_;
  reg [4:0] _zz_116_;
  reg  DebugPlugin_firstCycle;
  reg  DebugPlugin_secondCycle;
  reg  DebugPlugin_resetIt;
  reg  DebugPlugin_haltIt;
  reg  DebugPlugin_stepIt;
  reg  DebugPlugin_isPipBusy;
  reg  DebugPlugin_godmode;
  reg  DebugPlugin_haltedByBreak;
  reg [31:0] DebugPlugin_busReadDataReg;
  reg  _zz_117_;
  reg  DebugPlugin_resetIt_regNext;
  reg [31:0] decode_to_execute_FORMAL_PC_NEXT;
  reg `BranchCtrlEnum_defaultEncoding_type decode_to_execute_BRANCH_CTRL;
  reg  decode_to_execute_RS2_USE;
  reg `Src2CtrlEnum_defaultEncoding_type decode_to_execute_SRC2_CTRL;
  reg  decode_to_execute_REGFILE_WRITE_VALID;
  reg  decode_to_execute_MEMORY_STORE;
  reg  decode_to_execute_RS1_USE;
  reg [31:0] decode_to_execute_PC;
  reg  decode_to_execute_DO_EBREAK;
  reg  decode_to_execute_IS_FENCEI;
  reg `AluCtrlEnum_defaultEncoding_type decode_to_execute_ALU_CTRL;
  reg `Src1CtrlEnum_defaultEncoding_type decode_to_execute_SRC1_CTRL;
  reg  decode_to_execute_SRC2_FORCE_ZERO;
  reg [31:0] decode_to_execute_INSTRUCTION;
  reg `ShiftCtrlEnum_defaultEncoding_type decode_to_execute_SHIFT_CTRL;
  reg  decode_to_execute_SRC_LESS_UNSIGNED;
  reg  decode_to_execute_MEMORY_ENABLE;
  reg `AluBitwiseCtrlEnum_defaultEncoding_type decode_to_execute_ALU_BITWISE_CTRL;
  reg  decode_to_execute_SRC_USE_SUB_LESS;
  reg [2:0] _zz_118_;
  `ifndef SYNTHESIS
  reg [39:0] decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_1__string;
  reg [39:0] _zz_2__string;
  reg [39:0] _zz_3__string;
  reg [71:0] decode_SHIFT_CTRL_string;
  reg [71:0] _zz_4__string;
  reg [71:0] _zz_5__string;
  reg [71:0] _zz_6__string;
  reg [95:0] decode_SRC1_CTRL_string;
  reg [95:0] _zz_7__string;
  reg [95:0] _zz_8__string;
  reg [95:0] _zz_9__string;
  reg [63:0] decode_ALU_CTRL_string;
  reg [63:0] _zz_10__string;
  reg [63:0] _zz_11__string;
  reg [63:0] _zz_12__string;
  reg [23:0] decode_SRC2_CTRL_string;
  reg [23:0] _zz_13__string;
  reg [23:0] _zz_14__string;
  reg [23:0] _zz_15__string;
  reg [31:0] decode_BRANCH_CTRL_string;
  reg [31:0] _zz_16__string;
  reg [31:0] _zz_17__string;
  reg [31:0] _zz_18__string;
  reg [31:0] execute_BRANCH_CTRL_string;
  reg [31:0] _zz_22__string;
  reg [71:0] execute_SHIFT_CTRL_string;
  reg [71:0] _zz_24__string;
  reg [23:0] execute_SRC2_CTRL_string;
  reg [23:0] _zz_28__string;
  reg [95:0] execute_SRC1_CTRL_string;
  reg [95:0] _zz_30__string;
  reg [63:0] execute_ALU_CTRL_string;
  reg [63:0] _zz_33__string;
  reg [39:0] execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_35__string;
  reg [71:0] _zz_45__string;
  reg [39:0] _zz_46__string;
  reg [95:0] _zz_47__string;
  reg [31:0] _zz_52__string;
  reg [23:0] _zz_53__string;
  reg [63:0] _zz_55__string;
  reg [63:0] _zz_88__string;
  reg [23:0] _zz_89__string;
  reg [31:0] _zz_90__string;
  reg [95:0] _zz_91__string;
  reg [39:0] _zz_92__string;
  reg [71:0] _zz_93__string;
  reg [31:0] decode_to_execute_BRANCH_CTRL_string;
  reg [23:0] decode_to_execute_SRC2_CTRL_string;
  reg [63:0] decode_to_execute_ALU_CTRL_string;
  reg [95:0] decode_to_execute_SRC1_CTRL_string;
  reg [71:0] decode_to_execute_SHIFT_CTRL_string;
  reg [39:0] decode_to_execute_ALU_BITWISE_CTRL_string;
  `endif

  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;
  assign _zz_121_ = ((execute_arbitration_isValid && execute_LightShifterPlugin_isShift) && (execute_SRC2[4 : 0] != (5'b00000)));
  assign _zz_122_ = (! execute_arbitration_isStuckByOthers);
  assign _zz_123_ = (execute_arbitration_isValid && execute_DO_EBREAK);
  assign _zz_124_ = (1'b0 == 1'b0);
  assign _zz_125_ = (DebugPlugin_stepIt && IBusSimplePlugin_incomingInstruction);
  assign _zz_126_ = debug_bus_cmd_payload_address[7 : 2];
  assign _zz_127_ = (IBusSimplePlugin_cmd_ready && (! IBusSimplePlugin_cmd_s2mPipe_ready));
  assign _zz_128_ = execute_INSTRUCTION[13 : 12];
  assign _zz_129_ = {IBusSimplePlugin_fetchPc_inc,(2'b00)};
  assign _zz_130_ = {29'd0, _zz_129_};
  assign _zz_131_ = (IBusSimplePlugin_pendingCmd + _zz_133_);
  assign _zz_132_ = (IBusSimplePlugin_cmd_valid && IBusSimplePlugin_cmd_ready);
  assign _zz_133_ = {2'd0, _zz_132_};
  assign _zz_134_ = iBus_rsp_valid;
  assign _zz_135_ = {2'd0, _zz_134_};
  assign _zz_136_ = (iBus_rsp_valid && (IBusSimplePlugin_rspJoin_discardCounter != (3'b000)));
  assign _zz_137_ = {2'd0, _zz_136_};
  assign _zz_138_ = iBus_rsp_valid;
  assign _zz_139_ = {2'd0, _zz_138_};
  assign _zz_140_ = _zz_83_[0 : 0];
  assign _zz_141_ = _zz_83_[3 : 3];
  assign _zz_142_ = _zz_83_[9 : 9];
  assign _zz_143_ = _zz_83_[10 : 10];
  assign _zz_144_ = _zz_83_[11 : 11];
  assign _zz_145_ = _zz_83_[12 : 12];
  assign _zz_146_ = _zz_83_[20 : 20];
  assign _zz_147_ = _zz_83_[21 : 21];
  assign _zz_148_ = _zz_83_[22 : 22];
  assign _zz_149_ = _zz_83_[24 : 24];
  assign _zz_150_ = execute_SRC_LESS;
  assign _zz_151_ = (3'b100);
  assign _zz_152_ = execute_INSTRUCTION[19 : 15];
  assign _zz_153_ = execute_INSTRUCTION[31 : 20];
  assign _zz_154_ = {execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]};
  assign _zz_155_ = ($signed(_zz_156_) + $signed(_zz_159_));
  assign _zz_156_ = ($signed(_zz_157_) + $signed(_zz_158_));
  assign _zz_157_ = execute_SRC1;
  assign _zz_158_ = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_159_ = (execute_SRC_USE_SUB_LESS ? _zz_160_ : _zz_161_);
  assign _zz_160_ = (32'b00000000000000000000000000000001);
  assign _zz_161_ = (32'b00000000000000000000000000000000);
  assign _zz_162_ = (_zz_163_ >>> 1);
  assign _zz_163_ = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_defaultEncoding_SRA_1) && execute_LightShifterPlugin_shiftInput[31]),execute_LightShifterPlugin_shiftInput};
  assign _zz_164_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz_165_ = execute_INSTRUCTION[31 : 20];
  assign _zz_166_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_167_ = 1'b1;
  assign _zz_168_ = 1'b1;
  assign _zz_169_ = (32'b00000000000000000000000001010000);
  assign _zz_170_ = ((decode_INSTRUCTION & _zz_177_) == (32'b00000000000000000000000001000000));
  assign _zz_171_ = {(_zz_178_ == _zz_179_),(_zz_180_ == _zz_181_)};
  assign _zz_172_ = ((decode_INSTRUCTION & _zz_182_) == (32'b00000000000000000001000000001000));
  assign _zz_173_ = (1'b0);
  assign _zz_174_ = ({_zz_183_,_zz_184_} != (2'b00));
  assign _zz_175_ = (_zz_185_ != (1'b0));
  assign _zz_176_ = {(_zz_186_ != _zz_187_),{_zz_188_,{_zz_189_,_zz_190_}}};
  assign _zz_177_ = (32'b00000000000000000000000001000100);
  assign _zz_178_ = (decode_INSTRUCTION & (32'b00000000000000000010000000010100));
  assign _zz_179_ = (32'b00000000000000000010000000010000);
  assign _zz_180_ = (decode_INSTRUCTION & (32'b01000000000000000100000000110100));
  assign _zz_181_ = (32'b01000000000000000000000000110000);
  assign _zz_182_ = (32'b11111111111111111001111111001000);
  assign _zz_183_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000000000000));
  assign _zz_184_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000011000)) == (32'b00000000000000000000000000000000));
  assign _zz_185_ = ((decode_INSTRUCTION & (32'b00000000000000000111000000010100)) == (32'b00000000000000000101000000010000));
  assign _zz_186_ = {(_zz_191_ == _zz_192_),(_zz_193_ == _zz_194_)};
  assign _zz_187_ = (2'b00);
  assign _zz_188_ = ((_zz_195_ == _zz_196_) != (1'b0));
  assign _zz_189_ = (_zz_197_ != (1'b0));
  assign _zz_190_ = {(_zz_198_ != _zz_199_),{_zz_200_,{_zz_201_,_zz_202_}}};
  assign _zz_191_ = (decode_INSTRUCTION & (32'b01000000000000000011000000010100));
  assign _zz_192_ = (32'b01000000000000000001000000010000);
  assign _zz_193_ = (decode_INSTRUCTION & (32'b00000000000000000111000000010100));
  assign _zz_194_ = (32'b00000000000000000001000000010000);
  assign _zz_195_ = (decode_INSTRUCTION & (32'b00000000000000000001000000000000));
  assign _zz_196_ = (32'b00000000000000000001000000000000);
  assign _zz_197_ = ((decode_INSTRUCTION & (32'b00000000000000000011000000000000)) == (32'b00000000000000000010000000000000));
  assign _zz_198_ = _zz_87_;
  assign _zz_199_ = (1'b0);
  assign _zz_200_ = (((decode_INSTRUCTION & _zz_203_) == (32'b00000000000000000000000000000100)) != (1'b0));
  assign _zz_201_ = ((_zz_204_ == _zz_205_) != (1'b0));
  assign _zz_202_ = {(_zz_206_ != (1'b0)),{(_zz_207_ != _zz_208_),{_zz_209_,{_zz_210_,_zz_211_}}}};
  assign _zz_203_ = (32'b00000000000000000000000000010100);
  assign _zz_204_ = (decode_INSTRUCTION & (32'b00000000000000000000000001000100));
  assign _zz_205_ = (32'b00000000000000000000000000000100);
  assign _zz_206_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000100000)) == (32'b00000000000000000000000000100000));
  assign _zz_207_ = {_zz_86_,{_zz_212_,{_zz_213_,_zz_214_}}};
  assign _zz_208_ = (4'b0000);
  assign _zz_209_ = ({_zz_215_,_zz_216_} != (2'b00));
  assign _zz_210_ = ({_zz_217_,_zz_218_} != (2'b00));
  assign _zz_211_ = {(_zz_219_ != _zz_220_),{_zz_221_,{_zz_222_,_zz_223_}}};
  assign _zz_212_ = ((decode_INSTRUCTION & _zz_224_) == (32'b00000000000000000000000000010000));
  assign _zz_213_ = (_zz_225_ == _zz_226_);
  assign _zz_214_ = (_zz_227_ == _zz_228_);
  assign _zz_215_ = ((decode_INSTRUCTION & _zz_229_) == (32'b00000000000000000000000000100100));
  assign _zz_216_ = ((decode_INSTRUCTION & _zz_230_) == (32'b00000000000000000001000000010000));
  assign _zz_217_ = (_zz_231_ == _zz_232_);
  assign _zz_218_ = (_zz_233_ == _zz_234_);
  assign _zz_219_ = {_zz_235_,_zz_85_};
  assign _zz_220_ = (2'b00);
  assign _zz_221_ = ({_zz_236_,_zz_237_} != (3'b000));
  assign _zz_222_ = (_zz_238_ != _zz_239_);
  assign _zz_223_ = {_zz_240_,{_zz_241_,_zz_242_}};
  assign _zz_224_ = (32'b00000000000000000000000001010000);
  assign _zz_225_ = (decode_INSTRUCTION & (32'b00000000000000000000000000001100));
  assign _zz_226_ = (32'b00000000000000000000000000000100);
  assign _zz_227_ = (decode_INSTRUCTION & (32'b00000000000000000000000000101000));
  assign _zz_228_ = (32'b00000000000000000000000000000000);
  assign _zz_229_ = (32'b00000000000000000000000001100100);
  assign _zz_230_ = (32'b00000000000000000011000000010100);
  assign _zz_231_ = (decode_INSTRUCTION & (32'b00000000000000000000000000110100));
  assign _zz_232_ = (32'b00000000000000000000000000100000);
  assign _zz_233_ = (decode_INSTRUCTION & (32'b00000000000000000000000001100100));
  assign _zz_234_ = (32'b00000000000000000000000000100000);
  assign _zz_235_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000001000000));
  assign _zz_236_ = _zz_86_;
  assign _zz_237_ = {(_zz_243_ == _zz_244_),_zz_85_};
  assign _zz_238_ = ((decode_INSTRUCTION & _zz_245_) == (32'b00000000000000000000000001000000));
  assign _zz_239_ = (1'b0);
  assign _zz_240_ = ({_zz_84_,_zz_246_} != (2'b00));
  assign _zz_241_ = ({_zz_247_,_zz_248_} != (2'b00));
  assign _zz_242_ = {(_zz_249_ != _zz_250_),{_zz_251_,{_zz_252_,_zz_253_}}};
  assign _zz_243_ = (decode_INSTRUCTION & (32'b00000000000000000000000000011100));
  assign _zz_244_ = (32'b00000000000000000000000000000100);
  assign _zz_245_ = (32'b00000000000000000000000001011000);
  assign _zz_246_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001110000)) == (32'b00000000000000000000000000100000));
  assign _zz_247_ = _zz_84_;
  assign _zz_248_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000100000)) == (32'b00000000000000000000000000000000));
  assign _zz_249_ = {((decode_INSTRUCTION & _zz_254_) == (32'b00000000000000000010000000000000)),((decode_INSTRUCTION & _zz_255_) == (32'b00000000000000000001000000000000))};
  assign _zz_250_ = (2'b00);
  assign _zz_251_ = ({(_zz_256_ == _zz_257_),(_zz_258_ == _zz_259_)} != (2'b00));
  assign _zz_252_ = ((_zz_260_ == _zz_261_) != (1'b0));
  assign _zz_253_ = ((_zz_262_ == _zz_263_) != (1'b0));
  assign _zz_254_ = (32'b00000000000000000010000000010000);
  assign _zz_255_ = (32'b00000000000000000101000000000000);
  assign _zz_256_ = (decode_INSTRUCTION & (32'b00000000000000000110000000000100));
  assign _zz_257_ = (32'b00000000000000000110000000000000);
  assign _zz_258_ = (decode_INSTRUCTION & (32'b00000000000000000101000000000100));
  assign _zz_259_ = (32'b00000000000000000100000000000000);
  assign _zz_260_ = (decode_INSTRUCTION & (32'b00000000000000000110000000000100));
  assign _zz_261_ = (32'b00000000000000000010000000000000);
  assign _zz_262_ = (decode_INSTRUCTION & (32'b00000000000000000000000001011000));
  assign _zz_263_ = (32'b00000000000000000000000000000000);
  initial begin
    $readmemb("BlackiceMxSocSdram.v_toplevel_system_cpu_cpu_RegFilePlugin_regFile.bin",RegFilePlugin_regFile);
  end
  always @ (posedge clock_out) begin
    if(_zz_38_) begin
      RegFilePlugin_regFile[lastStageRegFileWrite_payload_address] <= lastStageRegFileWrite_payload_data;
    end
  end

  always @ (posedge clock_out) begin
    if(_zz_167_) begin
      _zz_119_ <= RegFilePlugin_regFile[execute_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge clock_out) begin
    if(_zz_168_) begin
      _zz_120_ <= RegFilePlugin_regFile[execute_RegFilePlugin_regFileReadAddress2];
    end
  end

  StreamFifoLowLatency_1_ IBusSimplePlugin_rspJoin_rspBuffer_c ( 
    .io_push_valid(iBus_rsp_takeWhen_valid),
    .io_push_ready(IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready),
    .io_push_payload_error(iBus_rsp_takeWhen_payload_error),
    .io_push_payload_inst(iBus_rsp_takeWhen_payload_inst),
    .io_pop_valid(IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid),
    .io_pop_ready(IBusSimplePlugin_rspJoin_rspBufferOutput_ready),
    .io_pop_payload_error(IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error),
    .io_pop_payload_inst(IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst),
    .io_flush(IBusSimplePlugin_fetcherflushIt),
    .io_occupancy(IBusSimplePlugin_rspJoin_rspBuffer_c_io_occupancy),
    .clock_out(clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(decode_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : decode_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_1_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_1__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_1__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_1__string = "AND_1";
      default : _zz_1__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_2_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_2__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_2__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_2__string = "AND_1";
      default : _zz_2__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_3_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_3__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_3__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_3__string = "AND_1";
      default : _zz_3__string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : decode_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : decode_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : decode_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : decode_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_4_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_4__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_4__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_4__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_4__string = "SRA_1    ";
      default : _zz_4__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_5_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_5__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_5__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_5__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_5__string = "SRA_1    ";
      default : _zz_5__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_6_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_6__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_6__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_6__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_6__string = "SRA_1    ";
      default : _zz_6__string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : decode_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : decode_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : decode_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : decode_SRC1_CTRL_string = "URS1        ";
      default : decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_7_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_7__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_7__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_7__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_7__string = "URS1        ";
      default : _zz_7__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_8_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_8__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_8__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_8__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_8__string = "URS1        ";
      default : _zz_8__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_9_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_9__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_9__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_9__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_9__string = "URS1        ";
      default : _zz_9__string = "????????????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : decode_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : decode_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : decode_ALU_CTRL_string = "BITWISE ";
      default : decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_10_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_10__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_10__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_10__string = "BITWISE ";
      default : _zz_10__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_11_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_11__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_11__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_11__string = "BITWISE ";
      default : _zz_11__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_12_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_12__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_12__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_12__string = "BITWISE ";
      default : _zz_12__string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : decode_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : decode_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : decode_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : decode_SRC2_CTRL_string = "PC ";
      default : decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_13_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_13__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_13__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_13__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_13__string = "PC ";
      default : _zz_13__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_14_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_14__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_14__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_14__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_14__string = "PC ";
      default : _zz_14__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_15_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_15__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_15__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_15__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_15__string = "PC ";
      default : _zz_15__string = "???";
    endcase
  end
  always @(*) begin
    case(decode_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : decode_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : decode_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : decode_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : decode_BRANCH_CTRL_string = "JALR";
      default : decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_16_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_16__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_16__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_16__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_16__string = "JALR";
      default : _zz_16__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_17_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_17__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_17__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_17__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_17__string = "JALR";
      default : _zz_17__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_18_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_18__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_18__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_18__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_18__string = "JALR";
      default : _zz_18__string = "????";
    endcase
  end
  always @(*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : execute_BRANCH_CTRL_string = "JALR";
      default : execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_22_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_22__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_22__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_22__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_22__string = "JALR";
      default : _zz_22__string = "????";
    endcase
  end
  always @(*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : execute_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : execute_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : execute_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : execute_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_24_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_24__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_24__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_24__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_24__string = "SRA_1    ";
      default : _zz_24__string = "?????????";
    endcase
  end
  always @(*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : execute_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : execute_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : execute_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : execute_SRC2_CTRL_string = "PC ";
      default : execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_28_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_28__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_28__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_28__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_28__string = "PC ";
      default : _zz_28__string = "???";
    endcase
  end
  always @(*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : execute_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : execute_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : execute_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : execute_SRC1_CTRL_string = "URS1        ";
      default : execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_30_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_30__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_30__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_30__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_30__string = "URS1        ";
      default : _zz_30__string = "????????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : execute_ALU_CTRL_string = "BITWISE ";
      default : execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_33_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_33__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_33__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_33__string = "BITWISE ";
      default : _zz_33__string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : execute_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_35_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_35__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_35__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_35__string = "AND_1";
      default : _zz_35__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_45_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_45__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_45__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_45__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_45__string = "SRA_1    ";
      default : _zz_45__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_46_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_46__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_46__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_46__string = "AND_1";
      default : _zz_46__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_47_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_47__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_47__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_47__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_47__string = "URS1        ";
      default : _zz_47__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_52_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_52__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_52__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_52__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_52__string = "JALR";
      default : _zz_52__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_53_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_53__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_53__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_53__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_53__string = "PC ";
      default : _zz_53__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_55_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_55__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_55__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_55__string = "BITWISE ";
      default : _zz_55__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_88_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_88__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_88__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_88__string = "BITWISE ";
      default : _zz_88__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_89_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_89__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_89__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_89__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_89__string = "PC ";
      default : _zz_89__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_90_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_90__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_90__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_90__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_90__string = "JALR";
      default : _zz_90__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_91_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_91__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_91__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_91__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_91__string = "URS1        ";
      default : _zz_91__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_92_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_92__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_92__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_92__string = "AND_1";
      default : _zz_92__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_93_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_93__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_93__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_93__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_93__string = "SRA_1    ";
      default : _zz_93__string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : decode_to_execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : decode_to_execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : decode_to_execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : decode_to_execute_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : decode_to_execute_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : decode_to_execute_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : decode_to_execute_SRC2_CTRL_string = "PC ";
      default : decode_to_execute_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : decode_to_execute_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : decode_to_execute_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : decode_to_execute_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : decode_to_execute_SRC1_CTRL_string = "URS1        ";
      default : decode_to_execute_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  `endif

  assign decode_ALU_BITWISE_CTRL = _zz_1_;
  assign _zz_2_ = _zz_3_;
  assign decode_MEMORY_ENABLE = _zz_56_;
  assign decode_SRC_LESS_UNSIGNED = _zz_54_;
  assign decode_SHIFT_CTRL = _zz_4_;
  assign _zz_5_ = _zz_6_;
  assign decode_SRC2_FORCE_ZERO = _zz_32_;
  assign decode_SRC1_CTRL = _zz_7_;
  assign _zz_8_ = _zz_9_;
  assign decode_ALU_CTRL = _zz_10_;
  assign _zz_11_ = _zz_12_;
  assign decode_DO_EBREAK = _zz_19_;
  assign decode_RS1_USE = _zz_44_;
  assign decode_MEMORY_STORE = _zz_48_;
  assign execute_REGFILE_WRITE_DATA = _zz_34_;
  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign decode_SRC2_CTRL = _zz_13_;
  assign _zz_14_ = _zz_15_;
  assign decode_RS2_USE = _zz_51_;
  assign decode_BRANCH_CTRL = _zz_16_;
  assign _zz_17_ = _zz_18_;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = _zz_60_;
  assign execute_DO_EBREAK = decode_to_execute_DO_EBREAK;
  assign decode_IS_EBREAK = _zz_41_;
  assign execute_RS2_USE = decode_to_execute_RS2_USE;
  assign execute_RS1_USE = decode_to_execute_RS1_USE;
  assign execute_IS_FENCEI = decode_to_execute_IS_FENCEI;
  always @ (*) begin
    _zz_20_ = decode_INSTRUCTION;
    if(decode_IS_FENCEI)begin
      _zz_20_[12] = 1'b0;
      _zz_20_[22] = 1'b1;
    end
  end

  assign decode_IS_FENCEI = _zz_43_;
  assign execute_BRANCH_CALC = _zz_21_;
  assign execute_BRANCH_DO = _zz_23_;
  assign execute_RS1 = _zz_40_;
  assign execute_BRANCH_CTRL = _zz_22_;
  assign execute_SHIFT_CTRL = _zz_24_;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC2_FORCE_ZERO = decode_to_execute_SRC2_FORCE_ZERO;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign execute_SRC2_CTRL = _zz_28_;
  assign execute_SRC1_CTRL = _zz_30_;
  assign decode_SRC_USE_SUB_LESS = _zz_42_;
  assign decode_SRC_ADD_ZERO = _zz_50_;
  assign execute_SRC_ADD_SUB = _zz_27_;
  assign execute_SRC_LESS = _zz_25_;
  assign execute_ALU_CTRL = _zz_33_;
  assign execute_SRC2 = _zz_29_;
  assign execute_SRC1 = _zz_31_;
  assign execute_ALU_BITWISE_CTRL = _zz_35_;
  assign _zz_36_ = execute_INSTRUCTION;
  assign _zz_37_ = execute_REGFILE_WRITE_VALID;
  always @ (*) begin
    _zz_38_ = 1'b0;
    if(lastStageRegFileWrite_valid)begin
      _zz_38_ = 1'b1;
    end
  end

  always @ (*) begin
    decode_REGFILE_WRITE_VALID = _zz_49_;
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  always @ (*) begin
    _zz_57_ = execute_REGFILE_WRITE_DATA;
    if((execute_arbitration_isValid && execute_MEMORY_ENABLE))begin
      _zz_57_ = execute_DBusSimplePlugin_rspFormated;
    end
    if(_zz_121_)begin
      _zz_57_ = _zz_101_;
    end
  end

  assign execute_MEMORY_ADDRESS_LOW = _zz_59_;
  assign execute_MEMORY_READ_DATA = _zz_58_;
  assign execute_SRC_ADD = _zz_26_;
  assign execute_RS2 = _zz_39_;
  assign execute_MEMORY_STORE = decode_to_execute_MEMORY_STORE;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign execute_ALIGNEMENT_FAULT = 1'b0;
  assign decode_PC = _zz_62_;
  assign decode_INSTRUCTION = _zz_61_;
  assign execute_PC = decode_to_execute_PC;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  always @ (*) begin
    decode_arbitration_haltItself = 1'b0;
    case(_zz_118_)
      3'b000 : begin
      end
      3'b001 : begin
      end
      3'b010 : begin
        decode_arbitration_haltItself = 1'b1;
      end
      3'b011 : begin
      end
      3'b100 : begin
      end
      default : begin
      end
    endcase
  end

  assign decode_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    decode_arbitration_removeIt = 1'b0;
    if(decode_arbitration_isFlushed)begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_flushIt = 1'b0;
  assign decode_arbitration_flushNext = 1'b0;
  always @ (*) begin
    execute_arbitration_haltItself = 1'b0;
    if(((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! dBus_cmd_ready)) && (! execute_DBusSimplePlugin_skipCmd)) && (! _zz_76_)))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_MEMORY_STORE)) && ((! dBus_rsp_ready) || (! _zz_76_))))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(_zz_121_)begin
      if(_zz_122_)begin
        if(! execute_LightShifterPlugin_done) begin
          execute_arbitration_haltItself = 1'b1;
        end
      end
    end
  end

  always @ (*) begin
    execute_arbitration_haltByOther = 1'b0;
    if(((execute_arbitration_isValid && execute_IS_FENCEI) && 1'b0))begin
      execute_arbitration_haltByOther = 1'b1;
    end
    if((execute_arbitration_isValid && (_zz_112_ || _zz_113_)))begin
      execute_arbitration_haltByOther = 1'b1;
    end
    if(_zz_123_)begin
      execute_arbitration_haltByOther = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_removeIt = 1'b0;
    if(execute_arbitration_isFlushed)begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_flushIt = 1'b0;
    if(_zz_123_)begin
      if(_zz_124_)begin
        execute_arbitration_flushIt = 1'b1;
      end
    end
  end

  always @ (*) begin
    execute_arbitration_flushNext = 1'b0;
    if(BranchPlugin_jumpInterface_valid)begin
      execute_arbitration_flushNext = 1'b1;
    end
    if(_zz_123_)begin
      if(_zz_124_)begin
        execute_arbitration_flushNext = 1'b1;
      end
    end
  end

  assign lastStageInstruction = execute_INSTRUCTION;
  assign lastStagePc = execute_PC;
  assign lastStageIsValid = execute_arbitration_isValid;
  assign lastStageIsFiring = execute_arbitration_isFiring;
  always @ (*) begin
    IBusSimplePlugin_fetcherHalt = 1'b0;
    if(_zz_123_)begin
      if(_zz_124_)begin
        IBusSimplePlugin_fetcherHalt = 1'b1;
      end
    end
    if(DebugPlugin_haltIt)begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(_zz_125_)begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
  end

  always @ (*) begin
    IBusSimplePlugin_fetcherflushIt = 1'b0;
    if(({execute_arbitration_flushNext,decode_arbitration_flushNext} != (2'b00)))begin
      IBusSimplePlugin_fetcherflushIt = 1'b1;
    end
    if(_zz_123_)begin
      if(_zz_124_)begin
        IBusSimplePlugin_fetcherflushIt = 1'b1;
      end
    end
  end

  always @ (*) begin
    IBusSimplePlugin_incomingInstruction = 1'b0;
    if(IBusSimplePlugin_iBusRsp_stages_1_input_valid)begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
    if(IBusSimplePlugin_injector_decodeInput_valid)begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
  end

  assign IBusSimplePlugin_jump_pcLoad_valid = (BranchPlugin_jumpInterface_valid != (1'b0));
  assign IBusSimplePlugin_jump_pcLoad_payload = BranchPlugin_jumpInterface_payload;
  always @ (*) begin
    IBusSimplePlugin_fetchPc_corrected = 1'b0;
    if(IBusSimplePlugin_jump_pcLoad_valid)begin
      IBusSimplePlugin_fetchPc_corrected = 1'b1;
    end
  end

  always @ (*) begin
    IBusSimplePlugin_fetchPc_pcRegPropagate = 1'b0;
    if(IBusSimplePlugin_iBusRsp_stages_1_input_ready)begin
      IBusSimplePlugin_fetchPc_pcRegPropagate = 1'b1;
    end
  end

  always @ (*) begin
    IBusSimplePlugin_fetchPc_pc = (IBusSimplePlugin_fetchPc_pcReg + _zz_130_);
    if(IBusSimplePlugin_jump_pcLoad_valid)begin
      IBusSimplePlugin_fetchPc_pc = IBusSimplePlugin_jump_pcLoad_payload;
    end
    IBusSimplePlugin_fetchPc_pc[0] = 1'b0;
    IBusSimplePlugin_fetchPc_pc[1] = 1'b0;
  end

  assign IBusSimplePlugin_fetchPc_output_valid = ((! IBusSimplePlugin_fetcherHalt) && IBusSimplePlugin_fetchPc_booted);
  assign IBusSimplePlugin_fetchPc_output_payload = IBusSimplePlugin_fetchPc_pc;
  assign IBusSimplePlugin_iBusRsp_stages_0_input_valid = IBusSimplePlugin_fetchPc_output_valid;
  assign IBusSimplePlugin_fetchPc_output_ready = IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  assign IBusSimplePlugin_iBusRsp_stages_0_input_payload = IBusSimplePlugin_fetchPc_output_payload;
  assign IBusSimplePlugin_iBusRsp_stages_0_inputSample = 1'b1;
  always @ (*) begin
    IBusSimplePlugin_iBusRsp_stages_0_halt = 1'b0;
    if((IBusSimplePlugin_iBusRsp_stages_0_input_valid && ((! IBusSimplePlugin_cmd_valid) || (! IBusSimplePlugin_cmd_ready))))begin
      IBusSimplePlugin_iBusRsp_stages_0_halt = 1'b1;
    end
  end

  assign _zz_63_ = (! IBusSimplePlugin_iBusRsp_stages_0_halt);
  assign IBusSimplePlugin_iBusRsp_stages_0_input_ready = (IBusSimplePlugin_iBusRsp_stages_0_output_ready && _zz_63_);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_valid = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && _zz_63_);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_payload = IBusSimplePlugin_iBusRsp_stages_0_input_payload;
  assign IBusSimplePlugin_iBusRsp_stages_1_halt = 1'b0;
  assign _zz_64_ = (! IBusSimplePlugin_iBusRsp_stages_1_halt);
  assign IBusSimplePlugin_iBusRsp_stages_1_input_ready = (IBusSimplePlugin_iBusRsp_stages_1_output_ready && _zz_64_);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_valid = (IBusSimplePlugin_iBusRsp_stages_1_input_valid && _zz_64_);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_payload = IBusSimplePlugin_iBusRsp_stages_1_input_payload;
  assign IBusSimplePlugin_iBusRsp_stages_0_output_ready = _zz_65_;
  assign _zz_65_ = ((1'b0 && (! _zz_66_)) || IBusSimplePlugin_iBusRsp_stages_1_input_ready);
  assign _zz_66_ = _zz_67_;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_valid = _zz_66_;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_payload = IBusSimplePlugin_fetchPc_pcReg;
  always @ (*) begin
    IBusSimplePlugin_iBusRsp_readyForError = 1'b1;
    if(IBusSimplePlugin_injector_decodeInput_valid)begin
      IBusSimplePlugin_iBusRsp_readyForError = 1'b0;
    end
    if((! IBusSimplePlugin_pcValids_0))begin
      IBusSimplePlugin_iBusRsp_readyForError = 1'b0;
    end
  end

  assign IBusSimplePlugin_iBusRsp_output_ready = ((1'b0 && (! IBusSimplePlugin_injector_decodeInput_valid)) || IBusSimplePlugin_injector_decodeInput_ready);
  assign IBusSimplePlugin_injector_decodeInput_valid = _zz_68_;
  assign IBusSimplePlugin_injector_decodeInput_payload_pc = _zz_69_;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_error = _zz_70_;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_inst = _zz_71_;
  assign IBusSimplePlugin_injector_decodeInput_payload_isRvc = _zz_72_;
  assign IBusSimplePlugin_pcValids_0 = IBusSimplePlugin_injector_nextPcCalc_valids_1;
  assign IBusSimplePlugin_pcValids_1 = IBusSimplePlugin_injector_nextPcCalc_valids_2;
  assign IBusSimplePlugin_injector_decodeInput_ready = (! decode_arbitration_isStuck);
  always @ (*) begin
    decode_arbitration_isValid = (IBusSimplePlugin_injector_decodeInput_valid && (! IBusSimplePlugin_injector_decodeRemoved));
    case(_zz_118_)
      3'b000 : begin
      end
      3'b001 : begin
      end
      3'b010 : begin
        decode_arbitration_isValid = 1'b1;
      end
      3'b011 : begin
        decode_arbitration_isValid = 1'b1;
      end
      3'b100 : begin
      end
      default : begin
      end
    endcase
  end

  assign _zz_62_ = IBusSimplePlugin_injector_decodeInput_payload_pc;
  assign _zz_61_ = IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  assign _zz_60_ = (decode_PC + (32'b00000000000000000000000000000100));
  assign IBusSimplePlugin_cmd_s2mPipe_valid = (IBusSimplePlugin_cmd_valid || _zz_73_);
  assign IBusSimplePlugin_cmd_ready = (! _zz_73_);
  assign IBusSimplePlugin_cmd_s2mPipe_payload_pc = (_zz_73_ ? _zz_74_ : IBusSimplePlugin_cmd_payload_pc);
  assign iBus_cmd_valid = IBusSimplePlugin_cmd_s2mPipe_valid;
  assign IBusSimplePlugin_cmd_s2mPipe_ready = iBus_cmd_ready;
  assign iBus_cmd_payload_pc = IBusSimplePlugin_cmd_s2mPipe_payload_pc;
  assign IBusSimplePlugin_pendingCmdNext = (_zz_131_ - _zz_135_);
  assign IBusSimplePlugin_cmd_valid = ((IBusSimplePlugin_iBusRsp_stages_0_input_valid && IBusSimplePlugin_iBusRsp_stages_0_output_ready) && (IBusSimplePlugin_pendingCmd != (3'b111)));
  assign IBusSimplePlugin_cmd_payload_pc = {IBusSimplePlugin_iBusRsp_stages_0_input_payload[31 : 2],(2'b00)};
  assign iBus_rsp_takeWhen_valid = (iBus_rsp_valid && (! (IBusSimplePlugin_rspJoin_discardCounter != (3'b000))));
  assign iBus_rsp_takeWhen_payload_error = iBus_rsp_payload_error;
  assign iBus_rsp_takeWhen_payload_inst = iBus_rsp_payload_inst;
  assign IBusSimplePlugin_rspJoin_rspBufferOutput_valid = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid;
  assign IBusSimplePlugin_rspJoin_rspBufferOutput_payload_error = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error;
  assign IBusSimplePlugin_rspJoin_rspBufferOutput_payload_inst = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst;
  assign IBusSimplePlugin_rspJoin_fetchRsp_pc = IBusSimplePlugin_iBusRsp_stages_1_output_payload;
  always @ (*) begin
    IBusSimplePlugin_rspJoin_fetchRsp_rsp_error = IBusSimplePlugin_rspJoin_rspBufferOutput_payload_error;
    if((! IBusSimplePlugin_rspJoin_rspBufferOutput_valid))begin
      IBusSimplePlugin_rspJoin_fetchRsp_rsp_error = 1'b0;
    end
  end

  assign IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst = IBusSimplePlugin_rspJoin_rspBufferOutput_payload_inst;
  assign IBusSimplePlugin_rspJoin_exceptionDetected = 1'b0;
  assign IBusSimplePlugin_rspJoin_redoRequired = 1'b0;
  assign IBusSimplePlugin_rspJoin_join_valid = (IBusSimplePlugin_iBusRsp_stages_1_output_valid && IBusSimplePlugin_rspJoin_rspBufferOutput_valid);
  assign IBusSimplePlugin_rspJoin_join_payload_pc = IBusSimplePlugin_rspJoin_fetchRsp_pc;
  assign IBusSimplePlugin_rspJoin_join_payload_rsp_error = IBusSimplePlugin_rspJoin_fetchRsp_rsp_error;
  assign IBusSimplePlugin_rspJoin_join_payload_rsp_inst = IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst;
  assign IBusSimplePlugin_rspJoin_join_payload_isRvc = IBusSimplePlugin_rspJoin_fetchRsp_isRvc;
  assign IBusSimplePlugin_iBusRsp_stages_1_output_ready = (IBusSimplePlugin_iBusRsp_stages_1_output_valid ? (IBusSimplePlugin_rspJoin_join_valid && IBusSimplePlugin_rspJoin_join_ready) : IBusSimplePlugin_rspJoin_join_ready);
  assign IBusSimplePlugin_rspJoin_rspBufferOutput_ready = (IBusSimplePlugin_rspJoin_join_valid && IBusSimplePlugin_rspJoin_join_ready);
  assign _zz_75_ = (! (IBusSimplePlugin_rspJoin_exceptionDetected || IBusSimplePlugin_rspJoin_redoRequired));
  assign IBusSimplePlugin_rspJoin_join_ready = (IBusSimplePlugin_iBusRsp_output_ready && _zz_75_);
  assign IBusSimplePlugin_iBusRsp_output_valid = (IBusSimplePlugin_rspJoin_join_valid && _zz_75_);
  assign IBusSimplePlugin_iBusRsp_output_payload_pc = IBusSimplePlugin_rspJoin_join_payload_pc;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_error = IBusSimplePlugin_rspJoin_join_payload_rsp_error;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_inst = IBusSimplePlugin_rspJoin_join_payload_rsp_inst;
  assign IBusSimplePlugin_iBusRsp_output_payload_isRvc = IBusSimplePlugin_rspJoin_join_payload_isRvc;
  always @ (*) begin
    execute_DBusSimplePlugin_skipCmd = 1'b0;
    if(execute_ALIGNEMENT_FAULT)begin
      execute_DBusSimplePlugin_skipCmd = 1'b1;
    end
  end

  assign dBus_cmd_valid = (((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_isFlushed)) && (! execute_DBusSimplePlugin_skipCmd)) && (! _zz_76_));
  assign dBus_cmd_payload_wr = execute_MEMORY_STORE;
  assign dBus_cmd_payload_size = execute_INSTRUCTION[13 : 12];
  always @ (*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_77_ = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_77_ = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_77_ = execute_RS2[31 : 0];
      end
    endcase
  end

  assign dBus_cmd_payload_data = _zz_77_;
  assign _zz_59_ = dBus_cmd_payload_address[1 : 0];
  always @ (*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_78_ = (4'b0001);
      end
      2'b01 : begin
        _zz_78_ = (4'b0011);
      end
      default : begin
        _zz_78_ = (4'b1111);
      end
    endcase
  end

  assign execute_DBusSimplePlugin_formalMask = (_zz_78_ <<< dBus_cmd_payload_address[1 : 0]);
  assign dBus_cmd_payload_address = execute_SRC_ADD;
  assign _zz_58_ = dBus_rsp_data;
  always @ (*) begin
    execute_DBusSimplePlugin_rspShifted = execute_MEMORY_READ_DATA;
    case(execute_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        execute_DBusSimplePlugin_rspShifted[7 : 0] = execute_MEMORY_READ_DATA[15 : 8];
      end
      2'b10 : begin
        execute_DBusSimplePlugin_rspShifted[15 : 0] = execute_MEMORY_READ_DATA[31 : 16];
      end
      2'b11 : begin
        execute_DBusSimplePlugin_rspShifted[7 : 0] = execute_MEMORY_READ_DATA[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign _zz_79_ = (execute_DBusSimplePlugin_rspShifted[7] && (! execute_INSTRUCTION[14]));
  always @ (*) begin
    _zz_80_[31] = _zz_79_;
    _zz_80_[30] = _zz_79_;
    _zz_80_[29] = _zz_79_;
    _zz_80_[28] = _zz_79_;
    _zz_80_[27] = _zz_79_;
    _zz_80_[26] = _zz_79_;
    _zz_80_[25] = _zz_79_;
    _zz_80_[24] = _zz_79_;
    _zz_80_[23] = _zz_79_;
    _zz_80_[22] = _zz_79_;
    _zz_80_[21] = _zz_79_;
    _zz_80_[20] = _zz_79_;
    _zz_80_[19] = _zz_79_;
    _zz_80_[18] = _zz_79_;
    _zz_80_[17] = _zz_79_;
    _zz_80_[16] = _zz_79_;
    _zz_80_[15] = _zz_79_;
    _zz_80_[14] = _zz_79_;
    _zz_80_[13] = _zz_79_;
    _zz_80_[12] = _zz_79_;
    _zz_80_[11] = _zz_79_;
    _zz_80_[10] = _zz_79_;
    _zz_80_[9] = _zz_79_;
    _zz_80_[8] = _zz_79_;
    _zz_80_[7 : 0] = execute_DBusSimplePlugin_rspShifted[7 : 0];
  end

  assign _zz_81_ = (execute_DBusSimplePlugin_rspShifted[15] && (! execute_INSTRUCTION[14]));
  always @ (*) begin
    _zz_82_[31] = _zz_81_;
    _zz_82_[30] = _zz_81_;
    _zz_82_[29] = _zz_81_;
    _zz_82_[28] = _zz_81_;
    _zz_82_[27] = _zz_81_;
    _zz_82_[26] = _zz_81_;
    _zz_82_[25] = _zz_81_;
    _zz_82_[24] = _zz_81_;
    _zz_82_[23] = _zz_81_;
    _zz_82_[22] = _zz_81_;
    _zz_82_[21] = _zz_81_;
    _zz_82_[20] = _zz_81_;
    _zz_82_[19] = _zz_81_;
    _zz_82_[18] = _zz_81_;
    _zz_82_[17] = _zz_81_;
    _zz_82_[16] = _zz_81_;
    _zz_82_[15 : 0] = execute_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @ (*) begin
    case(_zz_128_)
      2'b00 : begin
        execute_DBusSimplePlugin_rspFormated = _zz_80_;
      end
      2'b01 : begin
        execute_DBusSimplePlugin_rspFormated = _zz_82_;
      end
      default : begin
        execute_DBusSimplePlugin_rspFormated = execute_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  assign _zz_84_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_85_ = ((decode_INSTRUCTION & (32'b11111111111111111001111110001000)) == (32'b00000000000000000001000000001000));
  assign _zz_86_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001001000));
  assign _zz_87_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000010000)) == (32'b00000000000000000000000000010000));
  assign _zz_83_ = {(((decode_INSTRUCTION & _zz_169_) == (32'b00000000000000000000000001010000)) != (1'b0)),{(_zz_87_ != (1'b0)),{({_zz_170_,_zz_171_} != (3'b000)),{(_zz_172_ != _zz_173_),{_zz_174_,{_zz_175_,_zz_176_}}}}}};
  assign _zz_56_ = _zz_140_[0];
  assign _zz_88_ = _zz_83_[2 : 1];
  assign _zz_55_ = _zz_88_;
  assign _zz_54_ = _zz_141_[0];
  assign _zz_89_ = _zz_83_[5 : 4];
  assign _zz_53_ = _zz_89_;
  assign _zz_90_ = _zz_83_[7 : 6];
  assign _zz_52_ = _zz_90_;
  assign _zz_51_ = _zz_142_[0];
  assign _zz_50_ = _zz_143_[0];
  assign _zz_49_ = _zz_144_[0];
  assign _zz_48_ = _zz_145_[0];
  assign _zz_91_ = _zz_83_[14 : 13];
  assign _zz_47_ = _zz_91_;
  assign _zz_92_ = _zz_83_[17 : 16];
  assign _zz_46_ = _zz_92_;
  assign _zz_93_ = _zz_83_[19 : 18];
  assign _zz_45_ = _zz_93_;
  assign _zz_44_ = _zz_146_[0];
  assign _zz_43_ = _zz_147_[0];
  assign _zz_42_ = _zz_148_[0];
  assign _zz_41_ = _zz_149_[0];
  assign execute_RegFilePlugin_srcInstruction = (execute_arbitration_isStuck ? execute_INSTRUCTION : decode_INSTRUCTION);
  assign execute_RegFilePlugin_regFileReadAddress1 = execute_RegFilePlugin_srcInstruction[19 : 15];
  assign execute_RegFilePlugin_regFileReadAddress2 = execute_RegFilePlugin_srcInstruction[24 : 20];
  assign execute_RegFilePlugin_rs1Data = _zz_119_;
  assign execute_RegFilePlugin_rs2Data = _zz_120_;
  assign _zz_40_ = execute_RegFilePlugin_rs1Data;
  assign _zz_39_ = execute_RegFilePlugin_rs2Data;
  assign lastStageRegFileWrite_valid = (_zz_37_ && execute_arbitration_isFiring);
  assign lastStageRegFileWrite_payload_address = _zz_36_[11 : 7];
  assign lastStageRegFileWrite_payload_data = _zz_57_;
  always @ (*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
    endcase
  end

  always @ (*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_BITWISE : begin
        _zz_94_ = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : begin
        _zz_94_ = {31'd0, _zz_150_};
      end
      default : begin
        _zz_94_ = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign _zz_34_ = _zz_94_;
  assign _zz_32_ = (decode_SRC_ADD_ZERO && (! decode_SRC_USE_SUB_LESS));
  always @ (*) begin
    case(execute_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : begin
        _zz_95_ = execute_RS1;
      end
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : begin
        _zz_95_ = {29'd0, _zz_151_};
      end
      `Src1CtrlEnum_defaultEncoding_IMU : begin
        _zz_95_ = {execute_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
      default : begin
        _zz_95_ = {27'd0, _zz_152_};
      end
    endcase
  end

  assign _zz_31_ = _zz_95_;
  assign _zz_96_ = _zz_153_[11];
  always @ (*) begin
    _zz_97_[19] = _zz_96_;
    _zz_97_[18] = _zz_96_;
    _zz_97_[17] = _zz_96_;
    _zz_97_[16] = _zz_96_;
    _zz_97_[15] = _zz_96_;
    _zz_97_[14] = _zz_96_;
    _zz_97_[13] = _zz_96_;
    _zz_97_[12] = _zz_96_;
    _zz_97_[11] = _zz_96_;
    _zz_97_[10] = _zz_96_;
    _zz_97_[9] = _zz_96_;
    _zz_97_[8] = _zz_96_;
    _zz_97_[7] = _zz_96_;
    _zz_97_[6] = _zz_96_;
    _zz_97_[5] = _zz_96_;
    _zz_97_[4] = _zz_96_;
    _zz_97_[3] = _zz_96_;
    _zz_97_[2] = _zz_96_;
    _zz_97_[1] = _zz_96_;
    _zz_97_[0] = _zz_96_;
  end

  assign _zz_98_ = _zz_154_[11];
  always @ (*) begin
    _zz_99_[19] = _zz_98_;
    _zz_99_[18] = _zz_98_;
    _zz_99_[17] = _zz_98_;
    _zz_99_[16] = _zz_98_;
    _zz_99_[15] = _zz_98_;
    _zz_99_[14] = _zz_98_;
    _zz_99_[13] = _zz_98_;
    _zz_99_[12] = _zz_98_;
    _zz_99_[11] = _zz_98_;
    _zz_99_[10] = _zz_98_;
    _zz_99_[9] = _zz_98_;
    _zz_99_[8] = _zz_98_;
    _zz_99_[7] = _zz_98_;
    _zz_99_[6] = _zz_98_;
    _zz_99_[5] = _zz_98_;
    _zz_99_[4] = _zz_98_;
    _zz_99_[3] = _zz_98_;
    _zz_99_[2] = _zz_98_;
    _zz_99_[1] = _zz_98_;
    _zz_99_[0] = _zz_98_;
  end

  always @ (*) begin
    case(execute_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : begin
        _zz_100_ = execute_RS2;
      end
      `Src2CtrlEnum_defaultEncoding_IMI : begin
        _zz_100_ = {_zz_97_,execute_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_defaultEncoding_IMS : begin
        _zz_100_ = {_zz_99_,{execute_INSTRUCTION[31 : 25],execute_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_100_ = execute_PC;
      end
    endcase
  end

  assign _zz_29_ = _zz_100_;
  always @ (*) begin
    execute_SrcPlugin_addSub = _zz_155_;
    if(execute_SRC2_FORCE_ZERO)begin
      execute_SrcPlugin_addSub = execute_SRC1;
    end
  end

  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign _zz_27_ = execute_SrcPlugin_addSub;
  assign _zz_26_ = execute_SrcPlugin_addSub;
  assign _zz_25_ = execute_SrcPlugin_less;
  assign execute_LightShifterPlugin_isShift = (execute_SHIFT_CTRL != `ShiftCtrlEnum_defaultEncoding_DISABLE_1);
  assign execute_LightShifterPlugin_amplitude = (execute_LightShifterPlugin_isActive ? execute_LightShifterPlugin_amplitudeReg : execute_SRC2[4 : 0]);
  assign execute_LightShifterPlugin_shiftInput = (execute_LightShifterPlugin_isActive ? execute_LightShifterPlugin_shiftReg : execute_SRC1);
  assign execute_LightShifterPlugin_done = (execute_LightShifterPlugin_amplitude[4 : 1] == (4'b0000));
  always @ (*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : begin
        _zz_101_ = (execute_LightShifterPlugin_shiftInput <<< 1);
      end
      default : begin
        _zz_101_ = _zz_162_;
      end
    endcase
  end

  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _zz_102_ = execute_INSTRUCTION[14 : 12];
  always @ (*) begin
    if((_zz_102_ == (3'b000))) begin
        _zz_103_ = execute_BranchPlugin_eq;
    end else if((_zz_102_ == (3'b001))) begin
        _zz_103_ = (! execute_BranchPlugin_eq);
    end else if((((_zz_102_ & (3'b101)) == (3'b101)))) begin
        _zz_103_ = (! execute_SRC_LESS);
    end else begin
        _zz_103_ = execute_SRC_LESS;
    end
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : begin
        _zz_104_ = 1'b0;
      end
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_104_ = 1'b1;
      end
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        _zz_104_ = 1'b1;
      end
      default : begin
        _zz_104_ = _zz_103_;
      end
    endcase
  end

  assign _zz_23_ = _zz_104_;
  assign execute_BranchPlugin_branch_src1 = ((execute_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JALR) ? execute_RS1 : execute_PC);
  assign _zz_105_ = _zz_164_[19];
  always @ (*) begin
    _zz_106_[10] = _zz_105_;
    _zz_106_[9] = _zz_105_;
    _zz_106_[8] = _zz_105_;
    _zz_106_[7] = _zz_105_;
    _zz_106_[6] = _zz_105_;
    _zz_106_[5] = _zz_105_;
    _zz_106_[4] = _zz_105_;
    _zz_106_[3] = _zz_105_;
    _zz_106_[2] = _zz_105_;
    _zz_106_[1] = _zz_105_;
    _zz_106_[0] = _zz_105_;
  end

  assign _zz_107_ = _zz_165_[11];
  always @ (*) begin
    _zz_108_[19] = _zz_107_;
    _zz_108_[18] = _zz_107_;
    _zz_108_[17] = _zz_107_;
    _zz_108_[16] = _zz_107_;
    _zz_108_[15] = _zz_107_;
    _zz_108_[14] = _zz_107_;
    _zz_108_[13] = _zz_107_;
    _zz_108_[12] = _zz_107_;
    _zz_108_[11] = _zz_107_;
    _zz_108_[10] = _zz_107_;
    _zz_108_[9] = _zz_107_;
    _zz_108_[8] = _zz_107_;
    _zz_108_[7] = _zz_107_;
    _zz_108_[6] = _zz_107_;
    _zz_108_[5] = _zz_107_;
    _zz_108_[4] = _zz_107_;
    _zz_108_[3] = _zz_107_;
    _zz_108_[2] = _zz_107_;
    _zz_108_[1] = _zz_107_;
    _zz_108_[0] = _zz_107_;
  end

  assign _zz_109_ = _zz_166_[11];
  always @ (*) begin
    _zz_110_[18] = _zz_109_;
    _zz_110_[17] = _zz_109_;
    _zz_110_[16] = _zz_109_;
    _zz_110_[15] = _zz_109_;
    _zz_110_[14] = _zz_109_;
    _zz_110_[13] = _zz_109_;
    _zz_110_[12] = _zz_109_;
    _zz_110_[11] = _zz_109_;
    _zz_110_[10] = _zz_109_;
    _zz_110_[9] = _zz_109_;
    _zz_110_[8] = _zz_109_;
    _zz_110_[7] = _zz_109_;
    _zz_110_[6] = _zz_109_;
    _zz_110_[5] = _zz_109_;
    _zz_110_[4] = _zz_109_;
    _zz_110_[3] = _zz_109_;
    _zz_110_[2] = _zz_109_;
    _zz_110_[1] = _zz_109_;
    _zz_110_[0] = _zz_109_;
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_111_ = {{_zz_106_,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
      end
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        _zz_111_ = {_zz_108_,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        _zz_111_ = {{_zz_110_,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src2 = _zz_111_;
  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign _zz_21_ = {execute_BranchPlugin_branchAdder[31 : 1],(1'b0)};
  assign BranchPlugin_jumpInterface_valid = ((execute_arbitration_isValid && execute_BRANCH_DO) && (! execute_arbitration_isStuckByOthers));
  assign BranchPlugin_jumpInterface_payload = execute_BRANCH_CALC;
  always @ (*) begin
    _zz_112_ = 1'b0;
    if(_zz_115_)begin
      if((_zz_116_ == execute_INSTRUCTION[19 : 15]))begin
        _zz_112_ = 1'b1;
      end
    end
    if((! execute_RS1_USE))begin
      _zz_112_ = 1'b0;
    end
  end

  always @ (*) begin
    _zz_113_ = 1'b0;
    if(_zz_115_)begin
      if((_zz_116_ == execute_INSTRUCTION[24 : 20]))begin
        _zz_113_ = 1'b1;
      end
    end
    if((! execute_RS2_USE))begin
      _zz_113_ = 1'b0;
    end
  end

  assign _zz_114_ = (_zz_37_ && execute_arbitration_isFiring);
  always @ (*) begin
    debug_bus_cmd_ready = 1'b1;
    if(debug_bus_cmd_valid)begin
      case(_zz_126_)
        6'b000000 : begin
        end
        6'b000001 : begin
          if(debug_bus_cmd_payload_wr)begin
            debug_bus_cmd_ready = IBusSimplePlugin_injectionPort_ready;
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @ (*) begin
    debug_bus_rsp_data = DebugPlugin_busReadDataReg;
    if((! _zz_117_))begin
      debug_bus_rsp_data[0] = DebugPlugin_resetIt;
      debug_bus_rsp_data[1] = DebugPlugin_haltIt;
      debug_bus_rsp_data[2] = DebugPlugin_isPipBusy;
      debug_bus_rsp_data[3] = DebugPlugin_haltedByBreak;
      debug_bus_rsp_data[4] = DebugPlugin_stepIt;
    end
  end

  always @ (*) begin
    IBusSimplePlugin_injectionPort_valid = 1'b0;
    if(debug_bus_cmd_valid)begin
      case(_zz_126_)
        6'b000000 : begin
        end
        6'b000001 : begin
          if(debug_bus_cmd_payload_wr)begin
            IBusSimplePlugin_injectionPort_valid = 1'b1;
          end
        end
        default : begin
        end
      endcase
    end
  end

  assign IBusSimplePlugin_injectionPort_payload = debug_bus_cmd_payload_data;
  assign _zz_19_ = ((! DebugPlugin_haltIt) && (decode_IS_EBREAK || 1'b0));
  assign debug_resetOut = DebugPlugin_resetIt_regNext;
  assign _zz_18_ = decode_BRANCH_CTRL;
  assign _zz_16_ = _zz_52_;
  assign _zz_22_ = decode_to_execute_BRANCH_CTRL;
  assign _zz_15_ = decode_SRC2_CTRL;
  assign _zz_13_ = _zz_53_;
  assign _zz_28_ = decode_to_execute_SRC2_CTRL;
  assign _zz_12_ = decode_ALU_CTRL;
  assign _zz_10_ = _zz_55_;
  assign _zz_33_ = decode_to_execute_ALU_CTRL;
  assign _zz_9_ = decode_SRC1_CTRL;
  assign _zz_7_ = _zz_47_;
  assign _zz_30_ = decode_to_execute_SRC1_CTRL;
  assign _zz_6_ = decode_SHIFT_CTRL;
  assign _zz_4_ = _zz_45_;
  assign _zz_24_ = decode_to_execute_SHIFT_CTRL;
  assign _zz_3_ = decode_ALU_BITWISE_CTRL;
  assign _zz_1_ = _zz_46_;
  assign _zz_35_ = decode_to_execute_ALU_BITWISE_CTRL;
  assign decode_arbitration_isFlushed = ((execute_arbitration_flushNext != (1'b0)) || ({execute_arbitration_flushIt,decode_arbitration_flushIt} != (2'b00)));
  assign execute_arbitration_isFlushed = (1'b0 || (execute_arbitration_flushIt != (1'b0)));
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (1'b0 || execute_arbitration_isStuck));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || 1'b0);
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  always @ (*) begin
    IBusSimplePlugin_injectionPort_ready = 1'b0;
    case(_zz_118_)
      3'b000 : begin
      end
      3'b001 : begin
      end
      3'b010 : begin
      end
      3'b011 : begin
      end
      3'b100 : begin
        IBusSimplePlugin_injectionPort_ready = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      IBusSimplePlugin_fetchPc_pcReg <= (32'b10000000000000000000000000000000);
      IBusSimplePlugin_fetchPc_booted <= 1'b0;
      IBusSimplePlugin_fetchPc_inc <= 1'b0;
      _zz_67_ <= 1'b0;
      _zz_68_ <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusSimplePlugin_injector_decodeRemoved <= 1'b0;
      _zz_73_ <= 1'b0;
      IBusSimplePlugin_pendingCmd <= (3'b000);
      IBusSimplePlugin_rspJoin_discardCounter <= (3'b000);
      _zz_76_ <= 1'b0;
      execute_LightShifterPlugin_isActive <= 1'b0;
      _zz_115_ <= 1'b0;
      execute_arbitration_isValid <= 1'b0;
      _zz_118_ <= (3'b000);
    end else begin
      IBusSimplePlugin_fetchPc_booted <= 1'b1;
      if((IBusSimplePlugin_fetchPc_corrected || IBusSimplePlugin_fetchPc_pcRegPropagate))begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if((IBusSimplePlugin_fetchPc_output_valid && IBusSimplePlugin_fetchPc_output_ready))begin
        IBusSimplePlugin_fetchPc_inc <= 1'b1;
      end
      if(((! IBusSimplePlugin_fetchPc_output_valid) && IBusSimplePlugin_fetchPc_output_ready))begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if((IBusSimplePlugin_fetchPc_booted && ((IBusSimplePlugin_fetchPc_output_ready || IBusSimplePlugin_fetcherflushIt) || IBusSimplePlugin_fetchPc_pcRegPropagate)))begin
        IBusSimplePlugin_fetchPc_pcReg <= IBusSimplePlugin_fetchPc_pc;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        _zz_67_ <= 1'b0;
      end
      if(_zz_65_)begin
        _zz_67_ <= IBusSimplePlugin_iBusRsp_stages_0_output_valid;
      end
      if(IBusSimplePlugin_iBusRsp_output_ready)begin
        _zz_68_ <= IBusSimplePlugin_iBusRsp_output_valid;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        _zz_68_ <= 1'b0;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if((! (! IBusSimplePlugin_iBusRsp_stages_1_input_ready)))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((! (! IBusSimplePlugin_injector_decodeInput_ready)))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= IBusSimplePlugin_injector_nextPcCalc_valids_0;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((! execute_arbitration_isStuck))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= IBusSimplePlugin_injector_nextPcCalc_valids_1;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if(decode_arbitration_removeIt)begin
        IBusSimplePlugin_injector_decodeRemoved <= 1'b1;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        IBusSimplePlugin_injector_decodeRemoved <= 1'b0;
      end
      if(IBusSimplePlugin_cmd_s2mPipe_ready)begin
        _zz_73_ <= 1'b0;
      end
      if(_zz_127_)begin
        _zz_73_ <= IBusSimplePlugin_cmd_valid;
      end
      IBusSimplePlugin_pendingCmd <= IBusSimplePlugin_pendingCmdNext;
      IBusSimplePlugin_rspJoin_discardCounter <= (IBusSimplePlugin_rspJoin_discardCounter - _zz_137_);
      if(IBusSimplePlugin_fetcherflushIt)begin
        IBusSimplePlugin_rspJoin_discardCounter <= (IBusSimplePlugin_pendingCmd - _zz_139_);
      end
      if((dBus_cmd_valid && dBus_cmd_ready))begin
        _zz_76_ <= 1'b1;
      end
      if((! execute_arbitration_isStuck))begin
        _zz_76_ <= 1'b0;
      end
      if(_zz_121_)begin
        if(_zz_122_)begin
          execute_LightShifterPlugin_isActive <= 1'b1;
          if(execute_LightShifterPlugin_done)begin
            execute_LightShifterPlugin_isActive <= 1'b0;
          end
        end
      end
      if(execute_arbitration_removeIt)begin
        execute_LightShifterPlugin_isActive <= 1'b0;
      end
      _zz_115_ <= _zz_114_;
      if(((! execute_arbitration_isStuck) || execute_arbitration_removeIt))begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt)))begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      case(_zz_118_)
        3'b000 : begin
          if(IBusSimplePlugin_injectionPort_valid)begin
            _zz_118_ <= (3'b001);
          end
        end
        3'b001 : begin
          _zz_118_ <= (3'b010);
        end
        3'b010 : begin
          _zz_118_ <= (3'b011);
        end
        3'b011 : begin
          if((! decode_arbitration_isStuck))begin
            _zz_118_ <= (3'b100);
          end
        end
        3'b100 : begin
          _zz_118_ <= (3'b000);
        end
        default : begin
        end
      endcase
    end
  end

  always @ (posedge clock_out) begin
    if(IBusSimplePlugin_iBusRsp_output_ready)begin
      _zz_69_ <= IBusSimplePlugin_iBusRsp_output_payload_pc;
      _zz_70_ <= IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
      _zz_71_ <= IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
      _zz_72_ <= IBusSimplePlugin_iBusRsp_output_payload_isRvc;
    end
    if(IBusSimplePlugin_injector_decodeInput_ready)begin
      IBusSimplePlugin_injector_formal_rawInDecode <= IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
    end
    if(_zz_127_)begin
      _zz_74_ <= IBusSimplePlugin_cmd_payload_pc;
    end
    if((! execute_arbitration_isStuckByOthers))begin
      execute_LightShifterPlugin_shiftReg <= _zz_57_;
    end
    if(_zz_121_)begin
      if(_zz_122_)begin
        execute_LightShifterPlugin_amplitudeReg <= (execute_LightShifterPlugin_amplitude - (5'b00001));
      end
    end
    if(_zz_114_)begin
      _zz_116_ <= _zz_36_[11 : 7];
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FORMAL_PC_NEXT <= decode_FORMAL_PC_NEXT;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BRANCH_CTRL <= _zz_17_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS2_USE <= decode_RS2_USE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_CTRL <= _zz_14_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_STORE <= decode_MEMORY_STORE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS1_USE <= decode_RS1_USE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PC <= decode_PC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_DO_EBREAK <= decode_DO_EBREAK;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_FENCEI <= decode_IS_FENCEI;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_CTRL <= _zz_11_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC1_CTRL <= _zz_8_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_FORCE_ZERO <= decode_SRC2_FORCE_ZERO;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_INSTRUCTION <= _zz_20_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SHIFT_CTRL <= _zz_5_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_2_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if((_zz_118_ != (3'b000)))begin
      _zz_71_ <= IBusSimplePlugin_injectionPort_payload;
    end
  end

  always @ (posedge clock_out) begin
    DebugPlugin_firstCycle <= 1'b0;
    if(debug_bus_cmd_ready)begin
      DebugPlugin_firstCycle <= 1'b1;
    end
    DebugPlugin_secondCycle <= DebugPlugin_firstCycle;
    DebugPlugin_isPipBusy <= (({execute_arbitration_isValid,decode_arbitration_isValid} != (2'b00)) || IBusSimplePlugin_incomingInstruction);
    if(execute_arbitration_isValid)begin
      DebugPlugin_busReadDataReg <= _zz_57_;
    end
    _zz_117_ <= debug_bus_cmd_payload_address[2];
    if(_zz_123_)begin
      DebugPlugin_busReadDataReg <= execute_PC;
    end
    DebugPlugin_resetIt_regNext <= DebugPlugin_resetIt;
  end

  always @ (posedge clock_out) begin
    if(clockCtrl_resetUnbuffered_regNext) begin
      DebugPlugin_resetIt <= 1'b0;
      DebugPlugin_haltIt <= 1'b0;
      DebugPlugin_stepIt <= 1'b0;
      DebugPlugin_godmode <= 1'b0;
      DebugPlugin_haltedByBreak <= 1'b0;
    end else begin
      if((DebugPlugin_haltIt && (! DebugPlugin_isPipBusy)))begin
        DebugPlugin_godmode <= 1'b1;
      end
      if(debug_bus_cmd_valid)begin
        case(_zz_126_)
          6'b000000 : begin
            if(debug_bus_cmd_payload_wr)begin
              DebugPlugin_stepIt <= debug_bus_cmd_payload_data[4];
              if(debug_bus_cmd_payload_data[16])begin
                DebugPlugin_resetIt <= 1'b1;
              end
              if(debug_bus_cmd_payload_data[24])begin
                DebugPlugin_resetIt <= 1'b0;
              end
              if(debug_bus_cmd_payload_data[17])begin
                DebugPlugin_haltIt <= 1'b1;
              end
              if(debug_bus_cmd_payload_data[25])begin
                DebugPlugin_haltIt <= 1'b0;
              end
              if(debug_bus_cmd_payload_data[25])begin
                DebugPlugin_haltedByBreak <= 1'b0;
              end
              if(debug_bus_cmd_payload_data[25])begin
                DebugPlugin_godmode <= 1'b0;
              end
            end
          end
          6'b000001 : begin
          end
          default : begin
          end
        endcase
      end
      if(_zz_123_)begin
        if(_zz_124_)begin
          DebugPlugin_haltIt <= 1'b1;
          DebugPlugin_haltedByBreak <= 1'b1;
        end
      end
      if(_zz_125_)begin
        if(decode_arbitration_isValid)begin
          DebugPlugin_haltIt <= 1'b1;
        end
      end
    end
  end

endmodule

module JtagBridge (
      input   io_jtag_tms,
      input   io_jtag_tdi,
      output  io_jtag_tdo,
      input   io_jtag_tck,
      output  io_remote_cmd_valid,
      input   io_remote_cmd_ready,
      output  io_remote_cmd_payload_last,
      output [0:0] io_remote_cmd_payload_fragment,
      input   io_remote_rsp_valid,
      output  io_remote_rsp_ready,
      input   io_remote_rsp_payload_error,
      input  [31:0] io_remote_rsp_payload_data,
      input   clock_out,
      input   clockCtrl_resetUnbuffered_regNext);
  wire  flowCCByToggle_1__io_output_valid;
  wire  flowCCByToggle_1__io_output_payload_last;
  wire [0:0] flowCCByToggle_1__io_output_payload_fragment;
  wire  _zz_2_;
  wire  _zz_3_;
  wire [3:0] _zz_4_;
  wire [3:0] _zz_5_;
  wire [3:0] _zz_6_;
  wire  system_cmd_valid;
  wire  system_cmd_payload_last;
  wire [0:0] system_cmd_payload_fragment;
  reg  system_rsp_valid;
  reg  system_rsp_payload_error;
  reg [31:0] system_rsp_payload_data;
  wire `JtagState_defaultEncoding_type jtag_tap_fsm_stateNext;
  reg `JtagState_defaultEncoding_type jtag_tap_fsm_state = `JtagState_defaultEncoding_RESET;
  reg `JtagState_defaultEncoding_type _zz_1_;
  reg [3:0] jtag_tap_instruction;
  reg [3:0] jtag_tap_instructionShift;
  reg  jtag_tap_bypass;
  reg  jtag_tap_tdoUnbufferd;
  reg  jtag_tap_tdoUnbufferd_regNext;
  wire [0:0] jtag_idcodeArea_instructionId;
  wire  jtag_idcodeArea_instructionHit;
  reg [31:0] jtag_idcodeArea_shifter;
  wire [1:0] jtag_writeArea_instructionId;
  wire  jtag_writeArea_instructionHit;
  reg  jtag_writeArea_source_valid;
  wire  jtag_writeArea_source_payload_last;
  wire [0:0] jtag_writeArea_source_payload_fragment;
  wire [1:0] jtag_readArea_instructionId;
  wire  jtag_readArea_instructionHit;
  reg [33:0] jtag_readArea_shifter;
  `ifndef SYNTHESIS
  reg [79:0] jtag_tap_fsm_stateNext_string;
  reg [79:0] jtag_tap_fsm_state_string;
  reg [79:0] _zz_1__string;
  `endif

  assign _zz_2_ = (jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_SHIFT);
  assign _zz_3_ = (jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_SHIFT);
  assign _zz_4_ = {3'd0, jtag_idcodeArea_instructionId};
  assign _zz_5_ = {2'd0, jtag_writeArea_instructionId};
  assign _zz_6_ = {2'd0, jtag_readArea_instructionId};
  FlowCCByToggle flowCCByToggle_1_ ( 
    .io_input_valid(jtag_writeArea_source_valid),
    .io_input_payload_last(jtag_writeArea_source_payload_last),
    .io_input_payload_fragment(jtag_writeArea_source_payload_fragment),
    .io_output_valid(flowCCByToggle_1__io_output_valid),
    .io_output_payload_last(flowCCByToggle_1__io_output_payload_last),
    .io_output_payload_fragment(flowCCByToggle_1__io_output_payload_fragment),
    .io_jtag_tck(io_jtag_tck),
    .clock_out(clock_out),
    .clockCtrl_resetUnbuffered_regNext(clockCtrl_resetUnbuffered_regNext) 
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(jtag_tap_fsm_stateNext)
      `JtagState_defaultEncoding_RESET : jtag_tap_fsm_stateNext_string = "RESET     ";
      `JtagState_defaultEncoding_IDLE : jtag_tap_fsm_stateNext_string = "IDLE      ";
      `JtagState_defaultEncoding_IR_SELECT : jtag_tap_fsm_stateNext_string = "IR_SELECT ";
      `JtagState_defaultEncoding_IR_CAPTURE : jtag_tap_fsm_stateNext_string = "IR_CAPTURE";
      `JtagState_defaultEncoding_IR_SHIFT : jtag_tap_fsm_stateNext_string = "IR_SHIFT  ";
      `JtagState_defaultEncoding_IR_EXIT1 : jtag_tap_fsm_stateNext_string = "IR_EXIT1  ";
      `JtagState_defaultEncoding_IR_PAUSE : jtag_tap_fsm_stateNext_string = "IR_PAUSE  ";
      `JtagState_defaultEncoding_IR_EXIT2 : jtag_tap_fsm_stateNext_string = "IR_EXIT2  ";
      `JtagState_defaultEncoding_IR_UPDATE : jtag_tap_fsm_stateNext_string = "IR_UPDATE ";
      `JtagState_defaultEncoding_DR_SELECT : jtag_tap_fsm_stateNext_string = "DR_SELECT ";
      `JtagState_defaultEncoding_DR_CAPTURE : jtag_tap_fsm_stateNext_string = "DR_CAPTURE";
      `JtagState_defaultEncoding_DR_SHIFT : jtag_tap_fsm_stateNext_string = "DR_SHIFT  ";
      `JtagState_defaultEncoding_DR_EXIT1 : jtag_tap_fsm_stateNext_string = "DR_EXIT1  ";
      `JtagState_defaultEncoding_DR_PAUSE : jtag_tap_fsm_stateNext_string = "DR_PAUSE  ";
      `JtagState_defaultEncoding_DR_EXIT2 : jtag_tap_fsm_stateNext_string = "DR_EXIT2  ";
      `JtagState_defaultEncoding_DR_UPDATE : jtag_tap_fsm_stateNext_string = "DR_UPDATE ";
      default : jtag_tap_fsm_stateNext_string = "??????????";
    endcase
  end
  always @(*) begin
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_RESET : jtag_tap_fsm_state_string = "RESET     ";
      `JtagState_defaultEncoding_IDLE : jtag_tap_fsm_state_string = "IDLE      ";
      `JtagState_defaultEncoding_IR_SELECT : jtag_tap_fsm_state_string = "IR_SELECT ";
      `JtagState_defaultEncoding_IR_CAPTURE : jtag_tap_fsm_state_string = "IR_CAPTURE";
      `JtagState_defaultEncoding_IR_SHIFT : jtag_tap_fsm_state_string = "IR_SHIFT  ";
      `JtagState_defaultEncoding_IR_EXIT1 : jtag_tap_fsm_state_string = "IR_EXIT1  ";
      `JtagState_defaultEncoding_IR_PAUSE : jtag_tap_fsm_state_string = "IR_PAUSE  ";
      `JtagState_defaultEncoding_IR_EXIT2 : jtag_tap_fsm_state_string = "IR_EXIT2  ";
      `JtagState_defaultEncoding_IR_UPDATE : jtag_tap_fsm_state_string = "IR_UPDATE ";
      `JtagState_defaultEncoding_DR_SELECT : jtag_tap_fsm_state_string = "DR_SELECT ";
      `JtagState_defaultEncoding_DR_CAPTURE : jtag_tap_fsm_state_string = "DR_CAPTURE";
      `JtagState_defaultEncoding_DR_SHIFT : jtag_tap_fsm_state_string = "DR_SHIFT  ";
      `JtagState_defaultEncoding_DR_EXIT1 : jtag_tap_fsm_state_string = "DR_EXIT1  ";
      `JtagState_defaultEncoding_DR_PAUSE : jtag_tap_fsm_state_string = "DR_PAUSE  ";
      `JtagState_defaultEncoding_DR_EXIT2 : jtag_tap_fsm_state_string = "DR_EXIT2  ";
      `JtagState_defaultEncoding_DR_UPDATE : jtag_tap_fsm_state_string = "DR_UPDATE ";
      default : jtag_tap_fsm_state_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_1_)
      `JtagState_defaultEncoding_RESET : _zz_1__string = "RESET     ";
      `JtagState_defaultEncoding_IDLE : _zz_1__string = "IDLE      ";
      `JtagState_defaultEncoding_IR_SELECT : _zz_1__string = "IR_SELECT ";
      `JtagState_defaultEncoding_IR_CAPTURE : _zz_1__string = "IR_CAPTURE";
      `JtagState_defaultEncoding_IR_SHIFT : _zz_1__string = "IR_SHIFT  ";
      `JtagState_defaultEncoding_IR_EXIT1 : _zz_1__string = "IR_EXIT1  ";
      `JtagState_defaultEncoding_IR_PAUSE : _zz_1__string = "IR_PAUSE  ";
      `JtagState_defaultEncoding_IR_EXIT2 : _zz_1__string = "IR_EXIT2  ";
      `JtagState_defaultEncoding_IR_UPDATE : _zz_1__string = "IR_UPDATE ";
      `JtagState_defaultEncoding_DR_SELECT : _zz_1__string = "DR_SELECT ";
      `JtagState_defaultEncoding_DR_CAPTURE : _zz_1__string = "DR_CAPTURE";
      `JtagState_defaultEncoding_DR_SHIFT : _zz_1__string = "DR_SHIFT  ";
      `JtagState_defaultEncoding_DR_EXIT1 : _zz_1__string = "DR_EXIT1  ";
      `JtagState_defaultEncoding_DR_PAUSE : _zz_1__string = "DR_PAUSE  ";
      `JtagState_defaultEncoding_DR_EXIT2 : _zz_1__string = "DR_EXIT2  ";
      `JtagState_defaultEncoding_DR_UPDATE : _zz_1__string = "DR_UPDATE ";
      default : _zz_1__string = "??????????";
    endcase
  end
  `endif

  assign io_remote_cmd_valid = system_cmd_valid;
  assign io_remote_cmd_payload_last = system_cmd_payload_last;
  assign io_remote_cmd_payload_fragment = system_cmd_payload_fragment;
  assign io_remote_rsp_ready = 1'b1;
  always @ (*) begin
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_IDLE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_SELECT : `JtagState_defaultEncoding_IDLE);
      end
      `JtagState_defaultEncoding_IR_SELECT : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_RESET : `JtagState_defaultEncoding_IR_CAPTURE);
      end
      `JtagState_defaultEncoding_IR_CAPTURE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_EXIT1 : `JtagState_defaultEncoding_IR_SHIFT);
      end
      `JtagState_defaultEncoding_IR_SHIFT : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_EXIT1 : `JtagState_defaultEncoding_IR_SHIFT);
      end
      `JtagState_defaultEncoding_IR_EXIT1 : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_UPDATE : `JtagState_defaultEncoding_IR_PAUSE);
      end
      `JtagState_defaultEncoding_IR_PAUSE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_EXIT2 : `JtagState_defaultEncoding_IR_PAUSE);
      end
      `JtagState_defaultEncoding_IR_EXIT2 : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_UPDATE : `JtagState_defaultEncoding_IR_SHIFT);
      end
      `JtagState_defaultEncoding_IR_UPDATE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_SELECT : `JtagState_defaultEncoding_IDLE);
      end
      `JtagState_defaultEncoding_DR_SELECT : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_SELECT : `JtagState_defaultEncoding_DR_CAPTURE);
      end
      `JtagState_defaultEncoding_DR_CAPTURE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_EXIT1 : `JtagState_defaultEncoding_DR_SHIFT);
      end
      `JtagState_defaultEncoding_DR_SHIFT : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_EXIT1 : `JtagState_defaultEncoding_DR_SHIFT);
      end
      `JtagState_defaultEncoding_DR_EXIT1 : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_UPDATE : `JtagState_defaultEncoding_DR_PAUSE);
      end
      `JtagState_defaultEncoding_DR_PAUSE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_EXIT2 : `JtagState_defaultEncoding_DR_PAUSE);
      end
      `JtagState_defaultEncoding_DR_EXIT2 : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_UPDATE : `JtagState_defaultEncoding_DR_SHIFT);
      end
      `JtagState_defaultEncoding_DR_UPDATE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_SELECT : `JtagState_defaultEncoding_IDLE);
      end
      default : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_RESET : `JtagState_defaultEncoding_IDLE);
      end
    endcase
  end

  assign jtag_tap_fsm_stateNext = _zz_1_;
  always @ (*) begin
    jtag_tap_tdoUnbufferd = jtag_tap_bypass;
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_IR_CAPTURE : begin
      end
      `JtagState_defaultEncoding_IR_SHIFT : begin
        jtag_tap_tdoUnbufferd = jtag_tap_instructionShift[0];
      end
      `JtagState_defaultEncoding_IR_UPDATE : begin
      end
      `JtagState_defaultEncoding_DR_SHIFT : begin
      end
      default : begin
      end
    endcase
    if(jtag_idcodeArea_instructionHit)begin
      if(_zz_2_)begin
        jtag_tap_tdoUnbufferd = jtag_idcodeArea_shifter[0];
      end
    end
    if(jtag_readArea_instructionHit)begin
      if(_zz_3_)begin
        jtag_tap_tdoUnbufferd = jtag_readArea_shifter[0];
      end
    end
  end

  assign io_jtag_tdo = jtag_tap_tdoUnbufferd_regNext;
  assign jtag_idcodeArea_instructionId = (1'b1);
  assign jtag_idcodeArea_instructionHit = (jtag_tap_instruction == _zz_4_);
  assign jtag_writeArea_instructionId = (2'b10);
  assign jtag_writeArea_instructionHit = (jtag_tap_instruction == _zz_5_);
  always @ (*) begin
    jtag_writeArea_source_valid = 1'b0;
    if(jtag_writeArea_instructionHit)begin
      if((jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_SHIFT))begin
        jtag_writeArea_source_valid = 1'b1;
      end
    end
  end

  assign jtag_writeArea_source_payload_last = io_jtag_tms;
  assign jtag_writeArea_source_payload_fragment[0] = io_jtag_tdi;
  assign system_cmd_valid = flowCCByToggle_1__io_output_valid;
  assign system_cmd_payload_last = flowCCByToggle_1__io_output_payload_last;
  assign system_cmd_payload_fragment = flowCCByToggle_1__io_output_payload_fragment;
  assign jtag_readArea_instructionId = (2'b11);
  assign jtag_readArea_instructionHit = (jtag_tap_instruction == _zz_6_);
  always @ (posedge clock_out) begin
    if(io_remote_cmd_valid)begin
      system_rsp_valid <= 1'b0;
    end
    if((io_remote_rsp_valid && io_remote_rsp_ready))begin
      system_rsp_valid <= 1'b1;
      system_rsp_payload_error <= io_remote_rsp_payload_error;
      system_rsp_payload_data <= io_remote_rsp_payload_data;
    end
  end

  always @ (posedge io_jtag_tck) begin
    jtag_tap_fsm_state <= jtag_tap_fsm_stateNext;
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_IR_CAPTURE : begin
        jtag_tap_instructionShift <= jtag_tap_instruction;
      end
      `JtagState_defaultEncoding_IR_SHIFT : begin
        jtag_tap_instructionShift <= ({io_jtag_tdi,jtag_tap_instructionShift} >>> 1);
      end
      `JtagState_defaultEncoding_IR_UPDATE : begin
        jtag_tap_instruction <= jtag_tap_instructionShift;
      end
      `JtagState_defaultEncoding_DR_SHIFT : begin
        jtag_tap_bypass <= io_jtag_tdi;
      end
      default : begin
      end
    endcase
    if(jtag_idcodeArea_instructionHit)begin
      if(_zz_2_)begin
        jtag_idcodeArea_shifter <= ({io_jtag_tdi,jtag_idcodeArea_shifter} >>> 1);
      end
    end
    if((jtag_tap_fsm_state == `JtagState_defaultEncoding_RESET))begin
      jtag_idcodeArea_shifter <= (32'b00010000000000000001111111111111);
      jtag_tap_instruction <= {3'd0, jtag_idcodeArea_instructionId};
    end
    if(jtag_readArea_instructionHit)begin
      if((jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_CAPTURE))begin
        jtag_readArea_shifter <= {{system_rsp_payload_data,system_rsp_payload_error},system_rsp_valid};
      end
      if(_zz_3_)begin
        jtag_readArea_shifter <= ({io_jtag_tdi,jtag_readArea_shifter} >>> 1);
      end
    end
  end

  always @ (negedge io_jtag_tck) begin
    jtag_tap_tdoUnbufferd_regNext <= jtag_tap_tdoUnbufferd;
  end

endmodule

module SystemDebugger (
      input   io_remote_cmd_valid,
      output  io_remote_cmd_ready,
      input   io_remote_cmd_payload_last,
      input  [0:0] io_remote_cmd_payload_fragment,
      output  io_remote_rsp_valid,
      input   io_remote_rsp_ready,
      output  io_remote_rsp_payload_error,
      output [31:0] io_remote_rsp_payload_data,
      output  io_mem_cmd_valid,
      input   io_mem_cmd_ready,
      output [31:0] io_mem_cmd_payload_address,
      output [31:0] io_mem_cmd_payload_data,
      output  io_mem_cmd_payload_wr,
      output [1:0] io_mem_cmd_payload_size,
      input   io_mem_rsp_valid,
      input  [31:0] io_mem_rsp_payload,
      input   clock_out,
      input   clockCtrl_resetUnbuffered_regNext);
  wire  _zz_2_;
  wire [0:0] _zz_3_;
  reg [66:0] dispatcher_dataShifter;
  reg  dispatcher_dataLoaded;
  reg [7:0] dispatcher_headerShifter;
  wire [7:0] dispatcher_header;
  reg  dispatcher_headerLoaded;
  reg [2:0] dispatcher_counter;
  wire [66:0] _zz_1_;
  assign _zz_2_ = (dispatcher_headerLoaded == 1'b0);
  assign _zz_3_ = _zz_1_[64 : 64];
  assign dispatcher_header = dispatcher_headerShifter[7 : 0];
  assign io_remote_cmd_ready = (! dispatcher_dataLoaded);
  assign _zz_1_ = dispatcher_dataShifter[66 : 0];
  assign io_mem_cmd_payload_address = _zz_1_[31 : 0];
  assign io_mem_cmd_payload_data = _zz_1_[63 : 32];
  assign io_mem_cmd_payload_wr = _zz_3_[0];
  assign io_mem_cmd_payload_size = _zz_1_[66 : 65];
  assign io_mem_cmd_valid = (dispatcher_dataLoaded && (dispatcher_header == (8'b00000000)));
  assign io_remote_rsp_valid = io_mem_rsp_valid;
  assign io_remote_rsp_payload_error = 1'b0;
  assign io_remote_rsp_payload_data = io_mem_rsp_payload;
  always @ (posedge clock_out) begin
    if(clockCtrl_resetUnbuffered_regNext) begin
      dispatcher_dataLoaded <= 1'b0;
      dispatcher_headerLoaded <= 1'b0;
      dispatcher_counter <= (3'b000);
    end else begin
      if(io_remote_cmd_valid)begin
        if(_zz_2_)begin
          dispatcher_counter <= (dispatcher_counter + (3'b001));
          if((dispatcher_counter == (3'b111)))begin
            dispatcher_headerLoaded <= 1'b1;
          end
        end
        if(io_remote_cmd_payload_last)begin
          dispatcher_headerLoaded <= 1'b1;
          dispatcher_dataLoaded <= 1'b1;
          dispatcher_counter <= (3'b000);
        end
      end
      if((io_mem_cmd_valid && io_mem_cmd_ready))begin
        dispatcher_headerLoaded <= 1'b0;
        dispatcher_dataLoaded <= 1'b0;
      end
    end
  end

  always @ (posedge clock_out) begin
    if(io_remote_cmd_valid)begin
      if(_zz_2_)begin
        dispatcher_headerShifter <= ({io_remote_cmd_payload_fragment,dispatcher_headerShifter} >>> 1);
      end else begin
        dispatcher_dataShifter <= ({io_remote_cmd_payload_fragment,dispatcher_dataShifter} >>> 1);
      end
    end
  end

endmodule

module BmbDecoder (
      input   io_input_cmd_valid,
      output reg  io_input_cmd_ready,
      input   io_input_cmd_payload_last,
      input  [0:0] io_input_cmd_payload_fragment_opcode,
      input  [31:0] io_input_cmd_payload_fragment_address,
      input  [1:0] io_input_cmd_payload_fragment_length,
      output reg  io_input_rsp_valid,
      input   io_input_rsp_ready,
      output reg  io_input_rsp_payload_last,
      output reg [0:0] io_input_rsp_payload_fragment_opcode,
      output [31:0] io_input_rsp_payload_fragment_data,
      output reg  io_outputs_0_cmd_valid,
      input   io_outputs_0_cmd_ready,
      output  io_outputs_0_cmd_payload_last,
      output [0:0] io_outputs_0_cmd_payload_fragment_opcode,
      output [31:0] io_outputs_0_cmd_payload_fragment_address,
      output [1:0] io_outputs_0_cmd_payload_fragment_length,
      input   io_outputs_0_rsp_valid,
      output  io_outputs_0_rsp_ready,
      input   io_outputs_0_rsp_payload_last,
      input  [0:0] io_outputs_0_rsp_payload_fragment_opcode,
      input  [31:0] io_outputs_0_rsp_payload_fragment_data,
      output reg  io_outputs_1_cmd_valid,
      input   io_outputs_1_cmd_ready,
      output  io_outputs_1_cmd_payload_last,
      output [0:0] io_outputs_1_cmd_payload_fragment_opcode,
      output [31:0] io_outputs_1_cmd_payload_fragment_address,
      output [1:0] io_outputs_1_cmd_payload_fragment_length,
      input   io_outputs_1_rsp_valid,
      output  io_outputs_1_rsp_ready,
      input   io_outputs_1_rsp_payload_last,
      input  [0:0] io_outputs_1_rsp_payload_fragment_opcode,
      input  [31:0] io_outputs_1_rsp_payload_fragment_data,
      input   clock_out,
      input   clockCtrl_systemReset);
  reg  _zz_4_;
  reg [0:0] _zz_5_;
  reg [31:0] _zz_6_;
  wire [3:0] _zz_7_;
  wire [0:0] _zz_8_;
  wire [3:0] _zz_9_;
  wire [0:0] _zz_10_;
  wire [3:0] _zz_11_;
  wire  logic_hits_0;
  wire  logic_hits_1;
  wire  _zz_1_;
  wire  _zz_2_;
  wire  logic_noHit;
  reg [3:0] logic_rspPendingCounter;
  reg  logic_rspHits_0;
  reg  logic_rspHits_1;
  wire  logic_rspPending;
  wire  logic_rspNoHitValid;
  reg  logic_rspNoHit_doIt;
  reg  logic_rspNoHit_singleBeatRsp;
  wire [0:0] _zz_3_;
  wire  logic_cmdWait;
  assign _zz_7_ = (logic_rspPendingCounter + _zz_9_);
  assign _zz_8_ = ((io_input_cmd_valid && io_input_cmd_ready) && io_input_cmd_payload_last);
  assign _zz_9_ = {3'd0, _zz_8_};
  assign _zz_10_ = ((io_input_rsp_valid && io_input_rsp_ready) && io_input_rsp_payload_last);
  assign _zz_11_ = {3'd0, _zz_10_};
  always @(*) begin
    case(_zz_3_)
      1'b0 : begin
        _zz_4_ = io_outputs_0_rsp_payload_last;
        _zz_5_ = io_outputs_0_rsp_payload_fragment_opcode;
        _zz_6_ = io_outputs_0_rsp_payload_fragment_data;
      end
      default : begin
        _zz_4_ = io_outputs_1_rsp_payload_last;
        _zz_5_ = io_outputs_1_rsp_payload_fragment_opcode;
        _zz_6_ = io_outputs_1_rsp_payload_fragment_data;
      end
    endcase
  end

  assign logic_hits_0 = ((io_input_cmd_payload_fragment_address & (~ (32'b00000000000000000001111111111111))) == (32'b10000000000000000000000000000000));
  always @ (*) begin
    io_outputs_0_cmd_valid = (io_input_cmd_valid && logic_hits_0);
    if(logic_cmdWait)begin
      io_outputs_0_cmd_valid = 1'b0;
    end
  end

  assign _zz_1_ = io_input_cmd_payload_last;
  assign io_outputs_0_cmd_payload_last = _zz_1_;
  assign io_outputs_0_cmd_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
  assign io_outputs_0_cmd_payload_fragment_address = io_input_cmd_payload_fragment_address;
  assign io_outputs_0_cmd_payload_fragment_length = io_input_cmd_payload_fragment_length;
  assign logic_hits_1 = ((io_input_cmd_payload_fragment_address & (~ (32'b00000000000111111111111111111111))) == (32'b10010000000000000000000000000000));
  always @ (*) begin
    io_outputs_1_cmd_valid = (io_input_cmd_valid && logic_hits_1);
    if(logic_cmdWait)begin
      io_outputs_1_cmd_valid = 1'b0;
    end
  end

  assign _zz_2_ = io_input_cmd_payload_last;
  assign io_outputs_1_cmd_payload_last = _zz_2_;
  assign io_outputs_1_cmd_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
  assign io_outputs_1_cmd_payload_fragment_address = io_input_cmd_payload_fragment_address;
  assign io_outputs_1_cmd_payload_fragment_length = io_input_cmd_payload_fragment_length;
  assign logic_noHit = (! ({logic_hits_1,logic_hits_0} != (2'b00)));
  always @ (*) begin
    io_input_cmd_ready = (({(logic_hits_1 && io_outputs_1_cmd_ready),(logic_hits_0 && io_outputs_0_cmd_ready)} != (2'b00)) || logic_noHit);
    if(logic_cmdWait)begin
      io_input_cmd_ready = 1'b0;
    end
  end

  assign logic_rspPending = (logic_rspPendingCounter != (4'b0000));
  assign logic_rspNoHitValid = (! ({logic_rspHits_1,logic_rspHits_0} != (2'b00)));
  always @ (*) begin
    io_input_rsp_valid = (({io_outputs_1_rsp_valid,io_outputs_0_rsp_valid} != (2'b00)) || (logic_rspPending && logic_rspNoHitValid));
    if(logic_rspNoHit_doIt)begin
      io_input_rsp_valid = 1'b1;
    end
  end

  assign _zz_3_ = logic_rspHits_1;
  always @ (*) begin
    io_input_rsp_payload_last = _zz_4_;
    if(logic_rspNoHit_doIt)begin
      io_input_rsp_payload_last = 1'b1;
    end
  end

  always @ (*) begin
    io_input_rsp_payload_fragment_opcode = _zz_5_;
    if(logic_rspNoHit_doIt)begin
      io_input_rsp_payload_fragment_opcode = (1'b1);
    end
  end

  assign io_input_rsp_payload_fragment_data = _zz_6_;
  assign io_outputs_0_rsp_ready = io_input_rsp_ready;
  assign io_outputs_1_rsp_ready = io_input_rsp_ready;
  assign logic_cmdWait = ((logic_rspPending && (((logic_hits_0 != logic_rspHits_0) || (logic_hits_1 != logic_rspHits_1)) || logic_rspNoHitValid)) || (logic_rspPendingCounter == (4'b1111)));
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      logic_rspPendingCounter <= (4'b0000);
      logic_rspNoHit_doIt <= 1'b0;
    end else begin
      logic_rspPendingCounter <= (_zz_7_ - _zz_11_);
      if(((io_input_rsp_valid && io_input_rsp_ready) && io_input_rsp_payload_last))begin
        logic_rspNoHit_doIt <= 1'b0;
      end
      if((((io_input_cmd_valid && io_input_cmd_ready) && logic_noHit) && io_input_cmd_payload_last))begin
        logic_rspNoHit_doIt <= 1'b1;
      end
    end
  end

  always @ (posedge clock_out) begin
    if((io_input_cmd_valid && io_input_cmd_ready))begin
      logic_rspHits_0 <= logic_hits_0;
      logic_rspHits_1 <= logic_hits_1;
    end
    if((io_input_cmd_valid && io_input_cmd_ready))begin
      logic_rspNoHit_singleBeatRsp <= (io_input_cmd_payload_fragment_opcode == (1'b1));
    end
  end

endmodule

module BmbDecoder_1_ (
      input   io_input_cmd_valid,
      output reg  io_input_cmd_ready,
      input   io_input_cmd_payload_last,
      input  [0:0] io_input_cmd_payload_fragment_opcode,
      input  [31:0] io_input_cmd_payload_fragment_address,
      input  [1:0] io_input_cmd_payload_fragment_length,
      input  [31:0] io_input_cmd_payload_fragment_data,
      input  [3:0] io_input_cmd_payload_fragment_mask,
      input  [0:0] io_input_cmd_payload_fragment_context,
      output reg  io_input_rsp_valid,
      input   io_input_rsp_ready,
      output reg  io_input_rsp_payload_last,
      output reg [0:0] io_input_rsp_payload_fragment_opcode,
      output [31:0] io_input_rsp_payload_fragment_data,
      output reg [0:0] io_input_rsp_payload_fragment_context,
      output reg  io_outputs_0_cmd_valid,
      input   io_outputs_0_cmd_ready,
      output  io_outputs_0_cmd_payload_last,
      output [0:0] io_outputs_0_cmd_payload_fragment_opcode,
      output [31:0] io_outputs_0_cmd_payload_fragment_address,
      output [1:0] io_outputs_0_cmd_payload_fragment_length,
      output [31:0] io_outputs_0_cmd_payload_fragment_data,
      output [3:0] io_outputs_0_cmd_payload_fragment_mask,
      output [0:0] io_outputs_0_cmd_payload_fragment_context,
      input   io_outputs_0_rsp_valid,
      output  io_outputs_0_rsp_ready,
      input   io_outputs_0_rsp_payload_last,
      input  [0:0] io_outputs_0_rsp_payload_fragment_opcode,
      input  [31:0] io_outputs_0_rsp_payload_fragment_data,
      input  [0:0] io_outputs_0_rsp_payload_fragment_context,
      output reg  io_outputs_1_cmd_valid,
      input   io_outputs_1_cmd_ready,
      output  io_outputs_1_cmd_payload_last,
      output [0:0] io_outputs_1_cmd_payload_fragment_opcode,
      output [31:0] io_outputs_1_cmd_payload_fragment_address,
      output [1:0] io_outputs_1_cmd_payload_fragment_length,
      output [31:0] io_outputs_1_cmd_payload_fragment_data,
      output [3:0] io_outputs_1_cmd_payload_fragment_mask,
      output [0:0] io_outputs_1_cmd_payload_fragment_context,
      input   io_outputs_1_rsp_valid,
      output  io_outputs_1_rsp_ready,
      input   io_outputs_1_rsp_payload_last,
      input  [0:0] io_outputs_1_rsp_payload_fragment_opcode,
      input  [31:0] io_outputs_1_rsp_payload_fragment_data,
      input  [0:0] io_outputs_1_rsp_payload_fragment_context,
      output reg  io_outputs_2_cmd_valid,
      input   io_outputs_2_cmd_ready,
      output  io_outputs_2_cmd_payload_last,
      output [0:0] io_outputs_2_cmd_payload_fragment_opcode,
      output [31:0] io_outputs_2_cmd_payload_fragment_address,
      output [1:0] io_outputs_2_cmd_payload_fragment_length,
      output [31:0] io_outputs_2_cmd_payload_fragment_data,
      output [3:0] io_outputs_2_cmd_payload_fragment_mask,
      output [0:0] io_outputs_2_cmd_payload_fragment_context,
      input   io_outputs_2_rsp_valid,
      output  io_outputs_2_rsp_ready,
      input   io_outputs_2_rsp_payload_last,
      input  [0:0] io_outputs_2_rsp_payload_fragment_opcode,
      input  [31:0] io_outputs_2_rsp_payload_fragment_data,
      input  [0:0] io_outputs_2_rsp_payload_fragment_context,
      input   clock_out,
      input   clockCtrl_systemReset);
  reg  _zz_5_;
  reg [0:0] _zz_6_;
  reg [31:0] _zz_7_;
  reg [0:0] _zz_8_;
  wire [3:0] _zz_9_;
  wire [0:0] _zz_10_;
  wire [3:0] _zz_11_;
  wire [0:0] _zz_12_;
  wire [3:0] _zz_13_;
  wire  logic_hits_0;
  wire  logic_hits_1;
  wire  logic_hits_2;
  wire  _zz_1_;
  wire  _zz_2_;
  wire  _zz_3_;
  wire  logic_noHit;
  reg [3:0] logic_rspPendingCounter;
  reg  logic_rspHits_0;
  reg  logic_rspHits_1;
  reg  logic_rspHits_2;
  wire  logic_rspPending;
  wire  logic_rspNoHitValid;
  reg  logic_rspNoHit_doIt;
  reg  logic_rspNoHit_singleBeatRsp;
  reg [0:0] logic_rspNoHit_context;
  wire [1:0] _zz_4_;
  wire  logic_cmdWait;
  assign _zz_9_ = (logic_rspPendingCounter + _zz_11_);
  assign _zz_10_ = ((io_input_cmd_valid && io_input_cmd_ready) && io_input_cmd_payload_last);
  assign _zz_11_ = {3'd0, _zz_10_};
  assign _zz_12_ = ((io_input_rsp_valid && io_input_rsp_ready) && io_input_rsp_payload_last);
  assign _zz_13_ = {3'd0, _zz_12_};
  always @(*) begin
    case(_zz_4_)
      2'b00 : begin
        _zz_5_ = io_outputs_0_rsp_payload_last;
        _zz_6_ = io_outputs_0_rsp_payload_fragment_opcode;
        _zz_7_ = io_outputs_0_rsp_payload_fragment_data;
        _zz_8_ = io_outputs_0_rsp_payload_fragment_context;
      end
      2'b01 : begin
        _zz_5_ = io_outputs_1_rsp_payload_last;
        _zz_6_ = io_outputs_1_rsp_payload_fragment_opcode;
        _zz_7_ = io_outputs_1_rsp_payload_fragment_data;
        _zz_8_ = io_outputs_1_rsp_payload_fragment_context;
      end
      default : begin
        _zz_5_ = io_outputs_2_rsp_payload_last;
        _zz_6_ = io_outputs_2_rsp_payload_fragment_opcode;
        _zz_7_ = io_outputs_2_rsp_payload_fragment_data;
        _zz_8_ = io_outputs_2_rsp_payload_fragment_context;
      end
    endcase
  end

  assign logic_hits_0 = ((io_input_cmd_payload_fragment_address & (~ (32'b00000000000000000001111111111111))) == (32'b10000000000000000000000000000000));
  always @ (*) begin
    io_outputs_0_cmd_valid = (io_input_cmd_valid && logic_hits_0);
    if(logic_cmdWait)begin
      io_outputs_0_cmd_valid = 1'b0;
    end
  end

  assign _zz_1_ = io_input_cmd_payload_last;
  assign io_outputs_0_cmd_payload_last = _zz_1_;
  assign io_outputs_0_cmd_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
  assign io_outputs_0_cmd_payload_fragment_address = io_input_cmd_payload_fragment_address;
  assign io_outputs_0_cmd_payload_fragment_length = io_input_cmd_payload_fragment_length;
  assign io_outputs_0_cmd_payload_fragment_data = io_input_cmd_payload_fragment_data;
  assign io_outputs_0_cmd_payload_fragment_mask = io_input_cmd_payload_fragment_mask;
  assign io_outputs_0_cmd_payload_fragment_context = io_input_cmd_payload_fragment_context;
  assign logic_hits_1 = ((io_input_cmd_payload_fragment_address & (~ (32'b00000000000111111111111111111111))) == (32'b10010000000000000000000000000000));
  always @ (*) begin
    io_outputs_1_cmd_valid = (io_input_cmd_valid && logic_hits_1);
    if(logic_cmdWait)begin
      io_outputs_1_cmd_valid = 1'b0;
    end
  end

  assign _zz_2_ = io_input_cmd_payload_last;
  assign io_outputs_1_cmd_payload_last = _zz_2_;
  assign io_outputs_1_cmd_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
  assign io_outputs_1_cmd_payload_fragment_address = io_input_cmd_payload_fragment_address;
  assign io_outputs_1_cmd_payload_fragment_length = io_input_cmd_payload_fragment_length;
  assign io_outputs_1_cmd_payload_fragment_data = io_input_cmd_payload_fragment_data;
  assign io_outputs_1_cmd_payload_fragment_mask = io_input_cmd_payload_fragment_mask;
  assign io_outputs_1_cmd_payload_fragment_context = io_input_cmd_payload_fragment_context;
  assign logic_hits_2 = ((io_input_cmd_payload_fragment_address & (~ (32'b00000000000000011111111111111111))) == (32'b00010000000000000000000000000000));
  always @ (*) begin
    io_outputs_2_cmd_valid = (io_input_cmd_valid && logic_hits_2);
    if(logic_cmdWait)begin
      io_outputs_2_cmd_valid = 1'b0;
    end
  end

  assign _zz_3_ = io_input_cmd_payload_last;
  assign io_outputs_2_cmd_payload_last = _zz_3_;
  assign io_outputs_2_cmd_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
  assign io_outputs_2_cmd_payload_fragment_address = io_input_cmd_payload_fragment_address;
  assign io_outputs_2_cmd_payload_fragment_length = io_input_cmd_payload_fragment_length;
  assign io_outputs_2_cmd_payload_fragment_data = io_input_cmd_payload_fragment_data;
  assign io_outputs_2_cmd_payload_fragment_mask = io_input_cmd_payload_fragment_mask;
  assign io_outputs_2_cmd_payload_fragment_context = io_input_cmd_payload_fragment_context;
  assign logic_noHit = (! ({logic_hits_2,{logic_hits_1,logic_hits_0}} != (3'b000)));
  always @ (*) begin
    io_input_cmd_ready = (({(logic_hits_2 && io_outputs_2_cmd_ready),{(logic_hits_1 && io_outputs_1_cmd_ready),(logic_hits_0 && io_outputs_0_cmd_ready)}} != (3'b000)) || logic_noHit);
    if(logic_cmdWait)begin
      io_input_cmd_ready = 1'b0;
    end
  end

  assign logic_rspPending = (logic_rspPendingCounter != (4'b0000));
  assign logic_rspNoHitValid = (! ({logic_rspHits_2,{logic_rspHits_1,logic_rspHits_0}} != (3'b000)));
  always @ (*) begin
    io_input_rsp_valid = (({io_outputs_2_rsp_valid,{io_outputs_1_rsp_valid,io_outputs_0_rsp_valid}} != (3'b000)) || (logic_rspPending && logic_rspNoHitValid));
    if(logic_rspNoHit_doIt)begin
      io_input_rsp_valid = 1'b1;
    end
  end

  assign _zz_4_ = {logic_rspHits_2,logic_rspHits_1};
  always @ (*) begin
    io_input_rsp_payload_last = _zz_5_;
    if(logic_rspNoHit_doIt)begin
      io_input_rsp_payload_last = 1'b1;
    end
  end

  always @ (*) begin
    io_input_rsp_payload_fragment_opcode = _zz_6_;
    if(logic_rspNoHit_doIt)begin
      io_input_rsp_payload_fragment_opcode = (1'b1);
    end
  end

  assign io_input_rsp_payload_fragment_data = _zz_7_;
  always @ (*) begin
    io_input_rsp_payload_fragment_context = _zz_8_;
    if(logic_rspNoHit_doIt)begin
      io_input_rsp_payload_fragment_context = logic_rspNoHit_context;
    end
  end

  assign io_outputs_0_rsp_ready = io_input_rsp_ready;
  assign io_outputs_1_rsp_ready = io_input_rsp_ready;
  assign io_outputs_2_rsp_ready = io_input_rsp_ready;
  assign logic_cmdWait = ((logic_rspPending && ((((logic_hits_0 != logic_rspHits_0) || (logic_hits_1 != logic_rspHits_1)) || (logic_hits_2 != logic_rspHits_2)) || logic_rspNoHitValid)) || (logic_rspPendingCounter == (4'b1111)));
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      logic_rspPendingCounter <= (4'b0000);
      logic_rspNoHit_doIt <= 1'b0;
    end else begin
      logic_rspPendingCounter <= (_zz_9_ - _zz_13_);
      if(((io_input_rsp_valid && io_input_rsp_ready) && io_input_rsp_payload_last))begin
        logic_rspNoHit_doIt <= 1'b0;
      end
      if((((io_input_cmd_valid && io_input_cmd_ready) && logic_noHit) && io_input_cmd_payload_last))begin
        logic_rspNoHit_doIt <= 1'b1;
      end
    end
  end

  always @ (posedge clock_out) begin
    if((io_input_cmd_valid && io_input_cmd_ready))begin
      logic_rspHits_0 <= logic_hits_0;
      logic_rspHits_1 <= logic_hits_1;
      logic_rspHits_2 <= logic_hits_2;
    end
    if((io_input_cmd_valid && io_input_cmd_ready))begin
      logic_rspNoHit_singleBeatRsp <= (io_input_cmd_payload_fragment_opcode == (1'b1));
    end
    if((io_input_cmd_valid && io_input_cmd_ready))begin
      logic_rspNoHit_context <= io_input_cmd_payload_fragment_context;
    end
  end

endmodule

module BmbOnChipRam (
      input   io_bus_cmd_valid,
      output  io_bus_cmd_ready,
      input   io_bus_cmd_payload_last,
      input  [0:0] io_bus_cmd_payload_fragment_source,
      input  [0:0] io_bus_cmd_payload_fragment_opcode,
      input  [12:0] io_bus_cmd_payload_fragment_address,
      input  [1:0] io_bus_cmd_payload_fragment_length,
      input  [31:0] io_bus_cmd_payload_fragment_data,
      input  [3:0] io_bus_cmd_payload_fragment_mask,
      input  [0:0] io_bus_cmd_payload_fragment_context,
      output  io_bus_rsp_valid,
      input   io_bus_rsp_ready,
      output  io_bus_rsp_payload_last,
      output [0:0] io_bus_rsp_payload_fragment_source,
      output [0:0] io_bus_rsp_payload_fragment_opcode,
      output [31:0] io_bus_rsp_payload_fragment_data,
      output [0:0] io_bus_rsp_payload_fragment_context,
      input   clock_out,
      input   clockCtrl_systemReset);
  reg [31:0] _zz_5_;
  reg  io_bus_cmd_valid_regNextWhen;
  reg [0:0] io_bus_cmd_payload_fragment_source_regNextWhen;
  reg [0:0] io_bus_cmd_payload_fragment_context_regNextWhen;
  wire [10:0] _zz_1_;
  wire  _zz_2_;
  wire  _zz_3_;
  wire [31:0] _zz_4_;
  reg [7:0] ram_symbol0 [0:2047];
  reg [7:0] ram_symbol1 [0:2047];
  reg [7:0] ram_symbol2 [0:2047];
  reg [7:0] ram_symbol3 [0:2047];
  reg [7:0] _zz_6_;
  reg [7:0] _zz_7_;
  reg [7:0] _zz_8_;
  reg [7:0] _zz_9_;
  initial begin
    $readmemb("BlackiceMxSocSdram.v_toplevel_system_ramA_ram_symbol0.bin",ram_symbol0);
    $readmemb("BlackiceMxSocSdram.v_toplevel_system_ramA_ram_symbol1.bin",ram_symbol1);
    $readmemb("BlackiceMxSocSdram.v_toplevel_system_ramA_ram_symbol2.bin",ram_symbol2);
    $readmemb("BlackiceMxSocSdram.v_toplevel_system_ramA_ram_symbol3.bin",ram_symbol3);
  end
  always @ (*) begin
    _zz_5_ = {_zz_9_, _zz_8_, _zz_7_, _zz_6_};
  end
  always @ (posedge clock_out) begin
    if(io_bus_cmd_payload_fragment_mask[0] && _zz_2_ && _zz_3_ ) begin
      ram_symbol0[_zz_1_] <= _zz_4_[7 : 0];
    end
    if(io_bus_cmd_payload_fragment_mask[1] && _zz_2_ && _zz_3_ ) begin
      ram_symbol1[_zz_1_] <= _zz_4_[15 : 8];
    end
    if(io_bus_cmd_payload_fragment_mask[2] && _zz_2_ && _zz_3_ ) begin
      ram_symbol2[_zz_1_] <= _zz_4_[23 : 16];
    end
    if(io_bus_cmd_payload_fragment_mask[3] && _zz_2_ && _zz_3_ ) begin
      ram_symbol3[_zz_1_] <= _zz_4_[31 : 24];
    end
    if(_zz_2_) begin
      _zz_6_ <= ram_symbol0[_zz_1_];
      _zz_7_ <= ram_symbol1[_zz_1_];
      _zz_8_ <= ram_symbol2[_zz_1_];
      _zz_9_ <= ram_symbol3[_zz_1_];
    end
  end

  assign io_bus_cmd_ready = (! (io_bus_rsp_valid && (! io_bus_rsp_ready)));
  assign io_bus_rsp_valid = io_bus_cmd_valid_regNextWhen;
  assign io_bus_rsp_payload_fragment_source = io_bus_cmd_payload_fragment_source_regNextWhen;
  assign io_bus_rsp_payload_fragment_context = io_bus_cmd_payload_fragment_context_regNextWhen;
  assign _zz_1_ = (io_bus_cmd_payload_fragment_address >>> 2);
  assign _zz_2_ = (io_bus_cmd_valid && io_bus_cmd_ready);
  assign _zz_3_ = (io_bus_cmd_payload_fragment_opcode == (1'b1));
  assign _zz_4_ = io_bus_cmd_payload_fragment_data;
  assign io_bus_rsp_payload_fragment_data = _zz_5_;
  assign io_bus_rsp_payload_fragment_opcode = (1'b0);
  assign io_bus_rsp_payload_last = 1'b1;
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      io_bus_cmd_valid_regNextWhen <= 1'b0;
    end else begin
      if(io_bus_cmd_ready)begin
        io_bus_cmd_valid_regNextWhen <= io_bus_cmd_valid;
      end
    end
  end

  always @ (posedge clock_out) begin
    if(io_bus_cmd_ready)begin
      io_bus_cmd_payload_fragment_source_regNextWhen <= io_bus_cmd_payload_fragment_source;
    end
    if(io_bus_cmd_ready)begin
      io_bus_cmd_payload_fragment_context_regNextWhen <= io_bus_cmd_payload_fragment_context;
    end
  end

endmodule

module BmbArbiter (
      input   io_inputs_0_cmd_valid,
      output  io_inputs_0_cmd_ready,
      input   io_inputs_0_cmd_payload_last,
      input  [0:0] io_inputs_0_cmd_payload_fragment_opcode,
      input  [12:0] io_inputs_0_cmd_payload_fragment_address,
      input  [1:0] io_inputs_0_cmd_payload_fragment_length,
      input  [31:0] io_inputs_0_cmd_payload_fragment_data,
      input  [3:0] io_inputs_0_cmd_payload_fragment_mask,
      input  [0:0] io_inputs_0_cmd_payload_fragment_context,
      output  io_inputs_0_rsp_valid,
      input   io_inputs_0_rsp_ready,
      output  io_inputs_0_rsp_payload_last,
      output [0:0] io_inputs_0_rsp_payload_fragment_opcode,
      output [31:0] io_inputs_0_rsp_payload_fragment_data,
      output [0:0] io_inputs_0_rsp_payload_fragment_context,
      input   io_inputs_1_cmd_valid,
      output  io_inputs_1_cmd_ready,
      input   io_inputs_1_cmd_payload_last,
      input  [0:0] io_inputs_1_cmd_payload_fragment_opcode,
      input  [12:0] io_inputs_1_cmd_payload_fragment_address,
      input  [1:0] io_inputs_1_cmd_payload_fragment_length,
      input  [31:0] io_inputs_1_cmd_payload_fragment_data,
      input  [3:0] io_inputs_1_cmd_payload_fragment_mask,
      input  [0:0] io_inputs_1_cmd_payload_fragment_context,
      output  io_inputs_1_rsp_valid,
      input   io_inputs_1_rsp_ready,
      output  io_inputs_1_rsp_payload_last,
      output [0:0] io_inputs_1_rsp_payload_fragment_opcode,
      output [31:0] io_inputs_1_rsp_payload_fragment_data,
      output [0:0] io_inputs_1_rsp_payload_fragment_context,
      output  io_output_cmd_valid,
      input   io_output_cmd_ready,
      output  io_output_cmd_payload_last,
      output [0:0] io_output_cmd_payload_fragment_source,
      output [0:0] io_output_cmd_payload_fragment_opcode,
      output [12:0] io_output_cmd_payload_fragment_address,
      output [1:0] io_output_cmd_payload_fragment_length,
      output [31:0] io_output_cmd_payload_fragment_data,
      output [3:0] io_output_cmd_payload_fragment_mask,
      output [0:0] io_output_cmd_payload_fragment_context,
      input   io_output_rsp_valid,
      output  io_output_rsp_ready,
      input   io_output_rsp_payload_last,
      input  [0:0] io_output_rsp_payload_fragment_source,
      input  [0:0] io_output_rsp_payload_fragment_opcode,
      input  [31:0] io_output_rsp_payload_fragment_data,
      input  [0:0] io_output_rsp_payload_fragment_context,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire [0:0] _zz_1_;
  wire [0:0] _zz_2_;
  reg  _zz_3_;
  wire  logic_arbiter_io_inputs_0_ready;
  wire  logic_arbiter_io_inputs_1_ready;
  wire  logic_arbiter_io_output_valid;
  wire  logic_arbiter_io_output_payload_last;
  wire [0:0] logic_arbiter_io_output_payload_fragment_source;
  wire [0:0] logic_arbiter_io_output_payload_fragment_opcode;
  wire [12:0] logic_arbiter_io_output_payload_fragment_address;
  wire [1:0] logic_arbiter_io_output_payload_fragment_length;
  wire [31:0] logic_arbiter_io_output_payload_fragment_data;
  wire [3:0] logic_arbiter_io_output_payload_fragment_mask;
  wire [0:0] logic_arbiter_io_output_payload_fragment_context;
  wire [0:0] logic_arbiter_io_chosen;
  wire [1:0] logic_arbiter_io_chosenOH;
  wire [0:0] logic_rspSel;
  StreamArbiter logic_arbiter ( 
    .io_inputs_0_valid(io_inputs_0_cmd_valid),
    .io_inputs_0_ready(logic_arbiter_io_inputs_0_ready),
    .io_inputs_0_payload_last(io_inputs_0_cmd_payload_last),
    .io_inputs_0_payload_fragment_source(_zz_1_),
    .io_inputs_0_payload_fragment_opcode(io_inputs_0_cmd_payload_fragment_opcode),
    .io_inputs_0_payload_fragment_address(io_inputs_0_cmd_payload_fragment_address),
    .io_inputs_0_payload_fragment_length(io_inputs_0_cmd_payload_fragment_length),
    .io_inputs_0_payload_fragment_data(io_inputs_0_cmd_payload_fragment_data),
    .io_inputs_0_payload_fragment_mask(io_inputs_0_cmd_payload_fragment_mask),
    .io_inputs_0_payload_fragment_context(io_inputs_0_cmd_payload_fragment_context),
    .io_inputs_1_valid(io_inputs_1_cmd_valid),
    .io_inputs_1_ready(logic_arbiter_io_inputs_1_ready),
    .io_inputs_1_payload_last(io_inputs_1_cmd_payload_last),
    .io_inputs_1_payload_fragment_source(_zz_2_),
    .io_inputs_1_payload_fragment_opcode(io_inputs_1_cmd_payload_fragment_opcode),
    .io_inputs_1_payload_fragment_address(io_inputs_1_cmd_payload_fragment_address),
    .io_inputs_1_payload_fragment_length(io_inputs_1_cmd_payload_fragment_length),
    .io_inputs_1_payload_fragment_data(io_inputs_1_cmd_payload_fragment_data),
    .io_inputs_1_payload_fragment_mask(io_inputs_1_cmd_payload_fragment_mask),
    .io_inputs_1_payload_fragment_context(io_inputs_1_cmd_payload_fragment_context),
    .io_output_valid(logic_arbiter_io_output_valid),
    .io_output_ready(io_output_cmd_ready),
    .io_output_payload_last(logic_arbiter_io_output_payload_last),
    .io_output_payload_fragment_source(logic_arbiter_io_output_payload_fragment_source),
    .io_output_payload_fragment_opcode(logic_arbiter_io_output_payload_fragment_opcode),
    .io_output_payload_fragment_address(logic_arbiter_io_output_payload_fragment_address),
    .io_output_payload_fragment_length(logic_arbiter_io_output_payload_fragment_length),
    .io_output_payload_fragment_data(logic_arbiter_io_output_payload_fragment_data),
    .io_output_payload_fragment_mask(logic_arbiter_io_output_payload_fragment_mask),
    .io_output_payload_fragment_context(logic_arbiter_io_output_payload_fragment_context),
    .io_chosen(logic_arbiter_io_chosen),
    .io_chosenOH(logic_arbiter_io_chosenOH),
    .clock_out(clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  always @(*) begin
    case(logic_rspSel)
      1'b0 : begin
        _zz_3_ = io_inputs_0_rsp_ready;
      end
      default : begin
        _zz_3_ = io_inputs_1_rsp_ready;
      end
    endcase
  end

  assign io_inputs_0_cmd_ready = logic_arbiter_io_inputs_0_ready;
  assign _zz_1_ = (1'b0);
  assign io_inputs_1_cmd_ready = logic_arbiter_io_inputs_1_ready;
  assign _zz_2_ = (1'b0);
  assign io_output_cmd_valid = logic_arbiter_io_output_valid;
  assign io_output_cmd_payload_last = logic_arbiter_io_output_payload_last;
  assign io_output_cmd_payload_fragment_opcode = logic_arbiter_io_output_payload_fragment_opcode;
  assign io_output_cmd_payload_fragment_address = logic_arbiter_io_output_payload_fragment_address;
  assign io_output_cmd_payload_fragment_length = logic_arbiter_io_output_payload_fragment_length;
  assign io_output_cmd_payload_fragment_data = logic_arbiter_io_output_payload_fragment_data;
  assign io_output_cmd_payload_fragment_mask = logic_arbiter_io_output_payload_fragment_mask;
  assign io_output_cmd_payload_fragment_context = logic_arbiter_io_output_payload_fragment_context;
  assign io_output_cmd_payload_fragment_source[0 : 0] = logic_arbiter_io_chosen;
  assign logic_rspSel = io_output_rsp_payload_fragment_source[0 : 0];
  assign io_inputs_0_rsp_valid = (io_output_rsp_valid && (logic_rspSel == (1'b0)));
  assign io_inputs_0_rsp_payload_last = io_output_rsp_payload_last;
  assign io_inputs_0_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_inputs_0_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data;
  assign io_inputs_0_rsp_payload_fragment_context = io_output_rsp_payload_fragment_context;
  assign io_inputs_1_rsp_valid = (io_output_rsp_valid && (logic_rspSel == (1'b1)));
  assign io_inputs_1_rsp_payload_last = io_output_rsp_payload_last;
  assign io_inputs_1_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_inputs_1_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data;
  assign io_inputs_1_rsp_payload_fragment_context = io_output_rsp_payload_fragment_context;
  assign io_output_rsp_ready = _zz_3_;
endmodule

module BmbSdramCtrl (
      input   io_bmb_cmd_valid,
      output  io_bmb_cmd_ready,
      input   io_bmb_cmd_payload_last,
      input  [0:0] io_bmb_cmd_payload_fragment_opcode,
      input  [20:0] io_bmb_cmd_payload_fragment_address,
      input  [0:0] io_bmb_cmd_payload_fragment_length,
      input  [15:0] io_bmb_cmd_payload_fragment_data,
      input  [1:0] io_bmb_cmd_payload_fragment_mask,
      input  [4:0] io_bmb_cmd_payload_fragment_context,
      output  io_bmb_rsp_valid,
      input   io_bmb_rsp_ready,
      output  io_bmb_rsp_payload_last,
      output [0:0] io_bmb_rsp_payload_fragment_opcode,
      output [15:0] io_bmb_rsp_payload_fragment_data,
      output [4:0] io_bmb_rsp_payload_fragment_context,
      output [10:0] io_sdram_ADDR,
      output [0:0] io_sdram_BA,
      input  [15:0] io_sdram_DQ_read,
      output [15:0] io_sdram_DQ_write,
      output  io_sdram_DQ_writeEnable,
      output [1:0] io_sdram_DQM,
      output  io_sdram_CASn,
      output  io_sdram_CKE,
      output  io_sdram_CSn,
      output  io_sdram_RASn,
      output  io_sdram_WEn,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire [19:0] _zz_1_;
  wire  _zz_2_;
  wire  ctrl_io_bus_cmd_ready;
  wire  ctrl_io_bus_rsp_valid;
  wire [15:0] ctrl_io_bus_rsp_payload_data;
  wire [4:0] ctrl_io_bus_rsp_payload_context_context;
  wire [10:0] ctrl_io_sdram_ADDR;
  wire [0:0] ctrl_io_sdram_BA;
  wire  ctrl_io_sdram_CASn;
  wire  ctrl_io_sdram_CKE;
  wire  ctrl_io_sdram_CSn;
  wire [1:0] ctrl_io_sdram_DQM;
  wire  ctrl_io_sdram_RASn;
  wire  ctrl_io_sdram_WEn;
  wire [15:0] ctrl_io_sdram_DQ_write;
  wire  ctrl_io_sdram_DQ_writeEnable;
  SdramCtrl ctrl ( 
    .io_bus_cmd_valid(io_bmb_cmd_valid),
    .io_bus_cmd_ready(ctrl_io_bus_cmd_ready),
    .io_bus_cmd_payload_address(_zz_1_),
    .io_bus_cmd_payload_write(_zz_2_),
    .io_bus_cmd_payload_data(io_bmb_cmd_payload_fragment_data),
    .io_bus_cmd_payload_mask(io_bmb_cmd_payload_fragment_mask),
    .io_bus_cmd_payload_context_context(io_bmb_cmd_payload_fragment_context),
    .io_bus_rsp_valid(ctrl_io_bus_rsp_valid),
    .io_bus_rsp_ready(io_bmb_rsp_ready),
    .io_bus_rsp_payload_data(ctrl_io_bus_rsp_payload_data),
    .io_bus_rsp_payload_context_context(ctrl_io_bus_rsp_payload_context_context),
    .io_sdram_ADDR(ctrl_io_sdram_ADDR),
    .io_sdram_BA(ctrl_io_sdram_BA),
    .io_sdram_DQ_read(io_sdram_DQ_read),
    .io_sdram_DQ_write(ctrl_io_sdram_DQ_write),
    .io_sdram_DQ_writeEnable(ctrl_io_sdram_DQ_writeEnable),
    .io_sdram_DQM(ctrl_io_sdram_DQM),
    .io_sdram_CASn(ctrl_io_sdram_CASn),
    .io_sdram_CKE(ctrl_io_sdram_CKE),
    .io_sdram_CSn(ctrl_io_sdram_CSn),
    .io_sdram_RASn(ctrl_io_sdram_RASn),
    .io_sdram_WEn(ctrl_io_sdram_WEn),
    .clock_out(clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  assign io_bmb_cmd_ready = ctrl_io_bus_cmd_ready;
  assign _zz_1_ = (io_bmb_cmd_payload_fragment_address >>> 1);
  assign _zz_2_ = (io_bmb_cmd_payload_fragment_opcode == (1'b1));
  assign io_bmb_rsp_valid = ctrl_io_bus_rsp_valid;
  assign io_bmb_rsp_payload_fragment_opcode = (1'b0);
  assign io_bmb_rsp_payload_fragment_data = ctrl_io_bus_rsp_payload_data;
  assign io_bmb_rsp_payload_fragment_context = ctrl_io_bus_rsp_payload_context_context;
  assign io_sdram_ADDR = ctrl_io_sdram_ADDR;
  assign io_sdram_BA = ctrl_io_sdram_BA;
  assign io_sdram_DQ_write = ctrl_io_sdram_DQ_write;
  assign io_sdram_DQ_writeEnable = ctrl_io_sdram_DQ_writeEnable;
  assign io_sdram_DQM = ctrl_io_sdram_DQM;
  assign io_sdram_CASn = ctrl_io_sdram_CASn;
  assign io_sdram_CKE = ctrl_io_sdram_CKE;
  assign io_sdram_CSn = ctrl_io_sdram_CSn;
  assign io_sdram_RASn = ctrl_io_sdram_RASn;
  assign io_sdram_WEn = ctrl_io_sdram_WEn;
endmodule

module BmbArbiter_1_ (
      input   io_inputs_0_cmd_valid,
      output  io_inputs_0_cmd_ready,
      input   io_inputs_0_cmd_payload_last,
      input  [0:0] io_inputs_0_cmd_payload_fragment_opcode,
      input  [20:0] io_inputs_0_cmd_payload_fragment_address,
      input  [1:0] io_inputs_0_cmd_payload_fragment_length,
      input  [31:0] io_inputs_0_cmd_payload_fragment_data,
      input  [3:0] io_inputs_0_cmd_payload_fragment_mask,
      input  [0:0] io_inputs_0_cmd_payload_fragment_context,
      output  io_inputs_0_rsp_valid,
      input   io_inputs_0_rsp_ready,
      output  io_inputs_0_rsp_payload_last,
      output [0:0] io_inputs_0_rsp_payload_fragment_opcode,
      output [31:0] io_inputs_0_rsp_payload_fragment_data,
      output [0:0] io_inputs_0_rsp_payload_fragment_context,
      input   io_inputs_1_cmd_valid,
      output  io_inputs_1_cmd_ready,
      input   io_inputs_1_cmd_payload_last,
      input  [0:0] io_inputs_1_cmd_payload_fragment_opcode,
      input  [20:0] io_inputs_1_cmd_payload_fragment_address,
      input  [1:0] io_inputs_1_cmd_payload_fragment_length,
      input  [31:0] io_inputs_1_cmd_payload_fragment_data,
      input  [3:0] io_inputs_1_cmd_payload_fragment_mask,
      input  [0:0] io_inputs_1_cmd_payload_fragment_context,
      output  io_inputs_1_rsp_valid,
      input   io_inputs_1_rsp_ready,
      output  io_inputs_1_rsp_payload_last,
      output [0:0] io_inputs_1_rsp_payload_fragment_opcode,
      output [31:0] io_inputs_1_rsp_payload_fragment_data,
      output [0:0] io_inputs_1_rsp_payload_fragment_context,
      output  io_output_cmd_valid,
      input   io_output_cmd_ready,
      output  io_output_cmd_payload_last,
      output [0:0] io_output_cmd_payload_fragment_source,
      output [0:0] io_output_cmd_payload_fragment_opcode,
      output [20:0] io_output_cmd_payload_fragment_address,
      output [1:0] io_output_cmd_payload_fragment_length,
      output [31:0] io_output_cmd_payload_fragment_data,
      output [3:0] io_output_cmd_payload_fragment_mask,
      output [0:0] io_output_cmd_payload_fragment_context,
      input   io_output_rsp_valid,
      output  io_output_rsp_ready,
      input   io_output_rsp_payload_last,
      input  [0:0] io_output_rsp_payload_fragment_source,
      input  [0:0] io_output_rsp_payload_fragment_opcode,
      input  [31:0] io_output_rsp_payload_fragment_data,
      input  [0:0] io_output_rsp_payload_fragment_context,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire [0:0] _zz_1_;
  wire [0:0] _zz_2_;
  reg  _zz_3_;
  wire  logic_arbiter_io_inputs_0_ready;
  wire  logic_arbiter_io_inputs_1_ready;
  wire  logic_arbiter_io_output_valid;
  wire  logic_arbiter_io_output_payload_last;
  wire [0:0] logic_arbiter_io_output_payload_fragment_source;
  wire [0:0] logic_arbiter_io_output_payload_fragment_opcode;
  wire [20:0] logic_arbiter_io_output_payload_fragment_address;
  wire [1:0] logic_arbiter_io_output_payload_fragment_length;
  wire [31:0] logic_arbiter_io_output_payload_fragment_data;
  wire [3:0] logic_arbiter_io_output_payload_fragment_mask;
  wire [0:0] logic_arbiter_io_output_payload_fragment_context;
  wire [0:0] logic_arbiter_io_chosen;
  wire [1:0] logic_arbiter_io_chosenOH;
  wire [0:0] logic_rspSel;
  StreamArbiter_1_ logic_arbiter ( 
    .io_inputs_0_valid(io_inputs_0_cmd_valid),
    .io_inputs_0_ready(logic_arbiter_io_inputs_0_ready),
    .io_inputs_0_payload_last(io_inputs_0_cmd_payload_last),
    .io_inputs_0_payload_fragment_source(_zz_1_),
    .io_inputs_0_payload_fragment_opcode(io_inputs_0_cmd_payload_fragment_opcode),
    .io_inputs_0_payload_fragment_address(io_inputs_0_cmd_payload_fragment_address),
    .io_inputs_0_payload_fragment_length(io_inputs_0_cmd_payload_fragment_length),
    .io_inputs_0_payload_fragment_data(io_inputs_0_cmd_payload_fragment_data),
    .io_inputs_0_payload_fragment_mask(io_inputs_0_cmd_payload_fragment_mask),
    .io_inputs_0_payload_fragment_context(io_inputs_0_cmd_payload_fragment_context),
    .io_inputs_1_valid(io_inputs_1_cmd_valid),
    .io_inputs_1_ready(logic_arbiter_io_inputs_1_ready),
    .io_inputs_1_payload_last(io_inputs_1_cmd_payload_last),
    .io_inputs_1_payload_fragment_source(_zz_2_),
    .io_inputs_1_payload_fragment_opcode(io_inputs_1_cmd_payload_fragment_opcode),
    .io_inputs_1_payload_fragment_address(io_inputs_1_cmd_payload_fragment_address),
    .io_inputs_1_payload_fragment_length(io_inputs_1_cmd_payload_fragment_length),
    .io_inputs_1_payload_fragment_data(io_inputs_1_cmd_payload_fragment_data),
    .io_inputs_1_payload_fragment_mask(io_inputs_1_cmd_payload_fragment_mask),
    .io_inputs_1_payload_fragment_context(io_inputs_1_cmd_payload_fragment_context),
    .io_output_valid(logic_arbiter_io_output_valid),
    .io_output_ready(io_output_cmd_ready),
    .io_output_payload_last(logic_arbiter_io_output_payload_last),
    .io_output_payload_fragment_source(logic_arbiter_io_output_payload_fragment_source),
    .io_output_payload_fragment_opcode(logic_arbiter_io_output_payload_fragment_opcode),
    .io_output_payload_fragment_address(logic_arbiter_io_output_payload_fragment_address),
    .io_output_payload_fragment_length(logic_arbiter_io_output_payload_fragment_length),
    .io_output_payload_fragment_data(logic_arbiter_io_output_payload_fragment_data),
    .io_output_payload_fragment_mask(logic_arbiter_io_output_payload_fragment_mask),
    .io_output_payload_fragment_context(logic_arbiter_io_output_payload_fragment_context),
    .io_chosen(logic_arbiter_io_chosen),
    .io_chosenOH(logic_arbiter_io_chosenOH),
    .clock_out(clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  always @(*) begin
    case(logic_rspSel)
      1'b0 : begin
        _zz_3_ = io_inputs_0_rsp_ready;
      end
      default : begin
        _zz_3_ = io_inputs_1_rsp_ready;
      end
    endcase
  end

  assign io_inputs_0_cmd_ready = logic_arbiter_io_inputs_0_ready;
  assign _zz_1_ = (1'b0);
  assign io_inputs_1_cmd_ready = logic_arbiter_io_inputs_1_ready;
  assign _zz_2_ = (1'b0);
  assign io_output_cmd_valid = logic_arbiter_io_output_valid;
  assign io_output_cmd_payload_last = logic_arbiter_io_output_payload_last;
  assign io_output_cmd_payload_fragment_opcode = logic_arbiter_io_output_payload_fragment_opcode;
  assign io_output_cmd_payload_fragment_address = logic_arbiter_io_output_payload_fragment_address;
  assign io_output_cmd_payload_fragment_length = logic_arbiter_io_output_payload_fragment_length;
  assign io_output_cmd_payload_fragment_data = logic_arbiter_io_output_payload_fragment_data;
  assign io_output_cmd_payload_fragment_mask = logic_arbiter_io_output_payload_fragment_mask;
  assign io_output_cmd_payload_fragment_context = logic_arbiter_io_output_payload_fragment_context;
  assign io_output_cmd_payload_fragment_source[0 : 0] = logic_arbiter_io_chosen;
  assign logic_rspSel = io_output_rsp_payload_fragment_source[0 : 0];
  assign io_inputs_0_rsp_valid = (io_output_rsp_valid && (logic_rspSel == (1'b0)));
  assign io_inputs_0_rsp_payload_last = io_output_rsp_payload_last;
  assign io_inputs_0_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_inputs_0_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data;
  assign io_inputs_0_rsp_payload_fragment_context = io_output_rsp_payload_fragment_context;
  assign io_inputs_1_rsp_valid = (io_output_rsp_valid && (logic_rspSel == (1'b1)));
  assign io_inputs_1_rsp_payload_last = io_output_rsp_payload_last;
  assign io_inputs_1_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_inputs_1_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data;
  assign io_inputs_1_rsp_payload_fragment_context = io_output_rsp_payload_fragment_context;
  assign io_output_rsp_ready = _zz_3_;
endmodule

module BmbDownSizerBridge (
      input   io_input_cmd_valid,
      output  io_input_cmd_ready,
      input   io_input_cmd_payload_last,
      input  [0:0] io_input_cmd_payload_fragment_source,
      input  [0:0] io_input_cmd_payload_fragment_opcode,
      input  [20:0] io_input_cmd_payload_fragment_address,
      input  [1:0] io_input_cmd_payload_fragment_length,
      input  [31:0] io_input_cmd_payload_fragment_data,
      input  [3:0] io_input_cmd_payload_fragment_mask,
      input  [0:0] io_input_cmd_payload_fragment_context,
      output  io_input_rsp_valid,
      input   io_input_rsp_ready,
      output  io_input_rsp_payload_last,
      output [0:0] io_input_rsp_payload_fragment_source,
      output [0:0] io_input_rsp_payload_fragment_opcode,
      output [31:0] io_input_rsp_payload_fragment_data,
      output [0:0] io_input_rsp_payload_fragment_context,
      output  io_output_cmd_valid,
      input   io_output_cmd_ready,
      output  io_output_cmd_payload_last,
      output [0:0] io_output_cmd_payload_fragment_opcode,
      output [20:0] io_output_cmd_payload_fragment_address,
      output [1:0] io_output_cmd_payload_fragment_length,
      output [15:0] io_output_cmd_payload_fragment_data,
      output [1:0] io_output_cmd_payload_fragment_mask,
      output [2:0] io_output_cmd_payload_fragment_context,
      input   io_output_rsp_valid,
      output  io_output_rsp_ready,
      input   io_output_rsp_payload_last,
      input  [0:0] io_output_rsp_payload_fragment_opcode,
      input  [15:0] io_output_rsp_payload_fragment_data,
      input  [2:0] io_output_rsp_payload_fragment_context,
      input   clock_out,
      input   clockCtrl_systemReset);
  reg [15:0] _zz_2_;
  reg [1:0] _zz_3_;
  wire [20:0] _zz_4_;
  wire [20:0] _zz_5_;
  wire [0:0] cmdContext_context;
  wire [0:0] cmdContext_source;
  wire [0:0] cmdContext_sel;
  reg  cmdLogic_locked;
  reg [0:0] cmdLogic_counter;
  wire [0:0] cmdLogic_sel;
  wire [0:0] rspContext_context;
  wire [0:0] rspContext_source;
  wire [0:0] rspContext_sel;
  wire [2:0] _zz_1_;
  reg  rspLogic_locked;
  reg [0:0] rspLogic_counter;
  wire [0:0] rspLogic_sel;
  reg [15:0] rspLogic_buffers_0;
  reg [15:0] rspLogic_words_0;
  wire [15:0] rspLogic_words_1;
  assign _zz_4_ = (io_input_cmd_payload_fragment_address + _zz_5_);
  assign _zz_5_ = {19'd0, io_input_cmd_payload_fragment_length};
  always @(*) begin
    case(cmdLogic_sel)
      1'b0 : begin
        _zz_2_ = io_input_cmd_payload_fragment_data[15 : 0];
        _zz_3_ = io_input_cmd_payload_fragment_mask[1 : 0];
      end
      default : begin
        _zz_2_ = io_input_cmd_payload_fragment_data[31 : 16];
        _zz_3_ = io_input_cmd_payload_fragment_mask[3 : 2];
      end
    endcase
  end

  assign cmdContext_context = io_input_cmd_payload_fragment_context;
  assign cmdContext_source = io_input_cmd_payload_fragment_source;
  assign cmdContext_sel = io_input_cmd_payload_fragment_address[1 : 1];
  assign io_output_cmd_valid = io_input_cmd_valid;
  assign io_output_cmd_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
  assign io_output_cmd_payload_fragment_address = io_input_cmd_payload_fragment_address;
  assign io_output_cmd_payload_fragment_length = io_input_cmd_payload_fragment_length;
  assign io_output_cmd_payload_fragment_context = {cmdContext_sel,{cmdContext_source,cmdContext_context}};
  assign cmdLogic_sel = (cmdLogic_locked ? cmdLogic_counter : io_input_cmd_payload_fragment_address[1 : 1]);
  assign io_output_cmd_payload_fragment_data = _zz_2_;
  assign io_output_cmd_payload_fragment_mask = _zz_3_;
  assign io_output_cmd_payload_last = (io_input_cmd_payload_last && ((io_input_cmd_payload_fragment_opcode == (1'b0)) || (cmdLogic_sel == _zz_4_[1 : 1])));
  assign io_input_cmd_ready = (io_output_cmd_ready && ((cmdLogic_sel == (1'b1)) || io_output_cmd_payload_last));
  assign _zz_1_ = io_output_rsp_payload_fragment_context;
  assign rspContext_context = _zz_1_[0 : 0];
  assign rspContext_source = _zz_1_[1 : 1];
  assign rspContext_sel = _zz_1_[2 : 2];
  assign io_input_rsp_payload_last = io_output_rsp_payload_last;
  assign io_input_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_input_rsp_payload_fragment_source = rspContext_source;
  assign io_input_rsp_payload_fragment_context = rspContext_context;
  assign io_output_rsp_ready = io_input_rsp_ready;
  assign rspLogic_sel = (rspLogic_locked ? rspLogic_counter : rspContext_sel);
  always @ (*) begin
    rspLogic_words_0 = rspLogic_buffers_0;
    if((io_input_rsp_payload_last && (rspLogic_sel == (1'b0))))begin
      rspLogic_words_0 = io_output_rsp_payload_fragment_data;
    end
  end

  assign rspLogic_words_1 = io_output_rsp_payload_fragment_data;
  assign io_input_rsp_valid = (io_output_rsp_valid && (io_output_rsp_payload_last || (rspLogic_sel == (1'b1))));
  assign io_input_rsp_payload_fragment_data = {rspLogic_words_1,rspLogic_words_0};
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      cmdLogic_locked <= 1'b0;
      rspLogic_locked <= 1'b0;
    end else begin
      if((io_output_cmd_valid && io_output_cmd_ready))begin
        cmdLogic_locked <= (! io_output_cmd_payload_last);
      end
      if((io_output_rsp_valid && io_output_rsp_ready))begin
        rspLogic_locked <= (! io_output_rsp_payload_last);
      end
    end
  end

  always @ (posedge clock_out) begin
    if((io_output_cmd_valid && io_output_cmd_ready))begin
      cmdLogic_counter <= (cmdLogic_sel + (1'b1));
    end
    if((io_output_rsp_valid && io_output_rsp_ready))begin
      rspLogic_counter <= (rspLogic_sel + (1'b1));
      if((rspLogic_sel == (1'b0)))begin
        rspLogic_buffers_0 <= io_output_rsp_payload_fragment_data;
      end
    end
  end

endmodule

module BmbUnburstify (
      input   io_input_cmd_valid,
      output reg  io_input_cmd_ready,
      input   io_input_cmd_payload_last,
      input  [0:0] io_input_cmd_payload_fragment_opcode,
      input  [20:0] io_input_cmd_payload_fragment_address,
      input  [1:0] io_input_cmd_payload_fragment_length,
      input  [15:0] io_input_cmd_payload_fragment_data,
      input  [1:0] io_input_cmd_payload_fragment_mask,
      input  [2:0] io_input_cmd_payload_fragment_context,
      output  io_input_rsp_valid,
      input   io_input_rsp_ready,
      output  io_input_rsp_payload_last,
      output [0:0] io_input_rsp_payload_fragment_opcode,
      output [15:0] io_input_rsp_payload_fragment_data,
      output [2:0] io_input_rsp_payload_fragment_context,
      output reg  io_output_cmd_valid,
      input   io_output_cmd_ready,
      output  io_output_cmd_payload_last,
      output reg [0:0] io_output_cmd_payload_fragment_opcode,
      output reg [20:0] io_output_cmd_payload_fragment_address,
      output reg [0:0] io_output_cmd_payload_fragment_length,
      output [15:0] io_output_cmd_payload_fragment_data,
      output [1:0] io_output_cmd_payload_fragment_mask,
      output reg [4:0] io_output_cmd_payload_fragment_context,
      input   io_output_rsp_valid,
      output  io_output_rsp_ready,
      input   io_output_rsp_payload_last,
      input  [0:0] io_output_rsp_payload_fragment_opcode,
      input  [15:0] io_output_rsp_payload_fragment_data,
      input  [4:0] io_output_rsp_payload_fragment_context,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire  _zz_1_;
  wire [11:0] _zz_2_;
  wire [11:0] _zz_3_;
  wire [11:0] _zz_4_;
  wire  doResult;
  reg  buffer_valid;
  reg [0:0] buffer_opcode;
  reg [20:0] buffer_address;
  reg [2:0] buffer_context;
  reg [0:0] buffer_beat;
  wire  buffer_last;
  wire [20:0] buffer_addressIncr;
  wire  buffer_isWrite;
  wire [0:0] cmdTransferBeatCount;
  wire  requireBuffer;
  assign _zz_1_ = (io_output_cmd_valid && io_output_cmd_ready);
  assign _zz_2_ = (_zz_4_ + (12'b000000000010));
  assign _zz_3_ = buffer_address[11 : 0];
  assign _zz_4_ = _zz_3_;
  assign buffer_last = (buffer_beat == (1'b1));
  assign buffer_addressIncr = {buffer_address[20 : 12],(_zz_2_ & (~ (12'b000000000001)))};
  assign buffer_isWrite = (buffer_opcode == (1'b1));
  assign cmdTransferBeatCount = io_input_cmd_payload_fragment_length[1 : 1];
  assign requireBuffer = (cmdTransferBeatCount != (1'b0));
  assign io_output_cmd_payload_fragment_data = io_input_cmd_payload_fragment_data;
  assign io_output_cmd_payload_fragment_mask = io_input_cmd_payload_fragment_mask;
  assign io_output_cmd_payload_last = 1'b1;
  always @ (*) begin
    if(buffer_valid)begin
      io_output_cmd_payload_fragment_address = buffer_addressIncr;
    end else begin
      io_output_cmd_payload_fragment_address = io_input_cmd_payload_fragment_address;
      if(requireBuffer)begin
        io_output_cmd_payload_fragment_address[0 : 0] = (1'b0);
      end
    end
  end

  always @ (*) begin
    if(buffer_valid)begin
      io_output_cmd_payload_fragment_opcode = buffer_opcode;
    end else begin
      io_output_cmd_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
    end
  end

  always @ (*) begin
    if(buffer_valid)begin
      io_output_cmd_payload_fragment_length = (1'b1);
    end else begin
      if(requireBuffer)begin
        io_output_cmd_payload_fragment_length = (1'b1);
      end else begin
        io_output_cmd_payload_fragment_length = io_input_cmd_payload_fragment_length[0:0];
      end
    end
  end

  always @ (*) begin
    if(buffer_valid)begin
      io_output_cmd_payload_fragment_context[2 : 0] = buffer_context;
    end else begin
      io_output_cmd_payload_fragment_context[2 : 0] = io_input_cmd_payload_fragment_context;
    end
    if(buffer_valid)begin
      io_output_cmd_payload_fragment_context[4] = buffer_last;
      io_output_cmd_payload_fragment_context[3] = buffer_isWrite;
    end else begin
      io_output_cmd_payload_fragment_context[3] = (io_input_cmd_payload_fragment_opcode == (1'b1));
      io_output_cmd_payload_fragment_context[4] = (! requireBuffer);
    end
  end

  always @ (*) begin
    io_input_cmd_ready = 1'b0;
    if(buffer_valid)begin
      io_input_cmd_ready = (buffer_isWrite && io_output_cmd_ready);
    end else begin
      io_input_cmd_ready = io_output_cmd_ready;
    end
  end

  always @ (*) begin
    if(buffer_valid)begin
      io_output_cmd_valid = (! (buffer_isWrite && (! io_input_cmd_valid)));
    end else begin
      io_output_cmd_valid = io_input_cmd_valid;
    end
  end

  assign io_input_rsp_valid = (io_output_rsp_valid && (io_output_rsp_payload_fragment_context[4] || (! io_output_rsp_payload_fragment_context[3])));
  assign io_input_rsp_payload_last = io_output_rsp_payload_fragment_context[4];
  assign io_input_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_input_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data;
  assign io_input_rsp_payload_fragment_context = io_output_rsp_payload_fragment_context[2:0];
  assign io_output_rsp_ready = io_input_rsp_ready;
  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      buffer_valid <= 1'b0;
    end else begin
      if(_zz_1_)begin
        if(buffer_last)begin
          buffer_valid <= 1'b0;
        end
      end
      if(! buffer_valid) begin
        buffer_valid <= (requireBuffer && (io_output_cmd_valid && io_output_cmd_ready));
      end
    end
  end

  always @ (posedge clock_out) begin
    if(_zz_1_)begin
      buffer_beat <= (buffer_beat - (1'b1));
      buffer_address[11 : 0] <= buffer_addressIncr[11 : 0];
    end
    if(! buffer_valid) begin
      buffer_opcode <= io_input_cmd_payload_fragment_opcode;
      buffer_address <= io_input_cmd_payload_fragment_address;
      buffer_context <= io_input_cmd_payload_fragment_context;
      buffer_beat <= cmdTransferBeatCount;
    end
  end

endmodule

module Apb3Decoder (
      input  [16:0] io_input_PADDR,
      input  [0:0] io_input_PSEL,
      input   io_input_PENABLE,
      output reg  io_input_PREADY,
      input   io_input_PWRITE,
      input  [31:0] io_input_PWDATA,
      output [31:0] io_input_PRDATA,
      output reg  io_input_PSLVERROR,
      output [16:0] io_output_PADDR,
      output reg [1:0] io_output_PSEL,
      output  io_output_PENABLE,
      input   io_output_PREADY,
      output  io_output_PWRITE,
      output [31:0] io_output_PWDATA,
      input  [31:0] io_output_PRDATA,
      input   io_output_PSLVERROR);
  wire  _zz_1_;
  assign _zz_1_ = (io_input_PSEL[0] && (io_output_PSEL == (2'b00)));
  assign io_output_PADDR = io_input_PADDR;
  assign io_output_PENABLE = io_input_PENABLE;
  assign io_output_PWRITE = io_input_PWRITE;
  assign io_output_PWDATA = io_input_PWDATA;
  always @ (*) begin
    io_output_PSEL[0] = (((io_input_PADDR & (~ (17'b00000000000001111))) == (17'b10000000000000000)) && io_input_PSEL[0]);
    io_output_PSEL[1] = (((io_input_PADDR & (~ (17'b00000111111111111))) == (17'b00000000000000000)) && io_input_PSEL[0]);
  end

  always @ (*) begin
    io_input_PREADY = io_output_PREADY;
    if(_zz_1_)begin
      io_input_PREADY = 1'b1;
    end
  end

  assign io_input_PRDATA = io_output_PRDATA;
  always @ (*) begin
    io_input_PSLVERROR = io_output_PSLVERROR;
    if(_zz_1_)begin
      io_input_PSLVERROR = 1'b1;
    end
  end

endmodule

module Apb3Router (
      input  [16:0] io_input_PADDR,
      input  [1:0] io_input_PSEL,
      input   io_input_PENABLE,
      output  io_input_PREADY,
      input   io_input_PWRITE,
      input  [31:0] io_input_PWDATA,
      output [31:0] io_input_PRDATA,
      output  io_input_PSLVERROR,
      output [16:0] io_outputs_0_PADDR,
      output [0:0] io_outputs_0_PSEL,
      output  io_outputs_0_PENABLE,
      input   io_outputs_0_PREADY,
      output  io_outputs_0_PWRITE,
      output [31:0] io_outputs_0_PWDATA,
      input  [31:0] io_outputs_0_PRDATA,
      input   io_outputs_0_PSLVERROR,
      output [16:0] io_outputs_1_PADDR,
      output [0:0] io_outputs_1_PSEL,
      output  io_outputs_1_PENABLE,
      input   io_outputs_1_PREADY,
      output  io_outputs_1_PWRITE,
      output [31:0] io_outputs_1_PWDATA,
      input  [31:0] io_outputs_1_PRDATA,
      input   io_outputs_1_PSLVERROR,
      input   clock_out,
      input   clockCtrl_systemReset);
  reg  _zz_2_;
  reg [31:0] _zz_3_;
  reg  _zz_4_;
  wire  _zz_1_;
  reg [0:0] selIndex;
  always @(*) begin
    case(selIndex)
      1'b0 : begin
        _zz_2_ = io_outputs_0_PREADY;
        _zz_3_ = io_outputs_0_PRDATA;
        _zz_4_ = io_outputs_0_PSLVERROR;
      end
      default : begin
        _zz_2_ = io_outputs_1_PREADY;
        _zz_3_ = io_outputs_1_PRDATA;
        _zz_4_ = io_outputs_1_PSLVERROR;
      end
    endcase
  end

  assign io_outputs_0_PADDR = io_input_PADDR;
  assign io_outputs_0_PENABLE = io_input_PENABLE;
  assign io_outputs_0_PSEL[0] = io_input_PSEL[0];
  assign io_outputs_0_PWRITE = io_input_PWRITE;
  assign io_outputs_0_PWDATA = io_input_PWDATA;
  assign io_outputs_1_PADDR = io_input_PADDR;
  assign io_outputs_1_PENABLE = io_input_PENABLE;
  assign io_outputs_1_PSEL[0] = io_input_PSEL[1];
  assign io_outputs_1_PWRITE = io_input_PWRITE;
  assign io_outputs_1_PWDATA = io_input_PWDATA;
  assign _zz_1_ = io_input_PSEL[1];
  assign io_input_PREADY = _zz_2_;
  assign io_input_PRDATA = _zz_3_;
  assign io_input_PSLVERROR = _zz_4_;
  always @ (posedge clock_out) begin
    selIndex <= _zz_1_;
  end

endmodule

module BmbToApb3Bridge (
      input   io_input_cmd_valid,
      output  io_input_cmd_ready,
      input   io_input_cmd_payload_last,
      input  [0:0] io_input_cmd_payload_fragment_opcode,
      input  [16:0] io_input_cmd_payload_fragment_address,
      input  [1:0] io_input_cmd_payload_fragment_length,
      input  [31:0] io_input_cmd_payload_fragment_data,
      input  [3:0] io_input_cmd_payload_fragment_mask,
      input  [0:0] io_input_cmd_payload_fragment_context,
      output  io_input_rsp_valid,
      input   io_input_rsp_ready,
      output  io_input_rsp_payload_last,
      output [0:0] io_input_rsp_payload_fragment_opcode,
      output [31:0] io_input_rsp_payload_fragment_data,
      output [0:0] io_input_rsp_payload_fragment_context,
      output [16:0] io_output_PADDR,
      output [0:0] io_output_PSEL,
      output  io_output_PENABLE,
      input   io_output_PREADY,
      output  io_output_PWRITE,
      output [31:0] io_output_PWDATA,
      input  [31:0] io_output_PRDATA,
      input   io_output_PSLVERROR,
      input   clock_out,
      input   clockCtrl_systemReset);
  wire  _zz_7_;
  wire  bmbBuffer_cmd_valid;
  reg  bmbBuffer_cmd_ready;
  wire  bmbBuffer_cmd_payload_last;
  wire [0:0] bmbBuffer_cmd_payload_fragment_opcode;
  wire [16:0] bmbBuffer_cmd_payload_fragment_address;
  wire [1:0] bmbBuffer_cmd_payload_fragment_length;
  wire [31:0] bmbBuffer_cmd_payload_fragment_data;
  wire [3:0] bmbBuffer_cmd_payload_fragment_mask;
  wire [0:0] bmbBuffer_cmd_payload_fragment_context;
  reg  bmbBuffer_rsp_valid;
  wire  bmbBuffer_rsp_ready;
  wire  bmbBuffer_rsp_payload_last;
  reg [0:0] bmbBuffer_rsp_payload_fragment_opcode;
  wire [31:0] bmbBuffer_rsp_payload_fragment_data;
  wire [0:0] bmbBuffer_rsp_payload_fragment_context;
  wire  _zz_1_;
  wire  bmbBuffer_rsp_m2sPipe_valid;
  wire  bmbBuffer_rsp_m2sPipe_ready;
  wire  bmbBuffer_rsp_m2sPipe_payload_last;
  wire [0:0] bmbBuffer_rsp_m2sPipe_payload_fragment_opcode;
  wire [31:0] bmbBuffer_rsp_m2sPipe_payload_fragment_data;
  wire [0:0] bmbBuffer_rsp_m2sPipe_payload_fragment_context;
  reg  _zz_2_;
  reg  _zz_3_;
  reg [0:0] _zz_4_;
  reg [31:0] _zz_5_;
  reg [0:0] _zz_6_;
  reg  state;
  assign _zz_7_ = (! state);
  assign _zz_1_ = (! (io_input_rsp_valid && (! io_input_rsp_ready)));
  assign io_input_cmd_ready = (bmbBuffer_cmd_ready && _zz_1_);
  assign bmbBuffer_cmd_valid = (io_input_cmd_valid && _zz_1_);
  assign bmbBuffer_cmd_payload_last = io_input_cmd_payload_last;
  assign bmbBuffer_cmd_payload_fragment_opcode = io_input_cmd_payload_fragment_opcode;
  assign bmbBuffer_cmd_payload_fragment_address = io_input_cmd_payload_fragment_address;
  assign bmbBuffer_cmd_payload_fragment_length = io_input_cmd_payload_fragment_length;
  assign bmbBuffer_cmd_payload_fragment_data = io_input_cmd_payload_fragment_data;
  assign bmbBuffer_cmd_payload_fragment_mask = io_input_cmd_payload_fragment_mask;
  assign bmbBuffer_cmd_payload_fragment_context = io_input_cmd_payload_fragment_context;
  assign bmbBuffer_rsp_ready = ((1'b1 && (! bmbBuffer_rsp_m2sPipe_valid)) || bmbBuffer_rsp_m2sPipe_ready);
  assign bmbBuffer_rsp_m2sPipe_valid = _zz_2_;
  assign bmbBuffer_rsp_m2sPipe_payload_last = _zz_3_;
  assign bmbBuffer_rsp_m2sPipe_payload_fragment_opcode = _zz_4_;
  assign bmbBuffer_rsp_m2sPipe_payload_fragment_data = _zz_5_;
  assign bmbBuffer_rsp_m2sPipe_payload_fragment_context = _zz_6_;
  assign io_input_rsp_valid = bmbBuffer_rsp_m2sPipe_valid;
  assign bmbBuffer_rsp_m2sPipe_ready = io_input_rsp_ready;
  assign io_input_rsp_payload_last = bmbBuffer_rsp_m2sPipe_payload_last;
  assign io_input_rsp_payload_fragment_opcode = bmbBuffer_rsp_m2sPipe_payload_fragment_opcode;
  assign io_input_rsp_payload_fragment_data = bmbBuffer_rsp_m2sPipe_payload_fragment_data;
  assign io_input_rsp_payload_fragment_context = bmbBuffer_rsp_m2sPipe_payload_fragment_context;
  always @ (*) begin
    bmbBuffer_cmd_ready = 1'b0;
    if(! _zz_7_) begin
      if(io_output_PREADY)begin
        bmbBuffer_cmd_ready = 1'b1;
      end
    end
  end

  assign io_output_PSEL[0] = bmbBuffer_cmd_valid;
  assign io_output_PENABLE = state;
  assign io_output_PWRITE = (bmbBuffer_cmd_payload_fragment_opcode == (1'b1));
  assign io_output_PADDR = bmbBuffer_cmd_payload_fragment_address;
  assign io_output_PWDATA = bmbBuffer_cmd_payload_fragment_data;
  always @ (*) begin
    bmbBuffer_rsp_valid = 1'b0;
    if(! _zz_7_) begin
      if(io_output_PREADY)begin
        bmbBuffer_rsp_valid = 1'b1;
      end
    end
  end

  assign bmbBuffer_rsp_payload_fragment_data = io_output_PRDATA;
  assign bmbBuffer_rsp_payload_fragment_context = io_input_cmd_payload_fragment_context;
  assign bmbBuffer_rsp_payload_last = 1'b1;
  always @ (*) begin
    bmbBuffer_rsp_payload_fragment_opcode = (1'b0);
    if(io_output_PSLVERROR)begin
      bmbBuffer_rsp_payload_fragment_opcode = (1'b1);
    end
  end

  always @ (posedge clock_out) begin
    if(clockCtrl_systemReset) begin
      _zz_2_ <= 1'b0;
      state <= 1'b0;
    end else begin
      if(bmbBuffer_rsp_ready)begin
        _zz_2_ <= bmbBuffer_rsp_valid;
      end
      if(_zz_7_)begin
        state <= bmbBuffer_cmd_valid;
      end else begin
        if(io_output_PREADY)begin
          state <= 1'b0;
        end
      end
    end
  end

  always @ (posedge clock_out) begin
    if(bmbBuffer_rsp_ready)begin
      _zz_3_ <= bmbBuffer_rsp_payload_last;
      _zz_4_ <= bmbBuffer_rsp_payload_fragment_opcode;
      _zz_5_ <= bmbBuffer_rsp_payload_fragment_data;
      _zz_6_ <= bmbBuffer_rsp_payload_fragment_context;
    end
  end

endmodule

module BmbArbiter_2_ (
      input   io_inputs_0_cmd_valid,
      output  io_inputs_0_cmd_ready,
      input   io_inputs_0_cmd_payload_last,
      input  [0:0] io_inputs_0_cmd_payload_fragment_opcode,
      input  [16:0] io_inputs_0_cmd_payload_fragment_address,
      input  [1:0] io_inputs_0_cmd_payload_fragment_length,
      input  [31:0] io_inputs_0_cmd_payload_fragment_data,
      input  [3:0] io_inputs_0_cmd_payload_fragment_mask,
      input  [0:0] io_inputs_0_cmd_payload_fragment_context,
      output  io_inputs_0_rsp_valid,
      input   io_inputs_0_rsp_ready,
      output  io_inputs_0_rsp_payload_last,
      output [0:0] io_inputs_0_rsp_payload_fragment_opcode,
      output [31:0] io_inputs_0_rsp_payload_fragment_data,
      output [0:0] io_inputs_0_rsp_payload_fragment_context,
      output  io_output_cmd_valid,
      input   io_output_cmd_ready,
      output  io_output_cmd_payload_last,
      output [0:0] io_output_cmd_payload_fragment_opcode,
      output [16:0] io_output_cmd_payload_fragment_address,
      output [1:0] io_output_cmd_payload_fragment_length,
      output [31:0] io_output_cmd_payload_fragment_data,
      output [3:0] io_output_cmd_payload_fragment_mask,
      output [0:0] io_output_cmd_payload_fragment_context,
      input   io_output_rsp_valid,
      output  io_output_rsp_ready,
      input   io_output_rsp_payload_last,
      input  [0:0] io_output_rsp_payload_fragment_opcode,
      input  [31:0] io_output_rsp_payload_fragment_data,
      input  [0:0] io_output_rsp_payload_fragment_context);
  assign io_output_cmd_valid = io_inputs_0_cmd_valid;
  assign io_inputs_0_cmd_ready = io_output_cmd_ready;
  assign io_inputs_0_rsp_valid = io_output_rsp_valid;
  assign io_output_rsp_ready = io_inputs_0_rsp_ready;
  assign io_output_cmd_payload_last = io_inputs_0_cmd_payload_last;
  assign io_inputs_0_rsp_payload_last = io_output_rsp_payload_last;
  assign io_output_cmd_payload_fragment_opcode = io_inputs_0_cmd_payload_fragment_opcode;
  assign io_output_cmd_payload_fragment_address = io_inputs_0_cmd_payload_fragment_address;
  assign io_output_cmd_payload_fragment_length = io_inputs_0_cmd_payload_fragment_length;
  assign io_output_cmd_payload_fragment_data = io_inputs_0_cmd_payload_fragment_data;
  assign io_output_cmd_payload_fragment_mask = io_inputs_0_cmd_payload_fragment_mask;
  assign io_output_cmd_payload_fragment_context = io_inputs_0_cmd_payload_fragment_context;
  assign io_inputs_0_rsp_payload_fragment_opcode = io_output_rsp_payload_fragment_opcode;
  assign io_inputs_0_rsp_payload_fragment_data = io_output_rsp_payload_fragment_data;
  assign io_inputs_0_rsp_payload_fragment_context = io_output_rsp_payload_fragment_context;
endmodule

module BlackiceMxSocSdram (
      input   clk_25M,
      output  sdramClk,
      output  system_uartA_uart_txd,
      input   system_uartA_uart_rxd,
      input   system_cpu_tms,
      input   system_cpu_tdi,
      output  system_cpu_tdo,
      input   system_cpu_tck,
      output [10:0] system_sdramA_sdram_ADDR,
      output [0:0] system_sdramA_sdram_BA,
      output [1:0] system_sdramA_sdram_DQM,
      output  system_sdramA_sdram_CASn,
      output  system_sdramA_sdram_CKE,
      output  system_sdramA_sdram_CSn,
      output  system_sdramA_sdram_RASn,
      output  system_sdramA_sdram_WEn,
      inout  system_gpioA_gpio_0,
      inout  system_gpioA_gpio_1,
      inout  system_gpioA_gpio_2,
      inout  system_gpioA_gpio_3,
      inout  system_gpioA_gpio_4,
      inout  system_gpioA_gpio_5,
      inout  system_gpioA_gpio_6,
      inout  system_gpioA_gpio_7,
      inout  system_sdramA_sdram_DQ_0,
      inout  system_sdramA_sdram_DQ_1,
      inout  system_sdramA_sdram_DQ_2,
      inout  system_sdramA_sdram_DQ_3,
      inout  system_sdramA_sdram_DQ_4,
      inout  system_sdramA_sdram_DQ_5,
      inout  system_sdramA_sdram_DQ_6,
      inout  system_sdramA_sdram_DQ_7,
      inout  system_sdramA_sdram_DQ_8,
      inout  system_sdramA_sdram_DQ_9,
      inout  system_sdramA_sdram_DQ_10,
      inout  system_sdramA_sdram_DQ_11,
      inout  system_sdramA_sdram_DQ_12,
      inout  system_sdramA_sdram_DQ_13,
      inout  system_sdramA_sdram_DQ_14,
      inout  system_sdramA_sdram_DQ_15);
  wire [3:0] _zz_19_;
  wire [11:0] _zz_20_;
  wire  _zz_21_;
  wire [7:0] _zz_22_;
  wire  _zz_23_;
  wire  _zz_24_;
  wire  _zz_25_;
  wire [0:0] _zz_26_;
  wire [1:0] _zz_27_;
  wire  _zz_28_;
  wire  _zz_29_;
  wire [0:0] _zz_30_;
  wire [3:0] _zz_31_;
  wire  _zz_32_;
  wire [12:0] _zz_33_;
  wire [12:0] _zz_34_;
  wire [31:0] _zz_35_;
  wire [3:0] _zz_36_;
  wire [0:0] _zz_37_;
  wire [20:0] _zz_38_;
  wire [20:0] _zz_39_;
  wire [31:0] _zz_40_;
  wire [3:0] _zz_41_;
  wire [0:0] _zz_42_;
  wire  _zz_43_;
  wire  _zz_44_;
  wire [16:0] _zz_45_;
  wire  _zz_46_;
  wire  _zz_47_;
  wire  _zz_48_;
  wire  _zz_49_;
  wire  _zz_50_;
  wire  _zz_51_;
  wire  _zz_52_;
  wire  _zz_53_;
  wire  _zz_54_;
  wire  _zz_55_;
  wire  _zz_56_;
  wire  _zz_57_;
  wire  _zz_58_;
  wire  _zz_59_;
  wire  _zz_60_;
  wire  _zz_61_;
  wire  _zz_62_;
  wire  _zz_63_;
  wire  _zz_64_;
  wire  _zz_65_;
  wire  _zz_66_;
  wire  _zz_67_;
  wire  _zz_68_;
  wire  _zz_69_;
  wire  _zz_70_;
  wire  _zz_71_;
  wire  _zz_72_;
  wire  _zz_73_;
  wire  _zz_74_;
  wire  _zz_75_;
  wire  _zz_76_;
  wire  _zz_77_;
  wire  pll_clock_out;
  wire  pll_sdram_clock_out;
  wire  pll_locked;
  wire  bufferCC_4__io_dataOut;
  wire  system_uartA_io_apb_PREADY;
  wire [31:0] system_uartA_io_apb_PRDATA;
  wire  system_uartA_io_uart_txd;
  wire  system_uartA_io_interrupt;
  wire [7:0] system_gpioA_io_gpio_write;
  wire [7:0] system_gpioA_io_gpio_writeEnable;
  wire  system_gpioA_io_bus_PREADY;
  wire [31:0] system_gpioA_io_bus_PRDATA;
  wire  system_gpioA_io_bus_PSLVERROR;
  wire [7:0] system_gpioA_io_interrupt;
  wire  system_cpu_cpu_iBus_cmd_valid;
  wire [31:0] system_cpu_cpu_iBus_cmd_payload_pc;
  wire  system_cpu_cpu_debug_bus_cmd_ready;
  wire [31:0] system_cpu_cpu_debug_bus_rsp_data;
  wire  system_cpu_cpu_debug_resetOut;
  wire  system_cpu_cpu_dBus_cmd_valid;
  wire  system_cpu_cpu_dBus_cmd_payload_wr;
  wire [31:0] system_cpu_cpu_dBus_cmd_payload_address;
  wire [31:0] system_cpu_cpu_dBus_cmd_payload_data;
  wire [1:0] system_cpu_cpu_dBus_cmd_payload_size;
  wire  jtagBridge_1__io_jtag_tdo;
  wire  jtagBridge_1__io_remote_cmd_valid;
  wire  jtagBridge_1__io_remote_cmd_payload_last;
  wire [0:0] jtagBridge_1__io_remote_cmd_payload_fragment;
  wire  jtagBridge_1__io_remote_rsp_ready;
  wire  systemDebugger_1__io_remote_cmd_ready;
  wire  systemDebugger_1__io_remote_rsp_valid;
  wire  systemDebugger_1__io_remote_rsp_payload_error;
  wire [31:0] systemDebugger_1__io_remote_rsp_payload_data;
  wire  systemDebugger_1__io_mem_cmd_valid;
  wire [31:0] systemDebugger_1__io_mem_cmd_payload_address;
  wire [31:0] systemDebugger_1__io_mem_cmd_payload_data;
  wire  systemDebugger_1__io_mem_cmd_payload_wr;
  wire [1:0] systemDebugger_1__io_mem_cmd_payload_size;
  wire  system_cpu_iBus_decoder_io_input_cmd_ready;
  wire  system_cpu_iBus_decoder_io_input_rsp_valid;
  wire  system_cpu_iBus_decoder_io_input_rsp_payload_last;
  wire [0:0] system_cpu_iBus_decoder_io_input_rsp_payload_fragment_opcode;
  wire [31:0] system_cpu_iBus_decoder_io_input_rsp_payload_fragment_data;
  wire  system_cpu_iBus_decoder_io_outputs_0_cmd_valid;
  wire  system_cpu_iBus_decoder_io_outputs_0_cmd_payload_last;
  wire [0:0] system_cpu_iBus_decoder_io_outputs_0_cmd_payload_fragment_opcode;
  wire [31:0] system_cpu_iBus_decoder_io_outputs_0_cmd_payload_fragment_address;
  wire [1:0] system_cpu_iBus_decoder_io_outputs_0_cmd_payload_fragment_length;
  wire  system_cpu_iBus_decoder_io_outputs_0_rsp_ready;
  wire  system_cpu_iBus_decoder_io_outputs_1_cmd_valid;
  wire  system_cpu_iBus_decoder_io_outputs_1_cmd_payload_last;
  wire [0:0] system_cpu_iBus_decoder_io_outputs_1_cmd_payload_fragment_opcode;
  wire [31:0] system_cpu_iBus_decoder_io_outputs_1_cmd_payload_fragment_address;
  wire [1:0] system_cpu_iBus_decoder_io_outputs_1_cmd_payload_fragment_length;
  wire  system_cpu_iBus_decoder_io_outputs_1_rsp_ready;
  wire  system_cpu_dBus_decoder_io_input_cmd_ready;
  wire  system_cpu_dBus_decoder_io_input_rsp_valid;
  wire  system_cpu_dBus_decoder_io_input_rsp_payload_last;
  wire [0:0] system_cpu_dBus_decoder_io_input_rsp_payload_fragment_opcode;
  wire [31:0] system_cpu_dBus_decoder_io_input_rsp_payload_fragment_data;
  wire [0:0] system_cpu_dBus_decoder_io_input_rsp_payload_fragment_context;
  wire  system_cpu_dBus_decoder_io_outputs_0_cmd_valid;
  wire  system_cpu_dBus_decoder_io_outputs_0_cmd_payload_last;
  wire [0:0] system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_opcode;
  wire [31:0] system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_address;
  wire [1:0] system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_length;
  wire [31:0] system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_data;
  wire [3:0] system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_mask;
  wire [0:0] system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_context;
  wire  system_cpu_dBus_decoder_io_outputs_0_rsp_ready;
  wire  system_cpu_dBus_decoder_io_outputs_1_cmd_valid;
  wire  system_cpu_dBus_decoder_io_outputs_1_cmd_payload_last;
  wire [0:0] system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_opcode;
  wire [31:0] system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_address;
  wire [1:0] system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_length;
  wire [31:0] system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_data;
  wire [3:0] system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_mask;
  wire [0:0] system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_context;
  wire  system_cpu_dBus_decoder_io_outputs_1_rsp_ready;
  wire  system_cpu_dBus_decoder_io_outputs_2_cmd_valid;
  wire  system_cpu_dBus_decoder_io_outputs_2_cmd_payload_last;
  wire [0:0] system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_opcode;
  wire [31:0] system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_address;
  wire [1:0] system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_length;
  wire [31:0] system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_data;
  wire [3:0] system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_mask;
  wire [0:0] system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_context;
  wire  system_cpu_dBus_decoder_io_outputs_2_rsp_ready;
  wire  system_ramA_io_bus_cmd_ready;
  wire  system_ramA_io_bus_rsp_valid;
  wire  system_ramA_io_bus_rsp_payload_last;
  wire [0:0] system_ramA_io_bus_rsp_payload_fragment_source;
  wire [0:0] system_ramA_io_bus_rsp_payload_fragment_opcode;
  wire [31:0] system_ramA_io_bus_rsp_payload_fragment_data;
  wire [0:0] system_ramA_io_bus_rsp_payload_fragment_context;
  wire  system_ramA_bmb_arbiter_io_inputs_0_cmd_ready;
  wire  system_ramA_bmb_arbiter_io_inputs_0_rsp_valid;
  wire  system_ramA_bmb_arbiter_io_inputs_0_rsp_payload_last;
  wire [0:0] system_ramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_opcode;
  wire [31:0] system_ramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_data;
  wire [0:0] system_ramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_context;
  wire  system_ramA_bmb_arbiter_io_inputs_1_cmd_ready;
  wire  system_ramA_bmb_arbiter_io_inputs_1_rsp_valid;
  wire  system_ramA_bmb_arbiter_io_inputs_1_rsp_payload_last;
  wire [0:0] system_ramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_opcode;
  wire [31:0] system_ramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_data;
  wire [0:0] system_ramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_context;
  wire  system_ramA_bmb_arbiter_io_output_cmd_valid;
  wire  system_ramA_bmb_arbiter_io_output_cmd_payload_last;
  wire [0:0] system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_source;
  wire [0:0] system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_opcode;
  wire [12:0] system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address;
  wire [1:0] system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_length;
  wire [31:0] system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_data;
  wire [3:0] system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_mask;
  wire [0:0] system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_context;
  wire  system_ramA_bmb_arbiter_io_output_rsp_ready;
  wire  system_sdramA_io_bmb_cmd_ready;
  wire  system_sdramA_io_bmb_rsp_valid;
  wire  system_sdramA_io_bmb_rsp_payload_last;
  wire [0:0] system_sdramA_io_bmb_rsp_payload_fragment_opcode;
  wire [15:0] system_sdramA_io_bmb_rsp_payload_fragment_data;
  wire [4:0] system_sdramA_io_bmb_rsp_payload_fragment_context;
  wire [10:0] system_sdramA_io_sdram_ADDR;
  wire [0:0] system_sdramA_io_sdram_BA;
  wire  system_sdramA_io_sdram_CASn;
  wire  system_sdramA_io_sdram_CKE;
  wire  system_sdramA_io_sdram_CSn;
  wire [1:0] system_sdramA_io_sdram_DQM;
  wire  system_sdramA_io_sdram_RASn;
  wire  system_sdramA_io_sdram_WEn;
  wire [15:0] system_sdramA_io_sdram_DQ_write;
  wire  system_sdramA_io_sdram_DQ_writeEnable;
  wire  system_sdramA_bmb_arbiter_io_inputs_0_cmd_ready;
  wire  system_sdramA_bmb_arbiter_io_inputs_0_rsp_valid;
  wire  system_sdramA_bmb_arbiter_io_inputs_0_rsp_payload_last;
  wire [0:0] system_sdramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_opcode;
  wire [31:0] system_sdramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_data;
  wire [0:0] system_sdramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_context;
  wire  system_sdramA_bmb_arbiter_io_inputs_1_cmd_ready;
  wire  system_sdramA_bmb_arbiter_io_inputs_1_rsp_valid;
  wire  system_sdramA_bmb_arbiter_io_inputs_1_rsp_payload_last;
  wire [0:0] system_sdramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_opcode;
  wire [31:0] system_sdramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_data;
  wire [0:0] system_sdramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_context;
  wire  system_sdramA_bmb_arbiter_io_output_cmd_valid;
  wire  system_sdramA_bmb_arbiter_io_output_cmd_payload_last;
  wire [0:0] system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_source;
  wire [0:0] system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_opcode;
  wire [20:0] system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_address;
  wire [1:0] system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_length;
  wire [31:0] system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_data;
  wire [3:0] system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_mask;
  wire [0:0] system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_context;
  wire  system_sdramA_bmb_arbiter_io_output_rsp_ready;
  wire  system_sdramA_bmb_downSizer_io_input_cmd_ready;
  wire  system_sdramA_bmb_downSizer_io_input_rsp_valid;
  wire  system_sdramA_bmb_downSizer_io_input_rsp_payload_last;
  wire [0:0] system_sdramA_bmb_downSizer_io_input_rsp_payload_fragment_source;
  wire [0:0] system_sdramA_bmb_downSizer_io_input_rsp_payload_fragment_opcode;
  wire [31:0] system_sdramA_bmb_downSizer_io_input_rsp_payload_fragment_data;
  wire [0:0] system_sdramA_bmb_downSizer_io_input_rsp_payload_fragment_context;
  wire  system_sdramA_bmb_downSizer_io_output_cmd_valid;
  wire  system_sdramA_bmb_downSizer_io_output_cmd_payload_last;
  wire [0:0] system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_opcode;
  wire [20:0] system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_address;
  wire [1:0] system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_length;
  wire [15:0] system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_data;
  wire [1:0] system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_mask;
  wire [2:0] system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_context;
  wire  system_sdramA_bmb_downSizer_io_output_rsp_ready;
  wire  system_sdramA_bmb_burstUnburstifier_io_input_cmd_ready;
  wire  system_sdramA_bmb_burstUnburstifier_io_input_rsp_valid;
  wire  system_sdramA_bmb_burstUnburstifier_io_input_rsp_payload_last;
  wire [0:0] system_sdramA_bmb_burstUnburstifier_io_input_rsp_payload_fragment_opcode;
  wire [15:0] system_sdramA_bmb_burstUnburstifier_io_input_rsp_payload_fragment_data;
  wire [2:0] system_sdramA_bmb_burstUnburstifier_io_input_rsp_payload_fragment_context;
  wire  system_sdramA_bmb_burstUnburstifier_io_output_cmd_valid;
  wire  system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_last;
  wire [0:0] system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_opcode;
  wire [20:0] system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_address;
  wire [0:0] system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_length;
  wire [15:0] system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_data;
  wire [1:0] system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_mask;
  wire [4:0] system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_context;
  wire  system_sdramA_bmb_burstUnburstifier_io_output_rsp_ready;
  wire  generator_decoder_io_input_PREADY;
  wire [31:0] generator_decoder_io_input_PRDATA;
  wire  generator_decoder_io_input_PSLVERROR;
  wire [16:0] generator_decoder_io_output_PADDR;
  wire [1:0] generator_decoder_io_output_PSEL;
  wire  generator_decoder_io_output_PENABLE;
  wire  generator_decoder_io_output_PWRITE;
  wire [31:0] generator_decoder_io_output_PWDATA;
  wire  apb3Router_1__io_input_PREADY;
  wire [31:0] apb3Router_1__io_input_PRDATA;
  wire  apb3Router_1__io_input_PSLVERROR;
  wire [16:0] apb3Router_1__io_outputs_0_PADDR;
  wire [0:0] apb3Router_1__io_outputs_0_PSEL;
  wire  apb3Router_1__io_outputs_0_PENABLE;
  wire  apb3Router_1__io_outputs_0_PWRITE;
  wire [31:0] apb3Router_1__io_outputs_0_PWDATA;
  wire [16:0] apb3Router_1__io_outputs_1_PADDR;
  wire [0:0] apb3Router_1__io_outputs_1_PSEL;
  wire  apb3Router_1__io_outputs_1_PENABLE;
  wire  apb3Router_1__io_outputs_1_PWRITE;
  wire [31:0] apb3Router_1__io_outputs_1_PWDATA;
  wire  system_peripheralBridge_bridge_io_input_cmd_ready;
  wire  system_peripheralBridge_bridge_io_input_rsp_valid;
  wire  system_peripheralBridge_bridge_io_input_rsp_payload_last;
  wire [0:0] system_peripheralBridge_bridge_io_input_rsp_payload_fragment_opcode;
  wire [31:0] system_peripheralBridge_bridge_io_input_rsp_payload_fragment_data;
  wire [0:0] system_peripheralBridge_bridge_io_input_rsp_payload_fragment_context;
  wire [16:0] system_peripheralBridge_bridge_io_output_PADDR;
  wire [0:0] system_peripheralBridge_bridge_io_output_PSEL;
  wire  system_peripheralBridge_bridge_io_output_PENABLE;
  wire  system_peripheralBridge_bridge_io_output_PWRITE;
  wire [31:0] system_peripheralBridge_bridge_io_output_PWDATA;
  wire  system_peripheralBridge_input_arbiter_io_inputs_0_cmd_ready;
  wire  system_peripheralBridge_input_arbiter_io_inputs_0_rsp_valid;
  wire  system_peripheralBridge_input_arbiter_io_inputs_0_rsp_payload_last;
  wire [0:0] system_peripheralBridge_input_arbiter_io_inputs_0_rsp_payload_fragment_opcode;
  wire [31:0] system_peripheralBridge_input_arbiter_io_inputs_0_rsp_payload_fragment_data;
  wire [0:0] system_peripheralBridge_input_arbiter_io_inputs_0_rsp_payload_fragment_context;
  wire  system_peripheralBridge_input_arbiter_io_output_cmd_valid;
  wire  system_peripheralBridge_input_arbiter_io_output_cmd_payload_last;
  wire [0:0] system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_opcode;
  wire [16:0] system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_address;
  wire [1:0] system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_length;
  wire [31:0] system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_data;
  wire [3:0] system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_mask;
  wire [0:0] system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_context;
  wire  system_peripheralBridge_input_arbiter_io_output_rsp_ready;
  wire  sB_IO_1__D_IN_0;
  wire  sB_IO_2__D_IN_0;
  wire  sB_IO_3__D_IN_0;
  wire  sB_IO_4__D_IN_0;
  wire  sB_IO_5__D_IN_0;
  wire  sB_IO_6__D_IN_0;
  wire  sB_IO_7__D_IN_0;
  wire  sB_IO_8__D_IN_0;
  wire  sB_IO_9__D_IN_0;
  wire  sB_IO_10__D_IN_0;
  wire  sB_IO_11__D_IN_0;
  wire  sB_IO_12__D_IN_0;
  wire  sB_IO_13__D_IN_0;
  wire  sB_IO_14__D_IN_0;
  wire  sB_IO_15__D_IN_0;
  wire  sB_IO_16__D_IN_0;
  wire  sB_IO_17__D_IN_0;
  wire  sB_IO_18__D_IN_0;
  wire  sB_IO_19__D_IN_0;
  wire  sB_IO_20__D_IN_0;
  wire  sB_IO_21__D_IN_0;
  wire  sB_IO_22__D_IN_0;
  wire  sB_IO_23__D_IN_0;
  wire  sB_IO_24__D_IN_0;
  wire  _zz_78_;
  wire  clockCtrl_inputResetTrigger;
  reg  clockCtrl_resetUnbuffered;
  reg [7:0] clockCtrl_holdingLogic_resetCounter = (8'b00000000);
  reg  clockCtrl_resetRequest;
  reg  clockCtrl_systemReset;
  reg [7:0] _zz_1_;
  wire [7:0] _zz_2_;
  wire [7:0] _zz_3_;
  reg  clockCtrl_resetUnbuffered_regNext;
  wire [16:0] generator_PADDR;
  wire [0:0] generator_PSEL;
  wire  generator_PENABLE;
  wire  generator_PREADY;
  wire  generator_PWRITE;
  wire [31:0] generator_PWDATA;
  wire [31:0] generator_PRDATA;
  wire  generator_PSLVERROR;
  wire [0:0] _zz_4_;
  reg [1:0] _zz_5_;
  reg [3:0] _zz_6_;
  reg  system_cpu_cpu_debug_resetOut_regNext;
  reg  _zz_7_;
  reg [15:0] _zz_8_;
  wire [15:0] _zz_9_;
  wire  _zz_10_;
  wire  system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_valid;
  wire  system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_ready;
  wire  system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_last;
  wire [0:0] system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_opcode;
  wire [20:0] system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_address;
  wire [0:0] system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_length;
  wire [15:0] system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_data;
  wire [1:0] system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_mask;
  wire [4:0] system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_context;
  reg  _zz_11_;
  reg  _zz_12_;
  reg [0:0] _zz_13_;
  reg [20:0] _zz_14_;
  reg [0:0] _zz_15_;
  reg [15:0] _zz_16_;
  reg [1:0] _zz_17_;
  reg [4:0] _zz_18_;
  wire  generator;
  wire  generator_1_;
  wire  generator_2_;
  wire  generator_3_;
  wire  generator_4_;
  wire  generator_5_;
  wire  generator_6_;
  wire  generator_7_;
  assign _zz_78_ = (clockCtrl_holdingLogic_resetCounter != (8'b11111111));
  blackice_mx_pll pll ( 
    .clock_in(clk_25M),
    .clock_out(pll_clock_out),
    .sdram_clock_out(pll_sdram_clock_out),
    .locked(pll_locked) 
  );
  BufferCC_3_ bufferCC_4_ ( 
    .io_dataIn(clockCtrl_resetRequest),
    .io_dataOut(bufferCC_4__io_dataOut),
    .clock_out(pll_clock_out) 
  );
  Apb3UartCtrl system_uartA ( 
    .io_apb_PADDR(_zz_19_),
    .io_apb_PSEL(apb3Router_1__io_outputs_0_PSEL),
    .io_apb_PENABLE(apb3Router_1__io_outputs_0_PENABLE),
    .io_apb_PREADY(system_uartA_io_apb_PREADY),
    .io_apb_PWRITE(apb3Router_1__io_outputs_0_PWRITE),
    .io_apb_PWDATA(apb3Router_1__io_outputs_0_PWDATA),
    .io_apb_PRDATA(system_uartA_io_apb_PRDATA),
    .io_uart_txd(system_uartA_io_uart_txd),
    .io_uart_rxd(system_uartA_uart_rxd),
    .io_interrupt(system_uartA_io_interrupt),
    .clock_out(pll_clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  Apb3Gpio2 system_gpioA ( 
    .io_gpio_read(_zz_1_),
    .io_gpio_write(system_gpioA_io_gpio_write),
    .io_gpio_writeEnable(system_gpioA_io_gpio_writeEnable),
    .io_bus_PADDR(_zz_20_),
    .io_bus_PSEL(apb3Router_1__io_outputs_1_PSEL),
    .io_bus_PENABLE(apb3Router_1__io_outputs_1_PENABLE),
    .io_bus_PREADY(system_gpioA_io_bus_PREADY),
    .io_bus_PWRITE(apb3Router_1__io_outputs_1_PWRITE),
    .io_bus_PWDATA(apb3Router_1__io_outputs_1_PWDATA),
    .io_bus_PRDATA(system_gpioA_io_bus_PRDATA),
    .io_bus_PSLVERROR(system_gpioA_io_bus_PSLVERROR),
    .io_interrupt(system_gpioA_io_interrupt),
    .clock_out(pll_clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  VexRiscv system_cpu_cpu ( 
    .iBus_cmd_valid(system_cpu_cpu_iBus_cmd_valid),
    .iBus_cmd_ready(system_cpu_iBus_decoder_io_input_cmd_ready),
    .iBus_cmd_payload_pc(system_cpu_cpu_iBus_cmd_payload_pc),
    .iBus_rsp_valid(system_cpu_iBus_decoder_io_input_rsp_valid),
    .iBus_rsp_payload_error(_zz_21_),
    .iBus_rsp_payload_inst(system_cpu_iBus_decoder_io_input_rsp_payload_fragment_data),
    .debug_bus_cmd_valid(systemDebugger_1__io_mem_cmd_valid),
    .debug_bus_cmd_ready(system_cpu_cpu_debug_bus_cmd_ready),
    .debug_bus_cmd_payload_wr(systemDebugger_1__io_mem_cmd_payload_wr),
    .debug_bus_cmd_payload_address(_zz_22_),
    .debug_bus_cmd_payload_data(systemDebugger_1__io_mem_cmd_payload_data),
    .debug_bus_rsp_data(system_cpu_cpu_debug_bus_rsp_data),
    .debug_resetOut(system_cpu_cpu_debug_resetOut),
    .dBus_cmd_valid(system_cpu_cpu_dBus_cmd_valid),
    .dBus_cmd_ready(system_cpu_dBus_decoder_io_input_cmd_ready),
    .dBus_cmd_payload_wr(system_cpu_cpu_dBus_cmd_payload_wr),
    .dBus_cmd_payload_address(system_cpu_cpu_dBus_cmd_payload_address),
    .dBus_cmd_payload_data(system_cpu_cpu_dBus_cmd_payload_data),
    .dBus_cmd_payload_size(system_cpu_cpu_dBus_cmd_payload_size),
    .dBus_rsp_ready(_zz_23_),
    .dBus_rsp_error(_zz_24_),
    .dBus_rsp_data(system_cpu_dBus_decoder_io_input_rsp_payload_fragment_data),
    .clock_out(pll_clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset),
    .clockCtrl_resetUnbuffered_regNext(clockCtrl_resetUnbuffered_regNext) 
  );
  JtagBridge jtagBridge_1_ ( 
    .io_jtag_tms(system_cpu_tms),
    .io_jtag_tdi(system_cpu_tdi),
    .io_jtag_tdo(jtagBridge_1__io_jtag_tdo),
    .io_jtag_tck(system_cpu_tck),
    .io_remote_cmd_valid(jtagBridge_1__io_remote_cmd_valid),
    .io_remote_cmd_ready(systemDebugger_1__io_remote_cmd_ready),
    .io_remote_cmd_payload_last(jtagBridge_1__io_remote_cmd_payload_last),
    .io_remote_cmd_payload_fragment(jtagBridge_1__io_remote_cmd_payload_fragment),
    .io_remote_rsp_valid(systemDebugger_1__io_remote_rsp_valid),
    .io_remote_rsp_ready(jtagBridge_1__io_remote_rsp_ready),
    .io_remote_rsp_payload_error(systemDebugger_1__io_remote_rsp_payload_error),
    .io_remote_rsp_payload_data(systemDebugger_1__io_remote_rsp_payload_data),
    .clock_out(pll_clock_out),
    .clockCtrl_resetUnbuffered_regNext(clockCtrl_resetUnbuffered_regNext) 
  );
  SystemDebugger systemDebugger_1_ ( 
    .io_remote_cmd_valid(jtagBridge_1__io_remote_cmd_valid),
    .io_remote_cmd_ready(systemDebugger_1__io_remote_cmd_ready),
    .io_remote_cmd_payload_last(jtagBridge_1__io_remote_cmd_payload_last),
    .io_remote_cmd_payload_fragment(jtagBridge_1__io_remote_cmd_payload_fragment),
    .io_remote_rsp_valid(systemDebugger_1__io_remote_rsp_valid),
    .io_remote_rsp_ready(jtagBridge_1__io_remote_rsp_ready),
    .io_remote_rsp_payload_error(systemDebugger_1__io_remote_rsp_payload_error),
    .io_remote_rsp_payload_data(systemDebugger_1__io_remote_rsp_payload_data),
    .io_mem_cmd_valid(systemDebugger_1__io_mem_cmd_valid),
    .io_mem_cmd_ready(system_cpu_cpu_debug_bus_cmd_ready),
    .io_mem_cmd_payload_address(systemDebugger_1__io_mem_cmd_payload_address),
    .io_mem_cmd_payload_data(systemDebugger_1__io_mem_cmd_payload_data),
    .io_mem_cmd_payload_wr(systemDebugger_1__io_mem_cmd_payload_wr),
    .io_mem_cmd_payload_size(systemDebugger_1__io_mem_cmd_payload_size),
    .io_mem_rsp_valid(_zz_7_),
    .io_mem_rsp_payload(system_cpu_cpu_debug_bus_rsp_data),
    .clock_out(pll_clock_out),
    .clockCtrl_resetUnbuffered_regNext(clockCtrl_resetUnbuffered_regNext) 
  );
  BmbDecoder system_cpu_iBus_decoder ( 
    .io_input_cmd_valid(system_cpu_cpu_iBus_cmd_valid),
    .io_input_cmd_ready(system_cpu_iBus_decoder_io_input_cmd_ready),
    .io_input_cmd_payload_last(_zz_25_),
    .io_input_cmd_payload_fragment_opcode(_zz_26_),
    .io_input_cmd_payload_fragment_address(system_cpu_cpu_iBus_cmd_payload_pc),
    .io_input_cmd_payload_fragment_length(_zz_27_),
    .io_input_rsp_valid(system_cpu_iBus_decoder_io_input_rsp_valid),
    .io_input_rsp_ready(_zz_28_),
    .io_input_rsp_payload_last(system_cpu_iBus_decoder_io_input_rsp_payload_last),
    .io_input_rsp_payload_fragment_opcode(system_cpu_iBus_decoder_io_input_rsp_payload_fragment_opcode),
    .io_input_rsp_payload_fragment_data(system_cpu_iBus_decoder_io_input_rsp_payload_fragment_data),
    .io_outputs_0_cmd_valid(system_cpu_iBus_decoder_io_outputs_0_cmd_valid),
    .io_outputs_0_cmd_ready(system_ramA_bmb_arbiter_io_inputs_1_cmd_ready),
    .io_outputs_0_cmd_payload_last(system_cpu_iBus_decoder_io_outputs_0_cmd_payload_last),
    .io_outputs_0_cmd_payload_fragment_opcode(system_cpu_iBus_decoder_io_outputs_0_cmd_payload_fragment_opcode),
    .io_outputs_0_cmd_payload_fragment_address(system_cpu_iBus_decoder_io_outputs_0_cmd_payload_fragment_address),
    .io_outputs_0_cmd_payload_fragment_length(system_cpu_iBus_decoder_io_outputs_0_cmd_payload_fragment_length),
    .io_outputs_0_rsp_valid(system_ramA_bmb_arbiter_io_inputs_1_rsp_valid),
    .io_outputs_0_rsp_ready(system_cpu_iBus_decoder_io_outputs_0_rsp_ready),
    .io_outputs_0_rsp_payload_last(system_ramA_bmb_arbiter_io_inputs_1_rsp_payload_last),
    .io_outputs_0_rsp_payload_fragment_opcode(system_ramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_opcode),
    .io_outputs_0_rsp_payload_fragment_data(system_ramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_data),
    .io_outputs_1_cmd_valid(system_cpu_iBus_decoder_io_outputs_1_cmd_valid),
    .io_outputs_1_cmd_ready(system_sdramA_bmb_arbiter_io_inputs_1_cmd_ready),
    .io_outputs_1_cmd_payload_last(system_cpu_iBus_decoder_io_outputs_1_cmd_payload_last),
    .io_outputs_1_cmd_payload_fragment_opcode(system_cpu_iBus_decoder_io_outputs_1_cmd_payload_fragment_opcode),
    .io_outputs_1_cmd_payload_fragment_address(system_cpu_iBus_decoder_io_outputs_1_cmd_payload_fragment_address),
    .io_outputs_1_cmd_payload_fragment_length(system_cpu_iBus_decoder_io_outputs_1_cmd_payload_fragment_length),
    .io_outputs_1_rsp_valid(system_sdramA_bmb_arbiter_io_inputs_1_rsp_valid),
    .io_outputs_1_rsp_ready(system_cpu_iBus_decoder_io_outputs_1_rsp_ready),
    .io_outputs_1_rsp_payload_last(system_sdramA_bmb_arbiter_io_inputs_1_rsp_payload_last),
    .io_outputs_1_rsp_payload_fragment_opcode(system_sdramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_opcode),
    .io_outputs_1_rsp_payload_fragment_data(system_sdramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_data),
    .clock_out(pll_clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  BmbDecoder_1_ system_cpu_dBus_decoder ( 
    .io_input_cmd_valid(system_cpu_cpu_dBus_cmd_valid),
    .io_input_cmd_ready(system_cpu_dBus_decoder_io_input_cmd_ready),
    .io_input_cmd_payload_last(_zz_29_),
    .io_input_cmd_payload_fragment_opcode(_zz_30_),
    .io_input_cmd_payload_fragment_address(system_cpu_cpu_dBus_cmd_payload_address),
    .io_input_cmd_payload_fragment_length(_zz_5_),
    .io_input_cmd_payload_fragment_data(system_cpu_cpu_dBus_cmd_payload_data),
    .io_input_cmd_payload_fragment_mask(_zz_31_),
    .io_input_cmd_payload_fragment_context(_zz_4_),
    .io_input_rsp_valid(system_cpu_dBus_decoder_io_input_rsp_valid),
    .io_input_rsp_ready(_zz_32_),
    .io_input_rsp_payload_last(system_cpu_dBus_decoder_io_input_rsp_payload_last),
    .io_input_rsp_payload_fragment_opcode(system_cpu_dBus_decoder_io_input_rsp_payload_fragment_opcode),
    .io_input_rsp_payload_fragment_data(system_cpu_dBus_decoder_io_input_rsp_payload_fragment_data),
    .io_input_rsp_payload_fragment_context(system_cpu_dBus_decoder_io_input_rsp_payload_fragment_context),
    .io_outputs_0_cmd_valid(system_cpu_dBus_decoder_io_outputs_0_cmd_valid),
    .io_outputs_0_cmd_ready(system_ramA_bmb_arbiter_io_inputs_0_cmd_ready),
    .io_outputs_0_cmd_payload_last(system_cpu_dBus_decoder_io_outputs_0_cmd_payload_last),
    .io_outputs_0_cmd_payload_fragment_opcode(system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_opcode),
    .io_outputs_0_cmd_payload_fragment_address(system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_address),
    .io_outputs_0_cmd_payload_fragment_length(system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_length),
    .io_outputs_0_cmd_payload_fragment_data(system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_data),
    .io_outputs_0_cmd_payload_fragment_mask(system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_mask),
    .io_outputs_0_cmd_payload_fragment_context(system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_context),
    .io_outputs_0_rsp_valid(system_ramA_bmb_arbiter_io_inputs_0_rsp_valid),
    .io_outputs_0_rsp_ready(system_cpu_dBus_decoder_io_outputs_0_rsp_ready),
    .io_outputs_0_rsp_payload_last(system_ramA_bmb_arbiter_io_inputs_0_rsp_payload_last),
    .io_outputs_0_rsp_payload_fragment_opcode(system_ramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_opcode),
    .io_outputs_0_rsp_payload_fragment_data(system_ramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_data),
    .io_outputs_0_rsp_payload_fragment_context(system_ramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_context),
    .io_outputs_1_cmd_valid(system_cpu_dBus_decoder_io_outputs_1_cmd_valid),
    .io_outputs_1_cmd_ready(system_sdramA_bmb_arbiter_io_inputs_0_cmd_ready),
    .io_outputs_1_cmd_payload_last(system_cpu_dBus_decoder_io_outputs_1_cmd_payload_last),
    .io_outputs_1_cmd_payload_fragment_opcode(system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_opcode),
    .io_outputs_1_cmd_payload_fragment_address(system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_address),
    .io_outputs_1_cmd_payload_fragment_length(system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_length),
    .io_outputs_1_cmd_payload_fragment_data(system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_data),
    .io_outputs_1_cmd_payload_fragment_mask(system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_mask),
    .io_outputs_1_cmd_payload_fragment_context(system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_context),
    .io_outputs_1_rsp_valid(system_sdramA_bmb_arbiter_io_inputs_0_rsp_valid),
    .io_outputs_1_rsp_ready(system_cpu_dBus_decoder_io_outputs_1_rsp_ready),
    .io_outputs_1_rsp_payload_last(system_sdramA_bmb_arbiter_io_inputs_0_rsp_payload_last),
    .io_outputs_1_rsp_payload_fragment_opcode(system_sdramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_opcode),
    .io_outputs_1_rsp_payload_fragment_data(system_sdramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_data),
    .io_outputs_1_rsp_payload_fragment_context(system_sdramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_context),
    .io_outputs_2_cmd_valid(system_cpu_dBus_decoder_io_outputs_2_cmd_valid),
    .io_outputs_2_cmd_ready(system_peripheralBridge_input_arbiter_io_inputs_0_cmd_ready),
    .io_outputs_2_cmd_payload_last(system_cpu_dBus_decoder_io_outputs_2_cmd_payload_last),
    .io_outputs_2_cmd_payload_fragment_opcode(system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_opcode),
    .io_outputs_2_cmd_payload_fragment_address(system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_address),
    .io_outputs_2_cmd_payload_fragment_length(system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_length),
    .io_outputs_2_cmd_payload_fragment_data(system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_data),
    .io_outputs_2_cmd_payload_fragment_mask(system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_mask),
    .io_outputs_2_cmd_payload_fragment_context(system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_context),
    .io_outputs_2_rsp_valid(system_peripheralBridge_input_arbiter_io_inputs_0_rsp_valid),
    .io_outputs_2_rsp_ready(system_cpu_dBus_decoder_io_outputs_2_rsp_ready),
    .io_outputs_2_rsp_payload_last(system_peripheralBridge_input_arbiter_io_inputs_0_rsp_payload_last),
    .io_outputs_2_rsp_payload_fragment_opcode(system_peripheralBridge_input_arbiter_io_inputs_0_rsp_payload_fragment_opcode),
    .io_outputs_2_rsp_payload_fragment_data(system_peripheralBridge_input_arbiter_io_inputs_0_rsp_payload_fragment_data),
    .io_outputs_2_rsp_payload_fragment_context(system_peripheralBridge_input_arbiter_io_inputs_0_rsp_payload_fragment_context),
    .clock_out(pll_clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  BmbOnChipRam system_ramA ( 
    .io_bus_cmd_valid(system_ramA_bmb_arbiter_io_output_cmd_valid),
    .io_bus_cmd_ready(system_ramA_io_bus_cmd_ready),
    .io_bus_cmd_payload_last(system_ramA_bmb_arbiter_io_output_cmd_payload_last),
    .io_bus_cmd_payload_fragment_source(system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_source),
    .io_bus_cmd_payload_fragment_opcode(system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_opcode),
    .io_bus_cmd_payload_fragment_address(system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address),
    .io_bus_cmd_payload_fragment_length(system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_length),
    .io_bus_cmd_payload_fragment_data(system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_data),
    .io_bus_cmd_payload_fragment_mask(system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_mask),
    .io_bus_cmd_payload_fragment_context(system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_context),
    .io_bus_rsp_valid(system_ramA_io_bus_rsp_valid),
    .io_bus_rsp_ready(system_ramA_bmb_arbiter_io_output_rsp_ready),
    .io_bus_rsp_payload_last(system_ramA_io_bus_rsp_payload_last),
    .io_bus_rsp_payload_fragment_source(system_ramA_io_bus_rsp_payload_fragment_source),
    .io_bus_rsp_payload_fragment_opcode(system_ramA_io_bus_rsp_payload_fragment_opcode),
    .io_bus_rsp_payload_fragment_data(system_ramA_io_bus_rsp_payload_fragment_data),
    .io_bus_rsp_payload_fragment_context(system_ramA_io_bus_rsp_payload_fragment_context),
    .clock_out(pll_clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  BmbArbiter system_ramA_bmb_arbiter ( 
    .io_inputs_0_cmd_valid(system_cpu_dBus_decoder_io_outputs_0_cmd_valid),
    .io_inputs_0_cmd_ready(system_ramA_bmb_arbiter_io_inputs_0_cmd_ready),
    .io_inputs_0_cmd_payload_last(system_cpu_dBus_decoder_io_outputs_0_cmd_payload_last),
    .io_inputs_0_cmd_payload_fragment_opcode(system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_opcode),
    .io_inputs_0_cmd_payload_fragment_address(_zz_33_),
    .io_inputs_0_cmd_payload_fragment_length(system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_length),
    .io_inputs_0_cmd_payload_fragment_data(system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_data),
    .io_inputs_0_cmd_payload_fragment_mask(system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_mask),
    .io_inputs_0_cmd_payload_fragment_context(system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_context),
    .io_inputs_0_rsp_valid(system_ramA_bmb_arbiter_io_inputs_0_rsp_valid),
    .io_inputs_0_rsp_ready(system_cpu_dBus_decoder_io_outputs_0_rsp_ready),
    .io_inputs_0_rsp_payload_last(system_ramA_bmb_arbiter_io_inputs_0_rsp_payload_last),
    .io_inputs_0_rsp_payload_fragment_opcode(system_ramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_opcode),
    .io_inputs_0_rsp_payload_fragment_data(system_ramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_data),
    .io_inputs_0_rsp_payload_fragment_context(system_ramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_context),
    .io_inputs_1_cmd_valid(system_cpu_iBus_decoder_io_outputs_0_cmd_valid),
    .io_inputs_1_cmd_ready(system_ramA_bmb_arbiter_io_inputs_1_cmd_ready),
    .io_inputs_1_cmd_payload_last(system_cpu_iBus_decoder_io_outputs_0_cmd_payload_last),
    .io_inputs_1_cmd_payload_fragment_opcode(system_cpu_iBus_decoder_io_outputs_0_cmd_payload_fragment_opcode),
    .io_inputs_1_cmd_payload_fragment_address(_zz_34_),
    .io_inputs_1_cmd_payload_fragment_length(system_cpu_iBus_decoder_io_outputs_0_cmd_payload_fragment_length),
    .io_inputs_1_cmd_payload_fragment_data(_zz_35_),
    .io_inputs_1_cmd_payload_fragment_mask(_zz_36_),
    .io_inputs_1_cmd_payload_fragment_context(_zz_37_),
    .io_inputs_1_rsp_valid(system_ramA_bmb_arbiter_io_inputs_1_rsp_valid),
    .io_inputs_1_rsp_ready(system_cpu_iBus_decoder_io_outputs_0_rsp_ready),
    .io_inputs_1_rsp_payload_last(system_ramA_bmb_arbiter_io_inputs_1_rsp_payload_last),
    .io_inputs_1_rsp_payload_fragment_opcode(system_ramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_opcode),
    .io_inputs_1_rsp_payload_fragment_data(system_ramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_data),
    .io_inputs_1_rsp_payload_fragment_context(system_ramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_context),
    .io_output_cmd_valid(system_ramA_bmb_arbiter_io_output_cmd_valid),
    .io_output_cmd_ready(system_ramA_io_bus_cmd_ready),
    .io_output_cmd_payload_last(system_ramA_bmb_arbiter_io_output_cmd_payload_last),
    .io_output_cmd_payload_fragment_source(system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_source),
    .io_output_cmd_payload_fragment_opcode(system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_opcode),
    .io_output_cmd_payload_fragment_address(system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_address),
    .io_output_cmd_payload_fragment_length(system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_length),
    .io_output_cmd_payload_fragment_data(system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_data),
    .io_output_cmd_payload_fragment_mask(system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_mask),
    .io_output_cmd_payload_fragment_context(system_ramA_bmb_arbiter_io_output_cmd_payload_fragment_context),
    .io_output_rsp_valid(system_ramA_io_bus_rsp_valid),
    .io_output_rsp_ready(system_ramA_bmb_arbiter_io_output_rsp_ready),
    .io_output_rsp_payload_last(system_ramA_io_bus_rsp_payload_last),
    .io_output_rsp_payload_fragment_source(system_ramA_io_bus_rsp_payload_fragment_source),
    .io_output_rsp_payload_fragment_opcode(system_ramA_io_bus_rsp_payload_fragment_opcode),
    .io_output_rsp_payload_fragment_data(system_ramA_io_bus_rsp_payload_fragment_data),
    .io_output_rsp_payload_fragment_context(system_ramA_io_bus_rsp_payload_fragment_context),
    .clock_out(pll_clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  BmbSdramCtrl system_sdramA ( 
    .io_bmb_cmd_valid(system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_valid),
    .io_bmb_cmd_ready(system_sdramA_io_bmb_cmd_ready),
    .io_bmb_cmd_payload_last(system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_last),
    .io_bmb_cmd_payload_fragment_opcode(system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_opcode),
    .io_bmb_cmd_payload_fragment_address(system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_address),
    .io_bmb_cmd_payload_fragment_length(system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_length),
    .io_bmb_cmd_payload_fragment_data(system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_data),
    .io_bmb_cmd_payload_fragment_mask(system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_mask),
    .io_bmb_cmd_payload_fragment_context(system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_context),
    .io_bmb_rsp_valid(system_sdramA_io_bmb_rsp_valid),
    .io_bmb_rsp_ready(system_sdramA_bmb_burstUnburstifier_io_output_rsp_ready),
    .io_bmb_rsp_payload_last(system_sdramA_io_bmb_rsp_payload_last),
    .io_bmb_rsp_payload_fragment_opcode(system_sdramA_io_bmb_rsp_payload_fragment_opcode),
    .io_bmb_rsp_payload_fragment_data(system_sdramA_io_bmb_rsp_payload_fragment_data),
    .io_bmb_rsp_payload_fragment_context(system_sdramA_io_bmb_rsp_payload_fragment_context),
    .io_sdram_ADDR(system_sdramA_io_sdram_ADDR),
    .io_sdram_BA(system_sdramA_io_sdram_BA),
    .io_sdram_DQ_read(_zz_8_),
    .io_sdram_DQ_write(system_sdramA_io_sdram_DQ_write),
    .io_sdram_DQ_writeEnable(system_sdramA_io_sdram_DQ_writeEnable),
    .io_sdram_DQM(system_sdramA_io_sdram_DQM),
    .io_sdram_CASn(system_sdramA_io_sdram_CASn),
    .io_sdram_CKE(system_sdramA_io_sdram_CKE),
    .io_sdram_CSn(system_sdramA_io_sdram_CSn),
    .io_sdram_RASn(system_sdramA_io_sdram_RASn),
    .io_sdram_WEn(system_sdramA_io_sdram_WEn),
    .clock_out(pll_clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  BmbArbiter_1_ system_sdramA_bmb_arbiter ( 
    .io_inputs_0_cmd_valid(system_cpu_dBus_decoder_io_outputs_1_cmd_valid),
    .io_inputs_0_cmd_ready(system_sdramA_bmb_arbiter_io_inputs_0_cmd_ready),
    .io_inputs_0_cmd_payload_last(system_cpu_dBus_decoder_io_outputs_1_cmd_payload_last),
    .io_inputs_0_cmd_payload_fragment_opcode(system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_opcode),
    .io_inputs_0_cmd_payload_fragment_address(_zz_38_),
    .io_inputs_0_cmd_payload_fragment_length(system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_length),
    .io_inputs_0_cmd_payload_fragment_data(system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_data),
    .io_inputs_0_cmd_payload_fragment_mask(system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_mask),
    .io_inputs_0_cmd_payload_fragment_context(system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_context),
    .io_inputs_0_rsp_valid(system_sdramA_bmb_arbiter_io_inputs_0_rsp_valid),
    .io_inputs_0_rsp_ready(system_cpu_dBus_decoder_io_outputs_1_rsp_ready),
    .io_inputs_0_rsp_payload_last(system_sdramA_bmb_arbiter_io_inputs_0_rsp_payload_last),
    .io_inputs_0_rsp_payload_fragment_opcode(system_sdramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_opcode),
    .io_inputs_0_rsp_payload_fragment_data(system_sdramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_data),
    .io_inputs_0_rsp_payload_fragment_context(system_sdramA_bmb_arbiter_io_inputs_0_rsp_payload_fragment_context),
    .io_inputs_1_cmd_valid(system_cpu_iBus_decoder_io_outputs_1_cmd_valid),
    .io_inputs_1_cmd_ready(system_sdramA_bmb_arbiter_io_inputs_1_cmd_ready),
    .io_inputs_1_cmd_payload_last(system_cpu_iBus_decoder_io_outputs_1_cmd_payload_last),
    .io_inputs_1_cmd_payload_fragment_opcode(system_cpu_iBus_decoder_io_outputs_1_cmd_payload_fragment_opcode),
    .io_inputs_1_cmd_payload_fragment_address(_zz_39_),
    .io_inputs_1_cmd_payload_fragment_length(system_cpu_iBus_decoder_io_outputs_1_cmd_payload_fragment_length),
    .io_inputs_1_cmd_payload_fragment_data(_zz_40_),
    .io_inputs_1_cmd_payload_fragment_mask(_zz_41_),
    .io_inputs_1_cmd_payload_fragment_context(_zz_42_),
    .io_inputs_1_rsp_valid(system_sdramA_bmb_arbiter_io_inputs_1_rsp_valid),
    .io_inputs_1_rsp_ready(system_cpu_iBus_decoder_io_outputs_1_rsp_ready),
    .io_inputs_1_rsp_payload_last(system_sdramA_bmb_arbiter_io_inputs_1_rsp_payload_last),
    .io_inputs_1_rsp_payload_fragment_opcode(system_sdramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_opcode),
    .io_inputs_1_rsp_payload_fragment_data(system_sdramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_data),
    .io_inputs_1_rsp_payload_fragment_context(system_sdramA_bmb_arbiter_io_inputs_1_rsp_payload_fragment_context),
    .io_output_cmd_valid(system_sdramA_bmb_arbiter_io_output_cmd_valid),
    .io_output_cmd_ready(system_sdramA_bmb_downSizer_io_input_cmd_ready),
    .io_output_cmd_payload_last(system_sdramA_bmb_arbiter_io_output_cmd_payload_last),
    .io_output_cmd_payload_fragment_source(system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_source),
    .io_output_cmd_payload_fragment_opcode(system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_opcode),
    .io_output_cmd_payload_fragment_address(system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_address),
    .io_output_cmd_payload_fragment_length(system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_length),
    .io_output_cmd_payload_fragment_data(system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_data),
    .io_output_cmd_payload_fragment_mask(system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_mask),
    .io_output_cmd_payload_fragment_context(system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_context),
    .io_output_rsp_valid(system_sdramA_bmb_downSizer_io_input_rsp_valid),
    .io_output_rsp_ready(system_sdramA_bmb_arbiter_io_output_rsp_ready),
    .io_output_rsp_payload_last(system_sdramA_bmb_downSizer_io_input_rsp_payload_last),
    .io_output_rsp_payload_fragment_source(system_sdramA_bmb_downSizer_io_input_rsp_payload_fragment_source),
    .io_output_rsp_payload_fragment_opcode(system_sdramA_bmb_downSizer_io_input_rsp_payload_fragment_opcode),
    .io_output_rsp_payload_fragment_data(system_sdramA_bmb_downSizer_io_input_rsp_payload_fragment_data),
    .io_output_rsp_payload_fragment_context(system_sdramA_bmb_downSizer_io_input_rsp_payload_fragment_context),
    .clock_out(pll_clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  BmbDownSizerBridge system_sdramA_bmb_downSizer ( 
    .io_input_cmd_valid(system_sdramA_bmb_arbiter_io_output_cmd_valid),
    .io_input_cmd_ready(system_sdramA_bmb_downSizer_io_input_cmd_ready),
    .io_input_cmd_payload_last(system_sdramA_bmb_arbiter_io_output_cmd_payload_last),
    .io_input_cmd_payload_fragment_source(system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_source),
    .io_input_cmd_payload_fragment_opcode(system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_opcode),
    .io_input_cmd_payload_fragment_address(system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_address),
    .io_input_cmd_payload_fragment_length(system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_length),
    .io_input_cmd_payload_fragment_data(system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_data),
    .io_input_cmd_payload_fragment_mask(system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_mask),
    .io_input_cmd_payload_fragment_context(system_sdramA_bmb_arbiter_io_output_cmd_payload_fragment_context),
    .io_input_rsp_valid(system_sdramA_bmb_downSizer_io_input_rsp_valid),
    .io_input_rsp_ready(system_sdramA_bmb_arbiter_io_output_rsp_ready),
    .io_input_rsp_payload_last(system_sdramA_bmb_downSizer_io_input_rsp_payload_last),
    .io_input_rsp_payload_fragment_source(system_sdramA_bmb_downSizer_io_input_rsp_payload_fragment_source),
    .io_input_rsp_payload_fragment_opcode(system_sdramA_bmb_downSizer_io_input_rsp_payload_fragment_opcode),
    .io_input_rsp_payload_fragment_data(system_sdramA_bmb_downSizer_io_input_rsp_payload_fragment_data),
    .io_input_rsp_payload_fragment_context(system_sdramA_bmb_downSizer_io_input_rsp_payload_fragment_context),
    .io_output_cmd_valid(system_sdramA_bmb_downSizer_io_output_cmd_valid),
    .io_output_cmd_ready(system_sdramA_bmb_burstUnburstifier_io_input_cmd_ready),
    .io_output_cmd_payload_last(system_sdramA_bmb_downSizer_io_output_cmd_payload_last),
    .io_output_cmd_payload_fragment_opcode(system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_opcode),
    .io_output_cmd_payload_fragment_address(system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_address),
    .io_output_cmd_payload_fragment_length(system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_length),
    .io_output_cmd_payload_fragment_data(system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_data),
    .io_output_cmd_payload_fragment_mask(system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_mask),
    .io_output_cmd_payload_fragment_context(system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_context),
    .io_output_rsp_valid(system_sdramA_bmb_burstUnburstifier_io_input_rsp_valid),
    .io_output_rsp_ready(system_sdramA_bmb_downSizer_io_output_rsp_ready),
    .io_output_rsp_payload_last(system_sdramA_bmb_burstUnburstifier_io_input_rsp_payload_last),
    .io_output_rsp_payload_fragment_opcode(system_sdramA_bmb_burstUnburstifier_io_input_rsp_payload_fragment_opcode),
    .io_output_rsp_payload_fragment_data(system_sdramA_bmb_burstUnburstifier_io_input_rsp_payload_fragment_data),
    .io_output_rsp_payload_fragment_context(system_sdramA_bmb_burstUnburstifier_io_input_rsp_payload_fragment_context),
    .clock_out(pll_clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  BmbUnburstify system_sdramA_bmb_burstUnburstifier ( 
    .io_input_cmd_valid(system_sdramA_bmb_downSizer_io_output_cmd_valid),
    .io_input_cmd_ready(system_sdramA_bmb_burstUnburstifier_io_input_cmd_ready),
    .io_input_cmd_payload_last(system_sdramA_bmb_downSizer_io_output_cmd_payload_last),
    .io_input_cmd_payload_fragment_opcode(system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_opcode),
    .io_input_cmd_payload_fragment_address(system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_address),
    .io_input_cmd_payload_fragment_length(system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_length),
    .io_input_cmd_payload_fragment_data(system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_data),
    .io_input_cmd_payload_fragment_mask(system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_mask),
    .io_input_cmd_payload_fragment_context(system_sdramA_bmb_downSizer_io_output_cmd_payload_fragment_context),
    .io_input_rsp_valid(system_sdramA_bmb_burstUnburstifier_io_input_rsp_valid),
    .io_input_rsp_ready(system_sdramA_bmb_downSizer_io_output_rsp_ready),
    .io_input_rsp_payload_last(system_sdramA_bmb_burstUnburstifier_io_input_rsp_payload_last),
    .io_input_rsp_payload_fragment_opcode(system_sdramA_bmb_burstUnburstifier_io_input_rsp_payload_fragment_opcode),
    .io_input_rsp_payload_fragment_data(system_sdramA_bmb_burstUnburstifier_io_input_rsp_payload_fragment_data),
    .io_input_rsp_payload_fragment_context(system_sdramA_bmb_burstUnburstifier_io_input_rsp_payload_fragment_context),
    .io_output_cmd_valid(system_sdramA_bmb_burstUnburstifier_io_output_cmd_valid),
    .io_output_cmd_ready(_zz_43_),
    .io_output_cmd_payload_last(system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_last),
    .io_output_cmd_payload_fragment_opcode(system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_opcode),
    .io_output_cmd_payload_fragment_address(system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_address),
    .io_output_cmd_payload_fragment_length(system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_length),
    .io_output_cmd_payload_fragment_data(system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_data),
    .io_output_cmd_payload_fragment_mask(system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_mask),
    .io_output_cmd_payload_fragment_context(system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_context),
    .io_output_rsp_valid(system_sdramA_io_bmb_rsp_valid),
    .io_output_rsp_ready(system_sdramA_bmb_burstUnburstifier_io_output_rsp_ready),
    .io_output_rsp_payload_last(system_sdramA_io_bmb_rsp_payload_last),
    .io_output_rsp_payload_fragment_opcode(system_sdramA_io_bmb_rsp_payload_fragment_opcode),
    .io_output_rsp_payload_fragment_data(system_sdramA_io_bmb_rsp_payload_fragment_data),
    .io_output_rsp_payload_fragment_context(system_sdramA_io_bmb_rsp_payload_fragment_context),
    .clock_out(pll_clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  Apb3Decoder generator_decoder ( 
    .io_input_PADDR(generator_PADDR),
    .io_input_PSEL(generator_PSEL),
    .io_input_PENABLE(generator_PENABLE),
    .io_input_PREADY(generator_decoder_io_input_PREADY),
    .io_input_PWRITE(generator_PWRITE),
    .io_input_PWDATA(generator_PWDATA),
    .io_input_PRDATA(generator_decoder_io_input_PRDATA),
    .io_input_PSLVERROR(generator_decoder_io_input_PSLVERROR),
    .io_output_PADDR(generator_decoder_io_output_PADDR),
    .io_output_PSEL(generator_decoder_io_output_PSEL),
    .io_output_PENABLE(generator_decoder_io_output_PENABLE),
    .io_output_PREADY(apb3Router_1__io_input_PREADY),
    .io_output_PWRITE(generator_decoder_io_output_PWRITE),
    .io_output_PWDATA(generator_decoder_io_output_PWDATA),
    .io_output_PRDATA(apb3Router_1__io_input_PRDATA),
    .io_output_PSLVERROR(apb3Router_1__io_input_PSLVERROR) 
  );
  Apb3Router apb3Router_1_ ( 
    .io_input_PADDR(generator_decoder_io_output_PADDR),
    .io_input_PSEL(generator_decoder_io_output_PSEL),
    .io_input_PENABLE(generator_decoder_io_output_PENABLE),
    .io_input_PREADY(apb3Router_1__io_input_PREADY),
    .io_input_PWRITE(generator_decoder_io_output_PWRITE),
    .io_input_PWDATA(generator_decoder_io_output_PWDATA),
    .io_input_PRDATA(apb3Router_1__io_input_PRDATA),
    .io_input_PSLVERROR(apb3Router_1__io_input_PSLVERROR),
    .io_outputs_0_PADDR(apb3Router_1__io_outputs_0_PADDR),
    .io_outputs_0_PSEL(apb3Router_1__io_outputs_0_PSEL),
    .io_outputs_0_PENABLE(apb3Router_1__io_outputs_0_PENABLE),
    .io_outputs_0_PREADY(system_uartA_io_apb_PREADY),
    .io_outputs_0_PWRITE(apb3Router_1__io_outputs_0_PWRITE),
    .io_outputs_0_PWDATA(apb3Router_1__io_outputs_0_PWDATA),
    .io_outputs_0_PRDATA(system_uartA_io_apb_PRDATA),
    .io_outputs_0_PSLVERROR(_zz_44_),
    .io_outputs_1_PADDR(apb3Router_1__io_outputs_1_PADDR),
    .io_outputs_1_PSEL(apb3Router_1__io_outputs_1_PSEL),
    .io_outputs_1_PENABLE(apb3Router_1__io_outputs_1_PENABLE),
    .io_outputs_1_PREADY(system_gpioA_io_bus_PREADY),
    .io_outputs_1_PWRITE(apb3Router_1__io_outputs_1_PWRITE),
    .io_outputs_1_PWDATA(apb3Router_1__io_outputs_1_PWDATA),
    .io_outputs_1_PRDATA(system_gpioA_io_bus_PRDATA),
    .io_outputs_1_PSLVERROR(system_gpioA_io_bus_PSLVERROR),
    .clock_out(pll_clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  BmbToApb3Bridge system_peripheralBridge_bridge ( 
    .io_input_cmd_valid(system_peripheralBridge_input_arbiter_io_output_cmd_valid),
    .io_input_cmd_ready(system_peripheralBridge_bridge_io_input_cmd_ready),
    .io_input_cmd_payload_last(system_peripheralBridge_input_arbiter_io_output_cmd_payload_last),
    .io_input_cmd_payload_fragment_opcode(system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_opcode),
    .io_input_cmd_payload_fragment_address(system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_address),
    .io_input_cmd_payload_fragment_length(system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_length),
    .io_input_cmd_payload_fragment_data(system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_data),
    .io_input_cmd_payload_fragment_mask(system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_mask),
    .io_input_cmd_payload_fragment_context(system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_context),
    .io_input_rsp_valid(system_peripheralBridge_bridge_io_input_rsp_valid),
    .io_input_rsp_ready(system_peripheralBridge_input_arbiter_io_output_rsp_ready),
    .io_input_rsp_payload_last(system_peripheralBridge_bridge_io_input_rsp_payload_last),
    .io_input_rsp_payload_fragment_opcode(system_peripheralBridge_bridge_io_input_rsp_payload_fragment_opcode),
    .io_input_rsp_payload_fragment_data(system_peripheralBridge_bridge_io_input_rsp_payload_fragment_data),
    .io_input_rsp_payload_fragment_context(system_peripheralBridge_bridge_io_input_rsp_payload_fragment_context),
    .io_output_PADDR(system_peripheralBridge_bridge_io_output_PADDR),
    .io_output_PSEL(system_peripheralBridge_bridge_io_output_PSEL),
    .io_output_PENABLE(system_peripheralBridge_bridge_io_output_PENABLE),
    .io_output_PREADY(generator_PREADY),
    .io_output_PWRITE(system_peripheralBridge_bridge_io_output_PWRITE),
    .io_output_PWDATA(system_peripheralBridge_bridge_io_output_PWDATA),
    .io_output_PRDATA(generator_PRDATA),
    .io_output_PSLVERROR(generator_PSLVERROR),
    .clock_out(pll_clock_out),
    .clockCtrl_systemReset(clockCtrl_systemReset) 
  );
  BmbArbiter_2_ system_peripheralBridge_input_arbiter ( 
    .io_inputs_0_cmd_valid(system_cpu_dBus_decoder_io_outputs_2_cmd_valid),
    .io_inputs_0_cmd_ready(system_peripheralBridge_input_arbiter_io_inputs_0_cmd_ready),
    .io_inputs_0_cmd_payload_last(system_cpu_dBus_decoder_io_outputs_2_cmd_payload_last),
    .io_inputs_0_cmd_payload_fragment_opcode(system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_opcode),
    .io_inputs_0_cmd_payload_fragment_address(_zz_45_),
    .io_inputs_0_cmd_payload_fragment_length(system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_length),
    .io_inputs_0_cmd_payload_fragment_data(system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_data),
    .io_inputs_0_cmd_payload_fragment_mask(system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_mask),
    .io_inputs_0_cmd_payload_fragment_context(system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_context),
    .io_inputs_0_rsp_valid(system_peripheralBridge_input_arbiter_io_inputs_0_rsp_valid),
    .io_inputs_0_rsp_ready(system_cpu_dBus_decoder_io_outputs_2_rsp_ready),
    .io_inputs_0_rsp_payload_last(system_peripheralBridge_input_arbiter_io_inputs_0_rsp_payload_last),
    .io_inputs_0_rsp_payload_fragment_opcode(system_peripheralBridge_input_arbiter_io_inputs_0_rsp_payload_fragment_opcode),
    .io_inputs_0_rsp_payload_fragment_data(system_peripheralBridge_input_arbiter_io_inputs_0_rsp_payload_fragment_data),
    .io_inputs_0_rsp_payload_fragment_context(system_peripheralBridge_input_arbiter_io_inputs_0_rsp_payload_fragment_context),
    .io_output_cmd_valid(system_peripheralBridge_input_arbiter_io_output_cmd_valid),
    .io_output_cmd_ready(system_peripheralBridge_bridge_io_input_cmd_ready),
    .io_output_cmd_payload_last(system_peripheralBridge_input_arbiter_io_output_cmd_payload_last),
    .io_output_cmd_payload_fragment_opcode(system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_opcode),
    .io_output_cmd_payload_fragment_address(system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_address),
    .io_output_cmd_payload_fragment_length(system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_length),
    .io_output_cmd_payload_fragment_data(system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_data),
    .io_output_cmd_payload_fragment_mask(system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_mask),
    .io_output_cmd_payload_fragment_context(system_peripheralBridge_input_arbiter_io_output_cmd_payload_fragment_context),
    .io_output_rsp_valid(system_peripheralBridge_bridge_io_input_rsp_valid),
    .io_output_rsp_ready(system_peripheralBridge_input_arbiter_io_output_rsp_ready),
    .io_output_rsp_payload_last(system_peripheralBridge_bridge_io_input_rsp_payload_last),
    .io_output_rsp_payload_fragment_opcode(system_peripheralBridge_bridge_io_input_rsp_payload_fragment_opcode),
    .io_output_rsp_payload_fragment_data(system_peripheralBridge_bridge_io_input_rsp_payload_fragment_data),
    .io_output_rsp_payload_fragment_context(system_peripheralBridge_bridge_io_input_rsp_payload_fragment_context) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_1_ ( 
    .PACKAGE_PIN(system_gpioA_gpio_0),
    .OUTPUT_ENABLE(_zz_46_),
    .D_OUT_0(_zz_47_),
    .D_IN_0(sB_IO_1__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_2_ ( 
    .PACKAGE_PIN(system_gpioA_gpio_1),
    .OUTPUT_ENABLE(_zz_48_),
    .D_OUT_0(_zz_49_),
    .D_IN_0(sB_IO_2__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_3_ ( 
    .PACKAGE_PIN(system_gpioA_gpio_2),
    .OUTPUT_ENABLE(_zz_50_),
    .D_OUT_0(_zz_51_),
    .D_IN_0(sB_IO_3__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_4_ ( 
    .PACKAGE_PIN(system_gpioA_gpio_3),
    .OUTPUT_ENABLE(_zz_52_),
    .D_OUT_0(_zz_53_),
    .D_IN_0(sB_IO_4__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_5_ ( 
    .PACKAGE_PIN(system_gpioA_gpio_4),
    .OUTPUT_ENABLE(_zz_54_),
    .D_OUT_0(_zz_55_),
    .D_IN_0(sB_IO_5__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_6_ ( 
    .PACKAGE_PIN(system_gpioA_gpio_5),
    .OUTPUT_ENABLE(_zz_56_),
    .D_OUT_0(_zz_57_),
    .D_IN_0(sB_IO_6__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_7_ ( 
    .PACKAGE_PIN(system_gpioA_gpio_6),
    .OUTPUT_ENABLE(_zz_58_),
    .D_OUT_0(_zz_59_),
    .D_IN_0(sB_IO_7__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_8_ ( 
    .PACKAGE_PIN(system_gpioA_gpio_7),
    .OUTPUT_ENABLE(_zz_60_),
    .D_OUT_0(_zz_61_),
    .D_IN_0(sB_IO_8__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_9_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_0),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_62_),
    .D_IN_0(sB_IO_9__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_10_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_1),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_63_),
    .D_IN_0(sB_IO_10__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_11_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_2),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_64_),
    .D_IN_0(sB_IO_11__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_12_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_3),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_65_),
    .D_IN_0(sB_IO_12__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_13_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_4),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_66_),
    .D_IN_0(sB_IO_13__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_14_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_5),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_67_),
    .D_IN_0(sB_IO_14__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_15_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_6),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_68_),
    .D_IN_0(sB_IO_15__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_16_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_7),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_69_),
    .D_IN_0(sB_IO_16__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_17_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_8),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_70_),
    .D_IN_0(sB_IO_17__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_18_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_9),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_71_),
    .D_IN_0(sB_IO_18__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_19_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_10),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_72_),
    .D_IN_0(sB_IO_19__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_20_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_11),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_73_),
    .D_IN_0(sB_IO_20__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_21_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_12),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_74_),
    .D_IN_0(sB_IO_21__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_22_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_13),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_75_),
    .D_IN_0(sB_IO_22__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_23_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_14),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_76_),
    .D_IN_0(sB_IO_23__D_IN_0) 
  );
  SB_IO #( 
    .PIN_TYPE((6'b101001)) 
  ) sB_IO_24_ ( 
    .PACKAGE_PIN(system_sdramA_sdram_DQ_15),
    .OUTPUT_ENABLE(_zz_10_),
    .D_OUT_0(_zz_77_),
    .D_IN_0(sB_IO_24__D_IN_0) 
  );
  assign sdramClk = pll_sdram_clock_out;
  assign clockCtrl_inputResetTrigger = 1'b0;
  always @ (*) begin
    clockCtrl_resetUnbuffered = 1'b0;
    if(_zz_78_)begin
      clockCtrl_resetUnbuffered = 1'b1;
    end
  end

  always @ (*) begin
    clockCtrl_resetRequest = 1'b0;
    if(system_cpu_cpu_debug_resetOut_regNext)begin
      clockCtrl_resetRequest = 1'b1;
    end
  end

  assign system_uartA_uart_txd = system_uartA_io_uart_txd;
  assign _zz_2_ = system_gpioA_io_gpio_write;
  assign _zz_3_ = system_gpioA_io_gpio_writeEnable;
  assign _zz_21_ = (system_cpu_iBus_decoder_io_input_rsp_payload_fragment_opcode == (1'b1));
  assign _zz_4_[0] = system_cpu_cpu_dBus_cmd_payload_wr;
  always @ (*) begin
    case(system_cpu_cpu_dBus_cmd_payload_size)
      2'b00 : begin
        _zz_5_ = (2'b00);
      end
      2'b01 : begin
        _zz_5_ = (2'b01);
      end
      default : begin
        _zz_5_ = (2'b11);
      end
    endcase
  end

  always @ (*) begin
    case(system_cpu_cpu_dBus_cmd_payload_size)
      2'b00 : begin
        _zz_6_ = (4'b0001);
      end
      2'b01 : begin
        _zz_6_ = (4'b0011);
      end
      default : begin
        _zz_6_ = (4'b1111);
      end
    endcase
  end

  assign _zz_23_ = (system_cpu_dBus_decoder_io_input_rsp_valid && (! system_cpu_dBus_decoder_io_input_rsp_payload_fragment_context[0]));
  assign _zz_24_ = (system_cpu_dBus_decoder_io_input_rsp_payload_fragment_opcode == (1'b1));
  assign _zz_22_ = systemDebugger_1__io_mem_cmd_payload_address[7:0];
  assign system_cpu_tdo = jtagBridge_1__io_jtag_tdo;
  assign _zz_28_ = 1'b1;
  assign _zz_25_ = 1'b1;
  assign _zz_26_ = (1'b0);
  assign _zz_27_ = (2'b11);
  assign _zz_32_ = 1'b1;
  assign _zz_29_ = 1'b1;
  assign _zz_30_ = (system_cpu_cpu_dBus_cmd_payload_wr ? (1'b1) : (1'b0));
  assign _zz_31_ = (_zz_6_ <<< system_cpu_cpu_dBus_cmd_payload_address[1 : 0]);
  assign system_sdramA_sdram_ADDR = system_sdramA_io_sdram_ADDR;
  assign system_sdramA_sdram_BA = system_sdramA_io_sdram_BA;
  assign _zz_9_ = system_sdramA_io_sdram_DQ_write;
  assign _zz_10_ = system_sdramA_io_sdram_DQ_writeEnable;
  assign system_sdramA_sdram_DQM = system_sdramA_io_sdram_DQM;
  assign system_sdramA_sdram_CASn = system_sdramA_io_sdram_CASn;
  assign system_sdramA_sdram_CKE = system_sdramA_io_sdram_CKE;
  assign system_sdramA_sdram_CSn = system_sdramA_io_sdram_CSn;
  assign system_sdramA_sdram_RASn = system_sdramA_io_sdram_RASn;
  assign system_sdramA_sdram_WEn = system_sdramA_io_sdram_WEn;
  assign _zz_43_ = ((1'b1 && (! system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_valid)) || system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_ready);
  assign system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_valid = _zz_11_;
  assign system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_last = _zz_12_;
  assign system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_opcode = _zz_13_;
  assign system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_address = _zz_14_;
  assign system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_length = _zz_15_;
  assign system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_data = _zz_16_;
  assign system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_mask = _zz_17_;
  assign system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_payload_fragment_context = _zz_18_;
  assign system_sdramA_bmb_burstUnburstifier_io_output_cmd_m2sPipe_ready = system_sdramA_io_bmb_cmd_ready;
  assign _zz_34_ = system_cpu_iBus_decoder_io_outputs_0_cmd_payload_fragment_address[12:0];
  assign _zz_35_ = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  assign _zz_36_ = (4'bxxxx);
  assign _zz_37_ = (1'b0);
  assign _zz_39_ = system_cpu_iBus_decoder_io_outputs_1_cmd_payload_fragment_address[20:0];
  assign _zz_40_ = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
  assign _zz_41_ = (4'bxxxx);
  assign _zz_42_ = (1'b0);
  assign _zz_33_ = system_cpu_dBus_decoder_io_outputs_0_cmd_payload_fragment_address[12:0];
  assign _zz_38_ = system_cpu_dBus_decoder_io_outputs_1_cmd_payload_fragment_address[20:0];
  assign generator = system_gpioA_io_interrupt[0];
  assign generator_1_ = system_gpioA_io_interrupt[1];
  assign generator_2_ = system_gpioA_io_interrupt[2];
  assign generator_3_ = system_gpioA_io_interrupt[3];
  assign generator_4_ = system_gpioA_io_interrupt[4];
  assign generator_5_ = system_gpioA_io_interrupt[5];
  assign generator_6_ = system_gpioA_io_interrupt[6];
  assign generator_7_ = system_gpioA_io_interrupt[7];
  assign generator_PREADY = generator_decoder_io_input_PREADY;
  assign generator_PRDATA = generator_decoder_io_input_PRDATA;
  assign generator_PSLVERROR = generator_decoder_io_input_PSLVERROR;
  assign _zz_19_ = apb3Router_1__io_outputs_0_PADDR[3:0];
  assign _zz_44_ = 1'b0;
  assign _zz_20_ = apb3Router_1__io_outputs_1_PADDR[11:0];
  assign generator_PADDR = system_peripheralBridge_bridge_io_output_PADDR;
  assign generator_PSEL = system_peripheralBridge_bridge_io_output_PSEL;
  assign generator_PENABLE = system_peripheralBridge_bridge_io_output_PENABLE;
  assign generator_PWRITE = system_peripheralBridge_bridge_io_output_PWRITE;
  assign generator_PWDATA = system_peripheralBridge_bridge_io_output_PWDATA;
  assign _zz_45_ = system_cpu_dBus_decoder_io_outputs_2_cmd_payload_fragment_address[16:0];
  assign _zz_46_ = _zz_3_[0];
  assign _zz_47_ = _zz_2_[0];
  always @ (*) begin
    _zz_1_[0] = sB_IO_1__D_IN_0;
    _zz_1_[1] = sB_IO_2__D_IN_0;
    _zz_1_[2] = sB_IO_3__D_IN_0;
    _zz_1_[3] = sB_IO_4__D_IN_0;
    _zz_1_[4] = sB_IO_5__D_IN_0;
    _zz_1_[5] = sB_IO_6__D_IN_0;
    _zz_1_[6] = sB_IO_7__D_IN_0;
    _zz_1_[7] = sB_IO_8__D_IN_0;
  end

  assign _zz_48_ = _zz_3_[1];
  assign _zz_49_ = _zz_2_[1];
  assign _zz_50_ = _zz_3_[2];
  assign _zz_51_ = _zz_2_[2];
  assign _zz_52_ = _zz_3_[3];
  assign _zz_53_ = _zz_2_[3];
  assign _zz_54_ = _zz_3_[4];
  assign _zz_55_ = _zz_2_[4];
  assign _zz_56_ = _zz_3_[5];
  assign _zz_57_ = _zz_2_[5];
  assign _zz_58_ = _zz_3_[6];
  assign _zz_59_ = _zz_2_[6];
  assign _zz_60_ = _zz_3_[7];
  assign _zz_61_ = _zz_2_[7];
  assign _zz_62_ = _zz_9_[0];
  always @ (*) begin
    _zz_8_[0] = sB_IO_9__D_IN_0;
    _zz_8_[1] = sB_IO_10__D_IN_0;
    _zz_8_[2] = sB_IO_11__D_IN_0;
    _zz_8_[3] = sB_IO_12__D_IN_0;
    _zz_8_[4] = sB_IO_13__D_IN_0;
    _zz_8_[5] = sB_IO_14__D_IN_0;
    _zz_8_[6] = sB_IO_15__D_IN_0;
    _zz_8_[7] = sB_IO_16__D_IN_0;
    _zz_8_[8] = sB_IO_17__D_IN_0;
    _zz_8_[9] = sB_IO_18__D_IN_0;
    _zz_8_[10] = sB_IO_19__D_IN_0;
    _zz_8_[11] = sB_IO_20__D_IN_0;
    _zz_8_[12] = sB_IO_21__D_IN_0;
    _zz_8_[13] = sB_IO_22__D_IN_0;
    _zz_8_[14] = sB_IO_23__D_IN_0;
    _zz_8_[15] = sB_IO_24__D_IN_0;
  end

  assign _zz_63_ = _zz_9_[1];
  assign _zz_64_ = _zz_9_[2];
  assign _zz_65_ = _zz_9_[3];
  assign _zz_66_ = _zz_9_[4];
  assign _zz_67_ = _zz_9_[5];
  assign _zz_68_ = _zz_9_[6];
  assign _zz_69_ = _zz_9_[7];
  assign _zz_70_ = _zz_9_[8];
  assign _zz_71_ = _zz_9_[9];
  assign _zz_72_ = _zz_9_[10];
  assign _zz_73_ = _zz_9_[11];
  assign _zz_74_ = _zz_9_[12];
  assign _zz_75_ = _zz_9_[13];
  assign _zz_76_ = _zz_9_[14];
  assign _zz_77_ = _zz_9_[15];
  always @ (posedge pll_clock_out) begin
    if(_zz_78_)begin
      clockCtrl_holdingLogic_resetCounter <= (clockCtrl_holdingLogic_resetCounter + (8'b00000001));
    end
    if(clockCtrl_inputResetTrigger)begin
      clockCtrl_holdingLogic_resetCounter <= (8'b00000000);
    end
  end

  always @ (posedge pll_clock_out) begin
    clockCtrl_systemReset <= (clockCtrl_resetUnbuffered || bufferCC_4__io_dataOut);
    clockCtrl_resetUnbuffered_regNext <= clockCtrl_resetUnbuffered;
  end

  always @ (posedge pll_clock_out) begin
    system_cpu_cpu_debug_resetOut_regNext <= system_cpu_cpu_debug_resetOut;
  end

  always @ (posedge pll_clock_out) begin
    if(clockCtrl_resetUnbuffered_regNext) begin
      _zz_7_ <= 1'b0;
    end else begin
      _zz_7_ <= (systemDebugger_1__io_mem_cmd_valid && system_cpu_cpu_debug_bus_cmd_ready);
    end
  end

  always @ (posedge pll_clock_out) begin
    if(clockCtrl_systemReset) begin
      _zz_11_ <= 1'b0;
    end else begin
      if(_zz_43_)begin
        _zz_11_ <= system_sdramA_bmb_burstUnburstifier_io_output_cmd_valid;
      end
    end
  end

  always @ (posedge pll_clock_out) begin
    if(_zz_43_)begin
      _zz_12_ <= system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_last;
      _zz_13_ <= system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_opcode;
      _zz_14_ <= system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_address;
      _zz_15_ <= system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_length;
      _zz_16_ <= system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_data;
      _zz_17_ <= system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_mask;
      _zz_18_ <= system_sdramA_bmb_burstUnburstifier_io_output_cmd_payload_fragment_context;
    end
  end

endmodule

