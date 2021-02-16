// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Tue Jan 12 17:39:03 2021
// Host        : LAPTOP-ER3N32PK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/higas/study/DM/FW/trig/digital_64_v17_2020_03_05/digital_64_v2.srcs/sources_1/ip/c_addsub_0/c_addsub_0_sim_netlist.v
// Design      : c_addsub_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tffg1156-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "c_addsub_0,c_addsub_v12_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_14,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module c_addsub_0
   (A,
    B,
    CLK,
    BYPASS,
    S);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [12:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [12:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF s_intf:c_out_intf:sinit_intf:sset_intf:bypass_intf:c_in_intf:add_intf:b_intf:a_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 bypass_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME bypass_intf, LAYERED_METADATA undef" *) input BYPASS;
  (* x_interface_info = "xilinx.com:signal:data:1.0 s_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME s_intf, LAYERED_METADATA undef" *) output [12:0]S;

  wire [12:0]A;
  wire [12:0]B;
  wire BYPASS;
  wire CLK;
  wire [12:0]S;
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
  (* c_a_width = "13" *) 
  (* c_add_mode = "1" *) 
  (* c_b_constant = "0" *) 
  (* c_b_type = "0" *) 
  (* c_b_value = "0000000000000" *) 
  (* c_b_width = "13" *) 
  (* c_bypass_low = "0" *) 
  (* c_has_bypass = "1" *) 
  (* c_has_c_in = "0" *) 
  (* c_has_c_out = "0" *) 
  (* c_latency = "1" *) 
  (* c_out_width = "13" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  c_addsub_0_c_addsub_v12_0_14 U0
       (.A(A),
        .ADD(1'b1),
        .B(B),
        .BYPASS(BYPASS),
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 2640)
`pragma protect data_block
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
n/aZ20cWLNNCbSu2P1elaKeT
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
juv0gQ7YFEcH01IdhzhtNf3UeyxME/zoL92CtK0SR0TkbHvYpdbi0jswAl8CcL3/9UEbyjOdlSlR
UJdPui5Njn8VtqT92J35g9wkyS/AiEtBQFnnPWoU/+vOaCaVfVup+aQ2vAGyR2a1qfnlbcnT5KIp
Qc3yZhxIZWjllcngyDalaBYJOZzBJ1OuG7bkyd8tCuEWaRhEodfcnqM9/MeBEnz1H6cdSx18JB51
YQBlde+gMSGV2GIZFlooRKyC0tw8pakEZWHR5UVPx+4Et5i5b28AxONO42edcNzJpD9lrkTGN/om
Xf5D+UoWItBivoz4jGnvonZmOWul2WMX3QrjSQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
KdIA4rBWKkZCm7/1+EDv27ocyCRZP34JPk4NNrytF5v1d+XfQkLxkuRUsZXej0ZFKLsSQ4wZ5kfk
NXBKiS64JbDEgBM2wAO7WPGji7SKcn6i24YUe6iZWXTbGWUcO7uHkgIAD15r8s3LFhKQ19z6dVBN
ptsQx/qMBDyFj1+SZ1DkKINXaoJJnj5rSrx++FvTdbo358m/b2Nke4228q3k7BdjjK42uKWQaoy1
1eqHU7yPHBCrJGZxws6NHSqe6VFidn7a0TvtcfadxEahjR0RmjDCVSb0qXXaBGiWCeC7SyRrYb09
KSjKiXF6RdQbv15DNURWLe/gtwLw6sYmHQyZeg==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 15488)
`pragma protect data_block
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
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
