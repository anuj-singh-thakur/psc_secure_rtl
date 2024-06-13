module sbox(
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
//INPUTS
    input clk;
    input  x0_inp;
    input  x1_inp;
    input  x2_inp;
    input  x3_inp;
	input [20:0] r;
//OUTPUTS
    output reg  Y0;
    output reg  Y1;
    output reg  Y2;
    output reg  Y3;
//Intermediate values
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
    assign L0 = (x1 ^ x2);
    assign L1 = (x0 ^ x1);
    assign L8 = (x2 ^ x0);
    assign L5 = (x0 ^ x3);
    assign Q0 = ~L0;
    assign Q1 = ~L1;
    assign Q3 = ~x3;
    assign Q4 = ~x2;
    assign L2 = (Q1 ^ x2);
    assign L3 = (Q0 ^ x3);
    assign T0 = (Q0 & Q1);
    assign L10 = ~L2;
    assign T2 = (x1 & Q4);
    assign Q2 = (T0_reg ^ L2_reg);
    assign L4 = (T0_reg ^ T2_reg);
    assign Q7 = (T0_reg ^ L5_reg);
    assign Q6 = (L4 ^ L3_reg);
    assign T1 = (Q2 & Q3_reg);
    assign T3 = (Q6 & Q7);
    assign z117_assgn117 = T0;
    assign L7 = (z52_assgn52 ^ T1_reg);
    assign z121_assgn121 = L10;
    assign L11 = (T1_reg ^ z53_assgn53);
    assign z125_assgn125 = T2;
    assign Y01 = (L7 ^ z55_assgn55);
    assign z129_assgn129 = L8;
    assign Y11 = (z58_assgn58 ^ T3_reg);
    assign z133_assgn133 = x3;
    assign z1_assgn1 = (z60_assgn60 ^ Y01);
    assign z141_assgn141 = T2;
    assign z3_assgn3 = (L11 ^ z65_assgn65);
    assign z147_assgn147 = (T2 ^ L5);
 
    always @(posedge clk) begin
        T0_reg <= T0;
        L2_reg <= L2;
        T2_reg <= T2;
        L5_reg <= L5;
        L3_reg <= L3;
        Q3_reg <= Q3;
        z117_assgn1170 <= z117_assgn117;
        z52_assgn52 <= z117_assgn1170;
        T1_reg <= T1;
        z121_assgn1210 <= z121_assgn121;
        z53_assgn53 <= z121_assgn1210;
        z125_assgn1250 <= z125_assgn125;
        z55_assgn55 <= z125_assgn1250;
        z129_assgn1290 <= z129_assgn129;
        z58_assgn58 <= z129_assgn1290;
        T3_reg <= T3;
        z133_assgn1330 <= z133_assgn133;
        z60_assgn60 <= z133_assgn1330;
        Y0 <= z1_assgn1;
        Y1 <= (L7 ^ Y11);
        z141_assgn1410 <= z141_assgn141;
        z65_assgn65 <= z141_assgn1410;
        Y2 <= z3_assgn3;
        z147_assgn1470 <= z147_assgn147;
        z147_assgn1471 <= z147_assgn1470;
        Y3 <= z147_assgn1471;
    end
 
endmodule
