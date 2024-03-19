`timescale 1 ns / 1 ps


module aes_main_AddRoundKey
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

  parameter ap_ST_fsm_state1 = 6'd1;
  parameter ap_ST_fsm_state2 = 6'd2;
  parameter ap_ST_fsm_state3 = 6'd4;
  parameter ap_ST_fsm_state4 = 6'd8;
  parameter ap_ST_fsm_state5 = 6'd16;
  parameter ap_ST_fsm_state6 = 6'd32;
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
  reg [31:0] statemt_d0;
  reg [4:0] statemt_address1;
  reg statemt_ce1;
  reg statemt_we1;
  reg [31:0] statemt_d1;
  (* fsm_encoding = "none" *)
  reg [5:0] ap_CS_fsm;
  wire ap_CS_fsm_state1;
  reg [8:0] word1_address0;
  reg word1_ce0;
  wire [7:0] word1_q0;
  reg [8:0] word1_address1;
  reg word1_ce1;
  wire [7:0] word1_q1;
  wire [5:0] mul_fu_136_p3;
  reg [5:0] mul_reg_315;
  wire [5:0] add_ln557_fu_168_p2;
  reg [5:0] add_ln557_reg_323;
  wire ap_CS_fsm_state2;
  wire [0:0] icmp_ln554_fu_156_p2;
  wire [1:0] trunc_ln557_fu_173_p1;
  reg [1:0] trunc_ln557_reg_330;
  wire ap_CS_fsm_state3;
  wire [3:0] shl_ln_fu_200_p3;
  reg [3:0] shl_ln_reg_345;
  reg [4:0] statemt_addr_reg_351;
  reg [4:0] statemt_addr_24_reg_356;
  wire ap_CS_fsm_state4;
  wire [31:0] xor_ln557_fu_252_p2;
  reg [31:0] xor_ln557_reg_371;
  wire [31:0] xor_ln558_fu_262_p2;
  reg [31:0] xor_ln558_reg_376;
  reg [4:0] statemt_addr_25_reg_381;
  reg [4:0] statemt_addr_26_reg_386;
  wire [31:0] xor_ln559_fu_292_p2;
  reg [31:0] xor_ln559_reg_391;
  wire ap_CS_fsm_state5;
  wire [31:0] xor_ln560_fu_302_p2;
  reg [31:0] xor_ln560_reg_396;
  wire [63:0] zext_ln557_fu_182_p1;
  wire [63:0] zext_ln558_2_fu_195_p1;
  wire [63:0] zext_ln557_2_fu_207_p1;
  wire [63:0] zext_ln558_1_fu_218_p1;
  wire [63:0] zext_ln559_2_fu_232_p1;
  wire [63:0] zext_ln560_2_fu_243_p1;
  wire [63:0] zext_ln559_1_fu_273_p1;
  wire [63:0] zext_ln560_1_fu_283_p1;
  reg [2:0] j_fu_44;
  wire [2:0] add_ln554_fu_162_p2;
  wire ap_CS_fsm_state6;
  wire [5:0] zext_ln554_fu_152_p1;
  wire [7:0] zext_ln557_4_fu_186_p1;
  wire [7:0] add_ln558_fu_189_p2;
  wire [3:0] or_ln558_fu_212_p2;
  wire [8:0] zext_ln557_3_fu_223_p1;
  wire [8:0] add_ln559_fu_226_p2;
  wire [8:0] add_ln560_fu_237_p2;
  wire [31:0] zext_ln557_1_fu_248_p1;
  wire [31:0] zext_ln558_fu_258_p1;
  wire [3:0] or_ln559_fu_268_p2;
  wire [3:0] or_ln560_fu_278_p2;
  wire [31:0] zext_ln559_fu_288_p1;
  wire [31:0] zext_ln560_fu_298_p1;
  reg [5:0] ap_NS_fsm;
  reg ap_ST_fsm_state1_blk;
  wire ap_ST_fsm_state2_blk;
  wire ap_ST_fsm_state3_blk;
  wire ap_ST_fsm_state4_blk;
  wire ap_ST_fsm_state5_blk;
  wire ap_ST_fsm_state6_blk;
  wire ap_ce_reg;

  initial begin
    #0 ap_CS_fsm = 6'd1;
  end


  aes_main_AddRoundKey_word1_ROM_AUTO_1R
  #(
    .DataWidth(8),
    .AddressRange(480),
    .AddressWidth(9)
  )
  word1_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(word1_address0),
    .ce0(word1_ce0),
    .q0(word1_q0),
    .address1(word1_address1),
    .ce1(word1_ce1),
    .q1(word1_q1)
  );


  always @(posedge ap_clk) begin
    if(ap_rst == 1'b1) begin
      ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
      ap_CS_fsm <= ap_NS_fsm;
    end
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)) begin
      j_fu_44 <= 3'd0;
    end else if((icmp_ln554_fu_156_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) begin
      j_fu_44 <= add_ln554_fu_162_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln554_fu_156_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state2)) begin
      add_ln557_reg_323 <= add_ln557_fu_168_p2;
      trunc_ln557_reg_330 <= trunc_ln557_fu_173_p1;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state1) begin
      mul_reg_315[5:2] <= mul_fu_136_p3[5:2];
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state3) begin
      shl_ln_reg_345[3:2] <= ~shl_ln_fu_200_p3[3:2];
      statemt_addr_24_reg_356[3:2] <= zext_ln558_1_fu_218_p1[3:2];
      statemt_addr_reg_351[3:2] <= ~zext_ln557_2_fu_207_p1[3:2];
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state4) begin
      statemt_addr_25_reg_381[3:2] <= zext_ln559_1_fu_273_p1[3:2];
      statemt_addr_26_reg_386[3:2] <= zext_ln560_1_fu_283_p1[3:2];
      xor_ln557_reg_371 <= xor_ln557_fu_252_p2;
      xor_ln558_reg_376 <= xor_ln558_fu_262_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state5) begin
      xor_ln559_reg_391 <= xor_ln559_fu_292_p2;
      xor_ln560_reg_396 <= xor_ln560_fu_302_p2;
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

  always @(*) begin
    if((icmp_ln554_fu_156_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state2) | (1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b0)) begin
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
    if((icmp_ln554_fu_156_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state2)) begin
      ap_ready = 1'b1;
    end else begin
      ap_ready = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state6) begin
      statemt_address0 = statemt_addr_26_reg_386;
    end else if(1'b1 == ap_CS_fsm_state5) begin
      statemt_address0 = statemt_addr_24_reg_356;
    end else if(1'b1 == ap_CS_fsm_state4) begin
      statemt_address0 = zext_ln560_1_fu_283_p1;
    end else if(1'b1 == ap_CS_fsm_state3) begin
      statemt_address0 = zext_ln558_1_fu_218_p1;
    end else begin
      statemt_address0 = 'bx;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state6) begin
      statemt_address1 = statemt_addr_25_reg_381;
    end else if(1'b1 == ap_CS_fsm_state5) begin
      statemt_address1 = ~statemt_addr_reg_351;
    end else if(1'b1 == ap_CS_fsm_state4) begin
      statemt_address1 = zext_ln559_1_fu_273_p1;
    end else if(1'b1 == ap_CS_fsm_state3) begin
      statemt_address1 = zext_ln557_2_fu_207_p1;
    end else begin
      statemt_address1 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state3) | (1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state5)) begin
      statemt_ce0 = 1'b1;
    end else begin
      statemt_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state3) | (1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state5)) begin
      statemt_ce1 = 1'b1;
    end else begin
      statemt_ce1 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state6) begin
      statemt_d0 = xor_ln560_reg_396;
    end else if(1'b1 == ap_CS_fsm_state5) begin
      statemt_d0 = xor_ln558_reg_376;
    end else begin
      statemt_d0 = 'bx;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state6) begin
      statemt_d1 = xor_ln559_reg_391;
    end else if(1'b1 == ap_CS_fsm_state5) begin
      statemt_d1 = ~xor_ln557_reg_371;
    end else begin
      statemt_d1 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state5)) begin
      statemt_we0 = 1'b1;
    end else begin
      statemt_we0 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state5)) begin
      statemt_we1 = 1'b1;
    end else begin
      statemt_we1 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state4) begin
      word1_address0 = zext_ln560_2_fu_243_p1;
    end else if(1'b1 == ap_CS_fsm_state3) begin
      word1_address0 = zext_ln558_2_fu_195_p1;
    end else begin
      word1_address0 = 'bx;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state4) begin
      word1_address1 = zext_ln559_2_fu_232_p1;
    end else if(1'b1 == ap_CS_fsm_state3) begin
      word1_address1 = zext_ln557_fu_182_p1;
    end else begin
      word1_address1 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state3)) begin
      word1_ce0 = 1'b1;
    end else begin
      word1_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state4) | (1'b1 == ap_CS_fsm_state3)) begin
      word1_ce1 = 1'b1;
    end else begin
      word1_ce1 = 1'b0;
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
        if((icmp_ln554_fu_156_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state2)) begin
          ap_NS_fsm = ap_ST_fsm_state1;
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
      default: begin
        ap_NS_fsm = 'bx;
      end
    endcase
  end

  assign add_ln554_fu_162_p2 = j_fu_44 + 3'd1;
  assign add_ln557_fu_168_p2 = zext_ln554_fu_152_p1 + mul_reg_315;
  assign add_ln558_fu_189_p2 = zext_ln557_4_fu_186_p1 + 8'd120;
  assign add_ln559_fu_226_p2 = zext_ln557_3_fu_223_p1 + 9'd240;
  assign add_ln560_fu_237_p2 = $signed(zext_ln557_3_fu_223_p1) + $signed(9'd360);
  assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];
  assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];
  assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];
  assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];
  assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];
  assign ap_CS_fsm_state6 = ap_CS_fsm[32'd5];
  assign icmp_ln554_fu_156_p2 = (j_fu_44 == 3'd4)? 1'b1 : 1'b0;
  assign mul_fu_136_p3 = { { n }, { 2'd0 } };
  assign or_ln558_fu_212_p2 = ~shl_ln_fu_200_p3 | 4'd1;
  assign or_ln559_fu_268_p2 = shl_ln_reg_345 | 4'd2;
  assign or_ln560_fu_278_p2 = shl_ln_reg_345 | 4'd3;
  assign shl_ln_fu_200_p3 = ~{ ~{ ~(~trunc_ln557_reg_330) }, ~{ ~2'd0 } };
  assign trunc_ln557_fu_173_p1 = ~j_fu_44[1:0];
  assign xor_ln557_fu_252_p2 = ~zext_ln557_1_fu_248_p1 ^ statemt_q1;
  assign xor_ln558_fu_262_p2 = zext_ln558_fu_258_p1 ^ statemt_q0;
  assign xor_ln559_fu_292_p2 = zext_ln559_fu_288_p1 ^ statemt_q1;
  assign xor_ln560_fu_302_p2 = zext_ln560_fu_298_p1 ^ statemt_q0;
  assign zext_ln554_fu_152_p1 = j_fu_44;
  assign zext_ln557_1_fu_248_p1 = word1_q1;
  assign zext_ln557_2_fu_207_p1 = ~shl_ln_fu_200_p3;
  assign zext_ln557_3_fu_223_p1 = add_ln557_reg_323;
  assign zext_ln557_4_fu_186_p1 = add_ln557_reg_323;
  assign zext_ln557_fu_182_p1 = add_ln557_reg_323;
  assign zext_ln558_1_fu_218_p1 = or_ln558_fu_212_p2;
  assign zext_ln558_2_fu_195_p1 = add_ln558_fu_189_p2;
  assign zext_ln558_fu_258_p1 = word1_q0;
  assign zext_ln559_1_fu_273_p1 = or_ln559_fu_268_p2;
  assign zext_ln559_2_fu_232_p1 = add_ln559_fu_226_p2;
  assign zext_ln559_fu_288_p1 = word1_q1;
  assign zext_ln560_1_fu_283_p1 = or_ln560_fu_278_p2;
  assign zext_ln560_2_fu_243_p1 = add_ln560_fu_237_p2;
  assign zext_ln560_fu_298_p1 = word1_q0;

  always @(posedge ap_clk) begin
    mul_reg_315[1:0] <= 2'b00;
    shl_ln_reg_345[1:0] <= 2'b00;
    statemt_addr_reg_351[1:0] <= ~2'b00;
    statemt_addr_reg_351[4] <= ~1'b0;
    statemt_addr_24_reg_356[1:0] <= 2'b01;
    statemt_addr_24_reg_356[4] <= 1'b0;
    statemt_addr_25_reg_381[1:0] <= 2'b10;
    statemt_addr_25_reg_381[4] <= 1'b0;
    statemt_addr_26_reg_386[1:0] <= 2'b11;
    statemt_addr_26_reg_386[4] <= 1'b0;
  end


endmodule


