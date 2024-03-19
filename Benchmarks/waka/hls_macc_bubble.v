`timescale 1 ns / 1 ps

(* CORE_GENERATION_INFO = "hls_macc_hls_macc,hls_ip_2022_1,{HLS_INPUT_TYPE=c,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu7ev-ffvf1517-3-e,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=3.634000,HLS_SYN_LAT=1,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=66,HLS_SYN_LUT=658,HLS_VERSION=2022_1}" *)


module hls_macc
(
  ap_clk,
  ap_rst,
  ap_start,
  ap_done,
  ap_idle,
  ap_ready,
  in1,
  in2,
  in3,
  in4,
  in7,
  in8,
  in9,
  in10,
  in14,
  in12,
  in15,
  in17,
  in19,
  in20,
  in22,
  in24,
  in27,
  in28,
  in29,
  in32,
  out13,
  out13_ap_vld,
  out30_i,
  out30_o,
  out30_o_ap_vld,
  out31,
  out31_ap_vld,
  ap_return
);

  parameter ap_ST_fsm_state1 = 2'd1;
  parameter ap_ST_fsm_state2 = 2'd2;
  input ap_clk;
  input ap_rst;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  input [31:0] in1;
  input [31:0] in2;
  input [31:0] in3;
  input [31:0] in4;
  input [31:0] in7;
  input [31:0] in8;
  input [31:0] in9;
  input [31:0] in10;
  input [31:0] in14;
  input [31:0] in12;
  input [31:0] in15;
  input [31:0] in17;
  input [31:0] in19;
  input [31:0] in20;
  input [31:0] in22;
  input [31:0] in24;
  input [31:0] in27;
  input [31:0] in28;
  input [31:0] in29;
  input [31:0] in32;
  output [31:0] out13;
  output out13_ap_vld;
  input [31:0] out30_i;
  output [31:0] out30_o;
  output out30_o_ap_vld;
  output [31:0] out31;
  output out31_ap_vld;
  output [31:0] ap_return;
  reg ap_done;
  reg ap_idle;
  reg ap_ready;
  reg out13_ap_vld;
  reg [31:0] out30_o;
  reg out30_o_ap_vld;
  reg out31_ap_vld;
  (* fsm_encoding = "none" *)
  reg [1:0] ap_CS_fsm;
  wire ap_CS_fsm_state1;
  wire [31:0] sub_ln11_fu_230_p2;
  reg [31:0] sub_ln11_reg_346;
  wire [31:0] t16_1_fu_305_p2;
  wire [0:0] icmp_ln13_fu_249_p2;
  wire [31:0] t16_fu_318_p2;
  reg [31:0] t16_2_reg_215;
  wire [31:0] add_ln28_fu_311_p2;
  wire [31:0] add_ln30_fu_324_p2;
  wire ap_CS_fsm_state2;
  wire [31:0] add_ln12_fu_237_p2;
  wire [31:0] t5_fu_224_p2;
  wire [31:0] add_ln21_fu_261_p2;
  wire [31:0] t11_fu_243_p2;
  wire [31:0] t23_fu_267_p2;
  wire [31:0] t25_fu_273_p2;
  wire [31:0] add_ln26_fu_285_p2;
  wire [0:0] icmp_ln18_fu_255_p2;
  wire [31:0] t26_fu_279_p2;
  wire [31:0] t26_1_fu_291_p2;
  wire [31:0] t26_2_fu_297_p3;
  wire [31:0] add_ln31_fu_330_p2;
  reg [1:0] ap_NS_fsm;
  reg ap_ST_fsm_state1_blk;
  wire ap_ST_fsm_state2_blk;
  wire ap_ce_reg;

  initial begin
    #0 ap_CS_fsm = 2'd1;
  end


  always @(posedge ap_clk) begin
    if(ap_rst == 1'b1) begin
      ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
      ap_CS_fsm <= ap_NS_fsm;
    end
  end


  always @(posedge ap_clk) begin
    if((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)) begin
      if(icmp_ln13_fu_249_p2 == 1'd0) begin
        t16_2_reg_215 <= t16_1_fu_305_p2;
      end else if(icmp_ln13_fu_249_p2 == 1'd1) begin
        t16_2_reg_215 <= t16_fu_318_p2;
      end 
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state1) begin
      sub_ln11_reg_346 <= ~sub_ln11_fu_230_p2;
    end 
  end


  always @(*) begin
    if(ap_start == 1'b0) begin
      ap_ST_fsm_state1_blk = 1'b1;
    end else begin
      ap_ST_fsm_state1_blk = 1'b0;
    end
  end

  assign ap_ST_fsm_state2_blk = 1'b0;

  always @(*) begin
    if(1'b1 == ap_CS_fsm_state2) begin
      ap_done = 1'b1;
    end else begin
      ap_done = 1'b0;
    end
  end


  always @(*) begin
    if((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)) begin
      ap_idle = 1'b1;
    end else begin
      ap_idle = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state2) begin
      ap_ready = 1'b1;
    end else begin
      ap_ready = 1'b0;
    end
  end


  always @(*) begin
    if((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)) begin
      out13_ap_vld = 1'b1;
    end else begin
      out13_ap_vld = 1'b0;
    end
  end


  always @(*) begin
    if((ap_start == 1'b1) & (icmp_ln13_fu_249_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1)) begin
      out30_o = add_ln28_fu_311_p2;
    end else begin
      out30_o = out30_i;
    end
  end


  always @(*) begin
    if((ap_start == 1'b1) & (icmp_ln13_fu_249_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state1)) begin
      out30_o_ap_vld = 1'b1;
    end else begin
      out30_o_ap_vld = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state2) begin
      out31_ap_vld = 1'b1;
    end else begin
      out31_ap_vld = 1'b0;
    end
  end


  always @(*) begin
    case(ap_CS_fsm)
      ap_ST_fsm_state1: begin
        if((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)) begin
          ap_NS_fsm = ap_ST_fsm_state2;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state1;
        end
      end
      ap_ST_fsm_state2: begin
        ap_NS_fsm = ap_ST_fsm_state1;
      end
      default: begin
        ap_NS_fsm = 'bx;
      end
    endcase
  end

  assign add_ln12_fu_237_p2 = in7 + in12;
  assign add_ln21_fu_261_p2 = t5_fu_224_p2 + in22;
  assign add_ln26_fu_285_p2 = in19 + in20;
  assign add_ln28_fu_311_p2 = t26_2_fu_297_p3 + in29;
  assign add_ln30_fu_324_p2 = ~t16_2_reg_215 + in32;
  assign add_ln31_fu_330_p2 = ~sub_ln11_reg_346 + add_ln30_fu_324_p2;
  assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];
  assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];
  assign ap_return = add_ln31_fu_330_p2 + out30_i;
  assign icmp_ln13_fu_249_p2 = (in2 == in1)? 1'b1 : 1'b0;
  assign icmp_ln18_fu_255_p2 = ($signed(in9) < $signed(in10))? 1'b1 : 1'b0;
  assign out13 = in14 - in15;
  assign out31 = add_ln30_fu_324_p2;
  assign sub_ln11_fu_230_p2 = in14 - in15;
  assign t11_fu_243_p2 = add_ln12_fu_237_p2 + in8;
  assign t16_1_fu_305_p2 = ~(~(~t26_2_fu_297_p3) - ~(~in28));
  assign t16_fu_318_p2 = ~(~in17 - ~t11_fu_243_p2);
  assign t23_fu_267_p2 = add_ln21_fu_261_p2 + t11_fu_243_p2;
  assign t25_fu_273_p2 = t23_fu_267_p2 - in24;
  assign t26_1_fu_291_p2 = add_ln26_fu_285_p2 + t5_fu_224_p2;
  assign t26_2_fu_297_p3 = (icmp_ln18_fu_255_p2[0:0] == 1'b1)? t26_fu_279_p2 : t26_1_fu_291_p2;
  assign t26_fu_279_p2 = t25_fu_273_p2 + in27;
  assign t5_fu_224_p2 = in3 - in4;

endmodule


