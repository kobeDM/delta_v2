// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Tue Jan 12 17:39:51 2021
// Host        : LAPTOP-ER3N32PK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/higas/study/DM/FW/trig/digital_64_v17_2020_03_05/digital_64_v2.srcs/sources_1/ip/c_addsub_2/c_addsub_2_sim_netlist.v
// Design      : c_addsub_2
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tffg1156-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "c_addsub_2,c_addsub_v12_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_14,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module c_addsub_2
   (A,
    B,
    CLK,
    S);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [8:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [8:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF s_intf:c_out_intf:sinit_intf:sset_intf:bypass_intf:c_in_intf:add_intf:b_intf:a_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 s_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME s_intf, LAYERED_METADATA undef" *) output [8:0]S;

  wire [8:0]A;
  wire [8:0]B;
  wire CLK;
  wire [8:0]S;
  wire NLW_U0_C_OUT_UNCONNECTED;

  (* C_AINIT_VAL = "0" *) 
  (* C_BORROW_LOW = "1" *) 
  (* C_CE_OVERRIDES_BYPASS = "1" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_SINIT = "0" *) 
  (* C_HAS_SSET = "0" *) 
  (* C_IMPLEMENTATION = "0" *) 
  (* C_SCLR_OVERRIDES_SSET = "1" *) 
  (* C_SINIT_VAL = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* c_a_type = "0" *) 
  (* c_a_width = "9" *) 
  (* c_add_mode = "1" *) 
  (* c_b_constant = "0" *) 
  (* c_b_type = "0" *) 
  (* c_b_value = "000000000" *) 
  (* c_b_width = "9" *) 
  (* c_bypass_low = "0" *) 
  (* c_has_bypass = "0" *) 
  (* c_has_c_in = "0" *) 
  (* c_has_c_out = "0" *) 
  (* c_latency = "1" *) 
  (* c_out_width = "9" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  c_addsub_2_c_addsub_v12_0_14 U0
       (.A(A),
        .ADD(1'b1),
        .B(B),
        .BYPASS(1'b0),
        .CE(1'b1),
        .CLK(CLK),
        .C_IN(1'b0),
        .C_OUT(NLW_U0_C_OUT_UNCONNECTED),
        .S(S),
        .SCLR(1'b0),
        .SINIT(1'b0),
        .SSET(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
EJFZwtxl4g9/OL6+bopUV8BP4e67HNukCIy7Ih3E75y7soa6GhqEucPXMiOy+mJrcrNwD+HjZ0/I
BwEKIiA4mA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
rZCGWdmPJXoOuANoS8fyUXk7SyF+uTNJL18BfeKc+fxcyRrCB++WrM02adxoUdICz4/92yY8TQgj
xyPC0eaHZcjSLepbnHHgSReIQ1PL0hmufLbye7QTD0ygUXC4MvFVY8s3KeW9cPCqOxkyCSziJQzs
J5OT9XLQno1e9rIBr9M=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
I7Zo4frj3tO6FFzeDhpSENS0yd34dQZBtiyIrI/GMASFBUeny6muOD2l0HK69ImRJIOyobvK1+9O
DhxptAc4NzRpY4xUZvr4ix1AhM1Kars1OkrQCWz4a7ciGU/XDblidF3IL0Fa7c41gHIZR9c/Usa6
XL7UEu3aSPQYbZLSDOzeao4VtSSn+dCcjsH4X8zVjSqXg8dcN3fd5C15JaMYg00F2yOFtxwWwZWq
Yvwe1q1PG/wcA1cKAOscANbj4o3O4LjfylNIB6L+Mssxosh+e0+oobWNk/ouBa4k1c3/IzXGSCAs
hEvbI+iqkWJJKZrSb9PZk7S7XSJcScrJO/DGkQ==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DDRecdVJcCPEpbUqhuwKtKWXteF7XhGc5d+lQn2uiREzbHyuZvQ1wDwAGGrPwE75gjqc7CdHPMOY
8+3nqcEwR4Q5USgQcou3Cyc6C0TnzzDD/dLKPHDWA1s52x8Rx+LBH9WCvBpD5BKkE4o1s3rN1tL2
wTdCqzzKD8YlryKQ4U0lr2bX6Mlf4/nIt2K1eyPKbIrHIvKDThmaIF/qLnLnkE04pksWJ9Af1OVB
46iqBssrR5p6wZc241D4CqSRCRamfP/s1JrTi8bBNCcXhC0f0Aa35UAoG8vnFngHlFd3G2J88cas
Fo7UH4k1BTTfgbQ35ec0XfSbS/qQWS+EgAF+wA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
L11p2bsABDhO9HvT3IM+HulCClFvs/UPexuAVExicKtzrLN7tNvUjSouZSn9KwAjR2hg5ZIJ23uy
1elB+eyEl65vQnoH4+s6Q5K4EIcMo5WVKfIKwgu5Q3Sg/jYW+aWT/kGuc7CazRsTxJ7XPFndpMIM
cxYWx2DLps320t+Be0c=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Uublhc2r9VmPPq1tMATsd3XJltn9QRg1/PdCtSlxgFBDDAk13md52Fz+h+DOWptR3Q4i+Sx5IhIP
QIONVNTf1DnoK/wa1lkbd1dROJam8/cZQFiIxnsnSPGXzOGoc0c04xDSCJCCDxiDMF1YTtAqt6nw
yZh1RwOhPpgwUKjeJ4o4TY6/i0xuYAYVc83O6KwI9Ywk9UsfyIQQS8UXFo8zA9eniU2n2NcyAVNj
Y8xZ9PYJfzfDo6dHWsj4Ik588uhfO/bmsf2/ZuY5HCAMQpnda9XzPkVomNjRfsUghko7KipIl2ur
aHh+4i2kI/+cHaihhw3z14aGidBkuYKaopasbA==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
VYqlyQSuRywWcSrUprXX2UzoaWsJXTTbptzDY9ycgFR91H2uYfY43f80gn0E87Gvj90Qmn0Dl6ck
2VjO2Zn9yATmqtuzi/Etuf29dkl3uyKtk02OitZJEhD1CDyUJHDXKHkPMXOZCBU5CfkrIWw2SsSq
YuQKmvxp4BrhcwXypr+vRSsYd1liMxxuXOdBN5AIyzibGfcR4YUeOokIoP05xZoQOfPQkotMC1B6
SHVKEaBxe37YkyKAkQ0f9eKfnPPLG/G5qeLrFPAiIar0HHpOvdCOO69vi3RG1XqoxtTm/wGwRb5J
ZqzZyTn1Fm55PXyKhlElzXXAv1xPOTbkJXRZNQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
EktM4icAEVQRmfzXBBFeRr7d3ZTOU9f+J40sQAiff114nDU+fxlewcv+twlytUk9LMSR67RJlLt4
+ZBTwcuSPZ2Cvrommkp++7rNze0VCD8pSAdj4uo1ZnYWVWmPMQaRIqI88lnAzc5+T/LxEiXKn4ji
AYGs9fja4ME8C0CHbBsg+jfUryleVk1D8jEMCetM7qDx64s/7AGfwzDqMiW2DPCPLKNUsdlOlBYT
JAOnfy6deN7/o7BYxBsE1P4Pib1x1hvR8RwEm38pBOLKGade6KL/1SHmz5N1KGLPSXQXlK53RLTI
Exc4wN04Kg72tf503oGq6Vp90c5pksQ9cc0M+w==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qzYsaSn6YzxyfrxIwv3eyowRK7ZyzZmQHzUmV2AITf6g43c7IV/fwNBDik+XFhLScW2SxsyaGGI7
5n6kAt9uM3GerkCXA+LJQrqshcEyjuvm17vWVovBURqxhTARgZaTs5OtXdhc/wLi5e6lsdyyLtQo
bt66ubjErMgf5+tD8rpn0HkjUYmGv/MBZ0i4bGui735H12aK+wTfhGVOOiuWHCk2zCJJSx3vH4sl
dKtlpg4W0hPEM3TBPHaLnOpIDkrIUaGGN5fm6NJL6US59+Lr8/3mplbD8ld21OKzgLH+5YPRMoo4
1Pbjxkawu5Kk60AsuaR/OxngawaRMd9N4niRfQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 2592)
`pragma protect data_block
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
5RjlinGaeeOVJPiq3EWVqfBtDPQ1ezHl+m9B
`pragma protect end_protected
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2020.1"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
EJFZwtxl4g9/OL6+bopUV8BP4e67HNukCIy7Ih3E75y7soa6GhqEucPXMiOy+mJrcrNwD+HjZ0/I
BwEKIiA4mA==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
rZCGWdmPJXoOuANoS8fyUXk7SyF+uTNJL18BfeKc+fxcyRrCB++WrM02adxoUdICz4/92yY8TQgj
xyPC0eaHZcjSLepbnHHgSReIQ1PL0hmufLbye7QTD0ygUXC4MvFVY8s3KeW9cPCqOxkyCSziJQzs
J5OT9XLQno1e9rIBr9M=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
I7Zo4frj3tO6FFzeDhpSENS0yd34dQZBtiyIrI/GMASFBUeny6muOD2l0HK69ImRJIOyobvK1+9O
DhxptAc4NzRpY4xUZvr4ix1AhM1Kars1OkrQCWz4a7ciGU/XDblidF3IL0Fa7c41gHIZR9c/Usa6
XL7UEu3aSPQYbZLSDOzeao4VtSSn+dCcjsH4X8zVjSqXg8dcN3fd5C15JaMYg00F2yOFtxwWwZWq
Yvwe1q1PG/wcA1cKAOscANbj4o3O4LjfylNIB6L+Mssxosh+e0+oobWNk/ouBa4k1c3/IzXGSCAs
hEvbI+iqkWJJKZrSb9PZk7S7XSJcScrJO/DGkQ==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
DDRecdVJcCPEpbUqhuwKtKWXteF7XhGc5d+lQn2uiREzbHyuZvQ1wDwAGGrPwE75gjqc7CdHPMOY
8+3nqcEwR4Q5USgQcou3Cyc6C0TnzzDD/dLKPHDWA1s52x8Rx+LBH9WCvBpD5BKkE4o1s3rN1tL2
wTdCqzzKD8YlryKQ4U0lr2bX6Mlf4/nIt2K1eyPKbIrHIvKDThmaIF/qLnLnkE04pksWJ9Af1OVB
46iqBssrR5p6wZc241D4CqSRCRamfP/s1JrTi8bBNCcXhC0f0Aa35UAoG8vnFngHlFd3G2J88cas
Fo7UH4k1BTTfgbQ35ec0XfSbS/qQWS+EgAF+wA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
L11p2bsABDhO9HvT3IM+HulCClFvs/UPexuAVExicKtzrLN7tNvUjSouZSn9KwAjR2hg5ZIJ23uy
1elB+eyEl65vQnoH4+s6Q5K4EIcMo5WVKfIKwgu5Q3Sg/jYW+aWT/kGuc7CazRsTxJ7XPFndpMIM
cxYWx2DLps320t+Be0c=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Uublhc2r9VmPPq1tMATsd3XJltn9QRg1/PdCtSlxgFBDDAk13md52Fz+h+DOWptR3Q4i+Sx5IhIP
QIONVNTf1DnoK/wa1lkbd1dROJam8/cZQFiIxnsnSPGXzOGoc0c04xDSCJCCDxiDMF1YTtAqt6nw
yZh1RwOhPpgwUKjeJ4o4TY6/i0xuYAYVc83O6KwI9Ywk9UsfyIQQS8UXFo8zA9eniU2n2NcyAVNj
Y8xZ9PYJfzfDo6dHWsj4Ik588uhfO/bmsf2/ZuY5HCAMQpnda9XzPkVomNjRfsUghko7KipIl2ur
aHh+4i2kI/+cHaihhw3z14aGidBkuYKaopasbA==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
VYqlyQSuRywWcSrUprXX2UzoaWsJXTTbptzDY9ycgFR91H2uYfY43f80gn0E87Gvj90Qmn0Dl6ck
2VjO2Zn9yATmqtuzi/Etuf29dkl3uyKtk02OitZJEhD1CDyUJHDXKHkPMXOZCBU5CfkrIWw2SsSq
YuQKmvxp4BrhcwXypr+vRSsYd1liMxxuXOdBN5AIyzibGfcR4YUeOokIoP05xZoQOfPQkotMC1B6
SHVKEaBxe37YkyKAkQ0f9eKfnPPLG/G5qeLrFPAiIar0HHpOvdCOO69vi3RG1XqoxtTm/wGwRb5J
ZqzZyTn1Fm55PXyKhlElzXXAv1xPOTbkJXRZNQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2019_11", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
EktM4icAEVQRmfzXBBFeRr7d3ZTOU9f+J40sQAiff114nDU+fxlewcv+twlytUk9LMSR67RJlLt4
+ZBTwcuSPZ2Cvrommkp++7rNze0VCD8pSAdj4uo1ZnYWVWmPMQaRIqI88lnAzc5+T/LxEiXKn4ji
AYGs9fja4ME8C0CHbBsg+jfUryleVk1D8jEMCetM7qDx64s/7AGfwzDqMiW2DPCPLKNUsdlOlBYT
JAOnfy6deN7/o7BYxBsE1P4Pib1x1hvR8RwEm38pBOLKGade6KL/1SHmz5N1KGLPSXQXlK53RLTI
Exc4wN04Kg72tf503oGq6Vp90c5pksQ9cc0M+w==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
qzYsaSn6YzxyfrxIwv3eyowRK7ZyzZmQHzUmV2AITf6g43c7IV/fwNBDik+XFhLScW2SxsyaGGI7
5n6kAt9uM3GerkCXA+LJQrqshcEyjuvm17vWVovBURqxhTARgZaTs5OtXdhc/wLi5e6lsdyyLtQo
bt66ubjErMgf5+tD8rpn0HkjUYmGv/MBZ0i4bGui735H12aK+wTfhGVOOiuWHCk2zCJJSx3vH4sl
dKtlpg4W0hPEM3TBPHaLnOpIDkrIUaGGN5fm6NJL6US59+Lr8/3mplbD8ld21OKzgLH+5YPRMoo4
1Pbjxkawu5Kk60AsuaR/OxngawaRMd9N4niRfQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
SEyQMircLikWOrBpNrRlnbQbEeOTZepxASiJ+E/OrR1sf1wqEKSk1cXSr3w7tnvmZX5flIWM0i0k
POElUd6jzt/aSLbEkqJiUyonUJPvheus2W+ciZDGd4NVGZ9S33sw6Ut8bWGEGzBo2SMgNvdvEo0Z
gs2zWynt6OQkwdS9Z+bYrLracXSdI7PRmOnjXGGevOmIjUAURiAcfhGHgCdp1qukwTCt5AVm1OLI
nwK+CtwDtjEvvQOMVUa2fgwwHVln+OhRSPLoYzJbDy0JJo2s/BJ0Twj45sOjm4pbMafpy91BeDdB
DYaExKYW5M+GYFeyE80tuURjURW0HTCVmxxAjQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
VQtFP+kwcJduk6/GMSaGZ1UEKS2mxgJDqvDava80dSO7XuAY3AW9zUkqtU4avU9vUiVkQBnM0FAy
eXR1seyKhNB4SfCLjjMjd4aMaSuRBkkmpvEGN+QJJaiI1yChKp3ZzDtoiDaY2INe0uuP6Kpl8MJ7
D3wN4nKrWUjUTQL/cx0u9YyWlkzB60DjbfU6VHd35S/LXWxkFPU8qe7PPwKqaHSVbF6mZtABdO98
h3CjQc0Zn5ExBNHqLdR/kkSqlzhZxu6vJRpYxck/DonWV80y+UJGtgX/WCS+bdUZ5oNGh6DARWmd
zrrGaXK1dNX8Ik3cB2ICsW63tXH6BYNa1xMz9g==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 8576)
`pragma protect data_block
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
5KMmYIOAPJ2xUOT3U7VbCY5vaJZLJjA2FFo=
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
