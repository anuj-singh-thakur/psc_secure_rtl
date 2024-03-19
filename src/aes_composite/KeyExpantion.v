//================================================ KeyExpantion
module KeyExpantion (kin, kout, rcon);

   //------------------------------------------------
   input [127:0]  kin;
   output [127:0] kout;
   input [7:0] 	  rcon;

   //------------------------------------------------
   wire [31:0]    ws, wr, w0, w1, w2, w3;
   //------------------------------------------------
   SubBytes SB0 ({kin[23:16], kin[15:8], kin[7:0], kin[31:24]}, ws);
   assign wr = {(ws[31:24] ^ rcon), ws[23:0]};

   assign w0 = wr ^ kin[127:96];
   assign w1 = w0 ^ kin[95:64];
   assign w2 = w1 ^ kin[63:32];
   assign w3 = w2 ^ kin[31:0];

   assign kout = {w0, w1, w2, w3};

endmodule // KeyExpantion


