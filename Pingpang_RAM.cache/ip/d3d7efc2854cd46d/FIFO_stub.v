// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (win64) Build 1733598 Wed Dec 14 22:35:39 MST 2016
// Date        : Mon Nov 20 17:27:08 2017
// Host        : DESKTOP-JC6NIF0 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ FIFO_stub.v
// Design      : FIFO
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_1_3,Vivado 2016.4" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(wr_clk, rd_clk, din, wr_en, rd_en, dout, full, 
  almost_full, wr_ack, empty, almost_empty, valid, rd_data_count, wr_data_count)
/* synthesis syn_black_box black_box_pad_pin="wr_clk,rd_clk,din[13:0],wr_en,rd_en,dout[13:0],full,almost_full,wr_ack,empty,almost_empty,valid,rd_data_count[9:0],wr_data_count[9:0]" */;
  input wr_clk;
  input rd_clk;
  input [13:0]din;
  input wr_en;
  input rd_en;
  output [13:0]dout;
  output full;
  output almost_full;
  output wr_ack;
  output empty;
  output almost_empty;
  output valid;
  output [9:0]rd_data_count;
  output [9:0]wr_data_count;
endmodule
