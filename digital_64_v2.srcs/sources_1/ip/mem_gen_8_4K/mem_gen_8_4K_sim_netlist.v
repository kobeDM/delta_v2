// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Tue Jan 12 17:32:40 2021
// Host        : LAPTOP-ER3N32PK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/higas/study/DM/FW/trig/digital_64_v17_2020_03_05/digital_64_v2.srcs/sources_1/ip/mem_gen_8_4K/mem_gen_8_4K_sim_netlist.v
// Design      : mem_gen_8_4K
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tffg1156-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mem_gen_8_4K,blk_mem_gen_v8_4_4,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_4,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module mem_gen_8_4K
   (clka,
    ena,
    wea,
    addra,
    dina,
    clkb,
    enb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [0:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [11:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [7:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [11:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [7:0]doutb;

  wire [11:0]addra;
  wire [11:0]addrb;
  wire clka;
  wire clkb;
  wire [7:0]dina;
  wire [7:0]doutb;
  wire ena;
  wire enb;
  wire [0:0]wea;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [7:0]NLW_U0_douta_UNCONNECTED;
  wire [11:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [11:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [7:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "12" *) 
  (* C_ADDRB_WIDTH = "12" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "1" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     4.53475 mW" *) 
  (* C_FAMILY = "artix7" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "mem_gen_8_4K.mem" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "1" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "4096" *) 
  (* C_READ_DEPTH_B = "4096" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "8" *) 
  (* C_READ_WIDTH_B = "8" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "4096" *) 
  (* C_WRITE_DEPTH_B = "4096" *) 
  (* C_WRITE_MODE_A = "NO_CHANGE" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "8" *) 
  (* C_WRITE_WIDTH_B = "8" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  mem_gen_8_4K_blk_mem_gen_v8_4_4 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(NLW_U0_douta_UNCONNECTED[7:0]),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[11:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[11:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[7:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.2"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
QGLtnqZzRetDH6gCWT4Js6wuLlZfrNx/VJp3sfR2NF+cxypO5AxN0oDKLJJtmdrtE/ueNDg+Qf7Z
TqBNRojORA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
B6Ger3hRvfjHkaJ+W8639Kl3TzC9TogLuklOXEiMNdc4Im+DjEUzxb3DKlzu0VW3zxZqjJ3+wsW/
LnRmPCESi5Y9eRJaLFXg79EMfoj4X+nTdHAP6yCfltBADKegZ12gpnB/8ey5yn2KA74LUtPC7jna
iyjqSfsWLGnz6UdXzwk=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BX+DxgMPRyZbYojCUR9Sk8Lq+3ZigBz4yMFHQkmurfdfDzyTPJCE827eGiPyTenK1QPVhEtf9g06
0BFXq/0COPuU1BWJwdkz1c4dE6/exDwhvEh+hPx3vRY6z8fDEf6aGVIXrHDvrmddehe7yMSIpo+k
aXHR06EEdfHCFY4TggYwhcJVXjkE+ApsVuyfmEfPmYjo8hCWyQyBsUWIOY03q1+MvUjjsmTwgs9g
fh5MY9ToaLfoJxPKdCpsqrBX4LJ+VDGFlAqIcqHTE2jCmPiToZAFXB7fzf1wDjFCBlJyFVDBGi0i
m+CouLSb7X1mvVhdDZgNrZDJMV688Bu3o54vew==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DaIU/Ddc8USbZ2mURzujJDWDH1JbHl5tFVOOQ2aVaUPIA71yyE38OXVLEtF8rNmujYH30nEeQ+FV
LVJ16aaHw+iiuaqorTM3K5KLohVlN+WlcEtSXHuPNHjw8ddqtzpaX7pH1zqZH+YmfCL5oaNLqDH4
rkBnUl0/Gm/hzSwKjYhXGQFYQ+gGP99OjXakzrAqZzp/Iq4gt+Z5902/JV9thd/isHQImJ0QyK8M
EKM579iPAfXGes2mbiNYHcvDmSPYmW1zlhOE++N1EKeea7j/msnKeyhlC+hGE4Xfn4TVvqgQexCT
rp/wS/MosY6WH1aKFQlFH2hEppA7KXUaQlvG+w==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
XmWoAt4X8hrCJ5yTyug4ajJW5UhfkLNibzjihWzZ4Cr9hQSvWZoTc8rjGsLPbz6Le+/9iI5KxecS
eR0wiAO+G2IkwhZgVBeZdKoFnlnTVAyLjk9wMAFXNyJZM6b1NDbfXlPcUsC6JePvPlwwdWknkSsC
r3KvgkWAS+O3xvRmaNw=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Hw3Y+rShKrXiUViyNU1/O2qv6TgheLHBnFMj1i9MUGrHYqh9pLfLYUgWR7S2vj4jv4S+Ks0BpP4p
dKEqVAFmTCfQNEUHaVcFPkOHgig6L4mhLY6HUUKJoRgiQepgLi/W3V+ZZPQSQFkB3CU4MsJzhXvR
yLcpDriZy8cnAHD87Zi5DrNGBzj3kigJeM0du6lCQbxtF5aEdoaNP+YTnIFtcqYhoYnswQlYt0sV
HKgFA8VzqzL5WYnpH7+1IKmFkJBHkyqHCa9wPK0qCKnxkuDj70YzPVqQ+cocdKU+/gNdpCOdZlci
F2HTxrgfrXndJru3TiDqu4UavqAe0MNuFp3t0w==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
XPVggoWL6aXz+MpODTOZhEUQDa0vfEnUDaYeEHXm2vGyqKJujN2c/FFAFBeBYdJATLsIsQ+BqoPc
pBbcFYXDBfOtFIW2dH6Y1OoD65KyJ/hAq8coa21kFgq4hFat5vzZ2iIfkCpTUr4vDZO7Xne8cZO9
WsHffoTCt5rS59wWm2b8I5R8Eh2TUbQg3RCyrcnD66cvcEnlXe1CNMQ4/loVJpA4IBinBf820Wjc
vw2fZbGI0jXC+ACSHOviH63Xwmn+aRV5Ppkup7IYoon/ieKapRQeASu3TTY37xSBXiInSdtMTzJ6
+4GfO4eSHVriCk/sWbuTBzfRzoSShrnHjzz5LA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2020_08", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
L78XuiswVcgO2gtebzL7SA9BC/jJGAM0v6S9pzmyqL+QYzRneiYeGyDmsW33jEVVSTuNjTXkBLY7
yTOKQruatwe4V0OLi6174saSAmPgerSV1GyLP7KhmusLV/N61avC9TPam+tekhKeE0tds4EnJ3et
4JdLh+SE4Z4pcuqCjB5MFneIYKKWDx7siU6oesAQtoSJOesfMchX63MhOjOHFP/ch+1gHv3T45hg
IGF7V7TrdREVE4f9631tlVJ1o2Dypsmo/76Itz5WCGlTMjAnWXN8IXxKN+PZ3dyt1wjrZm2P/td+
xiGszFnSLrRvw/HferwtSmRx8q0fiHZ88roGTw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
kDX5kq2QEe25429T6vQqBCFvV1McKTJRYfK99ymVNK2GGvGLXSzgwJHwB2fj9rM0wme3zYYY0vQR
x+9F4L7KLlOVY6qY3LB59uDzyXBI3mMZaS905HXHJkdZHWtQWpfHhl27LqL+8FSluaD6F+KFfYOV
CwIOVuCIp/XjxFXpNBik7YiPt4kHOlDA97IXNLnYUn/g1csGqeNWce4UTne50ggWvLYGbTFGmTjT
N67TpUiGRVRCSv8Tax72GWFIMFZk3Tlp68ZUSQEybZMWX1U9XdMdtxfvNGhf8mi5jQJ2SupSzKu4
T/+53IN9T8aLePAiGBKKG1ZBj4y1ZyYA7XYvjw==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 27376)
`pragma protect data_block
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
6b8OpuptBkZd0k6oYU/kBw==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
