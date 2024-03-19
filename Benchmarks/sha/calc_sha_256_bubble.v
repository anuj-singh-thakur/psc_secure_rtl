`timescale 1 ns / 1 ps

(* CORE_GENERATION_INFO = "calc_sha_256_calc_sha_256,hls_ip_2022_1,{HLS_INPUT_TYPE=c,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xczu7ev-ffvf1517-3-e,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=2.804750,HLS_SYN_LAT=-1,HLS_SYN_TPT=none,HLS_SYN_MEM=1,HLS_SYN_DSP=0,HLS_SYN_FF=1260,HLS_SYN_LUT=2485,HLS_VERSION=2022_1}" *)


module calc_sha_256
(
  ap_clk,
  ap_rst,
  ap_start,
  ap_done,
  ap_idle,
  ap_ready,
  hash_address0,
  hash_ce0,
  hash_we0,
  hash_d0,
  hash_address1,
  hash_ce1,
  hash_we1,
  hash_d1,
  input_r,
  len
);

  parameter ap_ST_fsm_state1 = 29'd1;
  parameter ap_ST_fsm_state2 = 29'd2;
  parameter ap_ST_fsm_state3 = 29'd4;
  parameter ap_ST_fsm_state4 = 29'd8;
  parameter ap_ST_fsm_state5 = 29'd16;
  parameter ap_ST_fsm_state6 = 29'd32;
  parameter ap_ST_fsm_state7 = 29'd64;
  parameter ap_ST_fsm_state8 = 29'd128;
  parameter ap_ST_fsm_state9 = 29'd256;
  parameter ap_ST_fsm_state10 = 29'd512;
  parameter ap_ST_fsm_state11 = 29'd1024;
  parameter ap_ST_fsm_state12 = 29'd2048;
  parameter ap_ST_fsm_state13 = 29'd4096;
  parameter ap_ST_fsm_state14 = 29'd8192;
  parameter ap_ST_fsm_state15 = 29'd16384;
  parameter ap_ST_fsm_state16 = 29'd32768;
  parameter ap_ST_fsm_state17 = 29'd65536;
  parameter ap_ST_fsm_state18 = 29'd131072;
  parameter ap_ST_fsm_state19 = 29'd262144;
  parameter ap_ST_fsm_state20 = 29'd524288;
  parameter ap_ST_fsm_state21 = 29'd1048576;
  parameter ap_ST_fsm_state22 = 29'd2097152;
  parameter ap_ST_fsm_state23 = 29'd4194304;
  parameter ap_ST_fsm_state24 = 29'd8388608;
  parameter ap_ST_fsm_state25 = 29'd16777216;
  parameter ap_ST_fsm_state26 = 29'd33554432;
  parameter ap_ST_fsm_state27 = 29'd67108864;
  parameter ap_ST_fsm_state28 = 29'd134217728;
  parameter ap_ST_fsm_state29 = 29'd268435456;
  input ap_clk;
  input ap_rst;
  input ap_start;
  output ap_done;
  output ap_idle;
  output ap_ready;
  output [4:0] hash_address0;
  output hash_ce0;
  output hash_we0;
  output [7:0] hash_d0;
  output [4:0] hash_address1;
  output hash_ce1;
  output hash_we1;
  output [7:0] hash_d1;
  input [7:0] input_r;
  input [63:0] len;
  reg ap_done;
  reg ap_idle;
  reg ap_ready;
  reg [4:0] hash_address0;
  reg hash_ce0;
  reg hash_we0;
  reg [7:0] hash_d0;
  reg [4:0] hash_address1;
  reg hash_ce1;
  reg hash_we1;
  reg [7:0] hash_d1;
  (* fsm_encoding = "none" *)
  reg [28:0] ap_CS_fsm;
  wire ap_CS_fsm_state1;
  wire [2:0] calc_sha_256_h_address0;
  reg calc_sha_256_h_ce0;
  wire [31:0] calc_sha_256_h_q0;
  wire [5:0] k_address0;
  reg k_ce0;
  wire [31:0] k_q0;
  wire [31:0] ah_q1;
  reg [31:0] reg_798;
  wire ap_CS_fsm_state19;
  wire [31:0] ah_q0;
  wire ap_CS_fsm_state22;
  reg [31:0] reg_805;
  wire ap_CS_fsm_state20;
  wire [63:0] loop_index_cast_fu_819_p1;
  reg [63:0] loop_index_cast_reg_1885;
  wire ap_CS_fsm_state2;
  wire [0:0] exitcond648_fu_824_p2;
  wire [7:0] conv_i_fu_844_p3;
  reg [7:0] conv_i_reg_1958;
  reg [58:0] len_1_cast_reg_1963;
  reg [63:0] state_len_2_reg_1973;
  wire ap_CS_fsm_state4;
  wire [5:0] trunc_ln166_fu_873_p1;
  reg [5:0] trunc_ln166_reg_1979;
  wire [6:0] trunc_ln166_1_fu_877_p1;
  reg [6:0] trunc_ln166_1_reg_1985;
  wire [0:0] icmp_ln79_fu_891_p2;
  reg [0:0] icmp_ln79_reg_1990;
  wire [0:0] ap_phi_mux_state_total_len_delivered_phi_fu_607_p4;
  wire [0:0] icmp_ln87_fu_897_p2;
  reg [0:0] icmp_ln87_reg_1994;
  wire [6:0] empty_24_fu_924_p2;
  wire ap_CS_fsm_state5;
  wire [5:0] empty_25_fu_945_p2;
  wire ap_CS_fsm_state6;
  wire [6:0] space_in_chunk_fu_963_p2;
  reg [6:0] space_in_chunk_reg_2028;
  wire [0:0] exitcond44_fu_955_p2;
  wire [0:0] icmp_ln95_fu_968_p2;
  reg [0:0] icmp_ln95_reg_2034;
  wire [5:0] trunc_ln166_2_fu_991_p1;
  reg [5:0] trunc_ln166_2_reg_2038;
  wire ap_CS_fsm_state7;
  wire [0:0] icmp_ln108_fu_1005_p2;
  reg [0:0] icmp_ln108_reg_2043;
  wire [63:0] zext_ln109_fu_1017_p1;
  reg [63:0] zext_ln109_reg_2047;
  wire [5:0] add_ln109_1_fu_1021_p2;
  reg [5:0] add_ln109_1_reg_2052;
  wire [0:0] icmp_ln112_fu_1027_p2;
  reg [0:0] icmp_ln112_reg_2057;
  wire [0:0] icmp_ln126_fu_1033_p2;
  reg [0:0] icmp_ln126_reg_2061;
  wire [63:0] empty_29_fu_1054_p2;
  wire ap_CS_fsm_state8;
  wire [58:0] zext_ln122_fu_1124_p1;
  wire ap_CS_fsm_state10;
  wire [0:0] tmp_2_fu_1085_p3;
  wire [3:0] add_ln119_fu_1128_p2;
  wire [2:0] empty_33_fu_1154_p2;
  wire ap_CS_fsm_state11;
  wire [63:0] zext_ln181_fu_1175_p1;
  reg [63:0] zext_ln181_reg_2094;
  wire ap_CS_fsm_state12;
  wire [3:0] add_ln181_fu_1186_p2;
  reg [3:0] add_ln181_reg_2102;
  wire [0:0] icmp_ln181_fu_1180_p2;
  wire [2:0] i_7_fu_1198_p2;
  reg [2:0] i_7_reg_2115;
  wire ap_CS_fsm_state14;
  wire [0:0] cmp10_fu_1204_p2;
  reg [0:0] cmp10_reg_2120;
  wire [0:0] icmp_ln189_fu_1192_p2;
  wire [4:0] add_ln210_fu_1221_p2;
  reg [4:0] add_ln210_reg_2127;
  wire ap_CS_fsm_state15;
  reg [3:0] w_addr_reg_2132;
  wire [0:0] icmp_ln210_fu_1215_p2;
  wire [3:0] trunc_ln218_fu_1227_p1;
  reg [3:0] trunc_ln218_reg_2138;
  wire [5:0] trunc_ln210_fu_1253_p1;
  reg [5:0] trunc_ln210_reg_2158;
  wire ap_CS_fsm_state16;
  wire [31:0] add_ln220_2_fu_1418_p2;
  reg [31:0] add_ln220_2_reg_2174;
  wire [63:0] p_3_fu_1447_p2;
  wire ap_CS_fsm_state17;
  wire [3:0] trunc_ln224_fu_1453_p1;
  reg [3:0] trunc_ln224_reg_2184;
  wire [1:0] trunc_ln224_1_fu_1457_p1;
  reg [1:0] trunc_ln224_1_reg_2189;
  wire [7:0] chunk_q1;
  reg [7:0] chunk_load_reg_2194;
  wire ap_CS_fsm_state18;
  wire [7:0] chunk_q0;
  reg [7:0] chunk_load_1_reg_2199;
  wire [31:0] s1_1_fu_1553_p2;
  reg [31:0] s1_1_reg_2214;
  wire [31:0] temp1_fu_1611_p2;
  reg [31:0] temp1_reg_2224;
  reg [31:0] ah_load_5_reg_2230;
  wire ap_CS_fsm_state21;
  wire [31:0] s0_1_fu_1689_p2;
  reg [31:0] s0_1_reg_2236;
  reg [31:0] ah_load_6_reg_2241;
  wire [31:0] add_ln233_fu_1716_p2;
  reg [31:0] add_ln233_reg_2247;
  wire [31:0] add_ln237_fu_1726_p2;
  reg [31:0] add_ln237_reg_2252;
  wire [3:0] add_ln243_fu_1743_p2;
  reg [3:0] add_ln243_reg_2260;
  wire ap_CS_fsm_state25;
  wire [0:0] icmp_ln243_fu_1737_p2;
  reg [2:0] h_addr_3_reg_2270;
  wire ap_CS_fsm_state27;
  wire [0:0] icmp_ln252_fu_1764_p2;
  wire [4:0] trunc_ln252_fu_1795_p1;
  reg [4:0] trunc_ln252_reg_2283;
  wire ap_CS_fsm_state28;
  reg [7:0] trunc_ln4_reg_2289;
  wire [7:0] trunc_ln258_fu_1836_p1;
  reg [7:0] trunc_ln258_reg_2294;
  reg [5:0] chunk_address0;
  reg chunk_ce0;
  reg chunk_we0;
  reg [7:0] chunk_d0;
  reg [5:0] chunk_address1;
  reg chunk_ce1;
  reg [2:0] h_address0;
  reg h_ce0;
  reg h_we0;
  reg [31:0] h_d0;
  wire [31:0] h_q0;
  reg [2:0] ah_address0;
  reg ah_ce0;
  reg ah_we0;
  reg [31:0] ah_d0;
  reg [2:0] ah_address1;
  reg ah_ce1;
  reg ah_we1;
  reg [31:0] ah_d1;
  reg [3:0] w_address0;
  reg w_ce0;
  reg w_we0;
  reg [31:0] w_d0;
  wire [31:0] w_q0;
  reg [3:0] w_address1;
  reg w_ce1;
  wire [31:0] w_q1;
  reg [0:0] state_total_len_delivered_reg_603;
  reg [0:0] state_total_len_delivered_2_ph_reg_687;
  reg [6:0] loop_index4_i_reg_614;
  wire [0:0] exitcond493_fu_918_p2;
  reg [5:0] loop_index_i_reg_625;
  wire [6:0] space_in_chunk_1_fu_974_p2;
  reg [6:0] ap_phi_mux_space_in_chunk_2_phi_fu_639_p4;
  reg [6:0] space_in_chunk_2_reg_636;
  wire [5:0] add_ln99_fu_980_p2;
  reg [5:0] chunk_addr_0_i_idx_reg_646;
  reg [63:0] empty_27_reg_656;
  wire [0:0] exitcond46_fu_1060_p2;
  reg signed [3:0] i_1_reg_667;
  wire ap_CS_fsm_state9;
  reg [58:0] len_1_reg_678;
  wire [0:0] exitcond45_fu_1164_p2;
  reg [2:0] empty_32_reg_704;
  reg [3:0] i_2_reg_715;
  wire ap_CS_fsm_state13;
  reg [63:0] p_reg_726;
  reg [2:0] i_3_reg_738;
  reg [4:0] j_1_reg_750;
  wire ap_CS_fsm_state24;
  reg [63:0] p_2_reg_762;
  reg [63:0] p_1_reg_775;
  reg [3:0] i_4_reg_787;
  wire ap_CS_fsm_state26;
  wire ap_CS_fsm_state3;
  wire [63:0] loop_index4_i_cast_fu_913_p1;
  wire [63:0] loop_index_i_cast_fu_940_p1;
  wire [63:0] chunk_addr_0_i67_sum74_cast_fu_1049_p1;
  wire [63:0] zext_ln117_fu_1076_p1;
  wire [63:0] zext_ln121_fu_1109_p1;
  wire [63:0] chunk_addr_0_i67_sum_cast_fu_1149_p1;
  wire [63:0] zext_ln210_fu_1210_p1;
  wire [63:0] zext_ln218_fu_1237_p1;
  wire [63:0] zext_ln219_fu_1248_p1;
  wire [63:0] zext_ln213_fu_1263_p1;
  wire [63:0] zext_ln220_fu_1413_p1;
  wire [63:0] zext_ln214_fu_1466_p1;
  wire [63:0] zext_ln214_1_fu_1476_p1;
  wire [63:0] zext_ln224_fu_1565_p1;
  wire [63:0] zext_ln243_fu_1731_p1;
  wire [63:0] zext_ln252_fu_1759_p1;
  wire [63:0] zext_ln252_1_fu_1810_p1;
  wire [63:0] zext_ln255_fu_1805_p1;
  wire [63:0] zext_ln256_fu_1856_p1;
  wire ap_CS_fsm_state29;
  wire [63:0] zext_ln257_fu_1866_p1;
  reg [3:0] loop_index_fu_248;
  wire [3:0] empty_21_fu_830_p2;
  reg [63:0] state_len_fu_268;
  wire [63:0] state_len_3_fu_930_p2;
  reg [31:0] state_single_one_delivered_fu_272;
  reg [5:0] j_fu_276;
  wire [5:0] add_ln258_fu_1840_p2;
  reg [3:0] i_fu_280;
  wire [3:0] add_ln252_fu_1770_p2;
  wire [31:0] add_ln246_fu_1749_p2;
  wire [7:0] trunc_ln121_fu_1093_p1;
  wire ap_CS_fsm_state23;
  wire [31:0] add_ln220_3_fu_1430_p2;
  wire [31:0] or_ln_fu_1436_p5;
  wire [4:0] empty_22_fu_841_p1;
  wire [57:0] tmp_fu_881_p4;
  wire [63:0] p_cast22_fu_951_p1;
  wire [3:0] tmp_1_fu_995_p4;
  wire [6:0] left_fu_1011_p2;
  wire [5:0] empty_28_fu_1039_p1;
  wire [5:0] chunk_addr_0_i67_sum74_fu_1043_p2;
  wire [5:0] add_ln117_fu_1065_p2;
  wire [5:0] add_ln117_1_fu_1071_p2;
  wire signed [5:0] sext_ln119_fu_1081_p1;
  wire [5:0] add_ln121_fu_1098_p2;
  wire [5:0] add_ln121_1_fu_1104_p2;
  wire [50:0] len_2_fu_1114_p4;
  wire [5:0] p_cast19_fu_1139_p1;
  wire [5:0] chunk_addr_0_i67_sum_fu_1143_p2;
  wire [6:0] p_cast20_fu_1160_p1;
  wire [3:0] add_ln218_fu_1231_p2;
  wire [3:0] add_ln219_fu_1242_p2;
  wire [5:0] add_ln213_fu_1257_p2;
  wire [6:0] trunc_ln54_fu_1278_p1;
  wire [24:0] lshr_ln_fu_1268_p4;
  wire [17:0] trunc_ln54_1_fu_1300_p1;
  wire [13:0] lshr_ln54_1_fu_1290_p4;
  wire [28:0] lshr_ln1_fu_1312_p4;
  wire [31:0] zext_ln218_1_fu_1322_p1;
  wire [31:0] or_ln54_1_fu_1304_p3;
  wire [31:0] xor_ln218_fu_1326_p2;
  wire [31:0] or_ln2_fu_1282_p3;
  wire [16:0] trunc_ln54_2_fu_1348_p1;
  wire [14:0] lshr_ln54_2_fu_1338_p4;
  wire [18:0] trunc_ln54_3_fu_1370_p1;
  wire [12:0] lshr_ln54_3_fu_1360_p4;
  wire [21:0] lshr_ln2_fu_1382_p4;
  wire [31:0] zext_ln219_1_fu_1392_p1;
  wire [31:0] or_ln54_3_fu_1374_p3;
  wire [31:0] xor_ln219_fu_1396_p2;
  wire [31:0] or_ln54_2_fu_1352_p3;
  wire [3:0] add_ln220_fu_1408_p2;
  wire [31:0] s0_fu_1332_p2;
  wire [31:0] s1_fu_1402_p2;
  wire [31:0] add_ln220_1_fu_1424_p2;
  wire [5:0] add_ln214_fu_1461_p2;
  wire [5:0] add_ln214_1_fu_1471_p2;
  wire [5:0] trunc_ln54_4_fu_1491_p1;
  wire [25:0] lshr_ln54_4_fu_1481_p4;
  wire [10:0] trunc_ln54_5_fu_1513_p1;
  wire [20:0] lshr_ln54_5_fu_1503_p4;
  wire [24:0] trunc_ln54_6_fu_1535_p1;
  wire [6:0] lshr_ln54_6_fu_1525_p4;
  wire [31:0] or_ln54_4_fu_1495_p3;
  wire [31:0] or_ln54_5_fu_1517_p3;
  wire [31:0] xor_ln222_fu_1547_p2;
  wire [31:0] or_ln54_6_fu_1539_p3;
  wire [5:0] or_ln1_fu_1559_p3;
  wire [31:0] xor_ln223_fu_1576_p2;
  wire [31:0] and_ln223_1_fu_1582_p2;
  wire [31:0] and_ln223_fu_1570_p2;
  wire [31:0] ch_fu_1588_p2;
  wire [31:0] add_ln224_1_fu_1600_p2;
  wire [31:0] add_ln224_2_fu_1605_p2;
  wire [31:0] add_ln224_fu_1594_p2;
  wire [1:0] trunc_ln54_7_fu_1627_p1;
  wire [29:0] lshr_ln54_7_fu_1617_p4;
  wire [12:0] trunc_ln54_8_fu_1649_p1;
  wire [18:0] lshr_ln54_8_fu_1639_p4;
  wire [21:0] trunc_ln54_9_fu_1671_p1;
  wire [9:0] lshr_ln54_9_fu_1661_p4;
  wire [31:0] or_ln54_7_fu_1631_p3;
  wire [31:0] or_ln54_8_fu_1653_p3;
  wire [31:0] xor_ln225_fu_1683_p2;
  wire [31:0] or_ln54_9_fu_1675_p3;
  wire [31:0] xor_ln226_fu_1695_p2;
  wire [31:0] and_ln226_fu_1700_p2;
  wire [31:0] and_ln226_1_fu_1705_p2;
  wire [31:0] maj_fu_1710_p2;
  wire [31:0] add_ln237_1_fu_1721_p2;
  wire [4:0] or_ln255_fu_1799_p2;
  wire [4:0] or_ln256_fu_1851_p2;
  wire [4:0] or_ln257_fu_1861_p2;
  reg [28:0] ap_NS_fsm;
  reg ap_ST_fsm_state1_blk;
  wire ap_ST_fsm_state2_blk;
  wire ap_ST_fsm_state3_blk;
  wire ap_ST_fsm_state4_blk;
  wire ap_ST_fsm_state5_blk;
  wire ap_ST_fsm_state6_blk;
  wire ap_ST_fsm_state7_blk;
  wire ap_ST_fsm_state8_blk;
  wire ap_ST_fsm_state9_blk;
  wire ap_ST_fsm_state10_blk;
  wire ap_ST_fsm_state11_blk;
  wire ap_ST_fsm_state12_blk;
  wire ap_ST_fsm_state13_blk;
  wire ap_ST_fsm_state14_blk;
  wire ap_ST_fsm_state15_blk;
  wire ap_ST_fsm_state16_blk;
  wire ap_ST_fsm_state17_blk;
  wire ap_ST_fsm_state18_blk;
  wire ap_ST_fsm_state19_blk;
  wire ap_ST_fsm_state20_blk;
  wire ap_ST_fsm_state21_blk;
  wire ap_ST_fsm_state22_blk;
  wire ap_ST_fsm_state23_blk;
  wire ap_ST_fsm_state24_blk;
  wire ap_ST_fsm_state25_blk;
  wire ap_ST_fsm_state26_blk;
  wire ap_ST_fsm_state27_blk;
  wire ap_ST_fsm_state28_blk;
  wire ap_ST_fsm_state29_blk;
  wire ap_ce_reg;

  initial begin
    #0 ap_CS_fsm = 29'd1;
  end


  calc_sha_256_calc_sha_256_h_ROM_AUTO_1R
  #(
    .DataWidth(32),
    .AddressRange(8),
    .AddressWidth(3)
  )
  calc_sha_256_h_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(calc_sha_256_h_address0),
    .ce0(calc_sha_256_h_ce0),
    .q0(calc_sha_256_h_q0)
  );


  calc_sha_256_k_ROM_AUTO_1R
  #(
    .DataWidth(32),
    .AddressRange(64),
    .AddressWidth(6)
  )
  k_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(k_address0),
    .ce0(k_ce0),
    .q0(k_q0)
  );


  calc_sha_256_chunk_RAM_AUTO_1R1W
  #(
    .DataWidth(8),
    .AddressRange(64),
    .AddressWidth(6)
  )
  chunk_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(chunk_address0),
    .ce0(chunk_ce0),
    .we0(chunk_we0),
    .d0(~chunk_d0),
    .q0(chunk_q0),
    .address1(chunk_address1),
    .ce1(chunk_ce1),
    .q1(chunk_q1)
  );


  calc_sha_256_h_RAM_AUTO_1R1W
  #(
    .DataWidth(32),
    .AddressRange(8),
    .AddressWidth(3)
  )
  h_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(h_address0),
    .ce0(h_ce0),
    .we0(h_we0),
    .d0(h_d0),
    .q0(h_q0)
  );


  calc_sha_256_ah_RAM_AUTO_1R1W
  #(
    .DataWidth(32),
    .AddressRange(8),
    .AddressWidth(3)
  )
  ah_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(ah_address0),
    .ce0(ah_ce0),
    .we0(ah_we0),
    .d0(ah_d0),
    .q0(ah_q0),
    .address1(ah_address1),
    .ce1(ah_ce1),
    .we1(ah_we1),
    .d1(ah_d1),
    .q1(ah_q1)
  );


  calc_sha_256_w_RAM_AUTO_1R1W
  #(
    .DataWidth(32),
    .AddressRange(16),
    .AddressWidth(4)
  )
  w_U
  (
    .clk(ap_clk),
    .reset(ap_rst),
    .address0(w_address0),
    .ce0(w_ce0),
    .we0(w_we0),
    .d0(w_d0),
    .q0(w_q0),
    .address1(w_address1),
    .ce1(w_ce1),
    .q1(w_q1)
  );


  always @(posedge ap_clk) begin
    if(ap_rst == 1'b1) begin
      ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
      ap_CS_fsm <= ap_NS_fsm;
    end
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state6) & ((icmp_ln95_fu_968_p2 == 1'd0) & (icmp_ln87_reg_1994 == 1'd1) | (icmp_ln95_fu_968_p2 == 1'd0) & (exitcond44_fu_955_p2 == 1'd1))) begin
      chunk_addr_0_i_idx_reg_646 <= trunc_ln166_reg_1979;
    end else if((1'b1 == ap_CS_fsm_state7) & (icmp_ln95_reg_2034 == 1'd1)) begin
      chunk_addr_0_i_idx_reg_646 <= add_ln99_fu_980_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state7) & (icmp_ln112_fu_1027_p2 == 1'd0) & (icmp_ln108_fu_1005_p2 == 1'd0)) begin
      empty_27_reg_656 <= 64'd0;
    end else if((exitcond46_fu_1060_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state8) & (icmp_ln112_reg_2057 == 1'd0)) begin
      empty_27_reg_656 <= empty_29_fu_1054_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state7) & (icmp_ln126_fu_1033_p2 == 1'd0) & (icmp_ln108_fu_1005_p2 == 1'd1)) begin
      empty_32_reg_704 <= 3'd0;
    end else if((exitcond45_fu_1164_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state11) & (icmp_ln126_reg_2061 == 1'd0)) begin
      empty_32_reg_704 <= empty_33_fu_1154_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state9) begin
      i_1_reg_667 <= 4'd6;
    end else if((tmp_2_fu_1085_p3 == 1'd0) & (1'b1 == ap_CS_fsm_state10) & (icmp_ln108_reg_2043 == 1'd0) & (icmp_ln79_reg_1990 == 1'd1)) begin
      i_1_reg_667 <= add_ln119_fu_1128_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state10) & ((icmp_ln79_reg_1990 == 1'd0) | ((tmp_2_fu_1085_p3 == 1'd1) | (icmp_ln108_reg_2043 == 1'd1)))) begin
      i_2_reg_715 <= 4'd0;
    end else if(1'b1 == ap_CS_fsm_state13) begin
      i_2_reg_715 <= add_ln181_reg_2102;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln181_fu_1180_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state12)) begin
      i_3_reg_738 <= 3'd0;
    end else if((icmp_ln210_fu_1215_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state15)) begin
      i_3_reg_738 <= i_7_reg_2115;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln189_fu_1192_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state14)) begin
      i_4_reg_787 <= 4'd0;
    end else if(1'b1 == ap_CS_fsm_state26) begin
      i_4_reg_787 <= add_ln243_reg_2260;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state4) & (ap_phi_mux_state_total_len_delivered_phi_fu_607_p4 == 1'd1)) begin
      i_fu_280 <= 4'd0;
    end else if((icmp_ln252_fu_1764_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state27)) begin
      i_fu_280 <= add_ln252_fu_1770_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state24) begin
      j_1_reg_750 <= add_ln210_reg_2127;
    end else if((icmp_ln189_fu_1192_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state14)) begin
      j_1_reg_750 <= 5'd0;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state4) & (ap_phi_mux_state_total_len_delivered_phi_fu_607_p4 == 1'd1)) begin
      j_fu_276 <= 6'd0;
    end else if(1'b1 == ap_CS_fsm_state28) begin
      j_fu_276 <= add_ln258_fu_1840_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state9) begin
      len_1_reg_678 <= len_1_cast_reg_1963;
    end else if((tmp_2_fu_1085_p3 == 1'd0) & (1'b1 == ap_CS_fsm_state10) & (icmp_ln108_reg_2043 == 1'd0) & (icmp_ln79_reg_1990 == 1'd1)) begin
      len_1_reg_678 <= zext_ln122_fu_1124_p1;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state4) & (ap_phi_mux_state_total_len_delivered_phi_fu_607_p4 == 1'd0) & (icmp_ln79_fu_891_p2 == 1'd0)) begin
      loop_index4_i_reg_614 <= 7'd0;
    end else if((exitcond493_fu_918_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state5)) begin
      loop_index4_i_reg_614 <= empty_24_fu_924_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)) begin
      loop_index_fu_248 <= 4'd0;
    end else if((1'b1 == ap_CS_fsm_state2) & (exitcond648_fu_824_p2 == 1'd0)) begin
      loop_index_fu_248 <= empty_21_fu_830_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state4) & (icmp_ln87_fu_897_p2 == 1'd0) & (ap_phi_mux_state_total_len_delivered_phi_fu_607_p4 == 1'd0) & (icmp_ln79_fu_891_p2 == 1'd1)) begin
      loop_index_i_reg_625 <= 6'd0;
    end else if((1'b1 == ap_CS_fsm_state6) & (exitcond44_fu_955_p2 == 1'd0) & (icmp_ln87_reg_1994 == 1'd0)) begin
      loop_index_i_reg_625 <= empty_25_fu_945_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state17) begin
      if(cmp10_reg_2120 == 1'd0) begin
        p_1_reg_775 <= p_2_reg_762;
      end else if(cmp10_reg_2120 == 1'd1) begin
        p_1_reg_775 <= p_3_fu_1447_p2;
      end 
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state24) begin
      p_2_reg_762 <= p_1_reg_775;
    end else if((icmp_ln189_fu_1192_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state14)) begin
      p_2_reg_762 <= p_reg_726;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln181_fu_1180_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state12)) begin
      p_reg_726 <= 64'd0;
    end else if((icmp_ln210_fu_1215_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state15)) begin
      p_reg_726 <= p_2_reg_762;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state22) begin
      reg_798 <= ah_q0;
    end else if(1'b1 == ap_CS_fsm_state19) begin
      reg_798 <= ah_q1;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state20) begin
      reg_805 <= ah_q1;
    end else if(1'b1 == ap_CS_fsm_state19) begin
      reg_805 <= ah_q0;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state6) & ((icmp_ln95_fu_968_p2 == 1'd0) & (icmp_ln87_reg_1994 == 1'd1) | (icmp_ln95_fu_968_p2 == 1'd0) & (exitcond44_fu_955_p2 == 1'd1))) begin
      space_in_chunk_2_reg_636 <= space_in_chunk_fu_963_p2;
    end else if((1'b1 == ap_CS_fsm_state7) & (icmp_ln95_reg_2034 == 1'd1)) begin
      space_in_chunk_2_reg_636 <= space_in_chunk_1_fu_974_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state2) & (exitcond648_fu_824_p2 == 1'd1)) begin
      state_len_fu_268 <= ~len;
    end else if((exitcond493_fu_918_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state5)) begin
      state_len_fu_268 <= state_len_3_fu_930_p2;
    end else if((tmp_2_fu_1085_p3 == 1'd1) & (1'b1 == ap_CS_fsm_state10) & (icmp_ln108_reg_2043 == 1'd0) & (icmp_ln79_reg_1990 == 1'd1) | (1'b1 == ap_CS_fsm_state11) & ((exitcond45_fu_1164_p2 == 1'd1) | (icmp_ln126_reg_2061 == 1'd1))) begin
      state_len_fu_268 <= ~64'd0;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state2) & (exitcond648_fu_824_p2 == 1'd1)) begin
      state_single_one_delivered_fu_272[0] <= 1'b0;
    end else if((1'b1 == ap_CS_fsm_state7) & (icmp_ln95_reg_2034 == 1'd1)) begin
      state_single_one_delivered_fu_272[0] <= 1'b1;
    end 
  end


  always @(posedge ap_clk) begin
    if((tmp_2_fu_1085_p3 == 1'd1) & (1'b1 == ap_CS_fsm_state10) & (icmp_ln108_reg_2043 == 1'd0) & (icmp_ln79_reg_1990 == 1'd1)) begin
      state_total_len_delivered_2_ph_reg_687 <= 1'd1;
    end else if((exitcond493_fu_918_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state11) & ((exitcond45_fu_1164_p2 == 1'd1) | (icmp_ln126_reg_2061 == 1'd1))) begin
      state_total_len_delivered_2_ph_reg_687 <= 1'd0;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln243_fu_1737_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state25)) begin
      state_total_len_delivered_reg_603 <= state_total_len_delivered_2_ph_reg_687;
    end else if((1'b1 == ap_CS_fsm_state2) & (exitcond648_fu_824_p2 == 1'd1)) begin
      state_total_len_delivered_reg_603 <= 1'd0;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state7) & (icmp_ln108_fu_1005_p2 == 1'd0)) begin
      add_ln109_1_reg_2052 <= add_ln109_1_fu_1021_p2;
      icmp_ln112_reg_2057 <= icmp_ln112_fu_1027_p2;
      zext_ln109_reg_2047[6:0] <= zext_ln109_fu_1017_p1[6:0];
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state12) begin
      add_ln181_reg_2102 <= add_ln181_fu_1186_p2;
      zext_ln181_reg_2094[3:0] <= zext_ln181_fu_1175_p1[3:0];
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state15) begin
      add_ln210_reg_2127 <= add_ln210_fu_1221_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state16) begin
      add_ln220_2_reg_2174 <= add_ln220_2_fu_1418_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state22) begin
      add_ln233_reg_2247 <= add_ln233_fu_1716_p2;
      add_ln237_reg_2252 <= add_ln237_fu_1726_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state25) begin
      add_ln243_reg_2260 <= add_ln243_fu_1743_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state21) begin
      ah_load_5_reg_2230 <= ah_q1;
      ah_load_6_reg_2241 <= ah_q0;
      s0_1_reg_2236 <= s0_1_fu_1689_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state18) begin
      chunk_load_1_reg_2199 <= chunk_q0;
      chunk_load_reg_2194 <= chunk_q1;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln189_fu_1192_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state14)) begin
      cmp10_reg_2120 <= cmp10_fu_1204_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state2) & (exitcond648_fu_824_p2 == 1'd1)) begin
      conv_i_reg_1958[7:3] <= conv_i_fu_844_p3[7:3];
      len_1_cast_reg_1963 <= { { ~(~(~len[63:5])) } };
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln243_fu_1737_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state25)) begin
      h_addr_3_reg_2270 <= zext_ln243_fu_1731_p1;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state14) begin
      i_7_reg_2115 <= i_7_fu_1198_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state7) begin
      icmp_ln108_reg_2043 <= icmp_ln108_fu_1005_p2;
      trunc_ln166_2_reg_2038 <= trunc_ln166_2_fu_991_p1;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state7) & (icmp_ln108_fu_1005_p2 == 1'd1)) begin
      icmp_ln126_reg_2061 <= icmp_ln126_fu_1033_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state4) & (ap_phi_mux_state_total_len_delivered_phi_fu_607_p4 == 1'd0)) begin
      icmp_ln79_reg_1990 <= icmp_ln79_fu_891_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state4) & (ap_phi_mux_state_total_len_delivered_phi_fu_607_p4 == 1'd0) & (icmp_ln79_fu_891_p2 == 1'd1)) begin
      icmp_ln87_reg_1994 <= icmp_ln87_fu_897_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((1'b1 == ap_CS_fsm_state6) & ((exitcond44_fu_955_p2 == 1'd1) | (icmp_ln87_reg_1994 == 1'd1))) begin
      icmp_ln95_reg_2034 <= icmp_ln95_fu_968_p2;
      space_in_chunk_reg_2028 <= space_in_chunk_fu_963_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state2) begin
      loop_index_cast_reg_1885[3:0] <= loop_index_cast_fu_819_p1[3:0];
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state19) begin
      s1_1_reg_2214 <= s1_1_fu_1553_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state4) begin
      state_len_2_reg_1973 <= state_len_fu_268;
      trunc_ln166_1_reg_1985 <= trunc_ln166_1_fu_877_p1;
      trunc_ln166_reg_1979 <= trunc_ln166_fu_873_p1;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state20) begin
      temp1_reg_2224 <= temp1_fu_1611_p2;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln210_fu_1215_p2 == 1'd0) & (cmp10_reg_2120 == 1'd1) & (1'b1 == ap_CS_fsm_state15)) begin
      trunc_ln210_reg_2158 <= trunc_ln210_fu_1253_p1;
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln210_fu_1215_p2 == 1'd0) & (cmp10_reg_2120 == 1'd0) & (1'b1 == ap_CS_fsm_state15)) begin
      trunc_ln218_reg_2138 <= trunc_ln218_fu_1227_p1;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state17) begin
      trunc_ln224_1_reg_2189 <= trunc_ln224_1_fu_1457_p1;
      trunc_ln224_reg_2184 <= trunc_ln224_fu_1453_p1;
    end 
  end


  always @(posedge ap_clk) begin
    if(1'b1 == ap_CS_fsm_state28) begin
      trunc_ln252_reg_2283 <= trunc_ln252_fu_1795_p1;
      trunc_ln258_reg_2294 <= trunc_ln258_fu_1836_p1;
      trunc_ln4_reg_2289 <= { { h_q0[15:8] } };
    end 
  end


  always @(posedge ap_clk) begin
    if((icmp_ln210_fu_1215_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state15)) begin
      w_addr_reg_2132 <= zext_ln210_fu_1210_p1;
    end 
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state24) begin
      ah_address0 = 64'd4;
    end else if(1'b1 == ap_CS_fsm_state23) begin
      ah_address0 = 64'd3;
    end else if(1'b1 == ap_CS_fsm_state21) begin
      ah_address0 = 64'd2;
    end else if(1'b1 == ap_CS_fsm_state20) begin
      ah_address0 = 64'd1;
    end else if((1'b1 == ap_CS_fsm_state22) | (1'b1 == ap_CS_fsm_state19)) begin
      ah_address0 = 64'd7;
    end else if(1'b1 == ap_CS_fsm_state17) begin
      ah_address0 = 64'd5;
    end else if(1'b1 == ap_CS_fsm_state13) begin
      ah_address0 = zext_ln181_reg_2094;
    end else begin
      ah_address0 = 'bx;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state25) begin
      ah_address1 = zext_ln243_fu_1731_p1;
    end else if(1'b1 == ap_CS_fsm_state23) begin
      ah_address1 = 64'd1;
    end else if(1'b1 == ap_CS_fsm_state22) begin
      ah_address1 = 64'd5;
    end else if(1'b1 == ap_CS_fsm_state21) begin
      ah_address1 = 64'd3;
    end else if((1'b1 == ap_CS_fsm_state20) | (1'b1 == ap_CS_fsm_state24)) begin
      ah_address1 = 64'd0;
    end else if(1'b1 == ap_CS_fsm_state19) begin
      ah_address1 = 64'd6;
    end else if(1'b1 == ap_CS_fsm_state17) begin
      ah_address1 = 64'd4;
    end else begin
      ah_address1 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state20) | (1'b1 == ap_CS_fsm_state22) | (1'b1 == ap_CS_fsm_state19) | (1'b1 == ap_CS_fsm_state23) | (1'b1 == ap_CS_fsm_state24) | (1'b1 == ap_CS_fsm_state13) | (1'b1 == ap_CS_fsm_state21) | (1'b1 == ap_CS_fsm_state17)) begin
      ah_ce0 = 1'b1;
    end else begin
      ah_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state20) | (1'b1 == ap_CS_fsm_state22) | (1'b1 == ap_CS_fsm_state19) | (1'b1 == ap_CS_fsm_state23) | (1'b1 == ap_CS_fsm_state24) | (1'b1 == ap_CS_fsm_state25) | (1'b1 == ap_CS_fsm_state21) | (1'b1 == ap_CS_fsm_state17)) begin
      ah_ce1 = 1'b1;
    end else begin
      ah_ce1 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state24) begin
      ah_d0 = add_ln233_reg_2247;
    end else if(1'b1 == ap_CS_fsm_state23) begin
      ah_d0 = reg_798;
    end else if(1'b1 == ap_CS_fsm_state22) begin
      ah_d0 = reg_805;
    end else if(1'b1 == ap_CS_fsm_state21) begin
      ah_d0 = ah_q0;
    end else if(1'b1 == ap_CS_fsm_state13) begin
      ah_d0 = h_q0;
    end else begin
      ah_d0 = 'bx;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state24) begin
      ah_d1 = add_ln237_reg_2252;
    end else if(1'b1 == ap_CS_fsm_state23) begin
      ah_d1 = ah_load_5_reg_2230;
    end else if(1'b1 == ap_CS_fsm_state22) begin
      ah_d1 = reg_798;
    end else if(1'b1 == ap_CS_fsm_state19) begin
      ah_d1 = ah_q0;
    end else begin
      ah_d1 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state22) | (1'b1 == ap_CS_fsm_state23) | (1'b1 == ap_CS_fsm_state24) | (1'b1 == ap_CS_fsm_state13) | (1'b1 == ap_CS_fsm_state21)) begin
      ah_we0 = 1'b1;
    end else begin
      ah_we0 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state22) | (1'b1 == ap_CS_fsm_state19) | (1'b1 == ap_CS_fsm_state23) | (1'b1 == ap_CS_fsm_state24)) begin
      ah_we1 = 1'b1;
    end else begin
      ah_we1 = 1'b0;
    end
  end

  assign ap_ST_fsm_state10_blk = 1'b0;
  assign ap_ST_fsm_state11_blk = 1'b0;
  assign ap_ST_fsm_state12_blk = 1'b0;
  assign ap_ST_fsm_state13_blk = 1'b0;
  assign ap_ST_fsm_state14_blk = 1'b0;
  assign ap_ST_fsm_state15_blk = 1'b0;
  assign ap_ST_fsm_state16_blk = 1'b0;
  assign ap_ST_fsm_state17_blk = 1'b0;
  assign ap_ST_fsm_state18_blk = 1'b0;
  assign ap_ST_fsm_state19_blk = 1'b0;

  always @(*) begin
    if(ap_start == 1'b0) begin
      ap_ST_fsm_state1_blk = 1'b1;
    end else begin
      ap_ST_fsm_state1_blk = 1'b0;
    end
  end

  assign ap_ST_fsm_state20_blk = 1'b0;
  assign ap_ST_fsm_state21_blk = 1'b0;
  assign ap_ST_fsm_state22_blk = 1'b0;
  assign ap_ST_fsm_state23_blk = 1'b0;
  assign ap_ST_fsm_state24_blk = 1'b0;
  assign ap_ST_fsm_state25_blk = 1'b0;
  assign ap_ST_fsm_state26_blk = 1'b0;
  assign ap_ST_fsm_state27_blk = 1'b0;
  assign ap_ST_fsm_state28_blk = 1'b0;
  assign ap_ST_fsm_state29_blk = 1'b0;
  assign ap_ST_fsm_state2_blk = 1'b0;
  assign ap_ST_fsm_state3_blk = 1'b0;
  assign ap_ST_fsm_state4_blk = 1'b0;
  assign ap_ST_fsm_state5_blk = 1'b0;
  assign ap_ST_fsm_state6_blk = 1'b0;
  assign ap_ST_fsm_state7_blk = 1'b0;
  assign ap_ST_fsm_state8_blk = 1'b0;
  assign ap_ST_fsm_state9_blk = 1'b0;

  always @(*) begin
    if((icmp_ln252_fu_1764_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state27)) begin
      ap_done = 1'b1;
    end else begin
      ap_done = 1'b0;
    end
  end


  always @(*) begin
    if((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1)) begin
      ap_idle = 1'b1;
    end else begin
      ap_idle = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state7) & (icmp_ln95_reg_2034 == 1'd1)) begin
      ap_phi_mux_space_in_chunk_2_phi_fu_639_p4 = space_in_chunk_1_fu_974_p2;
    end else begin
      ap_phi_mux_space_in_chunk_2_phi_fu_639_p4 = space_in_chunk_2_reg_636;
    end
  end


  always @(*) begin
    if((icmp_ln252_fu_1764_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state27)) begin
      ap_ready = 1'b1;
    end else begin
      ap_ready = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state2) begin
      calc_sha_256_h_ce0 = 1'b1;
    end else begin
      calc_sha_256_h_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state18) begin
      chunk_address0 = zext_ln214_fu_1466_p1;
    end else if(1'b1 == ap_CS_fsm_state15) begin
      chunk_address0 = zext_ln213_fu_1263_p1;
    end else if(1'b1 == ap_CS_fsm_state11) begin
      chunk_address0 = chunk_addr_0_i67_sum_cast_fu_1149_p1;
    end else if(1'b1 == ap_CS_fsm_state10) begin
      chunk_address0 = zext_ln121_fu_1109_p1;
    end else if(1'b1 == ap_CS_fsm_state9) begin
      chunk_address0 = zext_ln117_fu_1076_p1;
    end else if(1'b1 == ap_CS_fsm_state8) begin
      chunk_address0 = chunk_addr_0_i67_sum74_cast_fu_1049_p1;
    end else if(1'b1 == ap_CS_fsm_state7) begin
      chunk_address0 = ~state_len_2_reg_1973;
    end else if(1'b1 == ap_CS_fsm_state6) begin
      chunk_address0 = loop_index_i_cast_fu_940_p1;
    end else if(1'b1 == ap_CS_fsm_state5) begin
      chunk_address0 = loop_index4_i_cast_fu_913_p1;
    end else begin
      chunk_address0 = 'bx;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state18) begin
      chunk_address1 = zext_ln214_1_fu_1476_p1;
    end else if(1'b1 == ap_CS_fsm_state15) begin
      chunk_address1 = p_2_reg_762;
    end else begin
      chunk_address1 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state9) | (1'b1 == ap_CS_fsm_state18) | (1'b1 == ap_CS_fsm_state15) | (1'b1 == ap_CS_fsm_state11) | (1'b1 == ap_CS_fsm_state10) | (1'b1 == ap_CS_fsm_state8) | (1'b1 == ap_CS_fsm_state7) | (1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state5)) begin
      chunk_ce0 = 1'b1;
    end else begin
      chunk_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state18) | (1'b1 == ap_CS_fsm_state15)) begin
      chunk_ce1 = 1'b1;
    end else begin
      chunk_ce1 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state10) begin
      chunk_d0 = trunc_ln121_fu_1093_p1;
    end else if(1'b1 == ap_CS_fsm_state9) begin
      chunk_d0 = conv_i_reg_1958;
    end else if((1'b1 == ap_CS_fsm_state11) | (1'b1 == ap_CS_fsm_state8)) begin
      chunk_d0 = ~8'd0;
    end else if(1'b1 == ap_CS_fsm_state7) begin
      chunk_d0 = ~8'd128;
    end else if((1'b1 == ap_CS_fsm_state6) | (1'b1 == ap_CS_fsm_state5)) begin
      chunk_d0 = ~input_r;
    end else begin
      chunk_d0 = ~'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state9) | (exitcond493_fu_918_p2 == 1'd0) & (1'b1 == ap_CS_fsm_state5) | (1'b1 == ap_CS_fsm_state11) & (icmp_ln126_reg_2061 == 1'd0) | (tmp_2_fu_1085_p3 == 1'd0) & (1'b1 == ap_CS_fsm_state10) & (icmp_ln108_reg_2043 == 1'd0) & (icmp_ln79_reg_1990 == 1'd1) | (1'b1 == ap_CS_fsm_state8) & (icmp_ln112_reg_2057 == 1'd0) | (1'b1 == ap_CS_fsm_state7) & (icmp_ln95_reg_2034 == 1'd1) | (1'b1 == ap_CS_fsm_state6) & (icmp_ln87_reg_1994 == 1'd0)) begin
      chunk_we0 = 1'b1;
    end else begin
      chunk_we0 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state27) begin
      h_address0 = zext_ln252_fu_1759_p1;
    end else if(1'b1 == ap_CS_fsm_state26) begin
      h_address0 = h_addr_3_reg_2270;
    end else if(1'b1 == ap_CS_fsm_state25) begin
      h_address0 = zext_ln243_fu_1731_p1;
    end else if(1'b1 == ap_CS_fsm_state12) begin
      h_address0 = zext_ln181_fu_1175_p1;
    end else if(1'b1 == ap_CS_fsm_state3) begin
      h_address0 = loop_index_cast_reg_1885;
    end else begin
      h_address0 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state3) | (1'b1 == ap_CS_fsm_state26) | (1'b1 == ap_CS_fsm_state27) | (1'b1 == ap_CS_fsm_state25) | (1'b1 == ap_CS_fsm_state12)) begin
      h_ce0 = 1'b1;
    end else begin
      h_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state26) begin
      h_d0 = add_ln246_fu_1749_p2;
    end else if(1'b1 == ap_CS_fsm_state3) begin
      h_d0 = calc_sha_256_h_q0;
    end else begin
      h_d0 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state3) | (1'b1 == ap_CS_fsm_state26)) begin
      h_we0 = 1'b1;
    end else begin
      h_we0 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state29) begin
      hash_address0 = zext_ln257_fu_1866_p1;
    end else if(1'b1 == ap_CS_fsm_state28) begin
      hash_address0 = zext_ln255_fu_1805_p1;
    end else begin
      hash_address0 = 'bx;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state29) begin
      hash_address1 = zext_ln256_fu_1856_p1;
    end else if(1'b1 == ap_CS_fsm_state28) begin
      hash_address1 = zext_ln252_1_fu_1810_p1;
    end else begin
      hash_address1 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state29) | (1'b1 == ap_CS_fsm_state28)) begin
      hash_ce0 = 1'b1;
    end else begin
      hash_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state29) | (1'b1 == ap_CS_fsm_state28)) begin
      hash_ce1 = 1'b1;
    end else begin
      hash_ce1 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state29) begin
      hash_d0 = trunc_ln258_reg_2294;
    end else if(1'b1 == ap_CS_fsm_state28) begin
      hash_d0 = { { h_q0[23:16] } };
    end else begin
      hash_d0 = 'bx;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state29) begin
      hash_d1 = trunc_ln4_reg_2289;
    end else if(1'b1 == ap_CS_fsm_state28) begin
      hash_d1 = { { h_q0[31:24] } };
    end else begin
      hash_d1 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state29) | (1'b1 == ap_CS_fsm_state28)) begin
      hash_we0 = 1'b1;
    end else begin
      hash_we0 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state29) | (1'b1 == ap_CS_fsm_state28)) begin
      hash_we1 = 1'b1;
    end else begin
      hash_we1 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state19) begin
      k_ce0 = 1'b1;
    end else begin
      k_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if((cmp10_reg_2120 == 1'd1) & (1'b1 == ap_CS_fsm_state17) | (cmp10_reg_2120 == 1'd0) & (1'b1 == ap_CS_fsm_state17)) begin
      w_address0 = w_addr_reg_2132;
    end else if(1'b1 == ap_CS_fsm_state16) begin
      w_address0 = zext_ln220_fu_1413_p1;
    end else if(1'b1 == ap_CS_fsm_state15) begin
      w_address0 = zext_ln219_fu_1248_p1;
    end else begin
      w_address0 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state19) | (1'b1 == ap_CS_fsm_state16)) begin
      w_address1 = w_addr_reg_2132;
    end else if(1'b1 == ap_CS_fsm_state15) begin
      w_address1 = zext_ln218_fu_1237_p1;
    end else begin
      w_address1 = 'bx;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state16) | (1'b1 == ap_CS_fsm_state15) | (cmp10_reg_2120 == 1'd1) & (1'b1 == ap_CS_fsm_state17) | (cmp10_reg_2120 == 1'd0) & (1'b1 == ap_CS_fsm_state17)) begin
      w_ce0 = 1'b1;
    end else begin
      w_ce0 = 1'b0;
    end
  end


  always @(*) begin
    if((1'b1 == ap_CS_fsm_state19) | (1'b1 == ap_CS_fsm_state16) | (1'b1 == ap_CS_fsm_state15)) begin
      w_ce1 = 1'b1;
    end else begin
      w_ce1 = 1'b0;
    end
  end


  always @(*) begin
    if(1'b1 == ap_CS_fsm_state17) begin
      if(cmp10_reg_2120 == 1'd1) begin
        w_d0 = or_ln_fu_1436_p5;
      end else if(cmp10_reg_2120 == 1'd0) begin
        w_d0 = add_ln220_3_fu_1430_p2;
      end else begin
        w_d0 = 'bx;
      end
    end else begin
      w_d0 = 'bx;
    end
  end


  always @(*) begin
    if((cmp10_reg_2120 == 1'd1) & (1'b1 == ap_CS_fsm_state17) | (cmp10_reg_2120 == 1'd0) & (1'b1 == ap_CS_fsm_state17)) begin
      w_we0 = 1'b1;
    end else begin
      w_we0 = 1'b0;
    end
  end


  always @(*) begin
    case(ap_CS_fsm)
      ap_ST_fsm_state1: begin
        if((ap_start == 1'b1) & (1'b1 == ap_CS_fsm_state1)) begin
          ap_NS_fsm = ap_ST_fsm_state2;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state1;
        end
      end
      ap_ST_fsm_state2: begin
        if((1'b1 == ap_CS_fsm_state2) & (exitcond648_fu_824_p2 == 1'd1)) begin
          ap_NS_fsm = ap_ST_fsm_state4;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state3;
        end
      end
      ap_ST_fsm_state3: begin
        ap_NS_fsm = ap_ST_fsm_state2;
      end
      ap_ST_fsm_state4: begin
        if((1'b1 == ap_CS_fsm_state4) & (ap_phi_mux_state_total_len_delivered_phi_fu_607_p4 == 1'd1)) begin
          ap_NS_fsm = ap_ST_fsm_state27;
        end else if((1'b1 == ap_CS_fsm_state4) & (ap_phi_mux_state_total_len_delivered_phi_fu_607_p4 == 1'd0) & (icmp_ln79_fu_891_p2 == 1'd1)) begin
          ap_NS_fsm = ap_ST_fsm_state6;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state5;
        end
      end
      ap_ST_fsm_state5: begin
        if((exitcond493_fu_918_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state5)) begin
          ap_NS_fsm = ap_ST_fsm_state10;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state5;
        end
      end
      ap_ST_fsm_state6: begin
        if((1'b1 == ap_CS_fsm_state6) & ((exitcond44_fu_955_p2 == 1'd1) | (icmp_ln87_reg_1994 == 1'd1))) begin
          ap_NS_fsm = ap_ST_fsm_state7;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state6;
        end
      end
      ap_ST_fsm_state7: begin
        if((1'b1 == ap_CS_fsm_state7) & (icmp_ln108_fu_1005_p2 == 1'd1)) begin
          ap_NS_fsm = ap_ST_fsm_state11;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state8;
        end
      end
      ap_ST_fsm_state8: begin
        if((1'b1 == ap_CS_fsm_state8) & ((exitcond46_fu_1060_p2 == 1'd1) | (icmp_ln112_reg_2057 == 1'd1))) begin
          ap_NS_fsm = ap_ST_fsm_state9;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state8;
        end
      end
      ap_ST_fsm_state9: begin
        ap_NS_fsm = ap_ST_fsm_state10;
      end
      ap_ST_fsm_state10: begin
        if((1'b1 == ap_CS_fsm_state10) & ((icmp_ln79_reg_1990 == 1'd0) | ((tmp_2_fu_1085_p3 == 1'd1) | (icmp_ln108_reg_2043 == 1'd1)))) begin
          ap_NS_fsm = ap_ST_fsm_state12;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state10;
        end
      end
      ap_ST_fsm_state11: begin
        if((1'b1 == ap_CS_fsm_state11) & ((exitcond45_fu_1164_p2 == 1'd1) | (icmp_ln126_reg_2061 == 1'd1))) begin
          ap_NS_fsm = ap_ST_fsm_state10;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state11;
        end
      end
      ap_ST_fsm_state12: begin
        if((icmp_ln181_fu_1180_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state12)) begin
          ap_NS_fsm = ap_ST_fsm_state14;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state13;
        end
      end
      ap_ST_fsm_state13: begin
        ap_NS_fsm = ap_ST_fsm_state12;
      end
      ap_ST_fsm_state14: begin
        if((icmp_ln189_fu_1192_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state14)) begin
          ap_NS_fsm = ap_ST_fsm_state25;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state15;
        end
      end
      ap_ST_fsm_state15: begin
        if((icmp_ln210_fu_1215_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state15)) begin
          ap_NS_fsm = ap_ST_fsm_state14;
        end else if((icmp_ln210_fu_1215_p2 == 1'd0) & (cmp10_reg_2120 == 1'd1) & (1'b1 == ap_CS_fsm_state15)) begin
          ap_NS_fsm = ap_ST_fsm_state18;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state16;
        end
      end
      ap_ST_fsm_state16: begin
        ap_NS_fsm = ap_ST_fsm_state17;
      end
      ap_ST_fsm_state17: begin
        ap_NS_fsm = ap_ST_fsm_state19;
      end
      ap_ST_fsm_state18: begin
        ap_NS_fsm = ap_ST_fsm_state17;
      end
      ap_ST_fsm_state19: begin
        ap_NS_fsm = ap_ST_fsm_state20;
      end
      ap_ST_fsm_state20: begin
        ap_NS_fsm = ap_ST_fsm_state21;
      end
      ap_ST_fsm_state21: begin
        ap_NS_fsm = ap_ST_fsm_state22;
      end
      ap_ST_fsm_state22: begin
        ap_NS_fsm = ap_ST_fsm_state23;
      end
      ap_ST_fsm_state23: begin
        ap_NS_fsm = ap_ST_fsm_state24;
      end
      ap_ST_fsm_state24: begin
        ap_NS_fsm = ap_ST_fsm_state15;
      end
      ap_ST_fsm_state25: begin
        if((icmp_ln243_fu_1737_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state25)) begin
          ap_NS_fsm = ap_ST_fsm_state4;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state26;
        end
      end
      ap_ST_fsm_state26: begin
        ap_NS_fsm = ap_ST_fsm_state25;
      end
      ap_ST_fsm_state27: begin
        if((icmp_ln252_fu_1764_p2 == 1'd1) & (1'b1 == ap_CS_fsm_state27)) begin
          ap_NS_fsm = ap_ST_fsm_state1;
        end else begin
          ap_NS_fsm = ap_ST_fsm_state28;
        end
      end
      ap_ST_fsm_state28: begin
        ap_NS_fsm = ap_ST_fsm_state29;
      end
      ap_ST_fsm_state29: begin
        ap_NS_fsm = ap_ST_fsm_state27;
      end
      default: begin
        ap_NS_fsm = 'bx;
      end
    endcase
  end

  assign add_ln109_1_fu_1021_p2 = $signed(trunc_ln166_2_fu_991_p1) + $signed(6'd56);
  assign add_ln117_1_fu_1071_p2 = add_ln117_fu_1065_p2 + trunc_ln166_2_reg_2038;
  assign add_ln117_fu_1065_p2 = $signed(chunk_addr_0_i_idx_reg_646) + $signed(6'd63);
  assign add_ln119_fu_1128_p2 = $signed(i_1_reg_667) + $signed(4'd15);
  assign add_ln121_1_fu_1104_p2 = add_ln121_fu_1098_p2 + add_ln109_1_reg_2052;
  assign add_ln121_fu_1098_p2 = $signed(chunk_addr_0_i_idx_reg_646) + $signed(sext_ln119_fu_1081_p1);
  assign add_ln181_fu_1186_p2 = i_2_reg_715 + 4'd1;
  assign add_ln210_fu_1221_p2 = j_1_reg_750 + 5'd1;
  assign add_ln213_fu_1257_p2 = trunc_ln210_fu_1253_p1 + 6'd1;
  assign add_ln214_1_fu_1471_p2 = trunc_ln210_reg_2158 + 6'd3;
  assign add_ln214_fu_1461_p2 = trunc_ln210_reg_2158 + 6'd2;
  assign add_ln218_fu_1231_p2 = trunc_ln218_fu_1227_p1 + 4'd1;
  assign add_ln219_fu_1242_p2 = $signed(trunc_ln218_fu_1227_p1) + $signed(4'd14);
  assign add_ln220_1_fu_1424_p2 = w_q1 + w_q0;
  assign add_ln220_2_fu_1418_p2 = s0_fu_1332_p2 + s1_fu_1402_p2;
  assign add_ln220_3_fu_1430_p2 = add_ln220_2_reg_2174 + add_ln220_1_fu_1424_p2;
  assign add_ln220_fu_1408_p2 = $signed(trunc_ln218_reg_2138) + $signed(4'd9);
  assign add_ln224_1_fu_1600_p2 = s1_1_reg_2214 + ch_fu_1588_p2;
  assign add_ln224_2_fu_1605_p2 = add_ln224_1_fu_1600_p2 + w_q1;
  assign add_ln224_fu_1594_p2 = k_q0 + ah_q0;
  assign add_ln233_fu_1716_p2 = ah_q1 + temp1_reg_2224;
  assign add_ln237_1_fu_1721_p2 = temp1_reg_2224 + maj_fu_1710_p2;
  assign add_ln237_fu_1726_p2 = add_ln237_1_fu_1721_p2 + s0_1_reg_2236;
  assign add_ln243_fu_1743_p2 = i_4_reg_787 + 4'd1;
  assign add_ln246_fu_1749_p2 = h_q0 + ah_q1;
  assign add_ln252_fu_1770_p2 = i_fu_280 + 4'd1;
  assign add_ln258_fu_1840_p2 = j_fu_276 + 6'd4;
  assign add_ln99_fu_980_p2 = trunc_ln166_reg_1979 + 6'd1;
  assign and_ln223_1_fu_1582_p2 = xor_ln223_fu_1576_p2 & ah_q1;
  assign and_ln223_fu_1570_p2 = reg_805 & reg_798;
  assign and_ln226_1_fu_1705_p2 = ah_q0 & ah_load_6_reg_2241;
  assign and_ln226_fu_1700_p2 = xor_ln226_fu_1695_p2 & ah_load_5_reg_2230;
  assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];
  assign ap_CS_fsm_state10 = ap_CS_fsm[32'd9];
  assign ap_CS_fsm_state11 = ap_CS_fsm[32'd10];
  assign ap_CS_fsm_state12 = ap_CS_fsm[32'd11];
  assign ap_CS_fsm_state13 = ap_CS_fsm[32'd12];
  assign ap_CS_fsm_state14 = ap_CS_fsm[32'd13];
  assign ap_CS_fsm_state15 = ap_CS_fsm[32'd14];
  assign ap_CS_fsm_state16 = ap_CS_fsm[32'd15];
  assign ap_CS_fsm_state17 = ap_CS_fsm[32'd16];
  assign ap_CS_fsm_state18 = ap_CS_fsm[32'd17];
  assign ap_CS_fsm_state19 = ap_CS_fsm[32'd18];
  assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];
  assign ap_CS_fsm_state20 = ap_CS_fsm[32'd19];
  assign ap_CS_fsm_state21 = ap_CS_fsm[32'd20];
  assign ap_CS_fsm_state22 = ap_CS_fsm[32'd21];
  assign ap_CS_fsm_state23 = ap_CS_fsm[32'd22];
  assign ap_CS_fsm_state24 = ap_CS_fsm[32'd23];
  assign ap_CS_fsm_state25 = ap_CS_fsm[32'd24];
  assign ap_CS_fsm_state26 = ap_CS_fsm[32'd25];
  assign ap_CS_fsm_state27 = ap_CS_fsm[32'd26];
  assign ap_CS_fsm_state28 = ap_CS_fsm[32'd27];
  assign ap_CS_fsm_state29 = ap_CS_fsm[32'd28];
  assign ap_CS_fsm_state3 = ap_CS_fsm[32'd2];
  assign ap_CS_fsm_state4 = ap_CS_fsm[32'd3];
  assign ap_CS_fsm_state5 = ap_CS_fsm[32'd4];
  assign ap_CS_fsm_state6 = ap_CS_fsm[32'd5];
  assign ap_CS_fsm_state7 = ap_CS_fsm[32'd6];
  assign ap_CS_fsm_state8 = ap_CS_fsm[32'd7];
  assign ap_CS_fsm_state9 = ap_CS_fsm[32'd8];
  assign ap_phi_mux_state_total_len_delivered_phi_fu_607_p4 = state_total_len_delivered_reg_603;
  assign calc_sha_256_h_address0 = loop_index_cast_fu_819_p1;
  assign ch_fu_1588_p2 = and_ln223_fu_1570_p2 ^ and_ln223_1_fu_1582_p2;
  assign chunk_addr_0_i67_sum74_cast_fu_1049_p1 = chunk_addr_0_i67_sum74_fu_1043_p2;
  assign chunk_addr_0_i67_sum74_fu_1043_p2 = empty_28_fu_1039_p1 + chunk_addr_0_i_idx_reg_646;
  assign chunk_addr_0_i67_sum_cast_fu_1149_p1 = chunk_addr_0_i67_sum_fu_1143_p2;
  assign chunk_addr_0_i67_sum_fu_1143_p2 = p_cast19_fu_1139_p1 + chunk_addr_0_i_idx_reg_646;
  assign cmp10_fu_1204_p2 = (i_3_reg_738 == 3'd0)? 1'b1 : 1'b0;
  assign conv_i_fu_844_p3 = { { empty_22_fu_841_p1 }, { ~3'd0 } };
  assign empty_21_fu_830_p2 = loop_index_fu_248 + 4'd1;
  assign empty_22_fu_841_p1 = ~len[4:0];
  assign empty_24_fu_924_p2 = loop_index4_i_reg_614 + 7'd1;
  assign empty_25_fu_945_p2 = loop_index_i_reg_625 + 6'd1;
  assign empty_28_fu_1039_p1 = empty_27_reg_656[5:0];
  assign empty_29_fu_1054_p2 = empty_27_reg_656 + 64'd1;
  assign empty_33_fu_1154_p2 = empty_32_reg_704 + 3'd1;
  assign exitcond44_fu_955_p2 = (p_cast22_fu_951_p1 == ~state_len_2_reg_1973)? 1'b1 : 1'b0;
  assign exitcond45_fu_1164_p2 = (p_cast20_fu_1160_p1 == space_in_chunk_2_reg_636)? 1'b1 : 1'b0;
  assign exitcond46_fu_1060_p2 = (empty_29_fu_1054_p2 == zext_ln109_reg_2047)? 1'b1 : 1'b0;
  assign exitcond493_fu_918_p2 = (loop_index4_i_reg_614 == 7'd64)? 1'b1 : 1'b0;
  assign exitcond648_fu_824_p2 = (loop_index_fu_248 == 4'd8)? 1'b1 : 1'b0;
  assign i_7_fu_1198_p2 = i_3_reg_738 + 3'd1;
  assign icmp_ln108_fu_1005_p2 = (tmp_1_fu_995_p4 == 4'd0)? 1'b1 : 1'b0;
  assign icmp_ln112_fu_1027_p2 = (add_ln109_1_fu_1021_p2 == 6'd0)? 1'b1 : 1'b0;
  assign icmp_ln126_fu_1033_p2 = (ap_phi_mux_space_in_chunk_2_phi_fu_639_p4 == 7'd0)? 1'b1 : 1'b0;
  assign icmp_ln181_fu_1180_p2 = (i_2_reg_715 == 4'd8)? 1'b1 : 1'b0;
  assign icmp_ln189_fu_1192_p2 = (i_3_reg_738 == 3'd4)? 1'b1 : 1'b0;
  assign icmp_ln210_fu_1215_p2 = (j_1_reg_750 == 5'd16)? 1'b1 : 1'b0;
  assign icmp_ln243_fu_1737_p2 = (i_4_reg_787 == 4'd8)? 1'b1 : 1'b0;
  assign icmp_ln252_fu_1764_p2 = (i_fu_280 == 4'd8)? 1'b1 : 1'b0;
  assign icmp_ln79_fu_891_p2 = (tmp_fu_881_p4 == 58'd0)? 1'b1 : 1'b0;
  assign icmp_ln87_fu_897_p2 = (~state_len_fu_268 == 64'd0)? 1'b1 : 1'b0;
  assign icmp_ln95_fu_968_p2 = (state_single_one_delivered_fu_272 == 32'd0)? 1'b1 : 1'b0;
  assign k_address0 = zext_ln224_fu_1565_p1;
  assign left_fu_1011_p2 = $signed(ap_phi_mux_space_in_chunk_2_phi_fu_639_p4) + $signed(7'd120);
  assign len_2_fu_1114_p4 = { { ~(~(~(~len_1_reg_678[58:8]))) } };
  assign loop_index4_i_cast_fu_913_p1 = loop_index4_i_reg_614;
  assign loop_index_cast_fu_819_p1 = loop_index_fu_248;
  assign loop_index_i_cast_fu_940_p1 = loop_index_i_reg_625;
  assign lshr_ln1_fu_1312_p4 = { { w_q1[31:3] } };
  assign lshr_ln2_fu_1382_p4 = { { w_q0[31:10] } };
  assign lshr_ln54_1_fu_1290_p4 = { { w_q1[31:18] } };
  assign lshr_ln54_2_fu_1338_p4 = { { w_q0[31:17] } };
  assign lshr_ln54_3_fu_1360_p4 = { { w_q0[31:19] } };
  assign lshr_ln54_4_fu_1481_p4 = { { ah_q1[31:6] } };
  assign lshr_ln54_5_fu_1503_p4 = { { ah_q1[31:11] } };
  assign lshr_ln54_6_fu_1525_p4 = { { ah_q1[31:25] } };
  assign lshr_ln54_7_fu_1617_p4 = { { ah_q1[31:2] } };
  assign lshr_ln54_8_fu_1639_p4 = { { ah_q1[31:13] } };
  assign lshr_ln54_9_fu_1661_p4 = { { ah_q1[31:22] } };
  assign lshr_ln_fu_1268_p4 = { { w_q1[31:7] } };
  assign maj_fu_1710_p2 = and_ln226_fu_1700_p2 ^ and_ln226_1_fu_1705_p2;
  assign or_ln1_fu_1559_p3 = { { trunc_ln224_1_reg_2189 }, { trunc_ln224_reg_2184 } };
  assign or_ln255_fu_1799_p2 = trunc_ln252_fu_1795_p1 | 5'd1;
  assign or_ln256_fu_1851_p2 = trunc_ln252_reg_2283 | 5'd2;
  assign or_ln257_fu_1861_p2 = trunc_ln252_reg_2283 | 5'd3;
  assign or_ln2_fu_1282_p3 = { { trunc_ln54_fu_1278_p1 }, { lshr_ln_fu_1268_p4 } };
  assign or_ln54_1_fu_1304_p3 = { { trunc_ln54_1_fu_1300_p1 }, { lshr_ln54_1_fu_1290_p4 } };
  assign or_ln54_2_fu_1352_p3 = { { trunc_ln54_2_fu_1348_p1 }, { lshr_ln54_2_fu_1338_p4 } };
  assign or_ln54_3_fu_1374_p3 = { { trunc_ln54_3_fu_1370_p1 }, { lshr_ln54_3_fu_1360_p4 } };
  assign or_ln54_4_fu_1495_p3 = { { trunc_ln54_4_fu_1491_p1 }, { lshr_ln54_4_fu_1481_p4 } };
  assign or_ln54_5_fu_1517_p3 = { { trunc_ln54_5_fu_1513_p1 }, { lshr_ln54_5_fu_1503_p4 } };
  assign or_ln54_6_fu_1539_p3 = { { trunc_ln54_6_fu_1535_p1 }, { lshr_ln54_6_fu_1525_p4 } };
  assign or_ln54_7_fu_1631_p3 = { { trunc_ln54_7_fu_1627_p1 }, { lshr_ln54_7_fu_1617_p4 } };
  assign or_ln54_8_fu_1653_p3 = { { trunc_ln54_8_fu_1649_p1 }, { lshr_ln54_8_fu_1639_p4 } };
  assign or_ln54_9_fu_1675_p3 = { { trunc_ln54_9_fu_1671_p1 }, { lshr_ln54_9_fu_1661_p4 } };
  assign or_ln_fu_1436_p5 = { { { { chunk_load_reg_2194 }, { chunk_load_1_reg_2199 } }, { chunk_q0 } }, { chunk_q1 } };
  assign p_3_fu_1447_p2 = p_2_reg_762 + 64'd4;
  assign p_cast19_fu_1139_p1 = empty_32_reg_704;
  assign p_cast20_fu_1160_p1 = empty_33_fu_1154_p2;
  assign p_cast22_fu_951_p1 = empty_25_fu_945_p2;
  assign s0_1_fu_1689_p2 = xor_ln225_fu_1683_p2 ^ or_ln54_9_fu_1675_p3;
  assign s0_fu_1332_p2 = xor_ln218_fu_1326_p2 ^ or_ln2_fu_1282_p3;
  assign s1_1_fu_1553_p2 = xor_ln222_fu_1547_p2 ^ or_ln54_6_fu_1539_p3;
  assign s1_fu_1402_p2 = xor_ln219_fu_1396_p2 ^ or_ln54_2_fu_1352_p3;
  assign sext_ln119_fu_1081_p1 = i_1_reg_667;
  assign space_in_chunk_1_fu_974_p2 = $signed(space_in_chunk_reg_2028) + $signed(7'd127);
  assign space_in_chunk_fu_963_p2 = $signed(7'd64) - $signed(trunc_ln166_1_reg_1985);
  assign state_len_3_fu_930_p2 = $signed((~(~state_len_fu_268))) + ($signed((~64'd18446744073709551552)) + 1);
  assign temp1_fu_1611_p2 = add_ln224_2_fu_1605_p2 + add_ln224_fu_1594_p2;
  assign tmp_1_fu_995_p4 = { { ap_phi_mux_space_in_chunk_2_phi_fu_639_p4[6:3] } };
  assign tmp_2_fu_1085_p3 = i_1_reg_667[32'd3];
  assign tmp_fu_881_p4 = { { ~state_len_fu_268[63:6] } };
  assign trunc_ln121_fu_1093_p1 = len_1_reg_678[7:0];
  assign trunc_ln166_1_fu_877_p1 = ~state_len_fu_268[6:0];
  assign trunc_ln166_2_fu_991_p1 = ap_phi_mux_space_in_chunk_2_phi_fu_639_p4[5:0];
  assign trunc_ln166_fu_873_p1 = ~state_len_fu_268[5:0];
  assign trunc_ln210_fu_1253_p1 = p_2_reg_762[5:0];
  assign trunc_ln218_fu_1227_p1 = j_1_reg_750[3:0];
  assign trunc_ln224_1_fu_1457_p1 = i_3_reg_738[1:0];
  assign trunc_ln224_fu_1453_p1 = j_1_reg_750[3:0];
  assign trunc_ln252_fu_1795_p1 = j_fu_276[4:0];
  assign trunc_ln258_fu_1836_p1 = h_q0[7:0];
  assign trunc_ln54_1_fu_1300_p1 = w_q1[17:0];
  assign trunc_ln54_2_fu_1348_p1 = w_q0[16:0];
  assign trunc_ln54_3_fu_1370_p1 = w_q0[18:0];
  assign trunc_ln54_4_fu_1491_p1 = ah_q1[5:0];
  assign trunc_ln54_5_fu_1513_p1 = ah_q1[10:0];
  assign trunc_ln54_6_fu_1535_p1 = ah_q1[24:0];
  assign trunc_ln54_7_fu_1627_p1 = ah_q1[1:0];
  assign trunc_ln54_8_fu_1649_p1 = ah_q1[12:0];
  assign trunc_ln54_9_fu_1671_p1 = ah_q1[21:0];
  assign trunc_ln54_fu_1278_p1 = w_q1[6:0];
  assign xor_ln218_fu_1326_p2 = zext_ln218_1_fu_1322_p1 ^ or_ln54_1_fu_1304_p3;
  assign xor_ln219_fu_1396_p2 = zext_ln219_1_fu_1392_p1 ^ or_ln54_3_fu_1374_p3;
  assign xor_ln222_fu_1547_p2 = or_ln54_5_fu_1517_p3 ^ or_ln54_4_fu_1495_p3;
  assign xor_ln223_fu_1576_p2 = reg_798 ^ 32'd4294967295;
  assign xor_ln225_fu_1683_p2 = or_ln54_8_fu_1653_p3 ^ or_ln54_7_fu_1631_p3;
  assign xor_ln226_fu_1695_p2 = ah_q0 ^ ah_load_6_reg_2241;
  assign zext_ln109_fu_1017_p1 = left_fu_1011_p2;
  assign zext_ln117_fu_1076_p1 = add_ln117_1_fu_1071_p2;
  assign zext_ln121_fu_1109_p1 = add_ln121_1_fu_1104_p2;
  assign zext_ln122_fu_1124_p1 = len_2_fu_1114_p4;
  assign zext_ln181_fu_1175_p1 = i_2_reg_715;
  assign zext_ln210_fu_1210_p1 = j_1_reg_750;
  assign zext_ln213_fu_1263_p1 = add_ln213_fu_1257_p2;
  assign zext_ln214_1_fu_1476_p1 = add_ln214_1_fu_1471_p2;
  assign zext_ln214_fu_1466_p1 = add_ln214_fu_1461_p2;
  assign zext_ln218_1_fu_1322_p1 = lshr_ln1_fu_1312_p4;
  assign zext_ln218_fu_1237_p1 = add_ln218_fu_1231_p2;
  assign zext_ln219_1_fu_1392_p1 = lshr_ln2_fu_1382_p4;
  assign zext_ln219_fu_1248_p1 = add_ln219_fu_1242_p2;
  assign zext_ln220_fu_1413_p1 = add_ln220_fu_1408_p2;
  assign zext_ln224_fu_1565_p1 = or_ln1_fu_1559_p3;
  assign zext_ln243_fu_1731_p1 = i_4_reg_787;
  assign zext_ln252_1_fu_1810_p1 = j_fu_276;
  assign zext_ln252_fu_1759_p1 = i_fu_280;
  assign zext_ln255_fu_1805_p1 = or_ln255_fu_1799_p2;
  assign zext_ln256_fu_1856_p1 = or_ln256_fu_1851_p2;
  assign zext_ln257_fu_1866_p1 = or_ln257_fu_1861_p2;

  always @(posedge ap_clk) begin
    loop_index_cast_reg_1885[63:4] <= 60'b000000000000000000000000000000000000000000000000000000000000;
    conv_i_reg_1958[2:0] <= ~3'b000;
    zext_ln109_reg_2047[63:7] <= 57'b000000000000000000000000000000000000000000000000000000000;
    zext_ln181_reg_2094[63:4] <= 60'b000000000000000000000000000000000000000000000000000000000000;
    state_single_one_delivered_fu_272[31:1] <= 31'b0000000000000000000000000000000;
  end


endmodule


