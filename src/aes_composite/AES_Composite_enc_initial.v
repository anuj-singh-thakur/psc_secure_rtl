`timescale 1 ns / 1 ps


module AES_Composite_enc
(
  Kin,
  Din,
  Dout,
  Krdy,
  Drdy,
  Kvld,
  Dvld,
  EN,
  BSY,
  CLK,
  RSTn
);

  input [127:0] Kin;
  input [127:0] Din;
  output [127:0] Dout;
  input Krdy;
  input Drdy;
  output Kvld;
  output Dvld;
  input EN;
  output BSY;
  input CLK;
  input RSTn;
  reg [127:0] dat;reg [127:0] key;reg [127:0] rkey;
  wire [127:0] dat_next;wire [127:0] rkey_next;
  reg [9:0] rnd;
  reg [7:0] rcon;
  reg sel;
  reg Dvld;reg Kvld;reg BSY;
  wire rst;
  assign rst = ~RSTn;

  always @(posedge CLK or posedge rst) begin
    if(rst) Dvld <= 0; 
    else if(EN) Dvld <= sel; 
  end


  always @(posedge CLK or posedge rst) begin
    if(rst) Kvld <= 0; 
    else if(EN) Kvld <= Krdy; 
  end


  always @(posedge CLK or posedge rst) begin
    if(rst) BSY <= 0; 
    else if(EN) BSY <= Drdy | |rnd[9:1] | sel; 
  end


  AES_Core
  aes_core
  (
    .din(~dat),
    .dout(dat_next),
    .kin(rkey_next),
    .sel(sel)
  );


  KeyExpantion
  keyexpantion
  (
    .kin(rkey),
    .kout(rkey_next),
    .rcon(rcon)
  );


  always @(posedge CLK or posedge rst) begin
    if(rst) rnd <= 10'b0000_0000_01; 
    else if(EN) begin
      if(Drdy) rnd <= { rnd[8:0], rnd[9] }; 
      else if(~rnd[0]) rnd <= { rnd[8:0], rnd[9] }; 
    end 
  end


  always @(posedge CLK or posedge rst) begin
    if(rst) sel <= 0; 
    else if(EN) sel <= rnd[9]; 
  end


  always @(posedge CLK or posedge rst) begin
    if(rst) dat <= ~128'h0; 
    else if(EN) begin
      if(Drdy) dat <= ~(Din ^ ~key); 
      else if(~rnd[0] | sel) dat <= ~dat_next; 
    end 
  end

  assign Dout = ~dat;

  always @(posedge CLK or posedge rst) begin
    if(rst) key <= ~128'h0; 
    else if(EN) if(Krdy) key <= ~Kin; 
  end


  always @(posedge CLK or posedge rst) begin
    if(rst) rkey <= 128'h0; 
    else if(EN) begin
      if(Krdy) rkey <= Kin; 
      else if(rnd[0]) rkey <= ~key; 
      else rkey <= rkey_next;
    end 
  end


  always @(posedge CLK or posedge rst) begin
    if(rst) rcon <= 8'h01; 
    else if(EN) begin
      if(Drdy) rcon <= 8'h01; 
      else if(~rnd[0]) rcon <= (rcon[7] == 1'b0)? { rcon[6:0], 1'b0 } : { rcon[6:0], 1'b0 } ^ 8'h1B; 
    end 
  end


  function [7:0] xtime;
    input [7:0] x;
    xtime = (x[7] == 1'b0)? { x[6:0], 1'b0 } : { x[6:0], 1'b0 } ^ 8'h1B;
  endfunction


endmodule


