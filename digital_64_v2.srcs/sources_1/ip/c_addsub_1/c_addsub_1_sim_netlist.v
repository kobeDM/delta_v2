// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Tue Jan 12 17:39:03 2021
// Host        : LAPTOP-ER3N32PK running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/higas/study/DM/FW/trig/digital_64_v17_2020_03_05/digital_64_v2.srcs/sources_1/ip/c_addsub_1/c_addsub_1_sim_netlist.v
// Design      : c_addsub_1
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a200tffg1156-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "c_addsub_1,c_addsub_v12_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "c_addsub_v12_0_14,Vivado 2020.1" *) 
(* NotValidForBitStream *)
module c_addsub_1
   (A,
    B,
    CLK,
    S);
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [12:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [12:0]B;
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF s_intf:c_out_intf:sinit_intf:sset_intf:bypass_intf:c_in_intf:add_intf:b_intf:a_intf, ASSOCIATED_RESET SCLR, ASSOCIATED_CLKEN CE, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 s_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME s_intf, LAYERED_METADATA undef" *) output [12:0]S;

  wire [12:0]A;
  wire [12:0]B;
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
  (* c_has_bypass = "0" *) 
  (* c_has_c_in = "0" *) 
  (* c_has_c_out = "0" *) 
  (* c_latency = "1" *) 
  (* c_out_width = "13" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  c_addsub_1_c_addsub_v12_0_14 U0
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
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 2624)
`pragma protect data_block
Di0UeH3NNEdcXIj3Nu8DCCGGJVExJ6T6+RCbMHdegOrn/LXpzBPbRTz9c2nYj30yyqmPaxqGP50O
wxHxm5Pnw3fbjI7iPvnbaudPnx7ntqxeyIkdEYs56+huSLtuov4OO1ESUc+dWbmavAH52/s3XplZ
w0W6JDJ1gYCzvfklLmR2OCJL8LYEmgOqW2PEDXSFdVISXxYfDgNKNCx4mHc8ywFBsw3dl4IL0N9n
D4gueHpztpXWZgA5aeV8JPp86+xUA3g8b1NhAqy3PYtBZSGpiIW3Et5mPO0fBZJNtD9oBeAWf1CE
rJgtCG7zPlKvlyG6RyOtoj1EVs8V1H+uKtX5bM4EU0sF8t6Fy0rtqfkDweulYfqxPRNs63lFlYLY
6ZamPzMgmMQW+n1WSUrLCX7Bb2AQo6m70sKhQ2G/1koxODRR611HD+jXG0UHMB1qxxVSwJFNOJeo
2VJO7p2UJFkn82tTsz6uu96//a41jOHo3frMXYo83phdsSrOuuVxDYU16rOAHy/ExlWKGQR41FSq
Lc1dNa8Ui7bMKjjzXiuBFCifLZtgQ9R4AwRJ3fJHatM3gCG7OzNb3ISBFS3iF8vhjUfAeuWOJ9wa
/Eym/MD0vu1s5yD8ZgaZ5XbzFmaOJcVscpuJBlxTrn2C25mEcZM9xDqn/I7vN/RPIShAEXjScrXn
VbQBv8IBDkahkqlXfHzrwWTWg3hWFnN/yrNTjsXyoTmbHsc027G7ToUebu12lXdnF1ULTclyV4jU
jIoe3/15X2GQNCkX3mX3ZPUi2P0jmG16yPuBhmbiYI4fur9MPaLtK6wEB9r7cdz4PhMFcwSKREYl
6DGHHn5IH5KwhpRNrym0b44eUTCdcMRxzDJmg9fO0PfuJtRLGijlNQKMdACT3OXoIrH0GBuTDKsK
yMmuxTlwXWd5Nu5So2lCWGKKDAO9iU+b+2zFuxMp2rbF605qD+/kjXQ0o8q/giCYaTraw80JhqW2
kWFNAoaMtTfF1nZhPH0L8pSSWd5lLt2Dk6r641WWhIGb6mubHYPydPLAFEHz598jAe6WwVgqSZPL
AYAfpoSxKUpUPBJhBEeEg2fDSkWNyu/l0hh0sS0mlVTG9oEQMMc39MC8aUg/PudPDyxIJFN5cBC5
2q441f5Xdyn4zH+Haeiuz7rMwhqh8Wb5Cs52Z8/1qMVAvocwaF7vQzvdyczF0SovmInGv2JbOrEX
WUnR1gJ30MdL0CCKANBqc5BpC8w7XQiuPgIkhLijYvwx8zCtsER/l0zmMEJmi2Cn+jvA4D+aI80J
Xj4BQJ7d9fp11NrMsEQADJVoxzhJBsDAFOx1dwAyxVwPJ5VdVBO3EBhE1P6FwGT53RmuDDeeBK1p
vHTOOZjHT1aZ14vqAYlqMkrcfa9Fo1MUfy51geJvomRWLUKrei2oKPYgwILqHtAFWmA7t4EOL/VD
xCoe5f5uMR/U56g1xIEFvKf1DQ5vhpUBRwTdEj375YxOBqFE0b1FISs5+q1w4GaXlhCByc+DICPJ
id1+XrEproUu9ff/ziOPP4bK4o/xRlFijG1O2EQ5n0DjXq0j5zxGPUXB3RMvy3IIkyU499fBnZgu
PfDCvW+kT4C5A2I6aNzJAGEYUr8uqvEEFmDezhndeRn0nZALyVCjNygYUY7b4AOidxCLyIoao6jZ
YLpZMDmns3scrb1+RUAvPC/x/0KUDUVmrJ8ubwOis3qArvDU5ARH2utbRiajhQmIGCRz8eEFK40u
+djBwr4nyfudPtoVcOUDRlDV1SwbUrmgmC+5axw8Phs9tN8zv4NW4FvM/xKdLwOQTpKTkyrATGzn
dcBYwgQRDAEnsGkOSIUE3mU34LQ65oAFuaKEeToweJXUAsnSAyFchU+yeDA9gg8x8ZQmtrYg4IIp
PYquUl+GbZ350YQebP1Y+/ucExa3X2NBmtFC7aB7BHGoTHKEmBj1vP0lnzP3e31fnKT5NxmWAv+K
WHX3jU8NHfxurme7/PSzBO/M7Rgks0Lc0Mld2S/vvLK5E+lSf8rW/pC0As+JBXoT9dyWf0lKxPJW
a0M5/7gsT4cfrc1GEShJnNPn1XO9H0jMXDAojppjTrCLaBG7fTpSB6NtcBbg951jJRc1TpOuXo3W
M/FAwaqEctFPT7NgpH8rtdgxMIRQIb/cxEB53XbXbxmKtx80NlLdrW+vS5SZ7dGdIPyxgGer/2e4
OBcGXe7y6LIjAXXFopUhzO6OMWch6pwp6YGY8M7B7GZ/JyMMur0d6KteM7BpmpIDSs7qBLtAyoat
C6nJnMX26Afckmr5WXM6WPTdRSvrujXrsUKhPk+wioRpKbOfu9YYPv9pwzKgj2y3Qak6XqyB5Aqf
KPH7fkWXI2SouVXCwjQbDzoEQc4WhL/ep5fLjVt05tFAMt+Dj8ho8wDAPn33CTQdj7yqq7Vxc2/E
s5BKdSdTvMVgdiazbWHJY9/TtNa0Z0IacC+IXFxE6k0B/6+uvTyl9dycU1nmElo21Py5wp1scnPy
puZ7M+cHDMNHR5up0FJYIbCf9w9d1Esx8EMeWOqrWK36b41Bn2LJVIgzhRQ+WQOnDWXG8YeWmQ9N
7ADQrTe8vPVVnl0n1xkC+bq0NGDtM+rH/viX933rb3TCThoSbRXdr5jxFBM8m7jAHUYzn6bw5ZCp
mQ7GjP/YVUdCpGNL6YJUaUn6xOrddz+Q5hJ/iHNDTwV2kVAtdX47EMY8xZ7Lu68S897RdA3pw/Vn
o9HAyiR7ynKAA+MOjGTdFtx8ifkzD/SSyP60MPVMQhzloPJFJvOrMxb4uCsiNrh5Zmc0aXggYsIA
5cDdbGojxOHa/8jarUpnXXesojtFE5I1fY4skhwDCk22j0R6hySqhOeO3PANTeaks9pPsNZ4i0SZ
jXYwQ+7odP7M5szQfrnPmMpLZCmQZV/amxT7bLRwXBx0gGBlacAMqaVhg6cwB7J7zxbh4VmP+qOL
1BRoOgEE81KpOyokibt06gLYAepUHrnBjlG2FMBNFPel1yvX/jQ+SD60IGPGVUWDsANiWiX3/pbw
WmPKP1e2hAe0EfYIYXSEkwBcuRFtgJYD0lhNA5E089tIsoZGXaJJm08PrH4CnATKfN6SBGFVU0Xi
KZLqCI6dzER2h8VGQabfe2ndlNxiRVbrog57J412OgyTGNMqs8HSxetmDApABdMll5tOeSBEtPTY
hahXbXGxaw+4btRQdlHHiAOqEINQOBOwUJcxuY+QnvqNnR6x0HnVbS3cKZTg+EOQxIyL1m65doGE
f9g4gnYEuJsLmMrnlwzMyEK6SmMyOxPfJJem0lngaQcgGOA0iDP6fX9oVO5EfkWJ8MDrXy3ArUg+
JISA0x7kEP0lD3+0ekfSI5Bn7o1eD4rbOfih66J7swMXbiKFNX2/ZiharjOYKQB2/WSsPiduJPvo
PMVuODlLsSnPznkLCShoot0DGZJFkOBvLToaht/nltXEiFQgWgWX2Awgtwr1pu4VhquR6zR0HAN0
jSg=
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
LG0gdaZfizojnmsc+0rPOM+RM0R5jsFZJHygTDZnIlhldbUIJI27hOgpul7od0NZRscXIkJEHSFB
EFXNJeidv0/eUkN3f+rfacS6EiPJh2hbsRvQuwvwZRIZ3PMZsWKEEOordRa0y34eabLAaGcBjivj
lGX1s8SSvYm2lq0kZAXhOoySF+/Nff0UjJh8GYRpcUHo55df604wAUDOV+0nC2NQMiiDJcBB+GQx
ZteLsn7VZgqEnP1E6OkoavQIQYi0d8BBazj55SdaMbS0sbSZ97vER1yfS0kFzMk955LrdF4/IGHu
HXm2crySAfD2o+BP8x8CzBeJZM/5xF9DZ1otOg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Sp/hCB6bo2m/OkcVPJgPR5YSrlzKgshW+wIpLBMPcKgOMFLna97UcXQETKvyI3tuEUfjguVwClrW
vPlCw7c77mVhlyHB8gIUX1ADupkPzLqu9xvqTtT7F07c/HCSe1WVromDlKRifin+z6oryX9O5vvH
rugjfqmq0OCPrE8BgEE5nPDvPjaeQuGF8Z72x23O86waRlXD+pMFgiU/7E+4kvb+63vDcEfRBcvf
rWy/eie06WXfAv3vxBFXOIZw71icvNqfBuPIlrhWfW2WrgEaCUV0yB2x+1hJ8qHrIBoHVDmqIuRM
faz9c2fDOiAP1efKAh6su1AwPkZJfcHEqZZjSA==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11024)
`pragma protect data_block
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
g2p5dSVDWY1P8mXHQxtc2M7uIdbx6dM=
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
