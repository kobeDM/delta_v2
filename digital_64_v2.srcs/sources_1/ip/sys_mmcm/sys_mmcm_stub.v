// Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2015.3 (win64) Build 1368829 Mon Sep 28 20:06:43 MDT 2015
// Date        : Fri Jul 29 17:08:22 2016
// Host        : E3E5 running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               C:/160112/debug/digital_64_v14/digital_64_v2.srcs/sources_1/ip/sys_mmcm/sys_mmcm_stub.v
// Design      : sys_mmcm
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a200tffg1156-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module sys_mmcm(clk_in1, clk_out1, clk_out2, clk_out3, reset, locked)
/* synthesis syn_black_box black_box_pad_pin="clk_in1,clk_out1,clk_out2,clk_out3,reset,locked" */;
  input clk_in1;
  output clk_out1;
  output clk_out2;
  output clk_out3;
  input reset;
  output locked;
endmodule
