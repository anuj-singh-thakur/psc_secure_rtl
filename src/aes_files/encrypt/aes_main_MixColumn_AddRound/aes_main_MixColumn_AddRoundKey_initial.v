`timescale 1 ns / 1 ps


module aes_main_MixColumn_AddRoundKey
(
  ap_clk,
  ap_rst,
  ap_start,
  ap_done,
  ap_idle,
  ap_ready,
  statemt_address0,
  statemt_ce0,
  statemt_we0,
  statemt_d0,
  statemt_q0,
  statemt_address1,
  statemt_ce1,
  statemt_we1,
  statemt_d1,
  statemt_q1,
  n
);

  parameter ap_ST_fsm_state1 = 9'd1;
  parameter ap_ST_fsm_state2 = 9'd2;
  parameter ap_ST_fsm_state3 = 9'd4;
  parameter ap_ST_fsm_state4 = 9'd8;
  parameter ap_ST_fsm_state5 = 9'd16;
  parameter ap_ST_fsm_state6 = 9'd32;
  parameter ap_ST_fsm_state7 = 9'd64;
  parameter ap_ST_fsm_state8 = 9'd128;
  parameter ap_ST_fsm_state9 = 9'd256;
  input ap_clk;
  input ap_rst;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  output [4:0] statemt_address0;
  output statemt_ce0;
  output statemt_we0;
  output [31:0] statemt_d0;
  input [31:0] statemt_q0;
  output [4:0] statemt_address1;
  output statemt_ce1;
  output statemt_we1;
  output [31:0] statemt_d1;
  input [31:0] statemt_q1;
  input [3:0] n;
  reg ap_done;
  reg ap_idle;
  reg ap_ready;
  reg [4:0] statemt_address0;
  reg statemt_ce0;
  reg statemt_we0;
  reg [4:0] statemt_address1;
  reg statemt_ce1;
  reg statemt_we1;
  (* fsm_encoding = "none" *)
  reg [8:0] ap_CS_fsm;
  wire ap_CS_fsm_state1;
  reg [8:0] MixColumn_AddRoundKey_word_address0;
  reg MixColumn_AddRoundKey_word_ce0;
  wire [31:0] MixColumn_AddRoundKey_word_q0;
  reg [8:0] MixColumn_AddRoundKey_word_address1;
  reg MixColumn_AddRoundKey_word_ce1;
  wire [31:0] MixColumn_AddRoundKey_word_q1;
  wire [5:0] mul_fu_285_p3;
  reg [5:0] mul_reg_882;
  wire [3:0] shl_ln_fu_321_p3;
  reg [3:0] shl_ln_reg_890;
  wire ap_CS_fsm_state2;
  wire [0:0] icmp_ln381_fu_305_p2;
  wire [63:0] zext_ln383_fu_329_p1;
  reg [63:0] zext_ln383_reg_896;
  wire [63:0] zext_ln386_fu_340_p1;
  reg [63:0] zext_ln386_reg_906;
  wire [5:0] add_ln393_fu_345_p2;
  reg [5:0] add_ln393_reg_916;
  reg [31:0] x_9_reg_930;
  wire ap_CS_fsm_state3;
  wire [0:0] icmp_ln384_fu_368_p2;
  reg [0:0] icmp_ln384_reg_938;
  reg [31:0] x_reg_943;
  wire [63:0] zext_ln393_fu_379_p1;
  reg [63:0] zext_ln393_reg_951;
  wire [63:0] zext_ln393_1_fu_389_p1;
  reg [63:0] zext_ln393_1_reg_961;
  wire [0:0] icmp_ln396_fu_420_p2;
  reg [0:0] icmp_ln396_reg_981;
  wire [31:0] shl_ln383_fu_426_p2;
  reg [31:0] shl_ln383_reg_986;
  wire ap_CS_fsm_state4;
  wire [31:0] shl_ln387_fu_444_p2;
  reg [31:0] shl_ln387_reg_991;
  reg [31:0] x_3_reg_997;
  reg [31:0] x_6_reg_1002;
  wire [31:0] xor_ln392_fu_535_p2;
  reg [31:0] xor_ln392_reg_1019;
  wire [31:0] shl_ln399_fu_541_p2;
  reg [31:0] shl_ln399_reg_1024;
  wire [31:0] x_4_fu_547_p2;
  reg [31:0] x_4_reg_1030;
  wire [0:0] icmp_ln400_fu_571_p2;
  reg [0:0] icmp_ln400_reg_1036;
  reg [31:0] MixColumn_AddRoundKey_word_load_1_reg_1041;
  wire [0:0] icmp_ln408_fu_585_p2;
  reg [0:0] icmp_ln408_reg_1046;
  wire [0:0] icmp_ln420_fu_599_p2;
  reg [0:0] icmp_ln420_reg_1051;
  wire [31:0] xor_ln416_fu_724_p2;
  reg [31:0] xor_ln416_reg_1056;
  wire ap_CS_fsm_state5;
  wire [31:0] xor_ln428_fu_801_p2;
  reg [31:0] xor_ln428_reg_1061;
  wire [3:0] shl_ln4_fu_826_p3;
  reg [3:0] shl_ln4_reg_1069;
  wire ap_CS_fsm_state7;
  wire [0:0] icmp_ln434_fu_810_p2;
  wire [63:0] zext_ln436_fu_834_p1;
  reg [63:0] zext_ln436_reg_1075;
  wire [63:0] zext_ln437_fu_845_p1;
  reg [63:0] zext_ln437_reg_1085;
  wire [63:0] zext_ln438_fu_860_p1;
  reg [63:0] zext_ln438_reg_1095;
  wire ap_CS_fsm_state8;
  wire [63:0] zext_ln439_fu_870_p1;
  reg [63:0] zext_ln439_reg_1105;
  reg [4:0] ret_address0;
  reg ret_ce0;
  reg ret_we0;
  reg [31:0] ret_d0;
  wire [31:0] ret_q0;
  reg [4:0] ret_address1;
  reg ret_ce1;
  reg ret_we1;
  reg [31:0] ret_d1;
  wire [31:0] ret_q1;
  wire [63:0] zext_ln393_2_fu_394_p1;
  wire [63:0] zext_ln405_fu_407_p1;
  wire [63:0] zext_ln417_fu_501_p1;
  wire [63:0] zext_ln429_fu_512_p1;
  wire ap_CS_fsm_state6;
  wire ap_CS_fsm_state9;
  reg [2:0] j_fu_66;
  wire [2:0] add_ln381_fu_311_p2;
  reg [2:0] j_1_fu_74;
  wire [2:0] add_ln434_fu_816_p2;
  wire [31:0] xor_ln404_fu_642_p2;
  wire [1:0] trunc_ln383_fu_317_p1;
  wire [3:0] or_ln386_fu_334_p2;
  wire [5:0] zext_ln381_fu_301_p1;
  wire [23:0] grp_fu_265_p4;
  wire [31:0] and_ln_fu_360_p3;
  wire [3:0] or_ln393_fu_374_p2;
  wire [3:0] or_ln393_1_fu_384_p2;
  wire [7:0] zext_ln393_4_fu_398_p1;
  wire [7:0] add_ln405_fu_401_p2;
  wire [23:0] grp_fu_275_p4;
  wire [31:0] and_ln2_fu_412_p3;
  wire [31:0] xor_ln385_fu_431_p2;
  wire [31:0] x_1_fu_449_p2;
  wire [23:0] tmp_4_fu_454_p4;
  wire [31:0] and_ln1_fu_464_p3;
  wire [0:0] icmp_ln388_fu_472_p2;
  wire [31:0] xor_ln389_fu_478_p2;
  wire [8:0] zext_ln393_3_fu_492_p1;
  wire [8:0] add_ln417_fu_495_p2;
  wire [8:0] add_ln429_fu_506_p2;
  wire [31:0] select_ln384_fu_437_p3;
  wire [31:0] x_2_fu_484_p3;
  wire [31:0] xor_ln392_2_fu_523_p2;
  wire [31:0] xor_ln392_3_fu_529_p2;
  wire [31:0] xor_ln392_1_fu_517_p2;
  wire [23:0] tmp_7_fu_553_p4;
  wire [31:0] and_ln3_fu_563_p3;
  wire [31:0] and_ln4_fu_577_p3;
  wire [31:0] and_ln6_fu_591_p3;
  wire [31:0] xor_ln397_fu_605_p2;
  wire [31:0] xor_ln401_fu_616_p2;
  wire [31:0] select_ln396_fu_610_p3;
  wire [31:0] x_5_fu_621_p3;
  wire [31:0] xor_ln404_2_fu_631_p2;
  wire [31:0] xor_ln404_3_fu_637_p2;
  wire [31:0] xor_ln404_1_fu_627_p2;
  wire [31:0] xor_ln409_fu_649_p2;
  wire [31:0] shl_ln411_fu_660_p2;
  wire [31:0] x_7_fu_665_p2;
  wire [23:0] tmp_s_fu_670_p4;
  wire [31:0] and_ln5_fu_680_p3;
  wire [0:0] icmp_ln412_fu_688_p2;
  wire [31:0] xor_ln413_fu_694_p2;
  wire [31:0] select_ln408_fu_654_p3;
  wire [31:0] x_8_fu_700_p3;
  wire [31:0] xor_ln416_2_fu_712_p2;
  wire [31:0] xor_ln416_3_fu_718_p2;
  wire [31:0] xor_ln416_1_fu_708_p2;
  wire [31:0] xor_ln421_fu_730_p2;
  wire [31:0] x_10_fu_743_p2;
  wire [23:0] tmp_3_fu_747_p4;
  wire [31:0] and_ln7_fu_757_p3;
  wire [0:0] icmp_ln424_fu_765_p2;
  wire [31:0] xor_ln425_fu_771_p2;
  wire [31:0] x_11_fu_777_p3;
  wire [31:0] select_ln420_fu_736_p3;
  wire [31:0] xor_ln428_2_fu_789_p2;
  wire [31:0] xor_ln428_3_fu_795_p2;
  wire [31:0] xor_ln428_1_fu_785_p2;
  wire [1:0] trunc_ln436_fu_822_p1;
  wire [3:0] or_ln437_fu_839_p2;
  wire [3:0] or_ln438_fu_855_p2;
  wire [3:0] or_ln439_fu_865_p2;
  reg [8:0] ap_NS_fsm;
  reg ap_ST_fsm_state1_blk;
  wire ap_ST_fsm_state2_blk;
  wire ap_ST_fsm_state3_blk;
  wire ap_ST_fsm_state4_blk;
  wire ap_ST_fsm_state5_blk;
  wire ap_ST_fsm_state6_blk;
  wire ap_ST_fsm_state7_blk;
  wire ap_ST_fsm_state8_blk;
  wire ap_ST_fsm_state9_blk;
  wire ap_ce_reg;

  initial begin
    #0 ap_CS_fsm = 9'd1;
  end


  aes_main_MixColumn_AddRoundKey_MixColumn_AddRoundKey_word_ROM_AUTO_1R
  #(
    .DataWidth(32),
    .AddressRange(480),
    .AddressWidth(9)
  )
  MixColumn_AddRoundKey_word_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(MixColumn_AddRoundKey_word_address0),
    .ce0(MixColumn_AddRoundKey_word_ce0),
    .q0(MixColumn_AddRoundKey_word_q0),
    .address1(MixColumn_AddRoundKey_word_address1),
    .ce1(MixColumn_AddRoundKey_word_ce1),
    .q1(MixColumn_AddRoundKey_word_q1)
  );


  aes_main_MixColumn_AddRoundKey_ret_RAM_AUTO_1R1W
  #(
    .DataWidth(32),
    .AddressRange(32),
    .AddressWidth(5)
  )
  ret_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(ret_address0),
    .ce0(ret_ce0),
    .we0(ret_we0),
    .d0(ret_d0),
    .q0(ret_q0),
    .address1(ret_address1),
    .ce1(ret_ce1),
    .we1(ret_we1),
    .d1(ret_d1),
    .q1(ret_q1)
  );


  always @(posedge ap_clk) begin
    if(ap_rst == 1'b1) begin
      ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
      ap_CS_fsm <= ap_NS_fsm;
    end
  end


  always @(posedge ap_clk) begin
    if((icmp_ln381_fu_305_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state2)) begin
      j_1_fu_74 <= 3'd0;
    end else if((1'b1 == ap_CS_fsm_state7) & (icmp_ln434_fu_810_p2 == 1'd0)) begin
      j_1_fu_74 <= add_ln434_fu_816_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)) begin
      j_fu_66 <= 3'd0;
    end else if((icmp_ln381_fu_305_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) begin
      j_fu_66 <= add_ln381_fu_311_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state4) begin
      MixColumn_AddRoundKey_word_load_1_reg_1041 <= ~MixColumn_AddRoundKey_word_q0;
      icmp_ln400_reg_1036 <= icmp_ln400_fu_571_p2;
      icmp_ln408_reg_1046 <= icmp_ln408_fu_585_p2;
      icmp_ln420_reg_1051 <= icmp_ln420_fu_599_p2;
      shl_ln383_reg_986[31:1] <= shl_ln383_fu_426_p2[31:1];
      shl_ln387_reg_991[31:1] <= shl_ln387_fu_444_p2[31:1];
      shl_ln399_reg_1024[31:1] <= shl_ln399_fu_541_p2[31:1];
      x_3_reg_997 <= statemt_q1;
      x_4_reg_1030 <= x_4_fu_547_p2;
      x_6_reg_1002 <= statemt_q0;
      xor_ln392_reg_1019 <= xor_ln392_fu_535_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln381_fu_305_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) begin
      add_ln393_reg_916 <= add_ln393_fu_345_p2;
      shl_ln_reg_890[3:2] <= shl_ln_fu_321_p3[3:2];
      zext_ln383_reg_896[3:2] <= zext_ln383_fu_329_p1[3:2];
      zext_ln386_reg_906[3:2] <= zext_ln386_fu_340_p1[3:2];
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state3) begin
      icmp_ln384_reg_938 <= icmp_ln384_fu_368_p2;
      icmp_ln396_reg_981 <= icmp_ln396_fu_420_p2;
      x_9_reg_930 <= statemt_q1;
      x_reg_943 <= statemt_q0;
      zext_ln393_1_reg_961[3:2] <= zext_ln393_1_fu_389_p1[3:2];
      zext_ln393_reg_951[3:2] <= zext_ln393_fu_379_p1[3:2];
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state1) begin
      mul_reg_882[5:2] <= mul_fu_285_p3[5:2];
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state7) & (icmp_ln434_fu_810_p2 == 1'd0)) begin
      shl_ln4_reg_1069[3:2] <= shl_ln4_fu_826_p3[3:2];
      zext_ln436_reg_1075[3:2] <= zext_ln436_fu_834_p1[3:2];
      zext_ln437_reg_1085[3:2] <= zext_ln437_fu_845_p1[3:2];
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state5) begin
      xor_ln416_reg_1056 <= xor_ln416_fu_724_p2;
      xor_ln428_reg_1061 <= xor_ln428_fu_801_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state8) begin
      zext_ln438_reg_1095[3:2] <= zext_ln438_fu_860_p1[3:2];
      zext_ln439_reg_1105[3:2] <= zext_ln439_fu_870_p1[3:2];
    end 
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state4) begin
      MixColumn_AddRoundKey_word_address0 = zext_ln429_fu_512_p1;
    end else if(1'b1 == ap_CS_fsm_state3) begin
      MixColumn_AddRoundKey_word_address0 = zext_ln405_fu_407_p1;
    end else begin
      MixColumn_AddRoundKey_word_address0 = 'bx;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state4) begin
      MixColumn_AddRoundKey_word_address1 = zext_ln417_fu_501_p1;
    end else if(1'b1 == ap_CS_fsm_state3) begin
      MixColumn_AddRoundKey_word_address1 = zext_ln393_2_fu_394_p1;
    end else begin
      MixColumn_AddRoundKey_word_address1 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state3) | (1'b1 == ap_CS_fsm_state4)) begin
      MixColumn_AddRoundKey_word_ce0 = 1'b1;
    end else begin
      MixColumn_AddRoundKey_word_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state3) | (1'b1 == ap_CS_fsm_state4)) begin
      MixColumn_AddRoundKey_word_ce1 = 1'b1;
    end else begin
      MixColumn_AddRoundKey_word_ce1 = 1'b0;
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
  assign ap_ST_fsm_state3_blk = 1'b0;
  assign ap_ST_fsm_state4_blk = 1'b0;
  assign ap_ST_fsm_state5_blk = 1'b0;
  assign ap_ST_fsm_state6_blk = 1'b0;
  assign ap_ST_fsm_state7_blk = 1'b0;
  assign ap_ST_fsm_state8_blk = 1'b0;
  assign ap_ST_fsm_state9_blk = 1'b0;

  always @(*) begin
    if((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0) | (1'b1 == ap_CS_fsm_state7) & (icmp_ln434_fu_810_p2 == 1'd1)) begin
      ap_done = 1'b1;
    end else begin
      ap_done = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0)) begin
      ap_idle = 1'b1;
    end else begin
      ap_idle = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state7) & (icmp_ln434_fu_810_p2 == 1'd1)) begin
      ap_ready = 1'b1;
    end else begin
      ap_ready = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state8) begin
      ret_address0 = zext_ln439_fu_870_p1;
    end else if(1'b1 == ap_CS_fsm_state7) begin
      ret_address0 = zext_ln437_fu_845_p1;
    end else if(1'b1 == ap_CS_fsm_state6) begin
      ret_address0 = zext_ln393_1_reg_961;
    end else if(1'b1 == ap_CS_fsm_state5) begin
      ret_address0 = zext_ln386_reg_906;
    end else begin
      ret_address0 = 'bx;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state8) begin
      ret_address1 = zext_ln438_fu_860_p1;
    end else if(1'b1 == ap_CS_fsm_state7) begin
      ret_address1 = zext_ln436_fu_834_p1;
    end else if(1'b1 == ap_CS_fsm_state6) begin
      ret_address1 = zext_ln393_reg_951;
    end else if(1'b1 == ap_CS_fsm_state5) begin
      ret_address1 = zext_ln383_reg_896;
    end else begin
      ret_address1 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state7) | (1'b1 == ap_CS_fsm_state5)) begin
      ret_ce0 = 1'b1;
    end else begin
      ret_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state7) | (1'b1 == ap_CS_fsm_state5)) begin
      ret_ce1 = 1'b1;
    end else begin
      ret_ce1 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state6) begin
      ret_d0 = xor_ln428_reg_1061;
    end else if(1'b1 == ap_CS_fsm_state5) begin
      ret_d0 = xor_ln404_fu_642_p2;
    end else begin
      ret_d0 = 'bx;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state6) begin
      ret_d1 = xor_ln416_reg_1056;
    end else if(1'b1 == ap_CS_fsm_state5) begin
      ret_d1 = xor_ln392_reg_1019;
    end else begin
      ret_d1 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state5)) begin
      ret_we0 = 1'b1;
    end else begin
      ret_we0 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state5)) begin
      ret_we1 = 1'b1;
    end else begin
      ret_we1 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state9) begin
      statemt_address0 = ~zext_ln439_reg_1105;
    end else if(1'b1 == ap_CS_fsm_state8) begin
      statemt_address0 = ~zext_ln437_reg_1085;
    end else if(1'b1 == ap_CS_fsm_state3) begin
      statemt_address0 = ~zext_ln393_1_fu_389_p1;
    end else if(1'b1 == ap_CS_fsm_state2) begin
      statemt_address0 = ~zext_ln386_fu_340_p1;
    end else begin
      statemt_address0 = ~'bx;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state9) begin
      statemt_address1 = ~zext_ln438_reg_1095;
    end else if(1'b1 == ap_CS_fsm_state8) begin
      statemt_address1 = ~zext_ln436_reg_1075;
    end else if(1'b1 == ap_CS_fsm_state3) begin
      statemt_address1 = ~zext_ln393_fu_379_p1;
    end else if(1'b1 == ap_CS_fsm_state2) begin
      statemt_address1 = ~zext_ln383_fu_329_p1;
    end else begin
      statemt_address1 = ~'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state3) | (1'b1 == ap_CS_fsm_state2) | (1'b1 == ap_CS_fsm_state9) | (1'b1 == ap_CS_fsm_state8)) begin
      statemt_ce0 = 1'b1;
    end else begin
      statemt_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state3) | (1'b1 == ap_CS_fsm_state2) | (1'b1 == ap_CS_fsm_state9) | (1'b1 == ap_CS_fsm_state8)) begin
      statemt_ce1 = 1'b1;
    end else begin
      statemt_ce1 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state9) | (1'b1 == ap_CS_fsm_state8)) begin
      statemt_we0 = 1'b1;
    end else begin
      statemt_we0 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state9) | (1'b1 == ap_CS_fsm_state8)) begin
      statemt_we1 = 1'b1;
    end else begin
      statemt_we1 = 1'b0;
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
        if((icmp_ln381_fu_305_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state2)) begin
          ap_NS_fsm = ap_ST_fsm_state7;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state3;
        end
      end
      ap_ST_fsm_state3: begin
        ap_NS_fsm = ap_ST_fsm_state4;
      end
      ap_ST_fsm_state4: begin
        ap_NS_fsm = ap_ST_fsm_state5;
      end
      ap_ST_fsm_state5: begin
        ap_NS_fsm = ap_ST_fsm_state6;
      end
      ap_ST_fsm_state6: begin
        ap_NS_fsm = ap_ST_fsm_state2;
      end
      ap_ST_fsm_state7: begin
        if((1'b1 == ap_CS_fsm_state7) & (icmp_ln434_fu_810_p2 == 1'd1)) begin
          ap_NS_fsm = ap_ST_fsm_state1;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state8;
        end
      end
      ap_ST_fsm_state8: begin
        ap_NS_fsm = ap_ST_fsm_state9;
      end
      ap_ST_fsm_state9: begin
        ap_NS_fsm = ap_ST_fsm_state7;
      end
      default: begin
        ap_NS_fsm = 'bx;
      end
    endcase
  end

  assign add_ln381_fu_311_p2 = j_fu_66 + 3'd1;
  assign add_ln393_fu_345_p2 = zext_ln381_fu_301_p1 + mul_reg_882;
  assign add_ln405_fu_401_p2 = zext_ln393_4_fu_398_p1 + 8'd120;
  assign add_ln417_fu_495_p2 = zext_ln393_3_fu_492_p1 + 9'd240;
  assign add_ln429_fu_506_p2 = $signed(zext_ln393_3_fu_492_p1) + $signed(9'd360);
  assign add_ln434_fu_816_p2 = j_1_fu_74 + 3'd1;
  assign and_ln1_fu_464_p3 = { { tmp_4_fu_454_p4 }, { 8'd0 } };
  assign and_ln2_fu_412_p3 = { { grp_fu_275_p4 }, { 8'd0 } };
  assign and_ln3_fu_563_p3 = { { tmp_7_fu_553_p4 }, { 8'd0 } };
  assign and_ln4_fu_577_p3 = { { grp_fu_265_p4 }, { 8'd0 } };
  assign and_ln5_fu_680_p3 = { { tmp_s_fu_670_p4 }, { 8'd0 } };
  assign and_ln6_fu_591_p3 = { { grp_fu_275_p4 }, { 8'd0 } };
  assign and_ln7_fu_757_p3 = { { tmp_3_fu_747_p4 }, { 8'd0 } };
  assign and_ln_fu_360_p3 = { { grp_fu_265_p4 }, { 8'd0 } };
  assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];
  assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];
  assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];
  assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];
  assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];
  assign ap_CS_fsm_state6 = ap_CS_fsm[32'd5];
  assign ap_CS_fsm_state7 = ap_CS_fsm[32'd6];
  assign ap_CS_fsm_state8 = ap_CS_fsm[32'd7];
  assign ap_CS_fsm_state9 = ap_CS_fsm[32'd8];
  assign grp_fu_265_p4 = { { statemt_q1[30:7] } };
  assign grp_fu_275_p4 = { { statemt_q0[30:7] } };
  assign icmp_ln381_fu_305_p2 = (j_fu_66 == 3'd4)? 1'b1 : 1'b0;
  assign icmp_ln384_fu_368_p2 = (and_ln_fu_360_p3 == 32'd256)? 1'b1 : 1'b0;
  assign icmp_ln388_fu_472_p2 = (and_ln1_fu_464_p3 == 32'd256)? 1'b1 : 1'b0;
  assign icmp_ln396_fu_420_p2 = (and_ln2_fu_412_p3 == 32'd256)? 1'b1 : 1'b0;
  assign icmp_ln400_fu_571_p2 = (and_ln3_fu_563_p3 == 32'd256)? 1'b1 : 1'b0;
  assign icmp_ln408_fu_585_p2 = (and_ln4_fu_577_p3 == 32'd256)? 1'b1 : 1'b0;
  assign icmp_ln412_fu_688_p2 = (and_ln5_fu_680_p3 == 32'd256)? 1'b1 : 1'b0;
  assign icmp_ln420_fu_599_p2 = (and_ln6_fu_591_p3 == 32'd256)? 1'b1 : 1'b0;
  assign icmp_ln424_fu_765_p2 = (and_ln7_fu_757_p3 == 32'd256)? 1'b1 : 1'b0;
  assign icmp_ln434_fu_810_p2 = (j_1_fu_74 == 3'd4)? 1'b1 : 1'b0;
  assign mul_fu_285_p3 = { { n }, { 2'd0 } };
  assign or_ln386_fu_334_p2 = shl_ln_fu_321_p3 | 4'd1;
  assign or_ln393_1_fu_384_p2 = shl_ln_reg_890 | 4'd3;
  assign or_ln393_fu_374_p2 = shl_ln_reg_890 | 4'd2;
  assign or_ln437_fu_839_p2 = shl_ln4_fu_826_p3 | 4'd1;
  assign or_ln438_fu_855_p2 = shl_ln4_reg_1069 | 4'd2;
  assign or_ln439_fu_865_p2 = shl_ln4_reg_1069 | 4'd3;
  assign select_ln384_fu_437_p3 = (icmp_ln384_reg_938[0:0] == 1'b1)? xor_ln385_fu_431_p2 : shl_ln383_fu_426_p2;
  assign select_ln396_fu_610_p3 = (icmp_ln396_reg_981[0:0] == 1'b1)? xor_ln397_fu_605_p2 : shl_ln387_reg_991;
  assign select_ln408_fu_654_p3 = (icmp_ln408_reg_1046[0:0] == 1'b1)? xor_ln409_fu_649_p2 : shl_ln399_reg_1024;
  assign select_ln420_fu_736_p3 = (icmp_ln420_reg_1051[0:0] == 1'b1)? xor_ln421_fu_730_p2 : shl_ln411_fu_660_p2;
  assign shl_ln383_fu_426_p2 = x_9_reg_930 << 32'd1;
  assign shl_ln387_fu_444_p2 = x_reg_943 << 32'd1;
  assign shl_ln399_fu_541_p2 = statemt_q1 << 32'd1;
  assign shl_ln411_fu_660_p2 = x_6_reg_1002 << 32'd1;
  assign shl_ln4_fu_826_p3 = { { trunc_ln436_fu_822_p1 }, { 2'd0 } };
  assign shl_ln_fu_321_p3 = { { trunc_ln383_fu_317_p1 }, { 2'd0 } };
  assign statemt_d0 = ret_q0;
  assign statemt_d1 = ret_q1;
  assign tmp_3_fu_747_p4 = { { x_10_fu_743_p2[31:8] } };
  assign tmp_4_fu_454_p4 = { { x_1_fu_449_p2[31:8] } };
  assign tmp_7_fu_553_p4 = { { x_4_fu_547_p2[31:8] } };
  assign tmp_s_fu_670_p4 = { { x_7_fu_665_p2[31:8] } };
  assign trunc_ln383_fu_317_p1 = j_fu_66[1:0];
  assign trunc_ln436_fu_822_p1 = j_1_fu_74[1:0];
  assign x_10_fu_743_p2 = x_9_reg_930 ^ shl_ln383_reg_986;
  assign x_11_fu_777_p3 = (icmp_ln424_fu_765_p2[0:0] == 1'b1)? xor_ln425_fu_771_p2 : x_10_fu_743_p2;
  assign x_1_fu_449_p2 = x_reg_943 ^ shl_ln387_fu_444_p2;
  assign x_2_fu_484_p3 = (icmp_ln388_fu_472_p2[0:0] == 1'b1)? xor_ln389_fu_478_p2 : x_1_fu_449_p2;
  assign x_4_fu_547_p2 = statemt_q1 ^ shl_ln399_fu_541_p2;
  assign x_5_fu_621_p3 = (icmp_ln400_reg_1036[0:0] == 1'b1)? xor_ln401_fu_616_p2 : x_4_reg_1030;
  assign x_7_fu_665_p2 = x_6_reg_1002 ^ shl_ln411_fu_660_p2;
  assign x_8_fu_700_p3 = (icmp_ln412_fu_688_p2[0:0] == 1'b1)? xor_ln413_fu_694_p2 : x_7_fu_665_p2;
  assign xor_ln385_fu_431_p2 = shl_ln383_fu_426_p2 ^ 32'd283;
  assign xor_ln389_fu_478_p2 = x_1_fu_449_p2 ^ 32'd283;
  assign xor_ln392_1_fu_517_p2 = statemt_q1 ^ statemt_q0;
  assign xor_ln392_2_fu_523_p2 = x_2_fu_484_p3 ^ select_ln384_fu_437_p3;
  assign xor_ln392_3_fu_529_p2 = xor_ln392_2_fu_523_p2 ^ MixColumn_AddRoundKey_word_q1;
  assign xor_ln392_fu_535_p2 = xor_ln392_3_fu_529_p2 ^ xor_ln392_1_fu_517_p2;
  assign xor_ln397_fu_605_p2 = shl_ln387_reg_991 ^ 32'd283;
  assign xor_ln401_fu_616_p2 = x_4_reg_1030 ^ 32'd283;
  assign xor_ln404_1_fu_627_p2 = x_9_reg_930 ^ x_6_reg_1002;
  assign xor_ln404_2_fu_631_p2 = x_5_fu_621_p3 ^ select_ln396_fu_610_p3;
  assign xor_ln404_3_fu_637_p2 = xor_ln404_2_fu_631_p2 ^ ~MixColumn_AddRoundKey_word_load_1_reg_1041;
  assign xor_ln404_fu_642_p2 = xor_ln404_3_fu_637_p2 ^ xor_ln404_1_fu_627_p2;
  assign xor_ln409_fu_649_p2 = shl_ln399_reg_1024 ^ 32'd283;
  assign xor_ln413_fu_694_p2 = x_7_fu_665_p2 ^ 32'd283;
  assign xor_ln416_1_fu_708_p2 = x_reg_943 ^ x_9_reg_930;
  assign xor_ln416_2_fu_712_p2 = x_8_fu_700_p3 ^ select_ln408_fu_654_p3;
  assign xor_ln416_3_fu_718_p2 = xor_ln416_2_fu_712_p2 ^ MixColumn_AddRoundKey_word_q1;
  assign xor_ln416_fu_724_p2 = xor_ln416_3_fu_718_p2 ^ xor_ln416_1_fu_708_p2;
  assign xor_ln421_fu_730_p2 = shl_ln411_fu_660_p2 ^ 32'd283;
  assign xor_ln425_fu_771_p2 = x_10_fu_743_p2 ^ 32'd283;
  assign xor_ln428_1_fu_785_p2 = x_reg_943 ^ x_3_reg_997;
  assign xor_ln428_2_fu_789_p2 = x_11_fu_777_p3 ^ select_ln420_fu_736_p3;
  assign xor_ln428_3_fu_795_p2 = xor_ln428_2_fu_789_p2 ^ MixColumn_AddRoundKey_word_q0;
  assign xor_ln428_fu_801_p2 = xor_ln428_3_fu_795_p2 ^ xor_ln428_1_fu_785_p2;
  assign zext_ln381_fu_301_p1 = j_fu_66;
  assign zext_ln383_fu_329_p1 = shl_ln_fu_321_p3;
  assign zext_ln386_fu_340_p1 = or_ln386_fu_334_p2;
  assign zext_ln393_1_fu_389_p1 = or_ln393_1_fu_384_p2;
  assign zext_ln393_2_fu_394_p1 = add_ln393_reg_916;
  assign zext_ln393_3_fu_492_p1 = add_ln393_reg_916;
  assign zext_ln393_4_fu_398_p1 = add_ln393_reg_916;
  assign zext_ln393_fu_379_p1 = or_ln393_fu_374_p2;
  assign zext_ln405_fu_407_p1 = add_ln405_fu_401_p2;
  assign zext_ln417_fu_501_p1 = add_ln417_fu_495_p2;
  assign zext_ln429_fu_512_p1 = add_ln429_fu_506_p2;
  assign zext_ln436_fu_834_p1 = shl_ln4_fu_826_p3;
  assign zext_ln437_fu_845_p1 = or_ln437_fu_839_p2;
  assign zext_ln438_fu_860_p1 = or_ln438_fu_855_p2;
  assign zext_ln439_fu_870_p1 = or_ln439_fu_865_p2;

  always @(posedge ap_clk) begin
    mul_reg_882[1:0] <= 2'b00;
    shl_ln_reg_890[1:0] <= 2'b00;
    zext_ln383_reg_896[1:0] <= 2'b00;
    zext_ln383_reg_896[63:4] <= 60'b000000000000000000000000000000000000000000000000000000000000;
    zext_ln386_reg_906[1:0] <= 2'b01;
    zext_ln386_reg_906[63:4] <= 60'b000000000000000000000000000000000000000000000000000000000000;
    zext_ln393_reg_951[1:0] <= 2'b10;
    zext_ln393_reg_951[63:4] <= 60'b000000000000000000000000000000000000000000000000000000000000;
    zext_ln393_1_reg_961[1:0] <= 2'b11;
    zext_ln393_1_reg_961[63:4] <= 60'b000000000000000000000000000000000000000000000000000000000000;
    shl_ln383_reg_986[0] <= 1'b0;
    shl_ln387_reg_991[0] <= 1'b0;
    shl_ln399_reg_1024[0] <= 1'b0;
    shl_ln4_reg_1069[1:0] <= 2'b00;
    zext_ln436_reg_1075[1:0] <= 2'b00;
    zext_ln436_reg_1075[63:4] <= 60'b000000000000000000000000000000000000000000000000000000000000;
    zext_ln437_reg_1085[1:0] <= 2'b01;
    zext_ln437_reg_1085[63:4] <= 60'b000000000000000000000000000000000000000000000000000000000000;
    zext_ln438_reg_1095[1:0] <= 2'b10;
    zext_ln438_reg_1095[63:4] <= 60'b000000000000000000000000000000000000000000000000000000000000;
    zext_ln439_reg_1105[1:0] <= 2'b11;
    zext_ln439_reg_1105[63:4] <= 60'b000000000000000000000000000000000000000000000000000000000000;
  end


endmodule


