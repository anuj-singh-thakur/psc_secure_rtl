`timescale 1 ns / 1 ps

(* CORE_GENERATION_INFO = "hls_macc,hls_ip_2018_3,{HLS_INPUT_TYPE=c,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xa7a12tcsg325-1q,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=8.577000,HLS_SYN_LAT=4,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=21,HLS_SYN_FF=327,HLS_SYN_LUT=635,HLS_VERSION=2018_3}" *)


module hls_macc
(
  ap_clk,
  ap_rst,
  ap_start,
  ap_done,
  ap_idle,
  ap_ready,
  i1,
  i2,
  i3,
  i4,
  i6,
  o1,
  o1_ap_vld,
  o2,
  o2_ap_vld,
  o3,
  o4,
  G1,
  G2,
  G3,
  G4,
  GG1,
  GG2,
  ap_return
);

  wire [31:0] t10_op4_fu_106_p2;
  wire signed [31:0] t11_op4_fu_106_p0;
  wire signed [31:0] t12_op4_fu_106_p1;
  wire [31:0] t1_op13_fu_194_p2;
  wire [31:0] t2_tmp1_fu_189_p2;
  wire [31:0] t3_op6_1_fu_182_p3;
  wire [31:0] t4_op6_5_fu_171_p3;
  wire [31:0] t5_op6_2_fu_167_p2;
  wire [31:0] t6_op6_fu_163_p2;
  wire [31:0] t7_op6_4_fu_178_p2;
  wire signed [31:0] t8_op6_4_fu_178_p1;
  wire signed [31:0] t9_tmp1_fu_189_p1;
  parameter ap_ST_fsm_state1 = 5'd1;
  parameter ap_ST_fsm_state2 = 5'd2;
  parameter ap_ST_fsm_state3 = 5'd4;
  parameter ap_ST_fsm_state4 = 5'd8;
  parameter ap_ST_fsm_state5 = 5'd16;
  input ap_clk;
  input ap_rst;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  input [31:0] i1;
  input [31:0] i2;
  input [31:0] i3;
  input [31:0] i4;
  input [31:0] i6;
  output [31:0] o1;
  output o1_ap_vld;
  output [31:0] o2;
  output o2_ap_vld;
  input [31:0] o3;
  input [31:0] o4;
  input [31:0] G1;
  input [31:0] G2;
  input [31:0] G3;
  input [31:0] G4;
  input [31:0] GG1;
  input [31:0] GG2;
  output [31:0] ap_return;
  reg ap_done;
  reg ap_idle;
  reg ap_ready;
  reg o1_ap_vld;
  reg o2_ap_vld;
  (* fsm_encoding = "none" *)
  reg [4:0] ap_CS_fsm;
  wire ap_CS_fsm_state1;
  wire [31:0] op4_fu_106_p2;
  reg [31:0] op4_reg_239;
  wire [31:0] op5_fu_112_p2;
  reg [31:0] op5_reg_246;
  wire [31:0] op5_2_fu_118_p2;
  reg [31:0] op5_2_reg_251;
  wire [0:0] tmp_fu_124_p2;
  reg [0:0] tmp_reg_257;
  wire ap_CS_fsm_state2;
  wire [31:0] op5_1_fu_129_p2;
  reg [31:0] op5_1_reg_262;
  wire [0:0] tmp_6_fu_141_p2;
  reg [0:0] tmp_6_reg_267;
  wire [31:0] op3_fu_146_p2;
  reg [31:0] op3_reg_272;
  wire ap_CS_fsm_state3;
  wire [31:0] op6_3_fu_151_p2;
  reg [31:0] op6_3_reg_277;
  wire [31:0] op7_fu_155_p2;
  reg [31:0] op7_reg_282;
  wire [31:0] op8_fu_159_p2;
  reg [31:0] op8_reg_287;
  wire [31:0] op13_fu_194_p2;
  reg [31:0] op13_reg_292;
  wire ap_CS_fsm_state4;
  wire [31:0] op14_fu_204_p2;
  reg [31:0] op14_reg_298;
  wire ap_CS_fsm_state5;
  wire signed [31:0] op4_fu_106_p0;
  wire signed [31:0] op4_fu_106_p1;
  wire signed [31:0] op5_fu_112_p0;
  wire signed [31:0] op5_fu_112_p1;
  wire signed [31:0] op5_2_fu_118_p0;
  wire signed [31:0] op5_2_fu_118_p1;
  wire signed [31:0] tmp_fu_124_p0;
  wire [31:0] op5_3_fu_134_p3;
  wire signed [31:0] op3_fu_146_p0;
  wire signed [31:0] op3_fu_146_p1;
  wire signed [31:0] op6_3_fu_151_p0;
  wire signed [31:0] op6_3_fu_151_p1;
  wire signed [31:0] op7_fu_155_p0;
  wire signed [31:0] op7_fu_155_p1;
  wire signed [31:0] op8_fu_159_p0;
  wire signed [31:0] op8_fu_159_p1;
  wire [31:0] op6_fu_163_p2;
  wire [31:0] op6_2_fu_167_p2;
  wire signed [31:0] op6_4_fu_178_p1;
  wire [31:0] op6_4_fu_178_p2;
  wire [31:0] op6_5_fu_171_p3;
  wire [31:0] op6_1_fu_182_p3;
  wire signed [31:0] tmp1_fu_189_p1;
  wire [31:0] tmp1_fu_189_p2;
  wire [31:0] tmp2_fu_199_p2;
  reg [4:0] ap_NS_fsm;

  initial begin
    #0 ap_CS_fsm = 5'd1;
  end


  always @(posedge ap_clk) begin
    if(ap_rst == 1'b1) begin
      ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
      ap_CS_fsm <= ap_NS_fsm;
    end
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state4) begin
      op13_reg_292 <= (op4_reg_239[13:13])? ~t1_op13_fu_194_p2 : op13_fu_194_p2;
      op14_reg_298 <= op14_fu_204_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((tmp_6_reg_267 == 1'd0) & (tmp_reg_257 == 1'd0) & (1'b1 == ap_CS_fsm_state3)) begin
      op3_reg_272 <= op3_fu_146_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)) begin
      op4_reg_239 <= (op7_reg_282[31:31])? op4_fu_106_p2 : ~t10_op4_fu_106_p2;
      op5_2_reg_251 <= op5_2_fu_118_p2;
      op5_reg_246 <= op5_fu_112_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state2) begin
      op5_1_reg_262 <= op5_1_fu_129_p2;
      tmp_6_reg_267 <= tmp_6_fu_141_p2;
      tmp_reg_257 <= tmp_fu_124_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((tmp_6_reg_267 == 1'd1) & (1'b1 == ap_CS_fsm_state3)) begin
      op6_3_reg_277 <= op6_3_fu_151_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state3) begin
      op7_reg_282 <= op7_fu_155_p2;
      op8_reg_287 <= op8_fu_159_p2;
    end 
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state5) begin
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
    if(1'b1 == ap_CS_fsm_state5) begin
      ap_ready = 1'b1;
    end else begin
      ap_ready = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state5) begin
      o1_ap_vld = 1'b1;
    end else begin
      o1_ap_vld = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state5) begin
      o2_ap_vld = 1'b1;
    end else begin
      o2_ap_vld = 1'b0;
    end
  end


  always @(*) begin
    case(ap_CS_fsm)
      ap_ST_fsm_state1: begin
        if((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)) begin
          ap_NS_fsm = ap_ST_fsm_state2;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state1;
        end
      end
      ap_ST_fsm_state2: begin
        ap_NS_fsm = ap_ST_fsm_state3;
      end
      ap_ST_fsm_state3: begin
        ap_NS_fsm = ap_ST_fsm_state4;
      end
      ap_ST_fsm_state4: begin
        ap_NS_fsm = ap_ST_fsm_state5;
      end
      ap_ST_fsm_state5: begin
        ap_NS_fsm = ap_ST_fsm_state1;
      end
      default: begin
        ap_NS_fsm = 'bx;
      end
    endcase
  end

  assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];
  assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];
  assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];
  assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];
  assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];
  assign ap_return = op13_reg_292 + op14_reg_298;
  assign o1 = op13_reg_292;
  assign o2 = op14_reg_298;
  assign op13_fu_194_p2 = tmp1_fu_189_p2 + op4_reg_239;
  assign op14_fu_204_p2 = tmp2_fu_199_p2 + op7_reg_282;
  assign op3_fu_146_p0 = G1;
  assign op3_fu_146_p1 = i2;
  assign op3_fu_146_p2 = $signed(op3_fu_146_p0) * $signed(op3_fu_146_p1);
  assign op4_fu_106_p0 = G2;
  assign op4_fu_106_p1 = i1;
  assign op4_fu_106_p2 = $signed(op4_fu_106_p0) * $signed(op4_fu_106_p1);
  assign op5_1_fu_129_p2 = op5_reg_246 + GG1;
  assign op5_2_fu_118_p0 = i4;
  assign op5_2_fu_118_p1 = i3;
  assign op5_2_fu_118_p2 = $signed(op5_2_fu_118_p0) * $signed(op5_2_fu_118_p1);
  assign op5_3_fu_134_p3 = (tmp_fu_124_p2_temp === 1'b1)? op5_1_fu_129_p2 : op5_2_reg_251;
  assign tmp_fu_124_p2_temp = tmp_fu_124_p2 & 1'b1;
  assign op5_fu_112_p0 = G1;
  assign op5_fu_112_p1 = i3;
  assign op5_fu_112_p2 = $signed(op5_fu_112_p0) * $signed(op5_fu_112_p1);
  assign op6_1_fu_182_p3 = (tmp_6_reg_267_temp === 1'b1)? op6_4_fu_178_p2 : op6_5_fu_171_p3;
  assign tmp_6_reg_267_temp = tmp_6_reg_267 & 1'b1;
  assign op6_2_fu_167_p2 = op5_2_reg_251 - op3_reg_272;
  assign op6_3_fu_151_p0 = G2;
  assign op6_3_fu_151_p1 = i4;
  assign op6_3_fu_151_p2 = $signed(op6_3_fu_151_p0) * $signed(op6_3_fu_151_p1);
  assign op6_4_fu_178_p1 = i3;
  assign op6_4_fu_178_p2 = $signed(op6_3_reg_277) - $signed(op6_4_fu_178_p1);
  assign op6_5_fu_171_p3 = (tmp_reg_257_temp === 1'b1)? op6_fu_163_p2 : op6_2_fu_167_p2;
  assign tmp_reg_257_temp = tmp_reg_257 & 1'b1;
  assign op6_fu_163_p2 = op5_1_reg_262 - op4_reg_239;
  assign op7_fu_155_p0 = G1;
  assign op7_fu_155_p1 = i4;
  assign op7_fu_155_p2 = $signed(op7_fu_155_p0) * $signed(op7_fu_155_p1);
  assign op8_fu_159_p0 = G2;
  assign op8_fu_159_p1 = i3;
  assign op8_fu_159_p2 = $signed(op8_fu_159_p0) * $signed(op8_fu_159_p1);
  assign tmp1_fu_189_p1 = G1;
  assign tmp1_fu_189_p2 = $signed(op6_1_fu_182_p3) + $signed(tmp1_fu_189_p1);
  assign tmp2_fu_199_p2 = op8_reg_287 + i6;
  assign tmp_6_fu_141_p2 = (op5_3_fu_134_p3 < op4_reg_239)? 1'b1 : 1'b0;
  assign tmp_fu_124_p0 = G1;
  assign tmp_fu_124_p2 = (tmp_fu_124_p0 > 32'd10)? 1'b1 : 1'b0;
  assign t5_op6_2_fu_167_p2 = ~(~(~op3_reg_272 - ~op5_2_reg_251));
  assign t6_op6_fu_163_p2 = op5_1_reg_262 - op4_reg_239;
  assign t4_op6_5_fu_171_p3 = (tmp_reg_257_temp === 1'b1)? t6_op6_fu_163_p2 : t5_op6_2_fu_167_p2;
  assign t8_op6_4_fu_178_p1 = i3;
  assign t7_op6_4_fu_178_p2 = ~(~(~$signed(t8_op6_4_fu_178_p1) - ~$signed(op6_3_reg_277)));
  assign t3_op6_1_fu_182_p3 = (tmp_6_reg_267_temp === 1'b1)? t7_op6_4_fu_178_p2 : t4_op6_5_fu_171_p3;
  assign t9_tmp1_fu_189_p1 = ~(~G1);
  assign t2_tmp1_fu_189_p2 = ~(~$signed(t3_op6_1_fu_182_p3) + (~$signed(t9_tmp1_fu_189_p1) + 1));
  assign t1_op13_fu_194_p2 = ~t2_tmp1_fu_189_p2 + (~op4_reg_239 + 1);
  assign t11_op4_fu_106_p0 = ~(~G2);
  assign t12_op4_fu_106_p1 = i1;
  assign t10_op4_fu_106_p2 = (~($signed(t11_op4_fu_106_p0) + $signed(t12_op4_fu_106_p1)) << 31 + 1) - ~$signed(t11_op4_fu_106_p0) * ~$signed(t12_op4_fu_106_p1) + ($signed(t11_op4_fu_106_p0) + $signed(t12_op4_fu_106_p1));

endmodule


