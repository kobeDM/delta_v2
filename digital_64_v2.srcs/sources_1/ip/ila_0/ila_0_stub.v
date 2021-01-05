// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
// Date        : Tue Aug 27 10:44:56 2019
// Host        : daqmwpc3.kek.jp running 64-bit Scientific Linux release 6.4 (Carbon)
// Command     : write_verilog -force -mode synth_stub
//               /home/hamada/Liq/firmware/TEST1_5/digital_64_v2.srcs/sources_1/ip/ila_0/ila_0_stub.v
// Design      : ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tffg1156-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2018.2" *)
module ila_0(clk, probe0, probe1, probe2)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[11:0],probe1[0:0],probe2[0:0]" */;
  input clk;
  input [11:0]probe0;
  input [0:0]probe1;
  input [0:0]probe2;
endmodule
