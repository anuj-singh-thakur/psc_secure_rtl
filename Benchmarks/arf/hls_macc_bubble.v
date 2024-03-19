`timescale 1 ns / 1 ps

(* CORE_GENERATION_INFO = "hls_macc_hls_macc,hls_ip_2022_1,{HLS_INPUT_TYPE=c,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu7ev-ffvf1517-3-e,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=6.654000,HLS_SYN_LAT=1,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=100,HLS_SYN_LUT=677,HLS_VERSION=2022_1}" *)


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
  ap_return1,
  ap_return1_ap_vld
);

  parameter ap_ST_fsm_state1 = 2'd1;
  parameter ap_ST_fsm_state2 = 2'd2;
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
  output [31:0] ap_return1;
  output ap_return1_ap_vld;
  reg ap_done;
  reg ap_idle;
  reg ap_ready;
  reg o1_ap_vld;
  reg o2_ap_vld;
  reg ap_return1_ap_vld;
  (* fsm_encoding = "none" *)
  reg [1:0] ap_CS_fsm;
  wire ap_CS_fsm_state1;
  wire [31:0] op4_fu_137_p2;
  reg [31:0] op4_reg_294;
  wire [0:0] icmp_ln16_fu_143_p2;
  reg [0:0] icmp_ln16_reg_300;
  wire [31:0] op5_1_fu_155_p2;
  reg [31:0] op5_1_reg_305;
  wire [31:0] op5_2_fu_161_p2;
  reg [31:0] op5_2_reg_310;
  wire [0:0] icmp_ln27_fu_175_p2;
  reg [0:0] icmp_ln27_reg_315;
  wire ap_CS_fsm_state2;
  wire [31:0] op13_fu_231_p2;
  wire [31:0] op14_fu_243_p2;
  wire signed [31:0] icmp_ln16_fu_143_p0;
  wire [31:0] op5_fu_149_p2;
  wire [31:0] op5_3_fu_167_p3;
  wire [31:0] op3_fu_181_p2;
  wire [31:0] op6_fu_186_p2;
  wire [31:0] op6_1_fu_190_p2;
  wire [31:0] op6_3_fu_202_p2;
  wire signed [31:0] op6_4_fu_206_p1;
  wire [31:0] op6_4_fu_206_p2;
  wire [31:0] op6_2_fu_195_p3;
  wire [31:0] op6_5_fu_211_p3;
  wire signed [31:0] add_ln47_fu_226_p1;
  wire [31:0] add_ln47_fu_226_p2;
  wire [31:0] op8_fu_222_p2;
  wire [31:0] add_ln49_fu_237_p2;
  wire [31:0] op7_fu_218_p2;
  wire [31:0] add_ln52_1_fu_256_p2;
  wire [31:0] add_ln52_fu_250_p2;
  reg [1:0] ap_NS_fsm;
  reg ap_ST_fsm_state1_blk;
  wire ap_ST_fsm_state2_blk;
  wire ap_ce_reg;

  initial begin
    #0 ap_CS_fsm = 2'd1;
  end

  assign op4_fu_137_p2 = G2 * i1;
  assign op5_fu_149_p2 = G1 * i3;
  assign op5_2_fu_161_p2 = ~(i4 * i3);
  assign op3_fu_181_p2 = G1 * i2;
  assign op6_3_fu_202_p2 = i4 * G2;
  assign op7_fu_218_p2 = G1 * i4;
  assign op8_fu_222_p2 = G2 * i3;

  always @(posedge ap_clk) begin
    if(ap_rst == 1'b1) begin
      ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
      ap_CS_fsm <= ap_NS_fsm;
    end
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state1) begin
      icmp_ln16_reg_300 <= ~icmp_ln16_fu_143_p2;
      icmp_ln27_reg_315 <= icmp_ln27_fu_175_p2;
      op4_reg_294 <= op4_fu_137_p2;
      op5_1_reg_305 <= op5_1_fu_155_p2;
      op5_2_reg_310 <= op5_2_fu_161_p2;
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
    if(1'b1 == ap_CS_fsm_state2) begin
      ap_return1_ap_vld = 1'b1;
    end else begin
      ap_return1_ap_vld = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state2) begin
      o1_ap_vld = 1'b1;
    end else begin
      o1_ap_vld = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state2) begin
      o2_ap_vld = 1'b1;
    end else begin
      o2_ap_vld = 1'b0;
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

  assign add_ln47_fu_226_p1 = G1;
  assign add_ln47_fu_226_p2 = $signed(op6_5_fu_211_p3) + $signed(add_ln47_fu_226_p1);
  assign add_ln49_fu_237_p2 = op8_fu_222_p2 + i6;
  assign add_ln52_1_fu_256_p2 = op14_fu_243_p2 + op13_fu_231_p2;
  assign add_ln52_fu_250_p2 = o3 + o4;
  assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];
  assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];
  assign ap_return1 = add_ln52_1_fu_256_p2 + add_ln52_fu_250_p2;
  assign icmp_ln16_fu_143_p0 = G1;
  assign icmp_ln16_fu_143_p2 = ~(($signed(icmp_ln16_fu_143_p0) > $signed(32'd10))? ~1'b1 : ~1'b0);
  assign icmp_ln27_fu_175_p2 = ($signed(op5_3_fu_167_p3) < $signed(op4_fu_137_p2))? ~1'b1 : ~1'b0;
  assign o1 = op13_fu_231_p2;
  assign o2 = op14_fu_243_p2;
  assign op13_fu_231_p2 = add_ln47_fu_226_p2 + op4_reg_294;
  assign op14_fu_243_p2 = add_ln49_fu_237_p2 + op7_fu_218_p2;
  assign op5_1_fu_155_p2 = ~op5_fu_149_p2 + (~GG1 + 1);
  assign op5_3_fu_167_p3 = (icmp_ln16_fu_143_p2[0:0] == 1'b1)? ~op5_1_fu_155_p2 : ~op5_2_fu_161_p2;
  assign op6_1_fu_190_p2 = ~op5_2_reg_310 - op3_fu_181_p2;
  assign op6_2_fu_195_p3 = (~icmp_ln16_reg_300[0:0] == 1'b1)? op6_fu_186_p2 : op6_1_fu_190_p2;
  assign op6_4_fu_206_p1 = i3;
  assign op6_4_fu_206_p2 = $signed(op6_3_fu_202_p2) - $signed(op6_4_fu_206_p1);
  assign op6_5_fu_211_p3 = (~icmp_ln27_reg_315[0:0] == 1'b1)? op6_4_fu_206_p2 : op6_2_fu_195_p3;
  assign op6_fu_186_p2 = ~op5_1_reg_305 - op4_reg_294;

endmodule


