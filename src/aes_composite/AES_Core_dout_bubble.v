`timescale 1 ns / 1 ps


module AES_Core_dout
(
  din,
  dout,
  kin,
  sel
);

  input [127:0] din;input [127:0] kin;
  input sel;
  output [127:0] dout;

  wire [31:0] pre_sb0_0;
  wire [31:0] pre_sb0_1;
  wire [31:0] pre_sb0_2;
  wire [31:0] pre_sb0_3;
  wire [31:0] pre_sb0_4;
  wire [31:0] pre_sb0_5;
  wire [31:0] pre_sb0_6;
  wire [31:0] pre_sb0_7;

  wire [31:0] pre_sb1_0;
  wire [31:0] pre_sb1_1;
  wire [31:0] pre_sb1_2;
  wire [31:0] pre_sb1_3;
  wire [31:0] pre_sb1_4;
  wire [31:0] pre_sb1_5;
  wire [31:0] pre_sb1_6;
  wire [31:0] pre_sb1_7;

  wire [31:0] pre_sb2_0;
  wire [31:0] pre_sb2_1;
  wire [31:0] pre_sb2_2;
  wire [31:0] pre_sb2_3;
  wire [31:0] pre_sb2_4;
  wire [31:0] pre_sb2_5;
  wire [31:0] pre_sb2_6;
  wire [31:0] pre_sb2_7;

  wire [31:0] pre_sb3_0;
  wire [31:0] pre_sb3_1;
  wire [31:0] pre_sb3_2;
  wire [31:0] pre_sb3_3;
  wire [31:0] pre_sb3_4;
  wire [31:0] pre_sb3_5;
  wire [31:0] pre_sb3_6;
  wire [31:0] pre_sb3_7;

  wire [31:0] st0;wire [31:0] st1;wire [31:0] st2;wire [31:0] st3;reg [31:0] sb0;reg [31:0] sb1;reg [31:0] sb2;reg [31:0] sb3;wire [31:0] sr0;wire [31:0] sr1;wire [31:0] sr2;wire [31:0] sr3;wire [31:0] sc0;wire [31:0] sc1;wire [31:0] sc2;wire [31:0] sc3;wire [31:0] sk0;wire [31:0] sk1;wire [31:0] sk2;wire [31:0] sk3;
  assign st0 = ~din[127:96];
  assign st1 = din[95:64];
  assign st2 = din[63:32];
  assign st3 = ~din[31:0];

  SubBytes
  SB0
  (
    ~st0,
    pre_sb0_0
  );

  SubBytes_ny_v1
  SB0_1
  (
    ~st0,
    pre_sb0_1
  );

  SubBytes_ny_v2
  SB0_2
  (
    ~st0,
    pre_sb0_2
  );

  SubBytes_ny_v3
  SB0_3
  (
    ~st0,
    pre_sb0_3
  );

  SubBytes_ny_3
  SB0_4
  (
    ~st0,
    pre_sb0_4
  );

  SubBytes_ny
  SB0_5
  (
    ~st0,
    pre_sb0_5
  );

  SubBytes_ny_2_v1
  SB0_6
  (
    ~st0,
    pre_sb0_6
  );

  SubBytes_ny_3_v1
  SB0_7
  (
    ~st0,
    pre_sb0_7
  );


  always @(*) begin
    case ({din[6],din[14],din[31]}) 
      3'b00:  sb0 = pre_sb0_0;
      3'b01:  sb0 = ~pre_sb0_1;
      3'b10:  sb0 = ~pre_sb0_2;
      3'b11:  sb0 = ~pre_sb0_3;
      3'b100: sb0 = ~pre_sb0_4;
      3'b101: sb0 = ~pre_sb0_5;
      3'b110: sb0 = ~pre_sb0_6;
      3'b111: sb0 = ~pre_sb0_7;
    endcase
  end

  // SubBytes SB0
  SubBytes_ny_2
  SB1_0
  (
    st1,
    pre_sb1_0
  );

  SubBytes_ny_v1
  SB1_1
  (
    st1,
    pre_sb1_1
  );

  SubBytes_ny_v2
  SB1_2
  (
    st1,
    pre_sb1_2
  );

  SubBytes_ny_v3
  SB1_3
  (
    st1,
    pre_sb1_3
  );

  SubBytes_ny_3
  SB1_4
  (
    st1,
    pre_sb1_4
  );

  SubBytes_ny
  SB1_5
  (
    st1,
    pre_sb1_5
  );

  SubBytes_ny_2_v1
  SB1_6
  (
    st1,
    pre_sb1_6
  );

  SubBytes_ny_3_v1
  SB1_7
  (
    st1,
    pre_sb1_7
  );


  always @(*) begin
    case ({din[5],din[25],din[0 ]}) 
      3'b00:  sb1 = pre_sb1_0;
      3'b01:  sb1 = pre_sb1_1;
      3'b10:  sb1 = pre_sb1_2;
      3'b11:  sb1 = pre_sb1_3;
      3'b100: sb1 = pre_sb1_4;
      3'b101: sb1 = pre_sb1_5;
      3'b110: sb1 = pre_sb1_6;
      3'b111: sb1 = pre_sb1_7;
    endcase
  end


  // SB2
  SubBytes_ny
  SB2_0
  (
    st2,
    pre_sb2_0
  );

  SubBytes_ny_v1
  SB2_1
  (
    st2,
    pre_sb2_1
  );

  SubBytes_ny_v2
  SB2_2
  (
    st2,
    pre_sb2_2
  );

  SubBytes_ny_v3
  SB2_3
  (
    st2,
    pre_sb2_3
  );

  SubBytes_ny_3
  SB2_4
  (
    st2,
    pre_sb2_4
  );

  SubBytes_ny
  SB2_5
  (
    st2,
    pre_sb2_5
  );

  SubBytes_ny_2_v1
  SB2_6
  (
    st2,
    pre_sb2_6
  );

  SubBytes_ny_3_v1
  SB2_7
  (
    st2,
    pre_sb2_7
  );

  
  always @(*) begin
    case ({din[18],din[27],din[13]}) 
      3'b000:  sb2 = pre_sb2_0;
      3'b001:  sb2 = pre_sb2_1;
      3'b010:  sb2 = pre_sb2_2;
      3'b011:  sb2 = pre_sb2_3;
      3'b100: sb2 = pre_sb2_4;
      3'b101: sb2 = pre_sb2_5;
      3'b110: sb2 = pre_sb2_6;
      3'b111: sb2 = pre_sb2_7;
    endcase
  end

  // SB3
  SubBytes_ny
  SB3_0
  (
    ~st3,
    pre_sb3_0
  );

  SubBytes_ny_v1
  SB3_1
  (
    ~st3,
    pre_sb3_1
  );

  SubBytes_ny_v2
  SB3_2
  (
    ~st3,
    pre_sb3_2
  );

  SubBytes_ny_v3
  SB3_3
  (
    ~st3,
    pre_sb3_3
  );

  SubBytes_ny_3
  SB3_4
  (
    ~st3,
    pre_sb3_4
  );

  SubBytes_ny
  SB3_5
  (
    ~st3,
    pre_sb3_5
  );

  SubBytes_ny_2_v1
  SB3_6
  (
    ~st3,
    pre_sb3_6
  );

  SubBytes_ny_3_v1
  SB3_7
  (
    ~st3,
    pre_sb3_7
  );

  always @(*) begin
    case ({din[28],din[11],din[20]}) 
      3'b000:  sb3 = pre_sb3_0;
      3'b001:  sb3 = pre_sb3_1;
      3'b010:  sb3 = pre_sb3_2;
      3'b011:  sb3 = pre_sb3_3;
      3'b100: sb3 = pre_sb3_4;
      3'b101: sb3 = pre_sb3_5;
      3'b110: sb3 = pre_sb3_6;
      3'b111: sb3 = pre_sb3_7;
    endcase
    // sb3 = pre_sb3_4;
  end

  assign sr0 = ~{ ~sb0[31:24], ~(~(~(~(~(~sb1[23:16]))))), ~(~(~(~(~(~sb2[15:8]))))), ~(~(~(~(~(~sb3[7:0]))))) };
  assign sr1 = ~{ ~(~(~(~(~(~sb1[31:24]))))), ~(~(~(~(~(~sb2[23:16]))))), ~(~(~(~(~(~sb3[15:8]))))), ~sb0[7:0] };
  assign sr2 = { ~(~sb2[31:24]), ~(~sb3[23:16]), ~sb0[15:8], ~(~sb1[7:0]) };
  assign sr3 = { ~(~sb3[31:24]), ~sb0[23:16], ~(~sb1[15:8]), ~(~sb2[7:0]) };

  MixColumns_ny
  MC0
  (
    sr0,
    sc0
  );


  MixColumns
  MC1
  (
    sr1,
    sc1
  );


  MixColumns
  MC2
  (
    ~sr2,
    sc2
  );


  MixColumns_ny
  MC3
  (
    ~sr3,
    sc3
  );
  
  assign sk0 = (sel)? ~sr0 ^ kin[127:96] : ~(~sc0) ^ kin[127:96];
  assign sk1 = (sel)? ~sr1 ^ kin[95:64] : ~sc1 ^ kin[95:64];
  assign sk2 = (sel)? ~(~sr2) ^ kin[63:32] : ~sc2 ^ kin[63:32];
  assign sk3 = (sel)? ~(~sr3) ^ kin[31:0] : ~(~sc3) ^ kin[31:0];
  assign dout = { ~(~sk0), ~(~sk1), sk2, ~(~sk3) };

endmodule


