/*******************************************************************************
*                                                                              *
* System      : BELLE-II CDC readout module                                    *
* Module      : LOC_REG                                                        *
* Version     : v 3.2.0 2011/04/04                                             *
*                                                                              *
* Description : Slow control; registers, ADC controls, DAC controls            *
*                                                                              *
* Designer    : Tomohisa Uchida                                                *
*                                                                              *
*                Copyright (c) 2011 Tomohisa Uchida                            *
*                All rights reserved                                           *
*                                                                              *
*******************************************************************************/

`define SYN_DATE	32'h2003_0501
`define FPGA_VER	8'h01


module LOC_REG(
	CLK					,	// in	: Clock
	RST					,	// in	: System reset
	TIM_1US				,	// in	: Timer 1us
	TIM_1MS             ,
	// ADC I/F
	ADC_SCLK			,	// out	: SPI clock[2:1]
	ADC_CSB				,	// out	: SPI Chip enable
	ADC_SDIO_IN			,	// out	: SPI data input[2:1]
	ADC_SDIO_OUT		,	// out	: SPI data output
	ADC_SDIO_EN			,	// out	: SPI data direction
	// DAC I/F
	DAC_CLKI			    ,   // DAC Data
	DAC_SDI			,   // DAC CLOCK 
	DAC_STRI			,   // DAC SYNC
	NIM_OUT             ,
	//TEST ON/OFF
	TEST_SW             ,
 	// Register I/F
	LOC_ADDR			,	// in	: Address[31:0]
	LOC_WD				,	// in	: Data[7:0]
	LOC_WE				,	// in	: Write enable
	LOC_RE				,	// in	: Read enable
	LOC_ACK				,	// out	: Access acknowledge
	LOC_RD				,	// out	: Read data[7:0]
	// Registers
	REG_STATUS0			,   // in   : STATUS0
	REG_TRG_STATUS		,	// in	: Trigger status[15:0]
	REG_MODE				,	// out	: Processing mode[1:0]
	REG_WINDOW			,	// out	: Window size[15:0]  ÉÅÉÇÉäÇÃä÷åWÇ©ÇÁ0Å`4000Ç…ê›íË
	REG_DELAY			,	// out	: Delay time[15:0]  ÉÅÉÇÉäÇÃä÷åWÇ©ÇÁ0Å`4000Ç…ê›íË
	REG_LEN				,	// out	: Data length[15:0] REG_WINDOWÇ∆ìØÇ∂
	REG_0AX				,	// out	: 
	REG_0BX				,	// out	: 
	REG_0CX				,	// out	: 
	REG_0DX				,	// out	: 
	// Pedestal for ADC sum calculation
	REG_ADC_TH			,	// out	: 
	REG_ADC_PDSTL			// out	: Pedestal[479:0]
);

//-------- Input/Output -------------
	input			CLK				;
	input			RST				;
	input			TIM_1US			;
    input           TIM_1MS         ;
/*
	output	[2:1]	ADC_SCLK		;
	output	[2:1]	ADC_CSB			;
	input	[2:1]	ADC_SDIO_IN		;
*/
	output	[8:1]	ADC_SCLK		;
	output	[8:1]	ADC_CSB			;
	input	[8:1]	ADC_SDIO_IN		;
	output			ADC_SDIO_OUT	;
	output			ADC_SDIO_EN		;

	
	output			DAC_CLKI	    ;
	output			DAC_SDI		    ;
	output			DAC_STRI		;
	output          NIM_OUT         ;
	
	output          TEST_SW         ;

	input	[31:0]LOC_ADDR			;
	input	[7:0]	LOC_WD			;
	input			LOC_WE			;
	input			LOC_RE			;
	output			LOC_ACK			;
	output	[7:0]	LOC_RD			;

    input 	[7:0]	REG_STATUS0		;
    input	[15:0]REG_TRG_STATUS	;
	output	[1:0]	REG_MODE			;
	output  [15:0]	REG_WINDOW		;
	output	[15:0]	REG_LEN			;
	output   [15:0]	REG_DELAY		;
	output   [7:0]	REG_0AX			;
	output   [7:0]	REG_0BX			;
	output   [7:0]	REG_0CX			;
	output   [7:0]	REG_0DX			;

	output	[9:0]	REG_ADC_TH		;
	output	[479:0]	REG_ADC_PDSTL	;

//---------- Buffer ----------
	wire	[9:0]	REG_ADC_TH		;
	wire	[479:0]	REG_ADC_PDSTL	;
	wire	[1:0]	REG_MODE		;

	wire			REG_ACK			;
	wire			REG_RV			;
	wire	[7:0]	REG_RD			;

//------------------------------------------------------------------------------
//	Input buffer
//------------------------------------------------------------------------------
	reg		[7:0]	regCs			;
	reg				adcCs			;
	reg		[10:0]irAddr		;
	reg				irWe			;
	reg				irRe			;
	reg		[7:0]	irWd			;

	always@ (posedge CLK) begin
		regCs[0]	<= (LOC_ADDR[31:4]==28'h0);
		regCs[1]	<= (LOC_ADDR[31:4]==28'h1);
		regCs[2]	<= (LOC_ADDR[31:4]==28'h2);
		regCs[3]	<= (LOC_ADDR[31:4]==28'h3);
		regCs[4]	<= (LOC_ADDR[31:4]==28'h4);
		regCs[5]	<= (LOC_ADDR[31:4]==28'h5);
		regCs[6]	<= (LOC_ADDR[31:4]==28'h6);
		regCs[7]	<= (LOC_ADDR[31:4]==28'h7);
		adcCs		<= (LOC_ADDR[31:8]==24'h1);

		irAddr[10:0]	<= LOC_ADDR[10:0];
		irWe			<= LOC_WE;
		irRe			<= LOC_RE;
		irWd[7:0]		<= LOC_WD[7:0];
	end

//------------------------------------------------------------------------------
//	Receive
//------------------------------------------------------------------------------

//	reg		[7:0]	x00_Reg			;
//	reg		[7:0]	x01_Reg			;
//	reg		[7:0]	x02_Reg			;
//	reg		[7:0]	x03_Reg			;
//	reg		[7:0]	x04_Reg			;
	reg		[1:0]	x05_Reg			;
	reg		[7:0]	x06_Reg			;
	reg		[7:0]	x07_Reg			;
	reg		[7:0]	x08_Reg			;
	reg		[7:0]	x09_Reg			;
	reg		[7:0]	x0A_Reg			;
	reg		[7:0]	x0B_Reg			;
	reg		[7:0]	x0C_Reg			;
	reg		[7:0]	x0D_Reg			;
//	reg		[7:0]	x0E_Reg			;
//	reg		[7:0]	x0F_Reg			;

	reg		[7:0]	x10_Reg			;

    reg     [7:0]   x1B_Reg         ;
	reg		[7:0]	x1C_Reg			;
	reg		[7:0]	x1D_Reg			;
	reg		[7:0]	x1E_Reg			;	

	reg		[1:0]	x20_Reg			;	// Pedestal for ADC sum calculation
	reg		[7:0]	x21_Reg			;
	reg		[1:0]	x22_Reg			;
	reg		[7:0]	x23_Reg			;
	reg		[1:0]	x24_Reg			;
	reg		[7:0]	x25_Reg			;
	reg		[1:0]	x26_Reg			;
	reg		[7:0]	x27_Reg			;
	reg		[1:0]	x28_Reg			;
	reg		[7:0]	x29_Reg			;
	reg		[1:0]	x2A_Reg			;
	reg		[7:0]	x2B_Reg			;
	reg		[1:0]	x2C_Reg			;
	reg		[7:0]	x2D_Reg			;
	reg		[1:0]	x2E_Reg			;
	reg		[7:0]	x2F_Reg			;

	reg		[1:0]	x30_Reg			;
	reg		[7:0]	x31_Reg			;
	reg		[1:0]	x32_Reg			;
	reg		[7:0]	x33_Reg			;
	reg		[1:0]	x34_Reg			;
	reg		[7:0]	x35_Reg			;
	reg		[1:0]	x36_Reg			;
	reg		[7:0]	x37_Reg			;
	reg		[1:0]	x38_Reg			;
	reg		[7:0]	x39_Reg			;
	reg		[1:0]	x3A_Reg			;
	reg		[7:0]	x3B_Reg			;
	reg		[1:0]	x3C_Reg			;
	reg		[7:0]	x3D_Reg			;
	reg		[1:0]	x3E_Reg			;
	reg		[7:0]	x3F_Reg			;

	reg		[1:0]	x40_Reg			;
	reg		[7:0]	x41_Reg			;
	reg		[1:0]	x42_Reg			;
	reg		[7:0]	x43_Reg			;
	reg		[1:0]	x44_Reg			;
	reg		[7:0]	x45_Reg			;
	reg		[1:0]	x46_Reg			;
	reg		[7:0]	x47_Reg			;
	reg		[1:0]	x48_Reg			;
	reg		[7:0]	x49_Reg			;
	reg		[1:0]	x4A_Reg			;
	reg		[7:0]	x4B_Reg			;
	reg		[1:0]	x4C_Reg			;
	reg		[7:0]	x4D_Reg			;
	reg		[1:0]	x4E_Reg			;
	reg		[7:0]	x4F_Reg			;

	reg		[1:0]	x50_Reg			;
	reg		[7:0]	x51_Reg			;
	reg		[1:0]	x52_Reg			;
	reg		[7:0]	x53_Reg			;
	reg		[1:0]	x54_Reg			;
	reg		[7:0]	x55_Reg			;
	reg		[1:0]	x56_Reg			;
	reg		[7:0]	x57_Reg			;
	reg		[1:0]	x58_Reg			;
	reg		[7:0]	x59_Reg			;
	reg		[1:0]	x5A_Reg			;
	reg		[7:0]	x5B_Reg			;
	reg		[1:0]	x5C_Reg			;
	reg		[7:0]	x5D_Reg			;
	reg		[1:0]	x5E_Reg			;
	reg		[7:0]	x5F_Reg			;

	reg		[1:0]	x60_Reg			;
	reg		[7:0]	x61_Reg			;
	reg		[1:0]	x62_Reg			;
	reg		[7:0]	x63_Reg			;
	reg		[1:0]	x64_Reg			;
	reg		[7:0]	x65_Reg			;
	reg		[1:0]	x66_Reg			;
	reg		[7:0]	x67_Reg			;
	reg		[1:0]	x68_Reg			;
	reg		[7:0]	x69_Reg			;
	reg		[1:0]	x6A_Reg			;
	reg		[7:0]	x6B_Reg			;
	reg		[1:0]	x6C_Reg			;
	reg		[7:0]	x6D_Reg			;
	reg		[1:0]	x6E_Reg			;
	reg		[7:0]	x6F_Reg			;

	reg		[1:0]	x70_Reg			;
	reg		[7:0]	x71_Reg			;
	reg		[1:0]	x72_Reg			;
	reg		[7:0]	x73_Reg			;
	reg		[1:0]	x74_Reg			;
	reg		[7:0]	x75_Reg			;
	reg		[1:0]	x76_Reg			;
	reg		[7:0]	x77_Reg			;
	reg		[1:0]	x78_Reg			;
	reg		[7:0]	x79_Reg			;
	reg		[1:0]	x7A_Reg			;
	reg		[7:0]	x7B_Reg			;
	reg		[1:0]	x7C_Reg			;
	reg		[7:0]	x7D_Reg			;
	reg		[1:0]	x7E_Reg			;
	reg		[7:0]	x7F_Reg			;

	always@ (posedge CLK or posedge RST) begin
		if(RST)begin
//			x00_Reg[7:0]	<= 8'd0;
//			x01_Reg[7:0]	<= 8'd0;
//			x02_Reg[7:0]	<= 8'd0;
//			x03_Reg[7:0]	<= 8'd0;
//			x04_Reg[7:0]	<= 8'd0;
			x05_Reg[1:0]	<= 2'b01;  	// MODE
			x06_Reg[7:0]	<= 8'h0f;	// Window size[15:8]
			x07_Reg[7:0]	<= 8'ha0;	// Window size[7:0]
			x08_Reg[7:0]	<= 8'h00;	// DELAY[15:8]
			x09_Reg[7:0]	<= 8'h00;	// DELAY[7:0]
			x0A_Reg[7:0]	<= 8'h01;	// Packet Header ID
			x0B_Reg[7:0]	<= 8'h23;	// Packet Header ID
			x0C_Reg[7:0]	<= 8'h45;	// Packet Header ID
			x0D_Reg[7:0]	<= 8'h08;   // Tinning adc data
//			x0E_Reg[7:0]	<= 8'h23;	// Trg monitor
//			x0F_Reg[7:0]	<= 8'h45;	// Trg Monitor

			x10_Reg[7:0]	<= 8'h80;	// ADC

			x1B_Reg[7:0]	<= 8'h00;   // DAC
			x1C_Reg[7:0]	<= 8'h00;	// DAC
			x1D_Reg[7:0]	<= 8'h00;	// DAC
			x1E_Reg[7:0]	<= 8'h00;	// test on/off
			
			x20_Reg[1:0]	<= 2'h0;
			x21_Reg[7:0]	<= 8'h00;
			x22_Reg[1:0]	<= 2'h0;
			x23_Reg[7:0]	<= 8'h00;
			x24_Reg[1:0]	<= 2'h0;
			x25_Reg[7:0]	<= 8'h00;
			x26_Reg[1:0]	<= 2'h0;
			x27_Reg[7:0]	<= 8'h00;
			x28_Reg[1:0]	<= 2'h0;
			x29_Reg[7:0]	<= 8'h00;
			x2A_Reg[1:0]	<= 2'h0;
			x2B_Reg[7:0]	<= 8'h00;
			x2C_Reg[1:0]	<= 2'h0;
			x2D_Reg[7:0]	<= 8'h00;
			x2E_Reg[1:0]	<= 2'h0;
			x2F_Reg[7:0]	<= 8'h00;

			x30_Reg[1:0]	<= 2'h0;
			x31_Reg[7:0]	<= 8'h00;
			x32_Reg[1:0]	<= 2'h0;
			x33_Reg[7:0]	<= 8'h00;
			x34_Reg[1:0]	<= 2'h0;
			x35_Reg[7:0]	<= 8'h00;
			x36_Reg[1:0]	<= 2'h0;
			x37_Reg[7:0]	<= 8'h00;
			x38_Reg[1:0]	<= 2'h0;
			x39_Reg[7:0]	<= 8'h00;
			x3A_Reg[1:0]	<= 2'h0;
			x3B_Reg[7:0]	<= 8'h00;
			x3C_Reg[1:0]	<= 2'h0;
			x3D_Reg[7:0]	<= 8'h00;
			x3E_Reg[1:0]	<= 2'h0;
			x3F_Reg[7:0]	<= 8'h00;

			x40_Reg[1:0]	<= 2'h0;
			x41_Reg[7:0]	<= 8'h00;
			x42_Reg[1:0]	<= 2'h0;
			x43_Reg[7:0]	<= 8'h00;
			x44_Reg[1:0]	<= 2'h0;
			x45_Reg[7:0]	<= 8'h00;
			x46_Reg[1:0]	<= 2'h0;
			x47_Reg[7:0]	<= 8'h00;
			x48_Reg[1:0]	<= 2'h0;
			x49_Reg[7:0]	<= 8'h00;
			x4A_Reg[1:0]	<= 2'h0;
			x4B_Reg[7:0]	<= 8'h00;
			x4C_Reg[1:0]	<= 2'h0;
			x4D_Reg[7:0]	<= 8'h00;
			x4E_Reg[1:0]	<= 2'h0;
			x4F_Reg[7:0]	<= 8'h00;

			x50_Reg[1:0]	<= 2'h0;
			x51_Reg[7:0]	<= 8'h00;
			x52_Reg[1:0]	<= 2'h0;
			x53_Reg[7:0]	<= 8'h00;
			x54_Reg[1:0]	<= 2'h0;
			x55_Reg[7:0]	<= 8'h00;
			x56_Reg[1:0]	<= 2'h0;
			x57_Reg[7:0]	<= 8'h00;
			x58_Reg[1:0]	<= 2'h0;
			x59_Reg[7:0]	<= 8'h00;
			x5A_Reg[1:0]	<= 2'h0;
			x5B_Reg[7:0]	<= 8'h00;
			x5C_Reg[1:0]	<= 2'h0;
			x5D_Reg[7:0]	<= 8'h00;
			x5E_Reg[1:0]	<= 2'h0;
			x5F_Reg[7:0]	<= 8'h00;

			x60_Reg[1:0]	<= 2'h0;
			x61_Reg[7:0]	<= 8'h00;
			x62_Reg[1:0]	<= 2'h0;
			x63_Reg[7:0]	<= 8'h00;
			x64_Reg[1:0]	<= 2'h0;
			x65_Reg[7:0]	<= 8'h00;
			x66_Reg[1:0]	<= 2'h0;
			x67_Reg[7:0]	<= 8'h00;
			x68_Reg[1:0]	<= 2'h0;
			x69_Reg[7:0]	<= 8'h00;
			x6A_Reg[1:0]	<= 2'h0;
			x6B_Reg[7:0]	<= 8'h00;
			x6C_Reg[1:0]	<= 2'h0;
			x6D_Reg[7:0]	<= 8'h00;
			x6E_Reg[1:0]	<= 2'h0;
			x6F_Reg[7:0]	<= 8'h00;

			x70_Reg[1:0]	<= 2'h0;
			x71_Reg[7:0]	<= 8'h00;
			x72_Reg[1:0]	<= 2'h0;
			x73_Reg[7:0]	<= 8'h00;
			x74_Reg[1:0]	<= 2'h0;
			x75_Reg[7:0]	<= 8'h00;
			x76_Reg[1:0]	<= 2'h0;
			x77_Reg[7:0]	<= 8'h00;
			x78_Reg[1:0]	<= 2'h0;
			x79_Reg[7:0]	<= 8'h00;
			x7A_Reg[1:0]	<= 2'h0;
			x7B_Reg[7:0]	<= 8'h00;
			x7C_Reg[1:0]	<= 2'h0;
			x7D_Reg[7:0]	<= 8'h00;
			x7E_Reg[1:0]	<= 2'h0;
			x7F_Reg[7:0]	<= 8'h00;
		end else begin
			if(irWe)begin
//				x00_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'h0) ? irWd[7:0] : x00_Reg[7:0]);
//				x01_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'h1) ? irWd[7:0] : x01_Reg[7:0]);
//				x02_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'h2) ? irWd[7:0] : x02_Reg[7:0]);
//				x03_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'h3) ? irWd[7:0] : x03_Reg[7:0]);
//				x04_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'h4) ? irWd[7:0] : x04_Reg[7:0]);
				x05_Reg[1:0]	<= (regCs[0] & (irAddr[3:0]==4'h5) ? irWd[1:0] : x05_Reg[1:0]);
				x06_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'h6) ? irWd[7:0] : x06_Reg[7:0]);
				x07_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'h7) ? irWd[7:0] : x07_Reg[7:0]);
				x08_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'h8) ? irWd[7:0] : x08_Reg[7:0]);
				x09_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'h9) ? irWd[7:0] : x09_Reg[7:0]);
				x0A_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'hA) ? irWd[7:0] : x0A_Reg[7:0]);
				x0B_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'hB) ? irWd[7:0] : x0B_Reg[7:0]);
				x0C_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'hC) ? irWd[7:0] : x0C_Reg[7:0]);
				x0D_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'hD) ? irWd[7:0] : x0D_Reg[7:0]);
//				x0E_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'hE) ? irWd[7:0] : x0E_Reg[7:0]);
//				x0F_Reg[7:0]	<= (regCs[0] & (irAddr[3:0]==4'hF) ? irWd[7:0] : x0F_Reg[7:0]);

				x10_Reg[7:0]	<= (regCs[1] & (irAddr[3:0]==4'h0) ? irWd[7:0] : x10_Reg[7:0]);
				
				x1B_Reg[7:0]	<= (regCs[1] & (irAddr[3:0]==4'hB) ? irWd[7:0] : x1B_Reg[7:0]);
				x1C_Reg[7:0]	<= (regCs[1] & (irAddr[3:0]==4'hC) ? irWd[7:0] : x1C_Reg[7:0]);
				x1D_Reg[7:0]	<= (regCs[1] & (irAddr[3:0]==4'hD) ? irWd[7:0] : x1D_Reg[7:0]);
				x1E_Reg[7:0]	<= (regCs[1] & (irAddr[3:0]==4'hE) ? irWd[7:0] : x1E_Reg[7:0]);				

				x20_Reg[1:0]	<= (regCs[2] & (irAddr[3:0]==4'h0) ? irWd[1:0] : x20_Reg[1:0]);
				x21_Reg[7:0]	<= (regCs[2] & (irAddr[3:0]==4'h1) ? irWd[7:0] : x21_Reg[7:0]);
				x22_Reg[1:0]	<= (regCs[2] & (irAddr[3:0]==4'h2) ? irWd[1:0] : x22_Reg[1:0]);
				x23_Reg[7:0]	<= (regCs[2] & (irAddr[3:0]==4'h3) ? irWd[7:0] : x23_Reg[7:0]);
				x24_Reg[1:0]	<= (regCs[2] & (irAddr[3:0]==4'h4) ? irWd[1:0] : x24_Reg[1:0]);
				x25_Reg[7:0]	<= (regCs[2] & (irAddr[3:0]==4'h5) ? irWd[7:0] : x25_Reg[7:0]);
				x26_Reg[1:0]	<= (regCs[2] & (irAddr[3:0]==4'h6) ? irWd[1:0] : x26_Reg[1:0]);
				x27_Reg[7:0]	<= (regCs[2] & (irAddr[3:0]==4'h7) ? irWd[7:0] : x27_Reg[7:0]);
				x28_Reg[1:0]	<= (regCs[2] & (irAddr[3:0]==4'h8) ? irWd[1:0] : x28_Reg[1:0]);
				x29_Reg[7:0]	<= (regCs[2] & (irAddr[3:0]==4'h9) ? irWd[7:0] : x29_Reg[7:0]);
				x2A_Reg[1:0]	<= (regCs[2] & (irAddr[3:0]==4'hA) ? irWd[1:0] : x2A_Reg[1:0]);
				x2B_Reg[7:0]	<= (regCs[2] & (irAddr[3:0]==4'hB) ? irWd[7:0] : x2B_Reg[7:0]);
				x2C_Reg[1:0]	<= (regCs[2] & (irAddr[3:0]==4'hC) ? irWd[1:0] : x2C_Reg[1:0]);
				x2D_Reg[7:0]	<= (regCs[2] & (irAddr[3:0]==4'hD) ? irWd[7:0] : x2D_Reg[7:0]);
				x2E_Reg[1:0]	<= (regCs[2] & (irAddr[3:0]==4'hE) ? irWd[1:0] : x2E_Reg[1:0]);
				x2F_Reg[7:0]	<= (regCs[2] & (irAddr[3:0]==4'hF) ? irWd[7:0] : x2F_Reg[7:0]);

				x30_Reg[1:0]	<= (regCs[3] & (irAddr[3:0]==4'h0) ? irWd[1:0] : x30_Reg[1:0]);
				x31_Reg[7:0]	<= (regCs[3] & (irAddr[3:0]==4'h1) ? irWd[7:0] : x31_Reg[7:0]);
				x32_Reg[1:0]	<= (regCs[3] & (irAddr[3:0]==4'h2) ? irWd[1:0] : x32_Reg[1:0]);
				x33_Reg[7:0]	<= (regCs[3] & (irAddr[3:0]==4'h3) ? irWd[7:0] : x33_Reg[7:0]);
				x34_Reg[1:0]	<= (regCs[3] & (irAddr[3:0]==4'h4) ? irWd[1:0] : x34_Reg[1:0]);
				x35_Reg[7:0]	<= (regCs[3] & (irAddr[3:0]==4'h5) ? irWd[7:0] : x35_Reg[7:0]);
				x36_Reg[1:0]	<= (regCs[3] & (irAddr[3:0]==4'h6) ? irWd[1:0] : x36_Reg[1:0]);
				x37_Reg[7:0]	<= (regCs[3] & (irAddr[3:0]==4'h7) ? irWd[7:0] : x37_Reg[7:0]);
				x38_Reg[1:0]	<= (regCs[3] & (irAddr[3:0]==4'h8) ? irWd[1:0] : x38_Reg[1:0]);
				x39_Reg[7:0]	<= (regCs[3] & (irAddr[3:0]==4'h9) ? irWd[7:0] : x39_Reg[7:0]);
				x3A_Reg[1:0]	<= (regCs[3] & (irAddr[3:0]==4'hA) ? irWd[1:0] : x3A_Reg[1:0]);
				x3B_Reg[7:0]	<= (regCs[3] & (irAddr[3:0]==4'hB) ? irWd[7:0] : x3B_Reg[7:0]);
				x3C_Reg[1:0]	<= (regCs[3] & (irAddr[3:0]==4'hC) ? irWd[1:0] : x3C_Reg[1:0]);
				x3D_Reg[7:0]	<= (regCs[3] & (irAddr[3:0]==4'hD) ? irWd[7:0] : x3D_Reg[7:0]);
				x3E_Reg[1:0]	<= (regCs[3] & (irAddr[3:0]==4'hE) ? irWd[1:0] : x3E_Reg[1:0]);
				x3F_Reg[7:0]	<= (regCs[3] & (irAddr[3:0]==4'hF) ? irWd[7:0] : x3F_Reg[7:0]);

				x40_Reg[1:0]	<= (regCs[4] & (irAddr[3:0]==4'h0) ? irWd[1:0] : x40_Reg[1:0]);
				x41_Reg[7:0]	<= (regCs[4] & (irAddr[3:0]==4'h1) ? irWd[7:0] : x41_Reg[7:0]);
				x42_Reg[1:0]	<= (regCs[4] & (irAddr[3:0]==4'h2) ? irWd[1:0] : x42_Reg[1:0]);
				x43_Reg[7:0]	<= (regCs[4] & (irAddr[3:0]==4'h3) ? irWd[7:0] : x43_Reg[7:0]);
				x44_Reg[1:0]	<= (regCs[4] & (irAddr[3:0]==4'h4) ? irWd[1:0] : x44_Reg[1:0]);
				x45_Reg[7:0]	<= (regCs[4] & (irAddr[3:0]==4'h5) ? irWd[7:0] : x45_Reg[7:0]);
				x46_Reg[1:0]	<= (regCs[4] & (irAddr[3:0]==4'h6) ? irWd[1:0] : x46_Reg[1:0]);
				x47_Reg[7:0]	<= (regCs[4] & (irAddr[3:0]==4'h7) ? irWd[7:0] : x47_Reg[7:0]);
				x48_Reg[1:0]	<= (regCs[4] & (irAddr[3:0]==4'h8) ? irWd[1:0] : x48_Reg[1:0]);
				x49_Reg[7:0]	<= (regCs[4] & (irAddr[3:0]==4'h9) ? irWd[7:0] : x49_Reg[7:0]);
				x4A_Reg[1:0]	<= (regCs[4] & (irAddr[3:0]==4'hA) ? irWd[1:0] : x4A_Reg[1:0]);
				x4B_Reg[7:0]	<= (regCs[4] & (irAddr[3:0]==4'hB) ? irWd[7:0] : x4B_Reg[7:0]);
				x4C_Reg[1:0]	<= (regCs[4] & (irAddr[3:0]==4'hC) ? irWd[1:0] : x4C_Reg[1:0]);
				x4D_Reg[7:0]	<= (regCs[4] & (irAddr[3:0]==4'hD) ? irWd[7:0] : x4D_Reg[7:0]);
				x4E_Reg[1:0]	<= (regCs[4] & (irAddr[3:0]==4'hE) ? irWd[1:0] : x4E_Reg[1:0]);
				x4F_Reg[7:0]	<= (regCs[4] & (irAddr[3:0]==4'hF) ? irWd[7:0] : x4F_Reg[7:0]);

				x50_Reg[1:0]	<= (regCs[5] & (irAddr[3:0]==4'h0) ? irWd[1:0] : x50_Reg[1:0]);
				x51_Reg[7:0]	<= (regCs[5] & (irAddr[3:0]==4'h1) ? irWd[7:0] : x51_Reg[7:0]);
				x52_Reg[1:0]	<= (regCs[5] & (irAddr[3:0]==4'h2) ? irWd[1:0] : x52_Reg[1:0]);
				x53_Reg[7:0]	<= (regCs[5] & (irAddr[3:0]==4'h3) ? irWd[7:0] : x53_Reg[7:0]);
				x54_Reg[1:0]	<= (regCs[5] & (irAddr[3:0]==4'h4) ? irWd[1:0] : x54_Reg[1:0]);
				x55_Reg[7:0]	<= (regCs[5] & (irAddr[3:0]==4'h5) ? irWd[7:0] : x55_Reg[7:0]);
				x56_Reg[1:0]	<= (regCs[5] & (irAddr[3:0]==4'h6) ? irWd[1:0] : x56_Reg[1:0]);
				x57_Reg[7:0]	<= (regCs[5] & (irAddr[3:0]==4'h7) ? irWd[7:0] : x57_Reg[7:0]);
				x58_Reg[1:0]	<= (regCs[5] & (irAddr[3:0]==4'h8) ? irWd[1:0] : x58_Reg[1:0]);
				x59_Reg[7:0]	<= (regCs[5] & (irAddr[3:0]==4'h9) ? irWd[7:0] : x59_Reg[7:0]);
				x5A_Reg[1:0]	<= (regCs[5] & (irAddr[3:0]==4'hA) ? irWd[1:0] : x5A_Reg[1:0]);
				x5B_Reg[7:0]	<= (regCs[5] & (irAddr[3:0]==4'hB) ? irWd[7:0] : x5B_Reg[7:0]);
				x5C_Reg[1:0]	<= (regCs[5] & (irAddr[3:0]==4'hC) ? irWd[1:0] : x5C_Reg[1:0]);
				x5D_Reg[7:0]	<= (regCs[5] & (irAddr[3:0]==4'hD) ? irWd[7:0] : x5D_Reg[7:0]);
				x5E_Reg[1:0]	<= (regCs[5] & (irAddr[3:0]==4'hE) ? irWd[1:0] : x5E_Reg[1:0]);
				x5F_Reg[7:0]	<= (regCs[5] & (irAddr[3:0]==4'hF) ? irWd[7:0] : x5F_Reg[7:0]);

				x60_Reg[1:0]	<= (regCs[6] & (irAddr[3:0]==4'h0) ? irWd[1:0] : x60_Reg[1:0]);
				x61_Reg[7:0]	<= (regCs[6] & (irAddr[3:0]==4'h1) ? irWd[7:0] : x61_Reg[7:0]);
				x62_Reg[1:0]	<= (regCs[6] & (irAddr[3:0]==4'h2) ? irWd[1:0] : x62_Reg[1:0]);
				x63_Reg[7:0]	<= (regCs[6] & (irAddr[3:0]==4'h3) ? irWd[7:0] : x63_Reg[7:0]);
				x64_Reg[1:0]	<= (regCs[6] & (irAddr[3:0]==4'h4) ? irWd[1:0] : x64_Reg[1:0]);
				x65_Reg[7:0]	<= (regCs[6] & (irAddr[3:0]==4'h5) ? irWd[7:0] : x65_Reg[7:0]);
				x66_Reg[1:0]	<= (regCs[6] & (irAddr[3:0]==4'h6) ? irWd[1:0] : x66_Reg[1:0]);
				x67_Reg[7:0]	<= (regCs[6] & (irAddr[3:0]==4'h7) ? irWd[7:0] : x67_Reg[7:0]);
				x68_Reg[1:0]	<= (regCs[6] & (irAddr[3:0]==4'h8) ? irWd[1:0] : x68_Reg[1:0]);
				x69_Reg[7:0]	<= (regCs[6] & (irAddr[3:0]==4'h9) ? irWd[7:0] : x69_Reg[7:0]);
				x6A_Reg[1:0]	<= (regCs[6] & (irAddr[3:0]==4'hA) ? irWd[1:0] : x6A_Reg[1:0]);
				x6B_Reg[7:0]	<= (regCs[6] & (irAddr[3:0]==4'hB) ? irWd[7:0] : x6B_Reg[7:0]);
				x6C_Reg[1:0]	<= (regCs[6] & (irAddr[3:0]==4'hC) ? irWd[1:0] : x6C_Reg[1:0]);
				x6D_Reg[7:0]	<= (regCs[6] & (irAddr[3:0]==4'hD) ? irWd[7:0] : x6D_Reg[7:0]);
				x6E_Reg[1:0]	<= (regCs[6] & (irAddr[3:0]==4'hE) ? irWd[1:0] : x6E_Reg[1:0]);
				x6F_Reg[7:0]	<= (regCs[6] & (irAddr[3:0]==4'hF) ? irWd[7:0] : x6F_Reg[7:0]);

				x70_Reg[1:0]	<= (regCs[7] & (irAddr[3:0]==4'h0) ? irWd[1:0] : x70_Reg[1:0]);
				x71_Reg[7:0]	<= (regCs[7] & (irAddr[3:0]==4'h1) ? irWd[7:0] : x71_Reg[7:0]);
				x72_Reg[1:0]	<= (regCs[7] & (irAddr[3:0]==4'h2) ? irWd[1:0] : x72_Reg[1:0]);
				x73_Reg[7:0]	<= (regCs[7] & (irAddr[3:0]==4'h3) ? irWd[7:0] : x73_Reg[7:0]);
				x74_Reg[1:0]	<= (regCs[7] & (irAddr[3:0]==4'h4) ? irWd[1:0] : x74_Reg[1:0]);
				x75_Reg[7:0]	<= (regCs[7] & (irAddr[3:0]==4'h5) ? irWd[7:0] : x75_Reg[7:0]);
				x76_Reg[1:0]	<= (regCs[7] & (irAddr[3:0]==4'h6) ? irWd[1:0] : x76_Reg[1:0]);
				x77_Reg[7:0]	<= (regCs[7] & (irAddr[3:0]==4'h7) ? irWd[7:0] : x77_Reg[7:0]);
				x78_Reg[1:0]	<= (regCs[7] & (irAddr[3:0]==4'h8) ? irWd[1:0] : x78_Reg[1:0]);
				x79_Reg[7:0]	<= (regCs[7] & (irAddr[3:0]==4'h9) ? irWd[7:0] : x79_Reg[7:0]);
				x7A_Reg[1:0]	<= (regCs[7] & (irAddr[3:0]==4'hA) ? irWd[1:0] : x7A_Reg[1:0]);
				x7B_Reg[7:0]	<= (regCs[7] & (irAddr[3:0]==4'hB) ? irWd[7:0] : x7B_Reg[7:0]);
				x7C_Reg[1:0]	<= (regCs[7] & (irAddr[3:0]==4'hC) ? irWd[1:0] : x7C_Reg[1:0]);
				x7D_Reg[7:0]	<= (regCs[7] & (irAddr[3:0]==4'hD) ? irWd[7:0] : x7D_Reg[7:0]);
				x7E_Reg[1:0]	<= (regCs[7] & (irAddr[3:0]==4'hE) ? irWd[1:0] : x7E_Reg[1:0]);
				x7F_Reg[7:0]	<= (regCs[7] & (irAddr[3:0]==4'hF) ? irWd[7:0] : x7F_Reg[7:0]);
			end
		end
	end

	wire	[31:0]	fpgaVer		;

	assign	fpgaVer[31:0]	= `SYN_DATE;

	reg		[7:0]	rdDataA		;
	reg		[7:0]	rdDataB		;
	reg		[7:0]	rdDataC		;
	reg		[7:0]	rdDataD		;
	reg		[7:0]	rdDataE		;
	reg		[7:0]	rdDataF		;
	reg		[7:0]	rdDataG		;
	reg		[7:0]	rdDataH		;
	reg		[7:0]	regRv			;
	reg				regAck		;
	reg		[1:0]	smonAck		;
	reg		[15:0]rdDataI		;

	reg		[7:0]	rd_data_s2	;

	always@ (posedge CLK) begin
		case(irAddr[3:0])
			4'h0:	rdDataA[7:0]	<= fpgaVer[31:24];
			4'h1:	rdDataA[7:0]	<= fpgaVer[23:16];
			4'h2:	rdDataA[7:0]	<= fpgaVer[15: 8];
			4'h3:	rdDataA[7:0]	<= fpgaVer[ 7: 0];
			4'h4:	rdDataA[7:0]	<= `FPGA_VER;
			4'h5:	rdDataA[7:0]	<= {6'd0,x05_Reg[1:0]};
			4'h6:	rdDataA[7:0]	<= x06_Reg[7:0];	// Window[15:8]
			4'h7:	rdDataA[7:0]	<= x07_Reg[7:0];	// Window[7:0]
			4'h8:	rdDataA[7:0]	<= x08_Reg[7:0];	// DELAY[15:8]
			4'h9:	rdDataA[7:0]	<= x09_Reg[7:0];	// DELAY[7:0]
			4'hA:	rdDataA[7:0]	<= x0A_Reg[7:0];	// ID
			4'hB:	rdDataA[7:0]	<= x0B_Reg[7:0];	// ID
			4'hC:	rdDataA[7:0]	<= x0C_Reg[7:0];	// ID
			4'hD:	rdDataA[7:0]	<= x0D_Reg[7:0];
			4'hE:	rdDataA[7:0]	<= REG_TRG_STATUS[7:0];
			4'hF:	rdDataA[7:0]	<= REG_TRG_STATUS[7:0];
		endcase
		case(irAddr[3:0])
			4'h0:	rdDataB[7:0]	<= x10_Reg[7:0];
			4'h1:	rdDataB[7:0]	<= 8'd0;
			4'h2:	rdDataB[7:0]	<= 8'd0;
			4'h3:	rdDataB[7:0]	<= 8'd0;
			4'h4:	rdDataB[7:0]	<= 8'd0;
			4'h5:	rdDataB[7:0]	<= 8'd0;
			4'h6:	rdDataB[7:0]	<= 8'd0;
			4'h7:	rdDataB[7:0]	<= 8'd0;
			4'h8:	rdDataB[7:0]	<= 8'd0;
			4'h9:	rdDataB[7:0]	<= 8'd0;
			4'hA:	rdDataB[7:0]	<= 8'd0;
			4'hB:	rdDataB[7:0]	<= x1B_Reg[7:0];
			4'hC:	rdDataB[7:0]	<= x1C_Reg[7:0];
			4'hD:	rdDataB[7:0]	<= x1D_Reg[7:0];
			4'hE:	rdDataB[7:0]	<= x1E_Reg[7:0];
			4'hF:	rdDataB[7:0]	<= 8'd0;
		endcase
		case(irAddr[3:0])
			4'h0:	rdDataC[7:0]	<= {6'd0,x20_Reg[1:0]};
			4'h1:	rdDataC[7:0]	<= x21_Reg[7:0];
			4'h2:	rdDataC[7:0]	<= {6'd0,x22_Reg[1:0]};
			4'h3:	rdDataC[7:0]	<= x23_Reg[7:0];
			4'h4:	rdDataC[7:0]	<= {6'd0,x24_Reg[1:0]};
			4'h5:	rdDataC[7:0]	<= x25_Reg[7:0];
			4'h6:	rdDataC[7:0]	<= {6'd0,x26_Reg[1:0]};
			4'h7:	rdDataC[7:0]	<= x27_Reg[7:0];
			4'h8:	rdDataC[7:0]	<= {6'd0,x28_Reg[1:0]};
			4'h9:	rdDataC[7:0]	<= x29_Reg[7:0];
			4'hA:	rdDataC[7:0]	<= {6'd0,x2A_Reg[1:0]};
			4'hB:	rdDataC[7:0]	<= x2B_Reg[7:0];
			4'hC:	rdDataC[7:0]	<= {6'd0,x2C_Reg[1:0]};
			4'hD:	rdDataC[7:0]	<= x2D_Reg[7:0];
			4'hE:	rdDataC[7:0]	<= {6'd0,x2E_Reg[1:0]};
			4'hF:	rdDataC[7:0]	<= x2F_Reg[7:0];
		endcase
		case(irAddr[3:0])
			4'h0:	rdDataD[7:0]	<= {6'd0,x30_Reg[1:0]};
			4'h1:	rdDataD[7:0]	<= x31_Reg[7:0];
			4'h2:	rdDataD[7:0]	<= {6'd0,x32_Reg[1:0]};
			4'h3:	rdDataD[7:0]	<= x33_Reg[7:0];
			4'h4:	rdDataD[7:0]	<= {6'd0,x34_Reg[1:0]};
			4'h5:	rdDataD[7:0]	<= x35_Reg[7:0];
			4'h6:	rdDataD[7:0]	<= {6'd0,x36_Reg[1:0]};
			4'h7:	rdDataD[7:0]	<= x37_Reg[7:0];
			4'h8:	rdDataD[7:0]	<= {6'd0,x38_Reg[1:0]};
			4'h9:	rdDataD[7:0]	<= x39_Reg[7:0];
			4'hA:	rdDataD[7:0]	<= {6'd0,x3A_Reg[1:0]};
			4'hB:	rdDataD[7:0]	<= x3B_Reg[7:0];
			4'hC:	rdDataD[7:0]	<= {6'd0,x3C_Reg[1:0]};
			4'hD:	rdDataD[7:0]	<= x3D_Reg[7:0];
			4'hE:	rdDataD[7:0]	<= {6'd0,x3E_Reg[1:0]};
			4'hF:	rdDataD[7:0]	<= x3F_Reg[7:0];
		endcase
		case(irAddr[3:0])
			4'h0:	rdDataE[7:0]	<= {6'd0,x40_Reg[1:0]};
			4'h1:	rdDataE[7:0]	<= x41_Reg[7:0];
			4'h2:	rdDataE[7:0]	<= {6'd0,x42_Reg[1:0]};
			4'h3:	rdDataE[7:0]	<= x43_Reg[7:0];
			4'h4:	rdDataE[7:0]	<= {6'd0,x44_Reg[1:0]};
			4'h5:	rdDataE[7:0]	<= x45_Reg[7:0];
			4'h6:	rdDataE[7:0]	<= {6'd0,x46_Reg[1:0]};
			4'h7:	rdDataE[7:0]	<= x47_Reg[7:0];
			4'h8:	rdDataE[7:0]	<= {6'd0,x48_Reg[1:0]};
			4'h9:	rdDataE[7:0]	<= x49_Reg[7:0];
			4'hA:	rdDataE[7:0]	<= {6'd0,x4A_Reg[1:0]};
			4'hB:	rdDataE[7:0]	<= x4B_Reg[7:0];
			4'hC:	rdDataE[7:0]	<= {6'd0,x4C_Reg[1:0]};
			4'hD:	rdDataE[7:0]	<= x4D_Reg[7:0];
			4'hE:	rdDataE[7:0]	<= {6'd0,x4E_Reg[1:0]};
			4'hF:	rdDataE[7:0]	<= x4F_Reg[7:0];
		endcase
		case(irAddr[3:0])
			4'h0:	rdDataF[7:0]	<= {6'd0,x50_Reg[1:0]};
			4'h1:	rdDataF[7:0]	<= x51_Reg[7:0];
			4'h2:	rdDataF[7:0]	<= {6'd0,x52_Reg[1:0]};
			4'h3:	rdDataF[7:0]	<= x53_Reg[7:0];
			4'h4:	rdDataF[7:0]	<= {6'd0,x54_Reg[1:0]};
			4'h5:	rdDataF[7:0]	<= x55_Reg[7:0];
			4'h6:	rdDataF[7:0]	<= {6'd0,x56_Reg[1:0]};
			4'h7:	rdDataF[7:0]	<= x57_Reg[7:0];
			4'h8:	rdDataF[7:0]	<= {6'd0,x58_Reg[1:0]};
			4'h9:	rdDataF[7:0]	<= x59_Reg[7:0];
			4'hA:	rdDataF[7:0]	<= {6'd0,x5A_Reg[1:0]};
			4'hB:	rdDataF[7:0]	<= x5B_Reg[7:0];
			4'hC:	rdDataF[7:0]	<= {6'd0,x5C_Reg[1:0]};
			4'hD:	rdDataF[7:0]	<= x5D_Reg[7:0];
			4'hE:	rdDataF[7:0]	<= {6'd0,x5E_Reg[1:0]};
			4'hF:	rdDataF[7:0]	<= x5F_Reg[7:0];
		endcase
		case(irAddr[3:0])
			4'h0:	rdDataG[7:0]	<= {6'd0,x60_Reg[1:0]};
			4'h1:	rdDataG[7:0]	<= x61_Reg[7:0];
			4'h2:	rdDataG[7:0]	<= {6'd0,x62_Reg[1:0]};
			4'h3:	rdDataG[7:0]	<= x63_Reg[7:0];
			4'h4:	rdDataG[7:0]	<= {6'd0,x64_Reg[1:0]};
			4'h5:	rdDataG[7:0]	<= x65_Reg[7:0];
			4'h6:	rdDataG[7:0]	<= {6'd0,x66_Reg[1:0]};
			4'h7:	rdDataG[7:0]	<= x67_Reg[7:0];
			4'h8:	rdDataG[7:0]	<= {6'd0,x68_Reg[1:0]};
			4'h9:	rdDataG[7:0]	<= x69_Reg[7:0];
			4'hA:	rdDataG[7:0]	<= {6'd0,x6A_Reg[1:0]};
			4'hB:	rdDataG[7:0]	<= x6B_Reg[7:0];
			4'hC:	rdDataG[7:0]	<= {6'd0,x6C_Reg[1:0]};
			4'hD:	rdDataG[7:0]	<= x6D_Reg[7:0];
			4'hE:	rdDataG[7:0]	<= {6'd0,x6E_Reg[1:0]};
			4'hF:	rdDataG[7:0]	<= x6F_Reg[7:0];
		endcase
		case(irAddr[3:0])
			4'h0:	rdDataH[7:0]	<= {6'd0,x70_Reg[1:0]};
			4'h1:	rdDataH[7:0]	<= x71_Reg[7:0];
			4'h2:	rdDataH[7:0]	<= {6'd0,x72_Reg[1:0]};
			4'h3:	rdDataH[7:0]	<= x73_Reg[7:0];
			4'h4:	rdDataH[7:0]	<= {6'd0,x74_Reg[1:0]};
			4'h5:	rdDataH[7:0]	<= x75_Reg[7:0];
			4'h6:	rdDataH[7:0]	<= {6'd0,x76_Reg[1:0]};
			4'h7:	rdDataH[7:0]	<= x77_Reg[7:0];
			4'h8:	rdDataH[7:0]	<= {6'd0,x78_Reg[1:0]};
			4'h9:	rdDataH[7:0]	<= x79_Reg[7:0];
			4'hA:	rdDataH[7:0]	<= {6'd0,x7A_Reg[1:0]};
			4'hB:	rdDataH[7:0]	<= x7B_Reg[7:0];
			4'hC:	rdDataH[7:0]	<= {6'd0,x7C_Reg[1:0]};
			4'hD:	rdDataH[7:0]	<= x7D_Reg[7:0];
			4'hE:	rdDataH[7:0]	<= {6'd0,x7E_Reg[1:0]};
			4'hF:	rdDataH[7:0]	<= x7F_Reg[7:0];
		endcase

		regRv[7:0]	<= (irRe	? regCs[7:0] : 8'd0);
		regAck		<= (|regCs[7:0]) & (irWe | irRe);
	end

	reg				orAck		;
	reg		[7:0]	orRd		;

	wire			adcAck		;
	wire	[7:0]	adcRd		;

	always@ (posedge CLK) begin
		orAck		<= regAck | adcAck | (|smonAck[1:0]);
		orRd[7:0]	<=	(regRv[0]	? rdDataA[7:0]	: 8'd0)|
						(regRv[1]	? rdDataB[7:0]	: 8'd0)|
						(regRv[2]	? rdDataC[7:0]	: 8'd0)|
						(regRv[3]	? rdDataD[7:0]	: 8'd0)|
						(regRv[4]	? rdDataE[7:0]	: 8'd0)|
						(regRv[5]	? rdDataF[7:0]	: 8'd0)|
						(regRv[6]	? rdDataG[7:0]	: 8'd0)|
						(regRv[7]	? rdDataH[7:0]	: 8'd0)|
						(adcAck		? adcRd[7:0]	: 8'd0);
	end

	assign	LOC_ACK		= orAck;
	assign	LOC_RD[7:0] = orRd[7:0];

	reg		[15:0]	REG_DELAY	;
	reg		[15:0]	REG_LEN		;
	
	always@ (posedge CLK) begin
		REG_LEN[15:0]	<= {x06_Reg[6:0],x07_Reg[7:0],1'b0} - 1'b1;
//		REG_LEN[15:0]   <= {REG_LEN[14:0],1'b0} -1'b1;    //Ç±ÇøÇÁÇÃîFéØÇ∆ÇµÇƒÇÕ4000,é¿ç€Ç…égÇ§ílÇÕ7999(*2-1)Ç∑ÇÈïKóvÇ™Ç†ÇÈ
//		REG_DELAY[15:0]	<= {REG_LEN[15:0]} + {x08_Reg[7:0],x09_Reg[7:0]};
        REG_DELAY[15:0] <= {x08_Reg[7:0],x09_Reg[7:0]};
	end

	assign  REG_MODE[1:0] = x05_Reg[1:0];
	assign  REG_WINDOW[15:0] = {x06_Reg[7:0],x07_Reg[7:0]};

	assign  REG_0AX[7:0] = x0A_Reg[7:0];
	assign  REG_0BX[7:0] = x0B_Reg[7:0];
	assign  REG_0CX[7:0] = x0C_Reg[7:0];
	assign  REG_0DX[7:0] = x0D_Reg[7:0];


	assign	REG_ADC_PDSTL[10* 0+9:10* 0]	= {x20_Reg[1:0],x21_Reg[7:0]};
	assign	REG_ADC_PDSTL[10* 1+9:10* 1]	= {x22_Reg[1:0],x23_Reg[7:0]};
	assign	REG_ADC_PDSTL[10* 2+9:10* 2]	= {x24_Reg[1:0],x25_Reg[7:0]};
	assign	REG_ADC_PDSTL[10* 3+9:10* 3]	= {x26_Reg[1:0],x27_Reg[7:0]};
	assign	REG_ADC_PDSTL[10* 4+9:10* 4]	= {x28_Reg[1:0],x29_Reg[7:0]};
	assign	REG_ADC_PDSTL[10* 5+9:10* 5]	= {x2A_Reg[1:0],x2B_Reg[7:0]};
	assign	REG_ADC_PDSTL[10* 6+9:10* 6]	= {x2C_Reg[1:0],x2D_Reg[7:0]};
	assign	REG_ADC_PDSTL[10* 7+9:10* 7]	= {x2E_Reg[1:0],x2F_Reg[7:0]};
	assign	REG_ADC_PDSTL[10* 8+9:10* 8]	= {x30_Reg[1:0],x31_Reg[7:0]};
	assign	REG_ADC_PDSTL[10* 9+9:10* 9]	= {x32_Reg[1:0],x33_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*10+9:10*10]	= {x34_Reg[1:0],x35_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*11+9:10*11]	= {x36_Reg[1:0],x37_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*12+9:10*12]	= {x38_Reg[1:0],x39_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*13+9:10*13]	= {x3A_Reg[1:0],x3B_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*14+9:10*14]	= {x3C_Reg[1:0],x3D_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*15+9:10*15]	= {x3E_Reg[1:0],x3F_Reg[7:0]};

	assign	REG_ADC_PDSTL[10*16+9:10*16]	= {x40_Reg[1:0],x41_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*17+9:10*17]	= {x42_Reg[1:0],x43_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*18+9:10*18]	= {x44_Reg[1:0],x45_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*19+9:10*19]	= {x46_Reg[1:0],x47_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*20+9:10*20]	= {x48_Reg[1:0],x49_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*21+9:10*21]	= {x4A_Reg[1:0],x4B_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*22+9:10*22]	= {x4C_Reg[1:0],x4D_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*23+9:10*23]	= {x4E_Reg[1:0],x4F_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*24+9:10*24]	= {x50_Reg[1:0],x51_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*25+9:10*25]	= {x52_Reg[1:0],x53_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*26+9:10*26]	= {x54_Reg[1:0],x55_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*27+9:10*27]	= {x56_Reg[1:0],x57_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*28+9:10*28]	= {x58_Reg[1:0],x59_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*29+9:10*29]	= {x5A_Reg[1:0],x5B_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*30+9:10*30]	= {x5C_Reg[1:0],x5D_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*31+9:10*31]	= {x5E_Reg[1:0],x5F_Reg[7:0]};

	assign	REG_ADC_PDSTL[10*32+9:10*32]	= {x60_Reg[1:0],x61_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*33+9:10*33]	= {x62_Reg[1:0],x63_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*34+9:10*34]	= {x64_Reg[1:0],x65_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*35+9:10*35]	= {x66_Reg[1:0],x67_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*36+9:10*36]	= {x68_Reg[1:0],x69_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*37+9:10*37]	= {x6A_Reg[1:0],x6B_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*38+9:10*38]	= {x6C_Reg[1:0],x6D_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*39+9:10*39]	= {x6E_Reg[1:0],x6F_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*40+9:10*40]	= {x70_Reg[1:0],x71_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*41+9:10*41]	= {x72_Reg[1:0],x73_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*42+9:10*42]	= {x74_Reg[1:0],x75_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*43+9:10*43]	= {x76_Reg[1:0],x77_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*44+9:10*44]	= {x78_Reg[1:0],x79_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*45+9:10*45]	= {x7A_Reg[1:0],x7B_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*46+9:10*46]	= {x7C_Reg[1:0],x7D_Reg[7:0]};
	assign	REG_ADC_PDSTL[10*47+9:10*47]	= {x7E_Reg[1:0],x7F_Reg[7:0]};

//------------------------------------------------------------------------------
//	test in ON/OFF
//------------------------------------------------------------------------------

     wire   TEST_SW  ;
     
     assign TEST_SW  =   x1E_Reg[0]  ;



//------------------------------------------------------------------------------
//	DAC
//------------------------------------------------------------------------------


    reg dacLd;
    
    always@ (posedge CLK or posedge RST) begin
        if(RST)begin
            dacLd            <= 1'b0;
        end else begin
            dacLd            <= regCs[1] & (irAddr[3:0]==4'hC) & irWe;
        end
    end

    reg [255:0] dac_cont;

	always@ (posedge CLK or posedge RST) begin
	        if(RST)begin
	            dac_cont[255:0] <= 256'd0;
	        end else begin
	    if (dacLd)begin 
		case(x1C_Reg[7:0])
			8'h00:	dac_cont[7:0]	<= x1B_Reg[7:0];
			8'h01:	dac_cont[15:8]	<= x1B_Reg[7:0];
			8'h02:	dac_cont[23:16]	<= x1B_Reg[7:0];
		    8'h03:	dac_cont[31:24]	<= x1B_Reg[7:0];
			8'h04:	dac_cont[39:32]	<= x1B_Reg[7:0];
			8'h05:	dac_cont[47:40]	<= x1B_Reg[7:0];
			8'h06:	dac_cont[55:48]	<= x1B_Reg[7:0];
			8'h07:	dac_cont[63:56]	<= x1B_Reg[7:0];
			8'h08:	dac_cont[71:64]	<= x1B_Reg[7:0];
			8'h09:	dac_cont[79:72]	<= x1B_Reg[7:0];
			8'h0a:	dac_cont[87:80]	<= x1B_Reg[7:0];
			8'h0b:	dac_cont[95:88]	<= x1B_Reg[7:0];
			8'h0c:	dac_cont[103:96]	<= x1B_Reg[7:0];
			8'h0d:	dac_cont[111:104]	<= x1B_Reg[7:0];
			8'h0e:	dac_cont[119:112]	<= x1B_Reg[7:0];
			8'h0f:	dac_cont[127:120]	<= x1B_Reg[7:0];
			8'h10:	dac_cont[135:128]	<= x1B_Reg[7:0];
			8'h11:	dac_cont[143:136]	<= x1B_Reg[7:0];
			8'h12:	dac_cont[151:144]	<= x1B_Reg[7:0];
			8'h13:	dac_cont[159:152]	<= x1B_Reg[7:0];
			8'h14:	dac_cont[167:160]	<= x1B_Reg[7:0];
			8'h15:	dac_cont[175:168]	<= x1B_Reg[7:0];
			8'h16:	dac_cont[183:176]	<= x1B_Reg[7:0];
			8'h17:	dac_cont[191:184]	<= x1B_Reg[7:0];
			8'h18:	dac_cont[199:192]	<= x1B_Reg[7:0];
			8'h19:	dac_cont[207:200]	<= x1B_Reg[7:0];
			8'h1a:	dac_cont[215:208]	<= x1B_Reg[7:0];
			8'h1b:	dac_cont[223:216]	<= x1B_Reg[7:0];
			8'h1c:	dac_cont[231:224]	<= x1B_Reg[7:0];
			8'h1d:	dac_cont[239:232]	<= x1B_Reg[7:0];
            8'h1e:    dac_cont[247:240]    <= x1B_Reg[7:0];
            8'h1f:    dac_cont[255:248]    <= x1B_Reg[7:0];
            /*
            8'h20:    dac_cont[263:256]    <= x1B_Reg[7:0];
            8'h21:    dac_cont[271:264]    <= x1B_Reg[7:0];
            8'h22:    dac_cont[279:272]    <= x1B_Reg[7:0];
            8'h23:    dac_cont[287:280]    <= x1B_Reg[7:0];
            8'h24:    dac_cont[295:288]    <= x1B_Reg[7:0];
            8'h25:    dac_cont[303:296]    <= x1B_Reg[7:0];
            8'h26:    dac_cont[311:304]    <= x1B_Reg[7:0];
            8'h27:    dac_cont[319:312]    <= x1B_Reg[7:0];
			8'h28: 	  dac_cont[327:320]    <= x1B_Reg[7:0];
            8'h29:    dac_cont[335:328]    <= x1B_Reg[7:0];
            8'h2a:    dac_cont[343:336]    <= x1B_Reg[7:0];
            8'h2b:    dac_cont[351:344]    <= x1B_Reg[7:0];
            8'h2c:    dac_cont[359:352]    <= x1B_Reg[7:0];
            8'h2d:    dac_cont[367:360]    <= x1B_Reg[7:0];
            8'h2e:    dac_cont[375:368]    <= x1B_Reg[7:0];
            8'h2f:    dac_cont[383:376]    <= x1B_Reg[7:0];
            8'h30:    dac_cont[391:384]    <= x1B_Reg[7:0];
            8'h31:    dac_cont[399:392]    <= x1B_Reg[7:0];
            8'h32:    dac_cont[407:400]    <= x1B_Reg[7:0];
			8'h33:    dac_cont[415:408]    <= x1B_Reg[7:0];
            8'h34:    dac_cont[423:416]    <= x1B_Reg[7:0];
            8'h35:    dac_cont[431:424]    <= x1B_Reg[7:0];
            8'h36:    dac_cont[439:432]    <= x1B_Reg[7:0];
            8'h37:    dac_cont[447:440]    <= x1B_Reg[7:0];
            8'h38:    dac_cont[455:448]    <= x1B_Reg[7:0];
            8'h39:    dac_cont[463:456]    <= x1B_Reg[7:0];
            8'h3a:    dac_cont[471:464]    <= x1B_Reg[7:0];
            8'h3b:    dac_cont[479:472]    <= x1B_Reg[7:0];
            8'h3c:    dac_cont[487:480]    <= x1B_Reg[7:0];
            8'h3d:    dac_cont[495:488]    <= x1B_Reg[7:0];
			8'h3e:    dac_cont[503:496]    <= x1B_Reg[7:0];
            8'h3f:    dac_cont[511:504]    <= x1B_Reg[7:0];
            */
                endcase
            end
        end
    end
            
    reg shift;

   always@ (posedge CLK or posedge RST) begin
      if (RST) begin
        shift <= 0;
      end else begin
        if(TIM_1US)begin
        shift <= regCs[1] & (irAddr[3:0]==4'hD);
        end
     end
   end

   
//--clk 512---------------------------------------------------------------------------
        reg [8:0] count;
        reg        stri;
        reg        dacClk;
       
       always@ (posedge CLK) begin
          if (shift==0) begin
            count[8:0] <= 9'h100;
            stri        <= 1'b0;
            dacClk      <= 1'b0;
     
          end else begin
           if(TIM_1US)begin
                count[8:0]  <= (count[8] ? count[8:0] + 9'h1 : 9'h0);
                stri        <= 1'b1;
                dacClk      <= count[0];
            end
         end
       end
       
       reg dly_count;
        
        always@(posedge CLK)begin
           dly_count <= dacClk;
        end
        
        wire shift_count;
        
        assign shift_count = dacClk& ~dly_count;
       // assign shift_count = count[0] & ~dacClk;
         
    
        reg [128:0] dac_shift_A;
        reg [128:0] dac_shift_B; 
        
        always@(posedge CLK)begin
            if(irWe)begin
                 dac_shift_A[128:0]    <= {dac_cont[127:0],1'b0};
                 dac_shift_B[128:0]    <= {dac_cont[255:128],1'b0};
            end else begin    
              if(shift_count)begin 
                 dac_shift_A[128:0]    <= {1'b0,dac_shift_A[128:1]};
                 dac_shift_B[128:0]    <= {1'b0,dac_shift_B[128:1]};
                end
           end
        end
        

     reg dly_count2;  

     always@(posedge CLK)begin
        if (RST) begin
          dly_count2 <= 0;
        end else begin
             if(TIM_1US)begin
             dly_count2 <= dly_count;
             end  
        end         
     end

        
    //    assign  NIM_OUT     = ~dly_count2;
        assign  DAC_CLKI    = dly_count2;
        assign  DAC_STRI    = dac_shift_B[0];
        //assign    DAC_SDI      = dac_shift_delay;
        assign    DAC_SDI   = dac_shift_A[0] ;

/*

    reg dacLd;
    
    always@ (posedge CLK or posedge RST) begin
        if(RST)begin
            dacLd            <= 1'b0;
        end else begin
            dacLd            <= regCs[1] & (irAddr[3:0]==4'hC) & irWe;
        end
    end

    reg [511:0] dac_cont;

	always@ (posedge CLK or posedge RST) begin
	        if(RST)begin
	            dac_cont[511:0] <= 512'd0;
	        end else begin
	    if (dacLd)begin 
		case(x1C_Reg[7:0])
			8'h00:	dac_cont[7:0]	<= x1B_Reg[7:0];
			8'h01:	dac_cont[15:8]	<= x1B_Reg[7:0];
			8'h02:	dac_cont[23:16]	<= x1B_Reg[7:0];
		    8'h03:	dac_cont[31:24]	<= x1B_Reg[7:0];
			8'h04:	dac_cont[39:32]	<= x1B_Reg[7:0];
			8'h05:	dac_cont[47:40]	<= x1B_Reg[7:0];
			8'h06:	dac_cont[55:48]	<= x1B_Reg[7:0];
			8'h07:	dac_cont[63:56]	<= x1B_Reg[7:0];
			8'h08:	dac_cont[71:64]	<= x1B_Reg[7:0];
			8'h09:	dac_cont[79:72]	<= x1B_Reg[7:0];
			8'h0a:	dac_cont[87:80]	<= x1B_Reg[7:0];
			8'h0b:	dac_cont[95:88]	<= x1B_Reg[7:0];
			8'h0c:	dac_cont[103:96]	<= x1B_Reg[7:0];
			8'h0d:	dac_cont[111:104]	<= x1B_Reg[7:0];
			8'h0e:	dac_cont[119:112]	<= x1B_Reg[7:0];
			8'h0f:	dac_cont[127:120]	<= x1B_Reg[7:0];
			8'h10:	dac_cont[135:128]	<= x1B_Reg[7:0];
			8'h11:	dac_cont[143:136]	<= x1B_Reg[7:0];
			8'h12:	dac_cont[151:144]	<= x1B_Reg[7:0];
			8'h13:	dac_cont[159:152]	<= x1B_Reg[7:0];
			8'h14:	dac_cont[167:160]	<= x1B_Reg[7:0];
			8'h15:	dac_cont[175:168]	<= x1B_Reg[7:0];
			8'h16:	dac_cont[183:176]	<= x1B_Reg[7:0];
			8'h17:	dac_cont[191:184]	<= x1B_Reg[7:0];
			8'h18:	dac_cont[199:192]	<= x1B_Reg[7:0];
			8'h19:	dac_cont[207:200]	<= x1B_Reg[7:0];
			8'h1a:	dac_cont[215:208]	<= x1B_Reg[7:0];
			8'h1b:	dac_cont[223:216]	<= x1B_Reg[7:0];
			8'h1c:	dac_cont[231:224]	<= x1B_Reg[7:0];
			8'h1d:	dac_cont[239:232]	<= x1B_Reg[7:0];
            8'h1e:    dac_cont[247:240]    <= x1B_Reg[7:0];
            8'h1f:    dac_cont[255:248]    <= x1B_Reg[7:0];
            8'h20:    dac_cont[263:256]    <= x1B_Reg[7:0];
            8'h21:    dac_cont[271:264]    <= x1B_Reg[7:0];
            8'h22:    dac_cont[279:272]    <= x1B_Reg[7:0];
            8'h23:    dac_cont[287:280]    <= x1B_Reg[7:0];
            8'h24:    dac_cont[295:288]    <= x1B_Reg[7:0];
            8'h25:    dac_cont[303:296]    <= x1B_Reg[7:0];
            8'h26:    dac_cont[311:304]    <= x1B_Reg[7:0];
            8'h27:    dac_cont[319:312]    <= x1B_Reg[7:0];
			8'h28: 	  dac_cont[327:320]    <= x1B_Reg[7:0];
            8'h29:    dac_cont[335:328]    <= x1B_Reg[7:0];
            8'h2a:    dac_cont[343:336]    <= x1B_Reg[7:0];
            8'h2b:    dac_cont[351:344]    <= x1B_Reg[7:0];
            8'h2c:    dac_cont[359:352]    <= x1B_Reg[7:0];
            8'h2d:    dac_cont[367:360]    <= x1B_Reg[7:0];
            8'h2e:    dac_cont[375:368]    <= x1B_Reg[7:0];
            8'h2f:    dac_cont[383:376]    <= x1B_Reg[7:0];
            8'h30:    dac_cont[391:384]    <= x1B_Reg[7:0];
            8'h31:    dac_cont[399:392]    <= x1B_Reg[7:0];
            8'h32:    dac_cont[407:400]    <= x1B_Reg[7:0];
			8'h33:    dac_cont[415:408]    <= x1B_Reg[7:0];
            8'h34:    dac_cont[423:416]    <= x1B_Reg[7:0];
            8'h35:    dac_cont[431:424]    <= x1B_Reg[7:0];
            8'h36:    dac_cont[439:432]    <= x1B_Reg[7:0];
            8'h37:    dac_cont[447:440]    <= x1B_Reg[7:0];
            8'h38:    dac_cont[455:448]    <= x1B_Reg[7:0];
            8'h39:    dac_cont[463:456]    <= x1B_Reg[7:0];
            8'h3a:    dac_cont[471:464]    <= x1B_Reg[7:0];
            8'h3b:    dac_cont[479:472]    <= x1B_Reg[7:0];
            8'h3c:    dac_cont[487:480]    <= x1B_Reg[7:0];
            8'h3d:    dac_cont[495:488]    <= x1B_Reg[7:0];
			8'h3e:    dac_cont[503:496]    <= x1B_Reg[7:0];
            8'h3f:    dac_cont[511:504]    <= x1B_Reg[7:0];

                endcase
            end
        end
    end
            
    reg shift;

   always@ (posedge CLK or posedge RST) begin
      if (RST) begin
        shift <= 0;
      end else begin
        if(TIM_1US)begin
        shift <= x1D_Reg[0];//regCs[1] & (irAddr[3:0]==4'hD)
        end
     end
   end

   
//--clk 512---------------------------------------------------------------------------
        reg [10:0] count;
        reg        stri;
        reg        dacClk;
       
       always@ (posedge CLK) begin
          if (shift==0) begin
            count[10:0] <= 11'h400;
            stri        <= 1'b0;
            dacClk      <= 1'b0;
     
          end else begin
           if(TIM_1US)begin
                count[10:0]  <= (count[10] ? count[10:0] + 11'h1 : 11'h0);
                stri        <= 1'b1;
                dacClk      <= count[0];
            end
         end
       end
       
       reg dly_count;
        
        always@(posedge CLK)begin
           dly_count <= dacClk;
        end
        
        wire shift_count;
        
        assign shift_count = dacClk& ~dly_count;
       // assign shift_count = count[0] & ~dacClk;
         
    
        reg [512:0] dac_shift; 
        
        always@(posedge CLK)begin
            if(irWe)begin
                 dac_shift[512:0]    <= {dac_cont[511:0],1'b0};
            end else begin    
              if(shift_count)begin 
                 dac_shift[512:0]    <= {dac_shift[512:1],1'b0};
                end
           end
        end
        

     reg dly_count2;  

     always@(posedge CLK)begin
        if (RST) begin
          dly_count2 <= 0;
        end else begin
             if(TIM_1US)begin
             dly_count2 <= dly_count;
             end  
        end         
     end

        
    //    assign  NIM_OUT     = ~dly_count2;
        assign  DAC_CLKI    = dly_count2;
        assign  DAC_STRI    = stri;
        //assign    DAC_SDI      = dac_shift_delay;
        assign    DAC_SDI      =dac_shift[0] ;

*/
//------------------------------------------------------------------------------
//	ADC
//------------------------------------------------------------------------------

	wire	[2:0]	adcSel		;

	assign	adcSel[2:0]	= x10_Reg[2:0];

//	wire	[2:1]	ADC_CSB		;
	wire	[8:1]	ADC_CSB		;
	wire			adcCsb		;

/*
	assign	ADC_CSB[1]		= (~adcSel[0] ? adcCsb	: 1'b1);
//	assign	ADC_CSB[2]		= ( adcSel[0] ? adcCsb	: 1'bz);
	assign	ADC_CSB[2]		= ( adcSel[0] & ~adcCsb ? 1'b0	: 1'bz);
*/
assign	  ADC_CSB[1]		= ( adcSel[2:0]==3'h0 & ~adcCsb ? 1'b0	  : 1'bz);
assign    ADC_CSB[2]        = ( adcSel[2:0]==3'h1 & ~adcCsb ? 1'b0    : 1'bz);
assign    ADC_CSB[3]        = ( adcSel[2:0]==3'h2 & ~adcCsb ? 1'b0    : 1'bz);
assign    ADC_CSB[4]        = ( adcSel[2:0]==3'h3 & ~adcCsb ? 1'b0    : 1'bz);
assign    ADC_CSB[5]        = ( adcSel[2:0]==3'h4 & ~adcCsb ? 1'b0    : 1'bz);
assign    ADC_CSB[6]        = ( adcSel[2:0]==3'h5 & ~adcCsb ? 1'b0    : 1'bz);
assign    ADC_CSB[7]        = ( adcSel[2:0]==3'h6 & ~adcCsb ? 1'b0    : 1'bz);
assign    ADC_CSB[8]        = ( adcSel[2:0]==3'h7 & ~adcCsb ? 1'b0    : 1'bz);

	wire			adcSck		;

//	assign	ADC_SCLK[2:1]	= (adcSck	? 2'h3	: 2'h0);
	assign	ADC_SCLK[8:1]	= (adcSck	? 8'b11111111	: 8'b00000000);

	wire			adcSdioIn		;
/*
	assign	adcSdioIn		=	(~adcSel[0] ? ADC_SDIO_IN[1]	: 1'b0)|
								( adcSel[0] ? ADC_SDIO_IN[2]	: 1'b0);
*/
	assign	adcSdioIn		=	    ( adcSel[2:0]==3'h0 ? ADC_SDIO_IN[1]	: 1'b0)|
                                    ( adcSel[2:0]==3'h1 ? ADC_SDIO_IN[2]    : 1'b0)|
                                    ( adcSel[2:0]==3'h2 ? ADC_SDIO_IN[3]    : 1'b0)|
                                    ( adcSel[2:0]==3'h3 ? ADC_SDIO_IN[4]    : 1'b0)|
                                    ( adcSel[2:0]==3'h4 ? ADC_SDIO_IN[5]    : 1'b0)|
                                    ( adcSel[2:0]==3'h5 ? ADC_SDIO_IN[6]    : 1'b0)|
                                    ( adcSel[2:0]==3'h6 ? ADC_SDIO_IN[7]    : 1'b0)|
                                    ( adcSel[2:0]==3'h7 ? ADC_SDIO_IN[8]    : 1'b0);


	AD_ADC_SPI			AD_ADC_SPI(
	// System
		.CLK				(CLK			),	// in	: System clock
		.RST				(RST			),	// in	: System reset(Asynchronous)
		.TIM				(TIM_1US		),	// in	: Periodic pulse for generating SPI-SCK
												//			(This period equals a half priod of SCK)
	// RBCP I/F
		.RBCP_SELECT	(adcCs					),	// in	: Module select
		.RBCP_ADDR		({5'd0,irAddr[7:0]}	),	// in	: Address[12:0]
		.RBCP_WE			(irWe						),	// in	: Write enable
		.RBCP_WD			(irWd[7:0]				),	// in	: Write data[7:0]
		.RBCP_RE			(irRe						),	// in	: Read enable
		.RBCP_RD			(adcRd[7:0]				),	// out	: Read data[7:0]
		.RBCP_ACK		(adcAck					),	// out	: Access acknowledge
	// ADC SPI
		.SCK				(adcSck				),	// out	: Clock
		.CSB				(adcCsb				),	// out	: Chip select
		.SDDIR			(ADC_SDIO_EN		),	// out	: Direction of the serial data line
		.SDIN				(adcSdioIn			),	// in	: Serial data input
		.SDOUT			(ADC_SDIO_OUT		)	// out	: Serial data output
	);

endmodule



