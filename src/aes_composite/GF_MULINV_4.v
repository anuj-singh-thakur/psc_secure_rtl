module GF_MULINV_4 (x, y);

   //------------------------------------------------
   input  [3:0] x;
   output [3:0] y;
   
   //------------------------------------------------
   wire [1:0] 	g1, g0, g1_g0, p, pi;

   
   //------------------------------------------------
   // Multipricative inversion in GF(2^2)
   assign {g1, g0} = x;
   assign g1_g0    = g1 ^ g0;

   assign p        = gf_mul2_phi(gf_sq2(g1)) ^ gf_mul2(g1_g0, g0);
   assign pi       = gf_inv2(p);

   assign y[3:2]   = gf_mul2(g1, pi);
   assign y[1:0]   = gf_mul2(g1_g0, pi);
   
   //------------------------------------------------ Square
   function [1:0] gf_sq2;
      input [1:0] x;
      begin
	 gf_sq2[1] = x[1];
	 gf_sq2[0] = x[1] ^ x[0];
      end
   endfunction // case

   //------------------------------------------------ Multiply
   function [1:0] gf_mul2;
      input [1:0] x, y;
      begin
	 gf_mul2[1] = x[1]&y[1] ^ x[0]&y[1] ^ x[1]&y[0];
	 gf_mul2[0] = x[1]&y[1] ^ x[0]&y[0];
      end
   endfunction // case

   // phi = 2'b10
   function [1:0] gf_mul2_phi;
      input [1:0] x;
      begin
	 gf_mul2_phi[1] = x[1] ^ x[0];
	 gf_mul2_phi[0] = x[1];
      end
   endfunction // case

   //------------------------------------------------ Multiplicative inversion
   function [1:0] gf_inv2;
      input [1:0] x;
      begin
	 gf_inv2[1] = x[1];
	 gf_inv2[0] = x[1] ^ x[0];
      end
   endfunction // case
      
endmodule // GF_MULINV4
