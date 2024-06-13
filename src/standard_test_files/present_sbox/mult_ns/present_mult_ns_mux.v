

module sbox
(
  clk,
  x0_inp,
  x1_inp,
  x2_inp,
  x3_inp,
  r,
  Y0,
  Y1,
  Y2,
  Y3
);

  wire t166_z1_assgn1;
  reg z60_assgn60_reg31;
  reg z133_assgn1330_reg11_reg32;
  wire t167_t122_z133_assgn133;
  wire t168_t123_x3;
  reg z133_assgn1330_reg33;
  wire t169_z133_assgn133;
  wire t170_x3;
  wire t171_Y01;
  wire t172_L7;
  reg z52_assgn52_reg34;
  reg z117_assgn1170_reg35;
  wire t173_z117_assgn117;
  wire t174_T0;
  wire t175_Q0;
  wire t176_L0;
  wire t177_x1;
  wire t178_x2;
  wire t179_Q1;
  wire t180_L1;
  wire t181_x0;
  wire t182_x1;
  reg T1_reg_reg36;
  wire t183_t21_T1;
  wire t184_t22_Q2;
  reg Q3_reg_reg3_reg37;
  wire t185_T1;
  wire t186_Q2;
  reg Q3_reg_reg38;
  reg z55_assgn55_reg39;
  reg z125_assgn1250_reg4_reg40;
  wire t187_t65_z125_assgn125;
  wire t188_t66_T2;
  wire t189_t67_x1;
  wire t190_t68_Q4;
  wire t191_t69_x2;
  reg z125_assgn1250_reg41;
  wire t192_z125_assgn125;
  wire t193_T2;
  wire t194_x1;
  wire t195_Q4;
  wire t196_x2;
  wire t124_L7;
  reg z52_assgn52_reg12;
  reg z117_assgn1170_reg13;
  wire t125_z117_assgn117;
  wire t126_T0;
  wire t127_Q0;
  wire t128_L0;
  wire t129_x1;
  wire t130_x2;
  wire t131_Q1;
  wire t132_L1;
  wire t133_x0;
  wire t134_x1;
  reg T1_reg_reg14;
  wire t135_t21_T1;
  wire t136_t22_Q2;
  reg T0_reg_reg1_reg15;
  reg L2_reg_reg2_reg16;
  reg Q3_reg_reg3_reg17;
  wire t137_t53_t16_Q3;
  wire t138_t54_t17_x3;
  wire t139_t55_Q3;
  wire t140_t56_x3;
  wire t141_T1;
  wire t142_Q2;
  reg T0_reg_reg18;
  reg L2_reg_reg19;
  reg Q3_reg_reg20;
  wire t143_t16_Q3;
  wire t144_t17_x3;
  wire t145_Q3;
  wire t146_x3;
  wire t147_Y11;
  reg z58_assgn58_reg21;
  reg z129_assgn1290_reg5_reg22;
  wire t148_t70_z129_assgn129;
  wire t149_t71_L8;
  wire t150_t72_x2;
  wire t151_t73_x0;
  reg z129_assgn1290_reg23;
  wire t152_z129_assgn129;
  wire t153_L8;
  wire t154_x2;
  wire t155_x0;
  reg T3_reg_reg24;
  wire t156_t74_T3;
  wire t157_t75_Q6;
  wire t158_t76_L4;
  reg L3_reg_reg8_reg25;
  wire t159_t91_L3;
  wire t160_t97_Q7;
  reg T0_reg_reg9_reg26;
  reg L5_reg_reg10_reg27;
  wire t161_T3;
  wire t162_Q6;
  wire t163_L4;
  reg L3_reg_reg28;
  wire t164_L3;
  wire t165_Q7;
  reg T0_reg_reg29;
  reg L5_reg_reg30;
  reg z133_assgn1330_reg11;
  wire t122_z133_assgn133;
  wire t123_x3;
  wire t74_T3;
  wire t75_Q6;
  wire t76_L4;
  reg T0_reg_reg6;
  wire t77_t1_T0;
  wire t78_t2_Q0;
  wire t79_t3_L0;
  wire t80_t6_Q1;
  wire t81_t7_L1;
  wire t82_T0;
  wire t83_Q0;
  wire t84_L0;
  wire t85_Q1;
  wire t86_L1;
  reg T2_reg_reg7;
  wire t87_T2;
  wire t88_x1;
  wire t89_Q4;
  wire t90_x2;
  reg L3_reg_reg8;
  wire t91_L3;
  wire t92_Q0;
  wire t93_L0;
  wire t94_x1;
  wire t95_x2;
  wire t96_x3;
  wire t97_Q7;
  reg T0_reg_reg9;
  wire t98_t1_T0;
  wire t99_t2_Q0;
  wire t100_t3_L0;
  wire t101_t4_x1;
  wire t102_t5_x2;
  wire t103_t6_Q1;
  wire t104_t7_L1;
  wire t105_t8_x0;
  wire t106_t9_x1;
  wire t107_T0;
  wire t108_Q0;
  wire t109_L0;
  wire t110_x1;
  wire t111_x2;
  wire t112_Q1;
  wire t113_L1;
  wire t114_x0;
  wire t115_x1;
  reg L5_reg_reg10;
  wire t116_t18_L5;
  wire t117_t19_x0;
  wire t118_t20_x3;
  wire t119_L5;
  wire t120_x0;
  wire t121_x3;
  reg z129_assgn1290_reg5;
  wire t70_z129_assgn129;
  wire t71_L8;
  wire t72_x2;
  wire t73_x0;
  reg z125_assgn1250_reg4;
  wire t65_z125_assgn125;
  wire t66_T2;
  wire t67_x1;
  wire t68_Q4;
  wire t69_x2;
  wire t57_z121_assgn121;
  wire t58_L10;
  wire t59_L2;
  wire t60_Q1;
  wire t61_L1;
  wire t62_x0;
  wire t63_x1;
  wire t64_x2;
  wire t21_T1;
  wire t22_Q2;
  reg T0_reg_reg1;
  wire t23_t1_T0;
  wire t24_t2_Q0;
  wire t25_t3_L0;
  wire t26_t4_x1;
  wire t27_t5_x2;
  wire t28_t6_Q1;
  wire t29_t7_L1;
  wire t30_t8_x0;
  wire t31_t9_x1;
  wire t32_T0;
  wire t33_Q0;
  wire t34_L0;
  wire t35_x1;
  wire t36_x2;
  wire t37_Q1;
  wire t38_L1;
  wire t39_x0;
  wire t40_x1;
  reg L2_reg_reg2;
  wire t41_t10_L2;
  wire t42_t11_Q1;
  wire t43_t12_L1;
  wire t44_t13_x0;
  wire t45_t14_x1;
  wire t46_t15_x2;
  wire t47_L2;
  wire t48_Q1;
  wire t49_L1;
  wire t50_x0;
  wire t51_x1;
  wire t52_x2;
  reg Q3_reg_reg3;
  wire t53_t16_Q3;
  wire t54_t17_x3;
  wire t55_Q3;
  wire t56_x3;
  wire t18_L5;
  wire t19_x0;
  wire t20_x3;
  wire t16_Q3;
  wire t17_x3;
  wire t10_L2;
  wire t11_Q1;
  wire t12_L1;
  wire t13_x0;
  wire t14_x1;
  wire t15_x2;
  wire t1_T0;
  wire t2_Q0;
  wire t3_L0;
  wire t4_x1;
  wire t5_x2;
  wire t6_Q1;
  wire t7_L1;
  wire t8_x0;
  wire t9_x1;
  input clk;
  input x0_inp;
  input x1_inp;
  input x2_inp;
  input x3_inp;
  input [20:0] r;
  output Y0;reg Y0;
  output Y1;reg Y1;
  output Y2;reg Y2;
  output Y3;reg Y3;
  wire x0;
  wire x1;
  wire x2;
  wire x3;
  wire L0;
  wire L1;
  wire L8;
  wire L5;
  wire Q0;
  wire Q1;
  wire Q3;
  wire Q4;
  wire L2;
  wire L3;
  wire T0;
  wire L10;
  wire T2;
  reg T0_reg;
  reg L2_reg;
  wire Q2;
  reg T2_reg;
  wire L4;
  reg L5_reg;
  wire Q7;
  reg L3_reg;
  wire Q6;
  reg Q3_reg;
  wire T1;
  wire T3;
  wire z117_assgn117;
  reg z117_assgn1170;
  reg z52_assgn52;
  reg T1_reg;
  wire L7;
  wire z121_assgn121;
  reg z121_assgn1210;
  reg z53_assgn53;
  wire L11;
  wire z125_assgn125;
  reg z125_assgn1250;
  reg z55_assgn55;
  wire Y01;
  wire z129_assgn129;
  reg z129_assgn1290;
  reg z58_assgn58;
  reg T3_reg;
  wire Y11;
  wire z133_assgn133;
  reg z133_assgn1330;
  reg z60_assgn60;
  wire z1_assgn1;
  wire z141_assgn141;
  reg z141_assgn1410;
  reg z65_assgn65;
  wire z3_assgn3;
  wire z147_assgn147;
  reg z147_assgn1470;
  reg z147_assgn1471;
  assign x0 = x0_inp;
  assign x1 = x1_inp;
  assign x2 = x2_inp;
  assign x3 = x3_inp;
  assign L0 = x1 ^ x2;
  assign L1 = x0 ^ x1;
  assign L8 = x2 ^ x0;
  assign L5 = x0 ^ x3;
  assign Q0 = ~L0;
  assign Q1 = ~L1;
  assign Q3 = ~x3;
  assign Q4 = ~x2;
  assign L2 = Q1 ^ x2;
  assign L3 = Q0 ^ x3;
  assign T0 = Q0 & Q1;
  assign L10 = ~L2;
  assign T2 = x1 & Q4;
  assign Q2 = T0_reg ^ L2_reg;
  assign L4 = T0_reg ^ T2_reg;
  assign Q7 = T0_reg ^ L5_reg;
  assign Q6 = L4 ^ L3_reg;
  assign T1 = Q2 & Q3_reg;
  assign T3 = Q6 & Q7;
  assign z117_assgn117 = T0;
  assign L7 = z52_assgn52 ^ T1_reg;
  assign z121_assgn121 = L10;
  assign L11 = T1_reg ^ z53_assgn53;
  assign z125_assgn125 = T2;
  assign Y01 = L7 ^ z55_assgn55;
  assign z129_assgn129 = L8;
  assign Y11 = z58_assgn58 ^ T3_reg;
  assign z133_assgn133 = x3;
  assign z1_assgn1 = z60_assgn60 ^ Y01;
  assign z141_assgn141 = T2;
  assign z3_assgn3 = L11 ^ z65_assgn65;
  assign z147_assgn147 = T2 ^ L5;

  always @(posedge clk) begin
    T0_reg <= (r[18])? T0 : ~(~t1_T0);
  end


  always @(posedge clk) begin
    L2_reg <= (r[3])? L2 : ~t10_L2;
  end


  always @(posedge clk) begin
    T2_reg <= T2;
  end


  always @(posedge clk) begin
    L5_reg <= (r[3])? L5 : ~(~t18_L5);
  end


  always @(posedge clk) begin
    L3_reg <= L3;
  end


  always @(posedge clk) begin
    Q3_reg <= (r[6])? Q3 : ~(~t16_Q3);
  end


  always @(posedge clk) begin
    z117_assgn1170 <= z117_assgn117;
  end


  always @(posedge clk) begin
    z52_assgn52 <= z117_assgn1170;
  end


  always @(posedge clk) begin
    T1_reg <= (r[16])? T1 : ~t21_T1;
  end


  always @(posedge clk) begin
    z121_assgn1210 <= (r[16])? z121_assgn121 : ~(~t57_z121_assgn121);
  end


  always @(posedge clk) begin
    z53_assgn53 <= z121_assgn1210;
  end


  always @(posedge clk) begin
    z125_assgn1250 <= z125_assgn125;
  end


  always @(posedge clk) begin
    z55_assgn55 <= (r[8])? z125_assgn1250 : ~(~z125_assgn1250_reg4);
  end


  always @(posedge clk) begin
    z129_assgn1290 <= z129_assgn129;
  end


  always @(posedge clk) begin
    z58_assgn58 <= (r[6])? z129_assgn1290 : ~(~z129_assgn1290_reg5);
  end


  always @(posedge clk) begin
    T3_reg <= (r[9])? T3 : ~t74_T3;
  end


  always @(posedge clk) begin
    z133_assgn1330 <= z133_assgn133;
  end


  always @(posedge clk) begin
    z60_assgn60 <= (r[4])? z133_assgn1330 : ~(~z133_assgn1330_reg11);
  end


  always @(posedge clk) begin
    Y0 <= (r[19])? z1_assgn1 : ~t166_z1_assgn1;
  end


  always @(posedge clk) begin
    Y1 <= (r[7])? L7 ^ Y11 : ~t124_L7 ^ t147_Y11;
  end


  always @(posedge clk) begin
    z141_assgn1410 <= z141_assgn141;
  end


  always @(posedge clk) begin
    z65_assgn65 <= z141_assgn1410;
  end


  always @(posedge clk) begin
    Y2 <= z3_assgn3;
  end


  always @(posedge clk) begin
    z147_assgn1470 <= z147_assgn147;
  end


  always @(posedge clk) begin
    z147_assgn1471 <= z147_assgn1470;
  end


  always @(posedge clk) begin
    Y3 <= z147_assgn1471;
  end

  assign t4_x1 = ~(~x1_inp);
  assign t5_x2 = ~(~x2_inp);
  assign t3_L0 = t4_x1 ^ t5_x2;
  assign t2_Q0 = ~t3_L0;
  assign t8_x0 = x0_inp;
  assign t9_x1 = x1_inp;
  assign t7_L1 = ~(~t8_x0 ^ t9_x1);
  assign t6_Q1 = ~t7_L1;
  assign t1_T0 = ~(~t2_Q0 | ~t6_Q1);
  assign t13_x0 = ~(~x0_inp);
  assign t14_x1 = x1_inp;
  assign t12_L1 = t13_x0 ^ t14_x1;
  assign t11_Q1 = ~t12_L1;
  assign t15_x2 = ~(~x2_inp);
  assign t10_L2 = t11_Q1 ^ ~t15_x2;
  assign t17_x3 = ~(~x3_inp);
  assign t16_Q3 = ~t17_x3;
  assign t19_x0 = x0_inp;
  assign t20_x3 = ~(~x3_inp);
  assign t18_L5 = t19_x0 ^ t20_x3;
  assign t26_t4_x1 = ~(~x1_inp);
  assign t27_t5_x2 = ~(~x2_inp);
  assign t25_t3_L0 = ~(t26_t4_x1 ^ ~t27_t5_x2);
  assign t24_t2_Q0 = ~t25_t3_L0;
  assign t30_t8_x0 = ~(~x0_inp);
  assign t31_t9_x1 = x1_inp;
  assign t29_t7_L1 = ~(~t30_t8_x0 ^ t31_t9_x1);
  assign t28_t6_Q1 = ~t29_t7_L1;
  assign t23_t1_T0 = ~(~t24_t2_Q0 | ~t28_t6_Q1);
  assign t35_x1 = x1_inp;
  assign t36_x2 = x2_inp;
  assign t34_L0 = ~(~t35_x1 ^ t36_x2);
  assign t33_Q0 = ~t34_L0;
  assign t39_x0 = x0_inp;
  assign t40_x1 = x1_inp;
  assign t38_L1 = ~(~t39_x0 ^ t40_x1);
  assign t37_Q1 = ~t38_L1;
  assign t32_T0 = ~(~t33_Q0 | ~t37_Q1);

  always @(posedge clk) begin
    T0_reg_reg1 <= ~((r[18])? ~t32_T0 : ~(~(~t23_t1_T0)));
  end

  assign t44_t13_x0 = ~(~x0_inp);
  assign t45_t14_x1 = x1_inp;
  assign t43_t12_L1 = ~(~t44_t13_x0 ^ t45_t14_x1);
  assign t42_t11_Q1 = ~t43_t12_L1;
  assign t46_t15_x2 = ~(~x2_inp);
  assign t41_t10_L2 = ~(t42_t11_Q1 ^ ~(~t46_t15_x2));
  assign t50_x0 = ~(~x0_inp);
  assign t51_x1 = x1_inp;
  assign t49_L1 = ~(~t50_x0 ^ t51_x1);
  assign t48_Q1 = ~t49_L1;
  assign t52_x2 = ~(~x2_inp);
  assign t47_L2 = ~(t48_Q1 ^ ~t52_x2);

  always @(posedge clk) begin
    L2_reg_reg2 <= (r[3])? t47_L2 : ~t41_t10_L2;
  end

  assign t22_Q2 = ~(T0_reg_reg1 ^ ~L2_reg_reg2);
  assign t54_t17_x3 = ~(~x3_inp);
  assign t53_t16_Q3 = ~t54_t17_x3;
  assign t56_x3 = x3_inp;
  assign t55_Q3 = ~t56_x3;

  always @(posedge clk) begin
    Q3_reg_reg3 <= (r[6])? t55_Q3 : ~(~t53_t16_Q3);
  end

  assign t21_T1 = ~t22_Q2 | ~Q3_reg_reg3;
  assign t62_x0 = x0_inp;
  assign t63_x1 = ~(~x1_inp);
  assign t61_L1 = t62_x0 ^ t63_x1;
  assign t60_Q1 = ~t61_L1;
  assign t64_x2 = x2_inp;
  assign t59_L2 = ~(~t60_Q1 ^ t64_x2);
  assign t58_L10 = ~t59_L2;
  assign t57_z121_assgn121 = t58_L10;
  assign t67_x1 = x1_inp;
  assign t69_x2 = ~(~x2_inp);
  assign t68_Q4 = ~t69_x2;
  assign t66_T2 = t67_x1 & t68_Q4;
  assign t65_z125_assgn125 = t66_T2;

  always @(posedge clk) begin
    z125_assgn1250_reg4 <= ~(~t65_z125_assgn125);
  end

  assign t72_x2 = x2_inp;
  assign t73_x0 = x0_inp;
  assign t71_L8 = ~(t72_x2 ^ ~t73_x0);
  assign t70_z129_assgn129 = ~(~t71_L8);

  always @(posedge clk) begin
    z129_assgn1290_reg5 <= t70_z129_assgn129;
  end

  assign t79_t3_L0 = t4_x1 ^ t5_x2;
  assign t78_t2_Q0 = ~t79_t3_L0;
  assign t81_t7_L1 = ~(~t8_x0 ^ t9_x1);
  assign t80_t6_Q1 = ~t81_t7_L1;
  assign t77_t1_T0 = ~(~t78_t2_Q0 | ~t80_t6_Q1);
  assign t84_L0 = ~(x1 ^ ~x2);
  assign t83_Q0 = ~t84_L0;
  assign t86_L1 = x0 ^ x1;
  assign t85_Q1 = ~t86_L1;
  assign t82_T0 = ~(~t83_Q0 | ~t85_Q1);

  always @(posedge clk) begin
    T0_reg_reg6 <= ~((r[18])? ~t82_T0 : ~(~(~t77_t1_T0)));
  end

  assign t88_x1 = x1_inp;
  assign t90_x2 = ~(~x2_inp);
  assign t89_Q4 = ~t90_x2;
  assign t87_T2 = t88_x1 & t89_Q4;

  always @(posedge clk) begin
    T2_reg_reg7 <= ~(~t87_T2);
  end

  assign t76_L4 = ~(~T0_reg_reg6 ^ T2_reg_reg7);
  assign t94_x1 = x1_inp;
  assign t95_x2 = x2_inp;
  assign t93_L0 = ~(t94_x1 ^ ~t95_x2);
  assign t92_Q0 = ~t93_L0;
  assign t96_x3 = ~(~x3_inp);
  assign t91_L3 = ~(t92_Q0 ^ ~t96_x3);

  always @(posedge clk) begin
    L3_reg_reg8 <= ~(~t91_L3);
  end

  assign t75_Q6 = ~t76_L4 ^ L3_reg_reg8;
  assign t101_t4_x1 = ~(~x1_inp);
  assign t102_t5_x2 = ~(~x2_inp);
  assign t100_t3_L0 = t101_t4_x1 ^ t102_t5_x2;
  assign t99_t2_Q0 = ~t100_t3_L0;
  assign t105_t8_x0 = x0_inp;
  assign t106_t9_x1 = ~(~x1_inp);
  assign t104_t7_L1 = ~(~t105_t8_x0 ^ t106_t9_x1);
  assign t103_t6_Q1 = ~t104_t7_L1;
  assign t98_t1_T0 = ~(~t99_t2_Q0 | ~t103_t6_Q1);
  assign t110_x1 = x1_inp;
  assign t111_x2 = x2_inp;
  assign t109_L0 = ~(t110_x1 ^ ~t111_x2);
  assign t108_Q0 = ~t109_L0;
  assign t114_x0 = x0_inp;
  assign t115_x1 = ~(~x1_inp);
  assign t113_L1 = ~(t114_x0 ^ ~t115_x1);
  assign t112_Q1 = ~t113_L1;
  assign t107_T0 = t108_Q0 & t112_Q1;

  always @(posedge clk) begin
    T0_reg_reg9 <= ~((r[18])? ~t107_T0 : ~(~(~t98_t1_T0)));
  end

  assign t117_t19_x0 = ~(~x0_inp);
  assign t118_t20_x3 = ~(~x3_inp);
  assign t116_t18_L5 = t117_t19_x0 ^ t118_t20_x3;
  assign t120_x0 = x0_inp;
  assign t121_x3 = x3_inp;
  assign t119_L5 = t120_x0 ^ t121_x3;

  always @(posedge clk) begin
    L5_reg_reg10 <= ~((r[3])? ~t119_L5 : ~(~(~t116_t18_L5)));
  end

  assign t97_Q7 = T0_reg_reg9 ^ ~L5_reg_reg10;
  assign t74_T3 = t75_Q6 | t97_Q7;
  assign t123_x3 = x3_inp;
  assign t122_z133_assgn133 = ~(~t123_x3);

  always @(posedge clk) begin
    z133_assgn1330_reg11 <= t122_z133_assgn133;
  end

  assign t129_x1 = x1_inp;
  assign t130_x2 = x2_inp;
  assign t128_L0 = t129_x1 ^ t130_x2;
  assign t127_Q0 = ~t128_L0;
  assign t133_x0 = x0_inp;
  assign t134_x1 = x1_inp;
  assign t132_L1 = t133_x0 ^ t134_x1;
  assign t131_Q1 = ~t132_L1;
  assign t126_T0 = ~(~t127_Q0 | ~t131_Q1);
  assign t125_z117_assgn117 = ~(~t126_T0);

  always @(posedge clk) begin
    z117_assgn1170_reg13 <= ~(~t125_z117_assgn117);
  end


  always @(posedge clk) begin
    z52_assgn52_reg12 <= ~(~z117_assgn1170_reg13);
  end


  always @(posedge clk) begin
    T0_reg_reg1_reg15 <= ~((r[18])? ~t32_T0 : ~(~(~t23_t1_T0)));
  end


  always @(posedge clk) begin
    L2_reg_reg2_reg16 <= ~((r[3])? ~t47_L2 : ~(~t41_t10_L2));
  end

  assign t136_t22_Q2 = ~(T0_reg_reg1_reg15 ^ ~L2_reg_reg2_reg16);
  assign t138_t54_t17_x3 = ~(~x3_inp);
  assign t137_t53_t16_Q3 = ~t138_t54_t17_x3;
  assign t140_t56_x3 = x3_inp;
  assign t139_t55_Q3 = ~t140_t56_x3;

  always @(posedge clk) begin
    Q3_reg_reg3_reg17 <= ~((r[6])? ~t139_t55_Q3 : ~(~(~t137_t53_t16_Q3)));
  end

  assign t135_t21_T1 = t136_t22_Q2 & Q3_reg_reg3_reg17;

  always @(posedge clk) begin
    T0_reg_reg18 <= (r[18])? T0 : ~(~t1_T0);
  end


  always @(posedge clk) begin
    L2_reg_reg19 <= ~((r[3])? ~L2 : ~(~t10_L2));
  end

  assign t142_Q2 = T0_reg_reg18 ^ L2_reg_reg19;
  assign t144_t17_x3 = ~(~x3_inp);
  assign t143_t16_Q3 = ~t144_t17_x3;
  assign t146_x3 = x3_inp;
  assign t145_Q3 = ~t146_x3;

  always @(posedge clk) begin
    Q3_reg_reg20 <= (r[6])? t145_Q3 : ~(~t143_t16_Q3);
  end

  assign t141_T1 = ~(~t142_Q2 | ~Q3_reg_reg20);

  always @(posedge clk) begin
    T1_reg_reg14 <= (r[16])? ~t141_T1 : ~t135_t21_T1;
  end

  assign t124_L7 = ~z52_assgn52_reg12 ^ ~T1_reg_reg14;
  assign t150_t72_x2 = ~(~x2_inp);
  assign t151_t73_x0 = x0_inp;
  assign t149_t71_L8 = ~(t150_t72_x2 ^ ~t151_t73_x0);
  assign t148_t70_z129_assgn129 = ~(~t149_t71_L8);

  always @(posedge clk) begin
    z129_assgn1290_reg5_reg22 <= t148_t70_z129_assgn129;
  end

  assign t154_x2 = ~(~x2_inp);
  assign t155_x0 = x0_inp;
  assign t153_L8 = t154_x2 ^ t155_x0;
  assign t152_z129_assgn129 = ~(~t153_L8);

  always @(posedge clk) begin
    z129_assgn1290_reg23 <= t152_z129_assgn129;
  end


  always @(posedge clk) begin
    z58_assgn58_reg21 <= (r[6])? z129_assgn1290_reg23 : ~(~z129_assgn1290_reg5_reg22);
  end

  assign t158_t76_L4 = ~(~T0_reg_reg6 ^ T2_reg_reg7);
  assign t159_t91_L3 = ~(t92_Q0 ^ ~t96_x3);

  always @(posedge clk) begin
    L3_reg_reg8_reg25 <= ~(~t159_t91_L3);
  end

  assign t157_t75_Q6 = ~(~t158_t76_L4 ^ ~L3_reg_reg8_reg25);

  always @(posedge clk) begin
    T0_reg_reg9_reg26 <= ~((r[18])? ~t107_T0 : ~(~(~t98_t1_T0)));
  end


  always @(posedge clk) begin
    L5_reg_reg10_reg27 <= ~((r[3])? ~t119_L5 : ~(~(~t116_t18_L5)));
  end

  assign t160_t97_Q7 = ~(T0_reg_reg9_reg26 ^ ~(~L5_reg_reg10_reg27));
  assign t156_t74_T3 = ~(~t157_t75_Q6 & ~t160_t97_Q7);
  assign t163_L4 = ~(T0_reg ^ ~T2_reg);
  assign t164_L3 = Q0 ^ x3;

  always @(posedge clk) begin
    L3_reg_reg28 <= t164_L3;
  end

  assign t162_Q6 = ~(t163_L4 ^ ~L3_reg_reg28);

  always @(posedge clk) begin
    T0_reg_reg29 <= (r[18])? T0 : ~(~t1_T0);
  end


  always @(posedge clk) begin
    L5_reg_reg30 <= (r[3])? L5 : ~(~t18_L5);
  end

  assign t165_Q7 = ~(T0_reg_reg29 ^ ~L5_reg_reg30);
  assign t161_T3 = t162_Q6 & t165_Q7;

  always @(posedge clk) begin
    T3_reg_reg24 <= ~((r[9])? ~t161_T3 : ~(~t156_t74_T3));
  end

  assign t147_Y11 = ~(z58_assgn58_reg21 ^ ~T3_reg_reg24);
  assign t168_t123_x3 = x3_inp;
  assign t167_t122_z133_assgn133 = ~(~t168_t123_x3);

  always @(posedge clk) begin
    z133_assgn1330_reg11_reg32 <= ~(~t167_t122_z133_assgn133);
  end

  assign t170_x3 = ~(~x3_inp);
  assign t169_z133_assgn133 = ~(~t170_x3);

  always @(posedge clk) begin
    z133_assgn1330_reg33 <= t169_z133_assgn133;
  end


  always @(posedge clk) begin
    z60_assgn60_reg31 <= (r[4])? z133_assgn1330_reg33 : ~(~z133_assgn1330_reg11_reg32);
  end

  assign t177_x1 = ~(~x1_inp);
  assign t178_x2 = ~(~x2_inp);
  assign t176_L0 = t177_x1 ^ t178_x2;
  assign t175_Q0 = ~t176_L0;
  assign t181_x0 = x0_inp;
  assign t182_x1 = x1_inp;
  assign t180_L1 = ~(t181_x0 ^ ~t182_x1);
  assign t179_Q1 = ~t180_L1;
  assign t174_T0 = ~(~t175_Q0 | ~t179_Q1);
  assign t173_z117_assgn117 = ~(~t174_T0);

  always @(posedge clk) begin
    z117_assgn1170_reg35 <= t173_z117_assgn117;
  end


  always @(posedge clk) begin
    z52_assgn52_reg34 <= z117_assgn1170_reg35;
  end

  assign t184_t22_Q2 = ~(T0_reg_reg1 ^ ~L2_reg_reg2);

  always @(posedge clk) begin
    Q3_reg_reg3_reg37 <= (r[6])? t55_Q3 : ~(~t53_t16_Q3);
  end

  assign t183_t21_T1 = ~(t184_t22_Q2 & Q3_reg_reg3_reg37);
  assign t186_Q2 = ~(T0_reg ^ ~L2_reg);

  always @(posedge clk) begin
    Q3_reg_reg38 <= (r[6])? Q3 : ~(~t16_Q3);
  end

  assign t185_T1 = t186_Q2 & Q3_reg_reg38;

  always @(posedge clk) begin
    T1_reg_reg36 <= (r[16])? t185_T1 : ~t183_t21_T1;
  end

  assign t172_L7 = z52_assgn52_reg34 ^ T1_reg_reg36;
  assign t189_t67_x1 = ~(~x1_inp);
  assign t191_t69_x2 = ~(~x2_inp);
  assign t190_t68_Q4 = ~t191_t69_x2;
  assign t188_t66_T2 = t189_t67_x1 & t190_t68_Q4;
  assign t187_t65_z125_assgn125 = ~(~t188_t66_T2);

  always @(posedge clk) begin
    z125_assgn1250_reg4_reg40 <= ~(~t187_t65_z125_assgn125);
  end

  assign t194_x1 = x1_inp;
  assign t196_x2 = ~(~x2_inp);
  assign t195_Q4 = ~t196_x2;
  assign t193_T2 = t194_x1 & t195_Q4;
  assign t192_z125_assgn125 = t193_T2;

  always @(posedge clk) begin
    z125_assgn1250_reg41 <= ~(~t192_z125_assgn125);
  end


  always @(posedge clk) begin
    z55_assgn55_reg39 <= ~((r[8])? ~z125_assgn1250_reg41 : ~(~(~z125_assgn1250_reg4_reg40)));
  end

  assign t171_Y01 = ~(t172_L7 ^ ~z55_assgn55_reg39);
  assign t166_z1_assgn1 = ~z60_assgn60_reg31 ^ ~(~t171_Y01);

endmodule


