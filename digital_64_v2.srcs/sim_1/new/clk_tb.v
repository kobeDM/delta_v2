`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/01/12 14:55:08
// Design Name: 
// Module Name: clk_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_tb;

	reg			OSC50M			;

	reg		    EEPROM_DO		;

	reg			ETH_TX_CLK		;

	reg			ETH_RX_CLK		;
	reg			ETH_RX_DV		;
	reg	[7:0]	ETH_RXD			;
	reg			ETH_RX_ER		;
	reg			ETH_CRS			;
	reg			ETH_COL			;
//	reg			ETH_MDIO		;

    reg	[63:0]	ADC_D_P			;
	reg	[63:0]	ADC_D_N			;

	reg	[8:1]	ADC_DCO_P		;
	reg	[8:1]	ADC_DCO_N		;
	reg	[8:1]	ADC_FCO_P		;
	reg	[8:1]	ADC_FCO_N		;

//	reg	[8:1]	ADC_SDIO		;

    reg         DAC_SDO         ;
    reg         DAC_STRO        ;

	reg	[4:1]	NIM_INn			;

	reg	[3:0]	DIP_SW			;

    wire[3:0]  X_LED            ;
    
    wire DAC_STRI ; //a
    wire DAC_SDI ; //a
    
    

ADC_SiTCP_V20 uut(
    .OSC50M(OSC50M),
    .EEPROM_DO(EEPROM_DO),
    .ETH_RSTn(ETH_RSTn),
    .ETH_TX_CLK(ETH_TX_CLK),
    .ETH_RX_CLK(ETH_RX_CLK),
    .ETH_RX_DV(ETH_RX_DV),
    .ETH_RXD(ETH_RXD),
    .ETH_RX_ER(ETH_RX_ER),
    .ETH_CRS(ETH_CRS),
    .ETH_COL(ETH_COL),
//    .ETH_MDIO(ETH_MDIO),
    .NIM_INn(NIM_INn),
    .DIP_SW(DIP_SW),
    .ADC_D_P(ADC_D_P),
    .ADC_D_N(ADC_D_N),
    .ADC_DCO_P(ADC_DCO_P),
    .ADC_DCO_N(ADC_DCO_N),
    .ADC_FCO_P(ADC_FCO_P),
    .ADC_FCO_N(ADC_FCO_N),
 //   .ADC_SDIO(ADC_SDIO),
    .DAC_SDO(DAC_SDO),
    .DAC_STRO(DAC_STRO),
    .X_LED(X_LED),
    .DAC_STRI(DAC_STRI),
    .DAC_SDI(DAC_SDI)
    
    
);

    parameter STEP=20;
    always #(STEP/2)
    OSC50M = ~OSC50M;
    initial OSC50M=0;

    initial begin
    EEPROM_DO=0		;
    ETH_TX_CLK=0        ;
    ETH_RX_CLK=0       ;
    ETH_RX_DV=0        ;
    ETH_RXD[7:0]=0            ;
    ETH_RX_ER=0        ;
    ETH_CRS=0            ;
    ETH_COL=0            ;
 //   ETH_MDIO=0        ;
    ADC_D_P[63:0]=0          ;
    ADC_D_N[63:0]=0                ;
    ADC_DCO_P[8:1]=0       ;
    ADC_DCO_N[8:1]=0            ;
    ADC_FCO_P[8:1]=0       ;
    ADC_FCO_N[8:1]=0            ;
 //   ADC_SDIO[8:1]=0            ;
    DAC_SDO=0 ;
    DAC_STRO=0    ;
    NIM_INn[4:1]=0                ;
    DIP_SW[3:0]=0                ;
    
  
    
     end



endmodule
