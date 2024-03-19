`timescale 1 ns / 1 ps

(* CORE_GENERATION_INFO = "top_function_top_function,hls_ip_2022_1,{HLS_INPUT_TYPE=c,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu7ev-ffvf1517-3-e,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=5.058505,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=1,HLS_SYN_DSP=0,HLS_SYN_FF=1269,HLS_SYN_LUT=2683,HLS_VERSION=2022_1}" *)


module top_function
(
  ap_clk,
  ap_rst,
  ap_start,
  ap_done,
  ap_idle,
  ap_ready,
  inputdata
);

  parameter ap_ST_fsm_state1 = 7'd1;
  parameter ap_ST_fsm_state2 = 7'd2;
  parameter ap_ST_fsm_state3 = 7'd4;
  parameter ap_ST_fsm_state4 = 7'd8;
  parameter ap_ST_fsm_state5 = 7'd16;
  parameter ap_ST_fsm_state6 = 7'd32;
  parameter ap_ST_fsm_state7 = 7'd64;
  input ap_clk;
  input ap_rst;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  input [31:0] inputdata;
  reg ap_done;
  reg ap_idle;
  reg ap_ready;
  (* fsm_encoding = "none" *)
  reg [6:0] ap_CS_fsm;
  wire ap_CS_fsm_state1;
  wire [5:0] IP_address0;
  reg IP_ce0;
  wire [5:0] IP_q0;
  wire [5:0] PC1_address0;
  reg PC1_ce0;
  wire [5:0] PC1_q0;
  wire [4:0] i_4_fu_244_p2;
  reg [4:0] i_4_reg_404;
  wire ap_CS_fsm_state2;
  wire [6:0] add_ln35_fu_261_p2;
  reg [6:0] add_ln35_reg_412;
  wire ap_CS_fsm_state3;
  wire [0:0] icmp_ln35_fu_255_p2;
  wire [63:0] init_perm_res_1_fu_291_p3;
  wire ap_CS_fsm_state4;
  wire [5:0] add_ln66_fu_310_p2;
  reg [5:0] add_ln66_reg_430;
  wire ap_CS_fsm_state5;
  wire [0:0] icmp_ln66_fu_304_p2;
  wire [53:0] trunc_ln71_1_fu_316_p1;
  reg [53:0] trunc_ln71_1_reg_440;
  reg [27:0] trunc_ln2_reg_445;
  reg [31:0] L1_reg_450;
  wire [31:0] R1_fu_341_p1;
  reg [31:0] R1_reg_455;
  wire [27:0] trunc_ln75_fu_346_p1;
  reg [27:0] trunc_ln75_reg_460;
  wire [54:0] permuted_choice_1_1_fu_375_p3;
  wire ap_CS_fsm_state6;
  wire grp_shiftingcidi_fu_195_ap_start;
  wire grp_shiftingcidi_fu_195_ap_done;
  wire grp_shiftingcidi_fu_195_ap_idle;
  wire grp_shiftingcidi_fu_195_ap_ready;
  wire [63:0] grp_shiftingcidi_fu_195_ap_return;
  reg [6:0] i_1_reg_138;
  wire [0:0] icmp_ln331_fu_238_p2;
  reg [63:0] init_perm_res_reg_149;
  reg [5:0] i_3_reg_161;
  reg [54:0] permuted_choice_1_reg_172;
  reg [27:0] phi_ln74_reg_183;
  reg grp_shiftingcidi_fu_195_ap_start_reg;
  wire ap_CS_fsm_state7;
  wire [63:0] zext_ln35_fu_250_p1;
  wire [63:0] zext_ln66_fu_299_p1;
  reg [63:0] result_fu_98;
  wire signed [63:0] sext_ln323_fu_221_p1;
  reg [4:0] i_fu_102;
  wire [5:0] sub_ln40_fu_267_p2;
  wire [63:0] zext_ln40_fu_273_p1;
  wire [63:0] lshr_ln40_fu_277_p2;
  wire [62:0] trunc_ln40_1_fu_287_p1;
  wire [0:0] trunc_ln40_fu_283_p1;
  wire [5:0] sub_ln71_fu_355_p2;
  wire [63:0] zext_ln71_fu_361_p1;
  wire [63:0] lshr_ln71_fu_365_p2;
  wire [0:0] trunc_ln71_fu_371_p1;
  reg [6:0] ap_NS_fsm;
  reg ap_ST_fsm_state1_blk;
  wire ap_ST_fsm_state2_blk;
  wire ap_ST_fsm_state3_blk;
  wire ap_ST_fsm_state4_blk;
  wire ap_ST_fsm_state5_blk;
  wire ap_ST_fsm_state6_blk;
  reg ap_ST_fsm_state7_blk;
  wire ap_ce_reg;

  initial begin
    #0 ap_CS_fsm = 7'd1;
    #0 grp_shiftingcidi_fu_195_ap_start_reg = 1'b0;
  end


  top_function_IP_ROM_AUTO_1R
  #(
    .DataWidth(6),
    .AddressRange(64),
    .AddressWidth(6)
  )
  IP_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(IP_address0),
    .ce0(IP_ce0),
    .q0(IP_q0)
  );


  top_function_PC1_ROM_AUTO_1R
  #(
    .DataWidth(6),
    .AddressRange(56),
    .AddressWidth(6)
  )
  PC1_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(PC1_address0),
    .ce0(PC1_ce0),
    .q0(PC1_q0)
  );


  top_function_shiftingcidi
  grp_shiftingcidi_fu_195
  (
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_shiftingcidi_fu_195_ap_start),
    .ap_done(grp_shiftingcidi_fu_195_ap_done),
    .ap_idle(grp_shiftingcidi_fu_195_ap_idle),
    .ap_ready(grp_shiftingcidi_fu_195_ap_ready),
    .C(~phi_ln74_reg_183),
    .D(trunc_ln75_reg_460),
    .L(L1_reg_450),
    .R(R1_reg_455),
    .ap_return(grp_shiftingcidi_fu_195_ap_return)
  );


  always @(posedge ap_clk) begin
    if(ap_rst == 1'b1) begin
      ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
      ap_CS_fsm <= ap_NS_fsm;
    end
  end


  always @(posedge ap_clk) begin
    if(ap_rst == 1'b1) begin
      grp_shiftingcidi_fu_195_ap_start_reg <= 1'b0;
    end else begin
      if((icmp_ln66_fu_304_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state5)) begin
        grp_shiftingcidi_fu_195_ap_start_reg <= 1'b1;
      end else if(grp_shiftingcidi_fu_195_ap_ready == 1'b1) begin
        grp_shiftingcidi_fu_195_ap_start_reg <= 1'b0;
      end 
    end
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state2) & (icmp_ln331_fu_238_p2 == 1'd0)) begin
      i_1_reg_138 <= 7'd0;
    end else if(1'b1 == ap_CS_fsm_state4) begin
      i_1_reg_138 <= add_ln35_reg_412;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln35_fu_255_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state3)) begin
      i_3_reg_161 <= 6'd0;
    end else if(1'b1 == ap_CS_fsm_state6) begin
      i_3_reg_161 <= add_ln66_reg_430;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)) begin
      i_fu_102 <= 5'd0;
    end else if((icmp_ln66_fu_304_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state5)) begin
      i_fu_102 <= i_4_reg_404;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state2) & (icmp_ln331_fu_238_p2 == 1'd0)) begin
      init_perm_res_reg_149 <= ~64'd0;
    end else if(1'b1 == ap_CS_fsm_state4) begin
      init_perm_res_reg_149 <= ~init_perm_res_1_fu_291_p3;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln35_fu_255_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state3)) begin
      permuted_choice_1_reg_172 <= ~55'd0;
    end else if(1'b1 == ap_CS_fsm_state6) begin
      permuted_choice_1_reg_172 <= ~permuted_choice_1_1_fu_375_p3;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln35_fu_255_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state3)) begin
      phi_ln74_reg_183 <= ~28'd0;
    end else if(1'b1 == ap_CS_fsm_state6) begin
      phi_ln74_reg_183 <= ~trunc_ln2_reg_445;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state1) & (ap_start == 1'b1)) begin
      result_fu_98 <= sext_ln323_fu_221_p1;
    end else if((1'b1 == ap_CS_fsm_state7) & (grp_shiftingcidi_fu_195_ap_done == 1'b1)) begin
      result_fu_98 <= grp_shiftingcidi_fu_195_ap_return;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln66_fu_304_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state5)) begin
      L1_reg_450 <= { { ~init_perm_res_reg_149[63:32] } };
      R1_reg_455 <= R1_fu_341_p1;
      trunc_ln75_reg_460 <= trunc_ln75_fu_346_p1;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state3) begin
      add_ln35_reg_412 <= add_ln35_fu_261_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state5) begin
      add_ln66_reg_430 <= add_ln66_fu_310_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state2) begin
      i_4_reg_404 <= i_4_fu_244_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln66_fu_304_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state5)) begin
      trunc_ln2_reg_445 <= { { ~permuted_choice_1_reg_172[54:27] } };
      trunc_ln71_1_reg_440 <= trunc_ln71_1_fu_316_p1;
    end 
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state3) begin
      IP_ce0 = 1'b1;
    end else begin
      IP_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state5) begin
      PC1_ce0 = 1'b1;
    end else begin
      PC1_ce0 = 1'b0;
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
    if(grp_shiftingcidi_fu_195_ap_done == 1'b0) begin
      ap_ST_fsm_state7_blk = 1'b1;
    end else begin
      ap_ST_fsm_state7_blk = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state2) & (icmp_ln331_fu_238_p2 == 1'd1)) begin
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
    if((1'b1 == ap_CS_fsm_state2) & (icmp_ln331_fu_238_p2 == 1'd1)) begin
      ap_ready = 1'b1;
    end else begin
      ap_ready = 1'b0;
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
        if((1'b1 == ap_CS_fsm_state2) & (icmp_ln331_fu_238_p2 == 1'd1)) begin
          ap_NS_fsm = ap_ST_fsm_state1;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state3;
        end
      end
      ap_ST_fsm_state3: begin
        if((icmp_ln35_fu_255_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state3)) begin
          ap_NS_fsm = ap_ST_fsm_state5;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state4;
        end
      end
      ap_ST_fsm_state4: begin
        ap_NS_fsm = ap_ST_fsm_state3;
      end
      ap_ST_fsm_state5: begin
        if((icmp_ln66_fu_304_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state5)) begin
          ap_NS_fsm = ap_ST_fsm_state7;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state6;
        end
      end
      ap_ST_fsm_state6: begin
        ap_NS_fsm = ap_ST_fsm_state5;
      end
      ap_ST_fsm_state7: begin
        if((1'b1 == ap_CS_fsm_state7) & (grp_shiftingcidi_fu_195_ap_done == 1'b1)) begin
          ap_NS_fsm = ap_ST_fsm_state2;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state7;
        end
      end
      default: begin
        ap_NS_fsm = 'bx;
      end
    endcase
  end

  assign IP_address0 = zext_ln35_fu_250_p1;
  assign PC1_address0 = zext_ln66_fu_299_p1;
  assign R1_fu_341_p1 = ~init_perm_res_reg_149[31:0];
  assign add_ln35_fu_261_p2 = i_1_reg_138 + 7'd1;
  assign add_ln66_fu_310_p2 = i_3_reg_161 + 6'd1;
  assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];
  assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];
  assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];
  assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];
  assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];
  assign ap_CS_fsm_state6 = ap_CS_fsm[32'd5];
  assign ap_CS_fsm_state7 = ap_CS_fsm[32'd6];
  assign grp_shiftingcidi_fu_195_ap_start = grp_shiftingcidi_fu_195_ap_start_reg;
  assign i_4_fu_244_p2 = i_fu_102 + 5'd1;
  assign icmp_ln331_fu_238_p2 = (i_fu_102 == 5'd16)? 1'b1 : 1'b0;
  assign icmp_ln35_fu_255_p2 = (i_1_reg_138 == 7'd64)? 1'b1 : 1'b0;
  assign icmp_ln66_fu_304_p2 = (i_3_reg_161 == 6'd56)? 1'b1 : 1'b0;
  assign init_perm_res_1_fu_291_p3 = { { trunc_ln40_1_fu_287_p1 }, { trunc_ln40_fu_283_p1 } };
  assign lshr_ln40_fu_277_p2 = result_fu_98 >> zext_ln40_fu_273_p1;
  assign lshr_ln71_fu_365_p2 = result_fu_98 >> zext_ln71_fu_361_p1;
  assign permuted_choice_1_1_fu_375_p3 = { { trunc_ln71_1_reg_440 }, { trunc_ln71_fu_371_p1 } };
  assign sext_ln323_fu_221_p1 = $signed(inputdata);
  assign sub_ln40_fu_267_p2 = 6'd0 - IP_q0;
  assign sub_ln71_fu_355_p2 = 6'd0 - PC1_q0;
  assign trunc_ln40_1_fu_287_p1 = ~init_perm_res_reg_149[62:0];
  assign trunc_ln40_fu_283_p1 = lshr_ln40_fu_277_p2[0:0];
  assign trunc_ln71_1_fu_316_p1 = ~permuted_choice_1_reg_172[53:0];
  assign trunc_ln71_fu_371_p1 = lshr_ln71_fu_365_p2[0:0];
  assign trunc_ln75_fu_346_p1 = ~permuted_choice_1_reg_172[27:0];
  assign zext_ln35_fu_250_p1 = i_1_reg_138;
  assign zext_ln40_fu_273_p1 = sub_ln40_fu_267_p2;
  assign zext_ln66_fu_299_p1 = i_3_reg_161;
  assign zext_ln71_fu_361_p1 = sub_ln71_fu_355_p2;

endmodule


