//================================================ AES_Core
module AES_Core (din, dout, kin, sel);

   //------------------------------------------------
   input  [127:0] din, kin;
   input          sel;
   output [127:0] dout;
   
   //------------------------------------------------
   wire [31:0] st0, st1, st2, st3, // state
               sb0, sb1, sb2, sb3, // SubBytes
               sr0, sr1, sr2, sr3, // ShiftRows
               sc0, sc1, sc2, sc3, // MixColumns
               sk0, sk1, sk2, sk3; // AddRoundKey

   //------------------------------------------------
   // din -> state
   reg [31:0] sb0_new;
   assign st0 = din[127:96];
   assign st1 = din[ 95:64];
   assign st2 = din[ 63:32];
   assign st3 = din[ 31: 0];

   always @(din)begin
      sb0_new = sb0;
   end


   // SubBytes
   SubBytes SB0 (st0, sb0);
   SubBytes SB1 (st1, sb1);
   SubBytes SB2 (st2, sb2);
   SubBytes SB3 (st3, sb3);

   // ShiftRows
   assign sr0 = {sb0_new[31:24], sb1[23:16], sb2[15: 8], sb3[ 7: 0]};
   assign sr1 = {sb1[31:24], sb2[23:16], sb3[15: 8], sb0_new[ 7: 0]};
   assign sr2 = {sb2[31:24], sb3[23:16], sb0_new[15: 8], sb1[ 7: 0]};
   assign sr3 = {sb3[31:24], sb0_new[23:16], sb1[15: 8], sb2[ 7: 0]};

   // MixColumns
   MixColumns MC0 (sr0, sc0);
   MixColumns MC1 (sr1, sc1);
   MixColumns MC2 (sr2, sc2);
   MixColumns MC3 (sr3, sc3);

   // AddRoundKey
   assign sk0 = (sel) ? sr0 ^ kin[127:96] : sc0 ^ kin[127:96];
   assign sk1 = (sel) ? sr1 ^ kin[ 95:64] : sc1 ^ kin[ 95:64];
   assign sk2 = (sel) ? sr2 ^ kin[ 63:32] : sc2 ^ kin[ 63:32];
   assign sk3 = (sel) ? sr3 ^ kin[ 31: 0] : sc3 ^ kin[ 31: 0];

   // state -> dout
   assign dout = {sk0, sk1, sk2, sk3};
endmodule // AES_Core




// //================================================ AES_Core
// module AES_Core (din, dout, kin, sel);

//    //------------------------------------------------
//    input  [127:0] din, kin;
//    input          sel;
//    output [127:0] dout;
   
//    //------------------------------------------------
//    wire [31:0] st0, st1, st2, st3, // state
//                sb0, sb1, sb2, sb3, // SubBytes
//                sr0, sr1, sr2, sr3, // ShiftRows
//                sc0, sc1, sc2, sc3, // MixColumns
//                sk0, sk1, sk2, sk3; // AddRoundKey

//    //------------------------------------------------
//    // din -> state
//    assign st0 = din[127:96];
//    assign st1 = din[ 95:64];
//    assign st2 = din[ 63:32];
//    assign st3 = din[ 31: 0];

//    // SubBytes
//    SubBytes SB0 (st0, sb0);
//    SubBytes SB1 (st1, sb1);
//    SubBytes SB2 (st2, sb2);
//    SubBytes SB3 (st3, sb3);

//    // ShiftRows
//    assign sr0 = {sb0[31:24], sb1[23:16], sb2[15: 8], sb3[ 7: 0]};
//    assign sr1 = {sb1[31:24], sb2[23:16], sb3[15: 8], sb0[ 7: 0]};
//    assign sr2 = {sb2[31:24], sb3[23:16], sb0[15: 8], sb1[ 7: 0]};
//    assign sr3 = {sb3[31:24], sb0[23:16], sb1[15: 8], sb2[ 7: 0]};

//    // MixColumns
//    MixColumns MC0 (sr0, sc0);
//    MixColumns MC1 (sr1, sc1);
//    MixColumns MC2 (sr2, sc2);
//    MixColumns MC3 (sr3, sc3);

//    // AddRoundKey
//    assign sk0 = (sel) ? sr0 ^ kin[127:96] : sc0 ^ kin[127:96];
//    assign sk1 = (sel) ? sr1 ^ kin[ 95:64] : sc1 ^ kin[ 95:64];
//    assign sk2 = (sel) ? sr2 ^ kin[ 63:32] : sc2 ^ kin[ 63:32];
//    assign sk3 = (sel) ? sr3 ^ kin[ 31: 0] : sc3 ^ kin[ 31: 0];

//    // state -> dout
//    assign dout = {sk0, sk1, sk2, sk3};
// endmodule // AES_Core

