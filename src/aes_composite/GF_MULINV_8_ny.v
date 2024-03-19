module GF_MULINV_8_ny (x, y);

   //------------------------------------------------
   input  [7:0] x;
   output [7:0] y;
   
   //------------------------------------------------
   wire [7:0] 	xt, yt;
   wire [3:0] 	g1, g0, g1_g0, p, pi;
   
   //------------------------------------------------
   // GF(2^8) -> GF(2^2^2) transform
   assign xt = mat_x(x);

   // Multipricative inversion in GF(2^2^2)
   assign {g1, g0} = xt;
   assign g1_g0    = g1 ^ g0;

   assign p = gf_mul4_lambda(gf_sq4(g1)) ^ gf_mul4(g1_g0, g0);
   GF_MULINV_4 u0 (p, pi);
   
   assign yt[7:4]  = gf_mul4(g1, pi);
   assign yt[3:0]  = gf_mul4(g1_g0, pi);
   
   // GF(2^2^2) -> GF(2^8) inverse transform
   assign y = ~mat_xi(yt);
	     
   //------------------------------------------------ 
   // Isomorphism matrix (lambda = 4'b1100, phi = 2'b10)
   function [7:0] mat_x;
      input [7:0] x;
      begin
	 mat_x[7] =  x[7]        ^ x[5];
	 mat_x[6] =  x[7] ^ x[6]        ^ x[4] ^ x[3] ^ x[2] ^ x[1];
	 mat_x[5] =  x[7]        ^ x[5]        ^ x[3] ^ x[2];
	 mat_x[4] =  x[7]        ^ x[5]        ^ x[3] ^ x[2] ^ x[1];
	 mat_x[3] =  x[7] ^ x[6]                      ^ x[2] ^ x[1];
	 mat_x[2] =  x[7]               ^ x[4] ^ x[3] ^ x[2] ^ x[1];
	 mat_x[1] =         x[6]        ^ x[4]               ^ x[1];
	 mat_x[0] =         x[6]                             ^ x[1] ^ x[0];
      end
   endfunction
      
   function [7:0] mat_xi;
      input [7:0] x;
      begin
	 mat_xi[7] =  x[7] ^ x[6] ^ x[5]                      ^ x[1];
	 mat_xi[6] =         x[6]                      ^ x[2];
	 mat_xi[5] =         x[6] ^ x[5]                      ^ x[1];
	 mat_xi[4] =         x[6] ^ x[5] ^ x[4]        ^ x[2] ^ x[1];
	 mat_xi[3] =                x[5] ^ x[4] ^ x[3] ^ x[2] ^ x[1];
	 mat_xi[2] =  x[7]               ^ x[4] ^ x[3] ^ x[2] ^ x[1];
	 mat_xi[1] =                x[5] ^ x[4];
	 mat_xi[0] =         x[6] ^ x[5] ^ x[4]        ^ x[2]        ^ x[0];
      end
   endfunction
   
   //------------------------------------------------ Square 
   function [3:0] gf_sq4;
      input [3:0] x;
      begin
	 gf_sq4[0] = x[3] ^ x[1] ^ x[0];
	 gf_sq4[1] = x[2] ^ x[1];
	 gf_sq4[2] = x[3] ^ x[2];
	 gf_sq4[3] = x[3];      
      end
   endfunction // gf_sq4

   //------------------------------------------------ Multiply
   function [3:0] gf_mul4;
      input [3:0] x, y;
      begin
	 gf_mul4[3] = x[3]&y[3] ^ x[3]&y[1] ^ x[1]&y[3] ^ 
		      x[2]&y[3] ^ x[2]&y[1] ^ x[0]&y[3] ^
		      x[3]&y[2] ^ x[3]&y[0] ^ x[1]&y[2];
	 
	 gf_mul4[2] = x[3]&y[3] ^ x[3]&y[1] ^ x[1]&y[3] ^
		      x[2]&y[2] ^ x[2]&y[0] ^ x[0]&y[2];
	 
	 gf_mul4[1] = x[2]&y[3] ^ x[3]&y[2] ^ x[2]&y[2]^
		      x[1]&y[1] ^ x[0]&y[1] ^ x[1]&y[0];
	 
	 gf_mul4[0] = x[3]&y[3] ^ x[2]&y[3] ^ x[3]&y[2]^
		      x[1]&y[1] ^ x[0]&y[0];   
      end
   endfunction

   // lambda = 4'b1100
   function [3:0] gf_mul4_lambda;
      input [3:0] x;
      begin
	 gf_mul4_lambda[3] = x[2] ^ x[0];
	 gf_mul4_lambda[2] = x[3] ^ x[2] ^ x[1] ^ x[0];
	 gf_mul4_lambda[1] = x[3];
	 gf_mul4_lambda[0] = x[2];
      end
   endfunction

endmodule // GF_MULINV_8

