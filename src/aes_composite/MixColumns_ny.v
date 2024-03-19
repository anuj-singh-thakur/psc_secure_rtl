//================================================ MixColumns
module MixColumns_ny(x, y);

   //------------------------------------------------
   input  [31:0]  x;
   output [31:0]  y;

   //------------------------------------------------
   wire [7:0]    a0, a1, a2, a3;
   wire [7:0]    b0, b1, b2, b3;

   assign a0 = x[31:24];
   assign a1 = x[23:16];
   assign a2 = x[15: 8];
   assign a3 = x[ 7: 0];

   assign b0 = (a0[7]==1'b0)? {a0[6:0],1'b0} : {a0[6:0],1'b0} ^ 8'h1B; // b0 = xtime(a0);
   assign b1 = (a1[7]==1'b0)? {a1[6:0],1'b0} : {a1[6:0],1'b0} ^ 8'h1B; //b1 = xtime(a1);
   assign b2 = (a2[7]==1'b0)? {a2[6:0],1'b0} : {a2[6:0],1'b0} ^ 8'h1B;  //b2 = xtime(a2);
   assign b3 = (a3[7]==1'b0)? {a3[6:0],1'b0} : {a3[6:0],1'b0} ^ 8'h1B;  //b3 = xtime(a3);

   assign y[31:24] =   ~( b0 ^ a1^b1 ^ a2    ^ a3);
   assign y[23:16] = ~(a0        ^b1 ^ a2^b2 ^ a3);
   assign y[15: 8] = ~(a0    ^ a1        ^b2 ^ a3^b3);
   assign y[ 7: 0] = ~(a0^b0 ^ a1    ^ a2        ^b3);
  
   // function [7:0] xtime;
   //    input [7:0] x;
   //    xtime = (x[7]==1'b0)? {x[6:0],1'b0} : {x[6:0],1'b0} ^ 8'h1B;
   // endfunction
   
endmodule // MixColumns

