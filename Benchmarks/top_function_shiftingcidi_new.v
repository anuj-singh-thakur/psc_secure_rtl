`timescale 1 ns / 1 ps


module top_function_shiftingcidi
(
  ap_clk,
  ap_rst,
  ap_start,
  ap_done,
  ap_idle,
  ap_ready,
  C,
  D,
  L,
  R,
  ap_return
);

  parameter ap_ST_fsm_state1 = 16'd1;
  parameter ap_ST_fsm_state2 = 16'd2;
  parameter ap_ST_fsm_state3 = 16'd4;
  parameter ap_ST_fsm_state4 = 16'd8;
  parameter ap_ST_fsm_state5 = 16'd16;
  parameter ap_ST_fsm_state6 = 16'd32;
  parameter ap_ST_fsm_state7 = 16'd64;
  parameter ap_ST_fsm_state8 = 16'd128;
  parameter ap_ST_fsm_state9 = 16'd256;
  parameter ap_ST_fsm_state10 = 16'd512;
  parameter ap_ST_fsm_state11 = 16'd1024;
  parameter ap_ST_fsm_state12 = 16'd2048;
  parameter ap_ST_fsm_state13 = 16'd4096;
  parameter ap_ST_fsm_state14 = 16'd8192;
  parameter ap_ST_fsm_state15 = 16'd16384;
  parameter ap_ST_fsm_state16 = 16'd32768;
  input ap_clk;
  input ap_rst;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  input [27:0] C;
  input [27:0] D;
  input [31:0] L;
  input [31:0] R;
  output [63:0] ap_return;
  reg ap_done;
  reg ap_idle;
  reg ap_ready;
  (* fsm_encoding = "none" *)
  reg [15:0] ap_CS_fsm;
  wire ap_CS_fsm_state1;
  wire [3:0] iteration_shift_address0;
  reg iteration_shift_ce0;
  wire [1:0] iteration_shift_q0;
  wire [5:0] PC2_address0;
  reg PC2_ce0;
  wire [5:0] PC2_q0;
  reg [3:0] sub_key_address0;
  reg sub_key_ce0;
  reg sub_key_we0;
  wire [47:0] sub_key_q0;
  wire [5:0] E_address0;
  reg E_ce0;
  wire [4:0] E_q0;
  wire [8:0] S_address0;
  reg S_ce0;
  wire [3:0] S_q0;
  wire [4:0] P_address0;
  reg P_ce0;
  wire [4:0] P_q0;
  wire [5:0] PI_address0;
  reg PI_ce0;
  wire [5:0] PI_q0;
  wire [63:0] zext_ln105_fu_443_p1;
  reg [63:0] zext_ln105_reg_1113;
  wire ap_CS_fsm_state2;
  wire [4:0] add_ln105_fu_454_p2;
  reg [4:0] add_ln105_reg_1121;
  wire [0:0] icmp_ln105_fu_448_p2;
  reg [1:0] iteration_shift_load_reg_1159;
  wire ap_CS_fsm_state3;
  wire [1:0] j_1_fu_483_p2;
  wire ap_CS_fsm_state4;
  wire [63:0] zext_ln121_fu_577_p1;
  reg [63:0] zext_ln121_reg_1172;
  wire [0:0] icmp_ln110_fu_478_p2;
  reg [3:0] sub_key_addr_reg_1177;
  wire [5:0] add_ln124_fu_592_p2;
  reg [5:0] add_ln124_reg_1185;
  wire ap_CS_fsm_state5;
  wire [0:0] icmp_ln124_fu_586_p2;
  wire [46:0] trunc_ln129_1_fu_598_p1;
  reg [46:0] trunc_ln129_1_reg_1195;
  wire [47:0] or_ln_fu_625_p3;
  wire ap_CS_fsm_state6;
  wire [63:0] zext_ln229_fu_638_p1;
  reg [63:0] zext_ln229_reg_1208;
  wire ap_CS_fsm_state7;
  wire [4:0] add_ln229_fu_648_p2;
  reg [4:0] add_ln229_reg_1216;
  wire [63:0] pre_output_fu_654_p3;
  reg [63:0] pre_output_reg_1235;
  wire [0:0] icmp_ln229_fu_642_p2;
  wire [5:0] add_ln236_fu_683_p2;
  reg [5:0] add_ln236_reg_1243;
  wire ap_CS_fsm_state8;
  wire [0:0] icmp_ln236_fu_677_p2;
  wire [61:0] s_input_2_fu_712_p3;
  wire ap_CS_fsm_state9;
  wire [47:0] s_input_fu_732_p2;
  reg [47:0] s_input_reg_1263;
  wire ap_CS_fsm_state10;
  wire [46:0] xor_ln222_fu_738_p2;
  reg [46:0] xor_ln222_reg_1268;
  wire [3:0] add_ln253_fu_762_p2;
  reg [3:0] add_ln253_reg_1276;
  wire ap_CS_fsm_state11;
  wire [0:0] icmp_ln253_fu_756_p2;
  wire [5:0] add_ln269_fu_965_p2;
  reg [5:0] add_ln269_reg_1289;
  wire ap_CS_fsm_state13;
  wire [0:0] icmp_ln269_fu_959_p2;
  wire [30:0] trunc_ln274_1_fu_971_p1;
  reg [30:0] trunc_ln274_1_reg_1299;
  wire [31:0] f_function_res_1_fu_1014_p3;
  wire ap_CS_fsm_state14;
  wire ap_CS_fsm_state15;
  wire [0:0] icmp_ln308_fu_1029_p2;
  reg [1:0] j_reg_312;
  reg [5:0] j_3_reg_323;
  reg [47:0] shl2117_reg_334;
  reg [5:0] j_2_reg_346;
  reg [61:0] s_input_1_reg_357;
  reg [3:0] j_4_reg_369;
  wire ap_CS_fsm_state12;
  reg [5:0] j_5_reg_380;
  reg [31:0] f_function_res_reg_391;
  wire [63:0] zext_ln124_fu_581_p1;
  wire [63:0] zext_ln236_fu_672_p1;
  wire [63:0] zext_ln263_fu_932_p1;
  wire [63:0] zext_ln269_fu_954_p1;
  wire [63:0] zext_ln308_fu_1024_p1;
  reg [4:0] i_fu_154;
  reg [31:0] C1_fu_158;
  wire [31:0] zext_ln116_fu_509_p1;
  wire [31:0] C_cast_fu_421_p1;
  reg [31:0] D1_fu_162;
  wire [31:0] zext_ln110_fu_533_p1;
  wire [31:0] D_cast_fu_417_p1;
  reg [31:0] L1_fu_166;
  reg [4:0] i_4_fu_170;
  reg [31:0] s_output_fu_174;
  wire [31:0] s_output_1_fu_941_p3;
  reg [31:0] L1_1_fu_178;
  wire [31:0] R1_fu_975_p2;
  reg [63:0] inv_init_perm_res_fu_182;
  wire [63:0] inv_init_perm_res_1_fu_1069_p3;
  wire ap_CS_fsm_state16;
  reg [6:0] i_5_fu_186;
  wire [6:0] add_ln308_fu_1035_p2;
  wire [26:0] trunc_ln114_fu_497_p1;
  wire [0:0] tmp_1_fu_489_p3;
  wire [27:0] C1_1_fu_501_p3;
  wire [26:0] trunc_ln116_fu_521_p1;
  wire [0:0] tmp_2_fu_513_p3;
  wire [27:0] D1_1_fu_525_p3;
  wire [31:0] shl_ln121_fu_547_p2;
  wire [27:0] tmp_fu_559_p4;
  wire [31:0] or_ln121_fu_553_p2;
  wire [59:0] permuted_choice_2_fu_569_p3;
  wire [5:0] sub_ln129_fu_606_p2;
  wire [63:0] zext_ln129_fu_612_p1;
  wire [63:0] lshr_ln129_fu_616_p2;
  wire [0:0] trunc_ln129_fu_621_p1;
  wire [4:0] sub_ln241_fu_689_p2;
  wire [31:0] zext_ln241_fu_695_p1;
  wire [31:0] lshr_ln241_fu_699_p2;
  wire [60:0] trunc_ln241_1_fu_708_p1;
  wire [0:0] trunc_ln241_fu_704_p1;
  wire [47:0] trunc_ln236_fu_720_p1;
  wire [46:0] trunc_ln250_1_fu_728_p1;
  wire [46:0] trunc_ln250_fu_724_p1;
  wire [2:0] trunc_ln263_fu_744_p1;
  wire [5:0] shl_ln1_fu_768_p3;
  wire [3:0] shl_ln257_fu_780_p2;
  wire [6:0] zext_ln257_fu_776_p1;
  wire [6:0] zext_ln257_1_fu_786_p1;
  wire signed [6:0] sub_ln257_1_fu_790_p2;
  wire signed [63:0] sext_ln257_fu_796_p1;
  wire [63:0] lshr_ln257_fu_800_p2;
  wire [47:0] trunc_ln257_fu_806_p1;
  wire [47:0] and_ln257_fu_810_p2;
  wire [6:0] sub_ln257_fu_819_p2;
  wire [63:0] zext_ln257_2_fu_815_p1;
  wire signed [63:0] sext_ln257_1_fu_825_p1;
  wire [63:0] lshr_ln257_1_fu_829_p2;
  wire [0:0] tmp_3_fu_839_p3;
  wire [0:0] trunc_ln217_fu_835_p1;
  wire [63:0] lshr_ln260_fu_863_p2;
  wire [46:0] trunc_ln260_fu_869_p1;
  wire [46:0] and_ln260_fu_873_p2;
  wire [6:0] sub_ln260_fu_882_p2;
  wire [63:0] zext_ln260_fu_878_p1;
  wire signed [63:0] sext_ln260_fu_888_p1;
  wire [63:0] lshr_ln260_1_fu_892_p2;
  wire [2:0] tmp_7_fu_853_p4;
  wire [0:0] or_ln258_fu_847_p2;
  wire [7:0] shl_ln2_fu_902_p4;
  wire [7:0] column_fu_898_p1;
  wire signed [8:0] sext_ln263_fu_912_p1;
  wire signed [8:0] sext_ln263_1_fu_916_p1;
  wire [8:0] tmp_9_fu_748_p3;
  wire [8:0] add_ln263_fu_920_p2;
  wire [8:0] add_ln263_1_fu_926_p2;
  wire [27:0] trunc_ln263_1_fu_937_p1;
  wire [4:0] sub_ln274_fu_994_p2;
  wire [31:0] zext_ln274_fu_1000_p1;
  wire [31:0] lshr_ln274_fu_1004_p2;
  wire [0:0] trunc_ln274_fu_1010_p1;
  wire [5:0] sub_ln313_fu_1046_p2;
  wire [63:0] zext_ln313_fu_1052_p1;
  wire [63:0] lshr_ln313_fu_1056_p2;
  wire [62:0] trunc_ln313_1_fu_1065_p1;
  wire [0:0] trunc_ln313_fu_1061_p1;
  reg [15:0] ap_NS_fsm;
  reg ap_ST_fsm_state1_blk;
  wire ap_ST_fsm_state2_blk;
  wire ap_ST_fsm_state3_blk;
  wire ap_ST_fsm_state4_blk;
  wire ap_ST_fsm_state5_blk;
  wire ap_ST_fsm_state6_blk;
  wire ap_ST_fsm_state7_blk;
  wire ap_ST_fsm_state8_blk;
  wire ap_ST_fsm_state9_blk;
  wire ap_ST_fsm_state10_blk;
  wire ap_ST_fsm_state11_blk;
  wire ap_ST_fsm_state12_blk;
  wire ap_ST_fsm_state13_blk;
  wire ap_ST_fsm_state14_blk;
  wire ap_ST_fsm_state15_blk;
  wire ap_ST_fsm_state16_blk;
  wire ap_ce_reg;

  initial begin
    #0 ap_CS_fsm = 16'd1;
  end


  top_function_shiftingcidi_iteration_shift_ROM_AUTO_1R
  #(
    .DataWidth(2),
    .AddressRange(16),
    .AddressWidth(4)
  )
  iteration_shift_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(iteration_shift_address0),
    .ce0(~iteration_shift_ce0),
    .q0(iteration_shift_q0)
  );


  top_function_shiftingcidi_PC2_ROM_AUTO_1R
  #(
    .DataWidth(6),
    .AddressRange(48),
    .AddressWidth(6)
  )
  PC2_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(PC2_address0),
    .ce0(PC2_ce0),
    .q0(PC2_q0)
  );


  top_function_shiftingcidi_sub_key_RAM_AUTO_1R1W
  #(
    .DataWidth(48),
    .AddressRange(16),
    .AddressWidth(4)
  )
  sub_key_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(sub_key_address0),
    .ce0(~sub_key_ce0),
    .we0(sub_key_we0),
    .d0(shl2117_reg_334),
    .q0(sub_key_q0)
  );


  top_function_shiftingcidi_E_ROM_AUTO_1R
  #(
    .DataWidth(5),
    .AddressRange(48),
    .AddressWidth(6)
  )
  E_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(E_address0),
    .ce0(~E_ce0),
    .q0(E_q0)
  );


  top_function_shiftingcidi_S_ROM_AUTO_1R
  #(
    .DataWidth(4),
    .AddressRange(512),
    .AddressWidth(9)
  )
  S_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(S_address0),
    .ce0(S_ce0),
    .q0(S_q0)
  );


  top_function_shiftingcidi_P_ROM_AUTO_1R
  #(
    .DataWidth(5),
    .AddressRange(32),
    .AddressWidth(5)
  )
  P_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(P_address0),
    .ce0(~P_ce0),
    .q0(P_q0)
  );


  top_function_shiftingcidi_PI_ROM_AUTO_1R
  #(
    .DataWidth(6),
    .AddressRange(64),
    .AddressWidth(6)
  )
  PI_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(PI_address0),
    .ce0(PI_ce0),
    .q0(PI_q0)
  );


  always @(posedge ap_clk) begin
    if(ap_rst == 1'b1) begin
      ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
      ap_CS_fsm <= ap_NS_fsm;
    end
  end


  always @(posedge ap_clk) begin
    if((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)) begin
      C1_fu_158[27:0] <= C_cast_fu_421_p1[27:0];
    end else if((1'b1 == ap_CS_fsm_state4) & (icmp_ln110_fu_478_p2 == 1'd0)) begin
      C1_fu_158[27:0] <= zext_ln116_fu_509_p1[27:0];
    end 
  end


  always @(posedge ap_clk) begin
    if((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)) begin
      D1_fu_162[27:0] <= D_cast_fu_417_p1[27:0];
    end else if((1'b1 == ap_CS_fsm_state4) & (icmp_ln110_fu_478_p2 == 1'd0)) begin
      D1_fu_162[27:0] <= zext_ln110_fu_533_p1[27:0];
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state2) & (icmp_ln105_fu_448_p2 == 1'd1)) begin
      L1_1_fu_178 <= R;
    end else if((icmp_ln269_fu_959_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state13)) begin
      L1_1_fu_178 <= R1_fu_975_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state2) & (icmp_ln105_fu_448_p2 == 1'd1)) begin
      L1_fu_166 <= L;
    end else if((icmp_ln269_fu_959_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state13)) begin
      L1_fu_166 <= L1_1_fu_178;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln253_fu_756_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state11)) begin
      f_function_res_reg_391 <= 32'd0;
    end else if(1'b1 == ap_CS_fsm_state14) begin
      f_function_res_reg_391 <= f_function_res_1_fu_1014_p3;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state2) & (icmp_ln105_fu_448_p2 == 1'd1)) begin
      i_4_fu_170 <= ~5'd0;
    end else if((icmp_ln269_fu_959_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state13)) begin
      i_4_fu_170 <= add_ln229_reg_1216;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state7) & (icmp_ln229_fu_642_p2 == 1'd1)) begin
      i_5_fu_186 <= 7'd0;
    end else if((icmp_ln308_fu_1029_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state15)) begin
      i_5_fu_186 <= add_ln308_fu_1035_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)) begin
      i_fu_154 <= ~5'd0;
    end else if((1'b1 == ap_CS_fsm_state5) & (icmp_ln124_fu_586_p2 == 1'd1)) begin
      i_fu_154 <= add_ln105_reg_1121;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state7) & (icmp_ln229_fu_642_p2 == 1'd1)) begin
      inv_init_perm_res_fu_182 <= ~64'd0;
    end else if(1'b1 == ap_CS_fsm_state16) begin
      inv_init_perm_res_fu_182 <= inv_init_perm_res_1_fu_1069_p3;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state7) & (icmp_ln229_fu_642_p2 == 1'd0)) begin
      j_2_reg_346 <= 6'd0;
    end else if(1'b1 == ap_CS_fsm_state9) begin
      j_2_reg_346 <= add_ln236_reg_1243;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state4) & (icmp_ln110_fu_478_p2 == 1'd1)) begin
      j_3_reg_323 <= 6'd0;
    end else if(1'b1 == ap_CS_fsm_state6) begin
      j_3_reg_323 <= add_ln124_reg_1185;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state10) begin
      j_4_reg_369 <= 4'd0;
    end else if(1'b1 == ap_CS_fsm_state12) begin
      j_4_reg_369 <= add_ln253_reg_1276;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln253_fu_756_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state11)) begin
      j_5_reg_380 <= 6'd0;
    end else if(1'b1 == ap_CS_fsm_state14) begin
      j_5_reg_380 <= add_ln269_reg_1289;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state4) & (icmp_ln110_fu_478_p2 == 1'd0)) begin
      j_reg_312 <= j_1_fu_483_p2;
    end else if(1'b1 == ap_CS_fsm_state3) begin
      j_reg_312 <= 2'd0;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state7) & (icmp_ln229_fu_642_p2 == 1'd0)) begin
      s_input_1_reg_357 <= 62'd0;
    end else if(1'b1 == ap_CS_fsm_state9) begin
      s_input_1_reg_357 <= s_input_2_fu_712_p3;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state2) & (icmp_ln105_fu_448_p2 == 1'd1)) begin
      s_output_fu_174 <= 32'd0;
    end else if(1'b1 == ap_CS_fsm_state12) begin
      s_output_fu_174 <= s_output_1_fu_941_p3;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state4) & (icmp_ln110_fu_478_p2 == 1'd1)) begin
      shl2117_reg_334 <= 48'd0;
    end else if(1'b1 == ap_CS_fsm_state6) begin
      shl2117_reg_334 <= or_ln_fu_625_p3;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state2) begin
      add_ln105_reg_1121 <= add_ln105_fu_454_p2;
      zext_ln105_reg_1113[4:0] <= zext_ln105_fu_443_p1[4:0];
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state5) begin
      add_ln124_reg_1185 <= add_ln124_fu_592_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state7) begin
      add_ln229_reg_1216 <= add_ln229_fu_648_p2;
      zext_ln229_reg_1208[4:0] <= zext_ln229_fu_638_p1[4:0];
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state8) begin
      add_ln236_reg_1243 <= add_ln236_fu_683_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state11) begin
      add_ln253_reg_1276 <= add_ln253_fu_762_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state13) begin
      add_ln269_reg_1289 <= add_ln269_fu_965_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state3) begin
      iteration_shift_load_reg_1159 <= ~iteration_shift_q0;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state7) & (icmp_ln229_fu_642_p2 == 1'd1)) begin
      pre_output_reg_1235 <= pre_output_fu_654_p3;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state10) begin
      s_input_reg_1263 <= s_input_fu_732_p2;
      xor_ln222_reg_1268 <= xor_ln222_fu_738_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state4) & (icmp_ln110_fu_478_p2 == 1'd1)) begin
      sub_key_addr_reg_1177 <= zext_ln105_reg_1113;
      zext_ln121_reg_1172[55:0] <= zext_ln121_fu_577_p1[55:0];
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state5) & (icmp_ln124_fu_586_p2 == 1'd0)) begin
      trunc_ln129_1_reg_1195 <= trunc_ln129_1_fu_598_p1;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln269_fu_959_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state13)) begin
      trunc_ln274_1_reg_1299 <= trunc_ln274_1_fu_971_p1;
    end 
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state8) begin
      E_ce0 = ~1'b1;
    end else begin
      E_ce0 = ~1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state5) begin
      PC2_ce0 = 1'b1;
    end else begin
      PC2_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state15) begin
      PI_ce0 = 1'b1;
    end else begin
      PI_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state13) begin
      P_ce0 = ~1'b1;
    end else begin
      P_ce0 = ~1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state11) begin
      S_ce0 = 1'b1;
    end else begin
      S_ce0 = 1'b0;
    end
  end

  assign ap_ST_fsm_state10_blk = 1'b0;
  assign ap_ST_fsm_state11_blk = 1'b0;
  assign ap_ST_fsm_state12_blk = 1'b0;
  assign ap_ST_fsm_state13_blk = 1'b0;
  assign ap_ST_fsm_state14_blk = 1'b0;
  assign ap_ST_fsm_state15_blk = 1'b0;
  assign ap_ST_fsm_state16_blk = 1'b0;

  always @(*) begin
    if(ap_start == 1'b0) begin
      ap_ST_fsm_state1_blk = 1'b1;
    end else begin
      ap_ST_fsm_state1_blk = 1'b0;
    end
  end

  assign ap_ST_fsm_state2_blk = 1'b0;
  assign ap_ST_fsm_state3_blk = 1'b0;
  assign ap_ST_fsm_state4_blk = 1'b0;
  assign ap_ST_fsm_state5_blk = 1'b0;
  assign ap_ST_fsm_state6_blk = 1'b0;
  assign ap_ST_fsm_state7_blk = 1'b0;
  assign ap_ST_fsm_state8_blk = 1'b0;
  assign ap_ST_fsm_state9_blk = 1'b0;

  always @(*) begin
    if((icmp_ln308_fu_1029_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state15) | (ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)) begin
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
    if((icmp_ln308_fu_1029_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state15)) begin
      ap_ready = 1'b1;
    end else begin
      ap_ready = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state2) begin
      iteration_shift_ce0 = ~1'b1;
    end else begin
      iteration_shift_ce0 = ~1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state8) begin
      sub_key_address0 = ~zext_ln229_reg_1208;
    end else if(1'b1 == ap_CS_fsm_state5) begin
      sub_key_address0 = sub_key_addr_reg_1177;
    end else begin
      sub_key_address0 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state5)) begin
      sub_key_ce0 = ~1'b1;
    end else begin
      sub_key_ce0 = ~1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state5) & (icmp_ln124_fu_586_p2 == 1'd1)) begin
      sub_key_we0 = 1'b1;
    end else begin
      sub_key_we0 = 1'b0;
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
        if((1'b1 == ap_CS_fsm_state2) & (icmp_ln105_fu_448_p2 == 1'd1)) begin
          ap_NS_fsm = ap_ST_fsm_state7;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state3;
        end
      end
      ap_ST_fsm_state3: begin
        ap_NS_fsm = ap_ST_fsm_state4;
      end
      ap_ST_fsm_state4: begin
        if((1'b1 == ap_CS_fsm_state4) & (icmp_ln110_fu_478_p2 == 1'd1)) begin
          ap_NS_fsm = ap_ST_fsm_state5;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state4;
        end
      end
      ap_ST_fsm_state5: begin
        if((1'b1 == ap_CS_fsm_state5) & (icmp_ln124_fu_586_p2 == 1'd1)) begin
          ap_NS_fsm = ap_ST_fsm_state2;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state6;
        end
      end
      ap_ST_fsm_state6: begin
        ap_NS_fsm = ap_ST_fsm_state5;
      end
      ap_ST_fsm_state7: begin
        if((1'b1 == ap_CS_fsm_state7) & (icmp_ln229_fu_642_p2 == 1'd1)) begin
          ap_NS_fsm = ap_ST_fsm_state15;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state8;
        end
      end
      ap_ST_fsm_state8: begin
        if((1'b1 == ap_CS_fsm_state8) & (icmp_ln236_fu_677_p2 == 1'd1)) begin
          ap_NS_fsm = ap_ST_fsm_state10;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state9;
        end
      end
      ap_ST_fsm_state9: begin
        ap_NS_fsm = ap_ST_fsm_state8;
      end
      ap_ST_fsm_state10: begin
        ap_NS_fsm = ap_ST_fsm_state11;
      end
      ap_ST_fsm_state11: begin
        if((icmp_ln253_fu_756_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state11)) begin
          ap_NS_fsm = ap_ST_fsm_state13;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state12;
        end
      end
      ap_ST_fsm_state12: begin
        ap_NS_fsm = ap_ST_fsm_state11;
      end
      ap_ST_fsm_state13: begin
        if((icmp_ln269_fu_959_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state13)) begin
          ap_NS_fsm = ap_ST_fsm_state7;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state14;
        end
      end
      ap_ST_fsm_state14: begin
        ap_NS_fsm = ap_ST_fsm_state13;
      end
      ap_ST_fsm_state15: begin
        if((icmp_ln308_fu_1029_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state15)) begin
          ap_NS_fsm = ap_ST_fsm_state1;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state16;
        end
      end
      ap_ST_fsm_state16: begin
        ap_NS_fsm = ap_ST_fsm_state15;
      end
      default: begin
        ap_NS_fsm = 'bx;
      end
    endcase
  end

  assign C1_1_fu_501_p3 = { { trunc_ln114_fu_497_p1 }, { tmp_1_fu_489_p3 } };
  assign C_cast_fu_421_p1 = ~C;
  assign D1_1_fu_525_p3 = { { trunc_ln116_fu_521_p1 }, { tmp_2_fu_513_p3 } };
  assign D_cast_fu_417_p1 = D;
  assign E_address0 = zext_ln236_fu_672_p1;
  assign PC2_address0 = zext_ln124_fu_581_p1;
  assign PI_address0 = zext_ln308_fu_1024_p1;
  assign P_address0 = zext_ln269_fu_954_p1;
  assign R1_fu_975_p2 = f_function_res_reg_391 ^ L1_fu_166;
  assign S_address0 = zext_ln263_fu_932_p1;
  assign add_ln105_fu_454_p2 = i_fu_154 + (~5'd1 + 1);
  assign add_ln124_fu_592_p2 = j_3_reg_323 + (6'd1 + (~1 + 1) + (1 + (~1 + 1) + 1) + (~1 + 1) + 1);
  assign add_ln229_fu_648_p2 = i_4_fu_170 + (~5'd1 + 1);
  assign add_ln236_fu_683_p2 = j_2_reg_346 + 6'd1;
  assign add_ln253_fu_762_p2 = j_4_reg_369 + 4'd1;
  assign add_ln263_1_fu_926_p2 = tmp_9_fu_748_p3 + add_ln263_fu_920_p2;
  assign add_ln263_fu_920_p2 = $signed(sext_ln263_fu_912_p1) + $signed(sext_ln263_1_fu_916_p1);
  assign add_ln269_fu_965_p2 = j_5_reg_380 + 6'd1;
  assign add_ln308_fu_1035_p2 = i_5_fu_186 + 7'd1;
  assign and_ln257_fu_810_p2 = trunc_ln257_fu_806_p1 & s_input_reg_1263;
  assign and_ln260_fu_873_p2 = xor_ln222_reg_1268 & trunc_ln260_fu_869_p1;
  assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];
  assign ap_CS_fsm_state10 = ap_CS_fsm[32'd9];
  assign ap_CS_fsm_state11 = ap_CS_fsm[32'd10];
  assign ap_CS_fsm_state12 = ap_CS_fsm[32'd11];
  assign ap_CS_fsm_state13 = ap_CS_fsm[32'd12];
  assign ap_CS_fsm_state14 = ap_CS_fsm[32'd13];
  assign ap_CS_fsm_state15 = ap_CS_fsm[32'd14];
  assign ap_CS_fsm_state16 = ap_CS_fsm[32'd15];
  assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];
  assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];
  assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];
  assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];
  assign ap_CS_fsm_state6 = ap_CS_fsm[32'd5];
  assign ap_CS_fsm_state7 = ap_CS_fsm[32'd6];
  assign ap_CS_fsm_state8 = ap_CS_fsm[32'd7];
  assign ap_CS_fsm_state9 = ap_CS_fsm[32'd8];
  assign ap_return = ~inv_init_perm_res_fu_182;
  assign column_fu_898_p1 = lshr_ln260_1_fu_892_p2[7:0];
  assign f_function_res_1_fu_1014_p3 = { { trunc_ln274_1_reg_1299 }, { trunc_ln274_fu_1010_p1 } };
  assign icmp_ln105_fu_448_p2 = (~i_fu_154 == 5'd16)? 1'b1 : 1'b0;
  assign icmp_ln110_fu_478_p2 = (j_reg_312 == ~iteration_shift_load_reg_1159)? 1'b1 : 1'b0;
  assign icmp_ln124_fu_586_p2 = (j_3_reg_323 == 6'd48)? 1'b1 : 1'b0;
  assign icmp_ln229_fu_642_p2 = (~i_4_fu_170 == 5'd16)? 1'b1 : 1'b0;
  assign icmp_ln236_fu_677_p2 = (j_2_reg_346 == 6'd48)? 1'b1 : 1'b0;
  assign icmp_ln253_fu_756_p2 = (j_4_reg_369 == 4'd8)? 1'b1 : 1'b0;
  assign icmp_ln269_fu_959_p2 = (j_5_reg_380 == 6'd32)? 1'b1 : 1'b0;
  assign icmp_ln308_fu_1029_p2 = (i_5_fu_186 == 7'd64)? 1'b1 : 1'b0;
  assign inv_init_perm_res_1_fu_1069_p3 = { { trunc_ln313_1_fu_1065_p1 }, { trunc_ln313_fu_1061_p1 } };
  assign iteration_shift_address0 = zext_ln105_fu_443_p1;
  assign j_1_fu_483_p2 = j_reg_312 + 2'd1;
  assign lshr_ln129_fu_616_p2 = zext_ln121_reg_1172 >> zext_ln129_fu_612_p1;
  assign lshr_ln241_fu_699_p2 = L1_1_fu_178 >> zext_ln241_fu_695_p1;
  assign lshr_ln257_1_fu_829_p2 = zext_ln257_2_fu_815_p1 >> sext_ln257_1_fu_825_p1;
  assign lshr_ln257_fu_800_p2 = 64'd145135534866432 >> sext_ln257_fu_796_p1;
  assign lshr_ln260_1_fu_892_p2 = zext_ln260_fu_878_p1 >> sext_ln260_fu_888_p1;
  assign lshr_ln260_fu_863_p2 = 64'd131941395333120 >> sext_ln257_fu_796_p1;
  assign lshr_ln274_fu_1004_p2 = s_output_fu_174 >> zext_ln274_fu_1000_p1;
  assign lshr_ln313_fu_1056_p2 = ~(pre_output_reg_1235 >> zext_ln313_fu_1052_p1);
  assign or_ln121_fu_553_p2 = shl_ln121_fu_547_p2 | D1_fu_162;
  assign or_ln258_fu_847_p2 = trunc_ln217_fu_835_p1 | tmp_3_fu_839_p3;
  assign or_ln_fu_625_p3 = { { trunc_ln129_1_reg_1195 }, { trunc_ln129_fu_621_p1 } };
  assign permuted_choice_2_fu_569_p3 = { { tmp_fu_559_p4 }, { or_ln121_fu_553_p2 } };
  assign pre_output_fu_654_p3 = { { L1_1_fu_178 }, { L1_fu_166 } };
  assign s_input_2_fu_712_p3 = { { trunc_ln241_1_fu_708_p1 }, { trunc_ln241_fu_704_p1 } };
  assign s_input_fu_732_p2 = trunc_ln236_fu_720_p1 ^ sub_key_q0;
  assign s_output_1_fu_941_p3 = { { trunc_ln263_1_fu_937_p1 }, { S_q0 } };
  assign sext_ln257_1_fu_825_p1 = $signed(sub_ln257_fu_819_p2);
  assign sext_ln257_fu_796_p1 = sub_ln257_1_fu_790_p2;
  assign sext_ln260_fu_888_p1 = $signed(sub_ln260_fu_882_p2);
  assign sext_ln263_1_fu_916_p1 = $signed(column_fu_898_p1);
  assign sext_ln263_fu_912_p1 = $signed(shl_ln2_fu_902_p4);
  assign shl_ln121_fu_547_p2 = ~C1_fu_158 << 32'd28;
  assign shl_ln1_fu_768_p3 = { { trunc_ln263_fu_744_p1 }, { 3'd0 } };
  assign shl_ln257_fu_780_p2 = j_4_reg_369 << 4'd1;
  assign shl_ln2_fu_902_p4 = { { { tmp_7_fu_853_p4 }, { or_ln258_fu_847_p2 } }, { 4'd0 } };
  assign sub_ln129_fu_606_p2 = $signed(6'd56) - $signed(PC2_q0);
  assign sub_ln241_fu_689_p2 = 5'd0 - E_q0;
  assign sub_ln257_1_fu_790_p2 = zext_ln257_fu_776_p1 - zext_ln257_1_fu_786_p1;
  assign sub_ln257_fu_819_p2 = $signed(7'd42) - $signed(sub_ln257_1_fu_790_p2);
  assign sub_ln260_fu_882_p2 = $signed(7'd43) - $signed(sub_ln257_1_fu_790_p2);
  assign sub_ln274_fu_994_p2 = 5'd0 - P_q0;
  assign sub_ln313_fu_1046_p2 = 6'd0 - PI_q0;
  assign tmp_1_fu_489_p3 = C1_fu_158[32'd27];
  assign tmp_2_fu_513_p3 = D1_fu_162[32'd27];
  assign tmp_3_fu_839_p3 = lshr_ln257_1_fu_829_p2[32'd4];
  assign tmp_7_fu_853_p4 = { { lshr_ln257_1_fu_829_p2[7:5] } };
  assign tmp_9_fu_748_p3 = { { trunc_ln263_fu_744_p1 }, { 6'd0 } };
  assign tmp_fu_559_p4 = { { ~C1_fu_158[31:4] } };
  assign trunc_ln114_fu_497_p1 = C1_fu_158[26:0];
  assign trunc_ln116_fu_521_p1 = D1_fu_162[26:0];
  assign trunc_ln129_1_fu_598_p1 = shl2117_reg_334[46:0];
  assign trunc_ln129_fu_621_p1 = lshr_ln129_fu_616_p2[0:0];
  assign trunc_ln217_fu_835_p1 = lshr_ln257_1_fu_829_p2[0:0];
  assign trunc_ln236_fu_720_p1 = s_input_1_reg_357[47:0];
  assign trunc_ln241_1_fu_708_p1 = s_input_1_reg_357[60:0];
  assign trunc_ln241_fu_704_p1 = lshr_ln241_fu_699_p2[0:0];
  assign trunc_ln250_1_fu_728_p1 = sub_key_q0[46:0];
  assign trunc_ln250_fu_724_p1 = s_input_1_reg_357[46:0];
  assign trunc_ln257_fu_806_p1 = lshr_ln257_fu_800_p2[47:0];
  assign trunc_ln260_fu_869_p1 = lshr_ln260_fu_863_p2[46:0];
  assign trunc_ln263_1_fu_937_p1 = s_output_fu_174[27:0];
  assign trunc_ln263_fu_744_p1 = j_4_reg_369[2:0];
  assign trunc_ln274_1_fu_971_p1 = f_function_res_reg_391[30:0];
  assign trunc_ln274_fu_1010_p1 = lshr_ln274_fu_1004_p2[0:0];
  assign trunc_ln313_1_fu_1065_p1 = inv_init_perm_res_fu_182[62:0];
  assign trunc_ln313_fu_1061_p1 = lshr_ln313_fu_1056_p2[0:0];
  assign xor_ln222_fu_738_p2 = trunc_ln250_fu_724_p1 ^ trunc_ln250_1_fu_728_p1;
  assign zext_ln105_fu_443_p1 = ~i_fu_154;
  assign zext_ln110_fu_533_p1 = D1_1_fu_525_p3;
  assign zext_ln116_fu_509_p1 = C1_1_fu_501_p3;
  assign zext_ln121_fu_577_p1 = permuted_choice_2_fu_569_p3;
  assign zext_ln124_fu_581_p1 = j_3_reg_323;
  assign zext_ln129_fu_612_p1 = sub_ln129_fu_606_p2;
  assign zext_ln229_fu_638_p1 = i_4_fu_170;
  assign zext_ln236_fu_672_p1 = j_2_reg_346;
  assign zext_ln241_fu_695_p1 = sub_ln241_fu_689_p2;
  assign zext_ln257_1_fu_786_p1 = shl_ln257_fu_780_p2;
  assign zext_ln257_2_fu_815_p1 = and_ln257_fu_810_p2;
  assign zext_ln257_fu_776_p1 = shl_ln1_fu_768_p3;
  assign zext_ln260_fu_878_p1 = and_ln260_fu_873_p2;
  assign zext_ln263_fu_932_p1 = add_ln263_1_fu_926_p2;
  assign zext_ln269_fu_954_p1 = j_5_reg_380;
  assign zext_ln274_fu_1000_p1 = sub_ln274_fu_994_p2;
  assign zext_ln308_fu_1024_p1 = i_5_fu_186;
  assign zext_ln313_fu_1052_p1 = sub_ln313_fu_1046_p2;

  always @(posedge ap_clk) begin
    zext_ln105_reg_1113[63:5] <= 59'b00000000000000000000000000000000000000000000000000000000000;
    zext_ln121_reg_1172[63:56] <= 8'b00000000;
    zext_ln229_reg_1208[63:5] <= ~59'b00000000000000000000000000000000000000000000000000000000000;
    C1_fu_158[31:28] <= ~4'b0000;
    D1_fu_162[31:28] <= 4'b0000;
  end


endmodule



