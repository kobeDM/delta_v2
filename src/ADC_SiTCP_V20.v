/*******************************************************************************
*                                                                              *
* System      : Liq_Ar_TPC_RO_Digital module                                   *
* Version     : ver2                                          						 *
*                                                                              *
* Description : Top Module                                                     *
*                                                                              *
* Designer    : Yuya Iwazaki																	 *
*					 Tomohisa Uchida                                                *
*                                                                              *
*               Copyright (c) 2012 Tomohisa Uchida                             *
*               All rights reserved                                            *
*                                                                              *
*******************************************************************************/
`define SYN_DATE	32'h1601_1301
`define FPGA_VER	8'h01
`define PACKET_HD_RAW_TYPE	8'h01

//`define SPARTAN_SERIES

//`include "../Src/sys_dcm.v"
//`include "../Src/mem_64_256.v"
					//?ｿｽR?ｿｽA?ｿｽW?ｿｽF?ｿｽl?ｿｽ?ｿｽ?ｿｽ[?ｿｽ^?ｿｽﾅ再撰ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽB

//`include "../Src/ADC_SiTCP_RING.v"
//`include "../Src/ADC_SiTCP_RAW.v"

//`include "../Src/WRAP_SiTCP_MII_XC6S_8K.v"
//`include "../Src/WRAP_SiTCP_GMII_XC7A_32K.V"
//`include "../Src/TIMER.v"
//`include "../Src/SiTCP_XC6S_8K_BBT_V40.v"
//`include "../Src/SiTCP_XC7A_32K_BBT_V80.V"
//`include "../Src/LOC_REG.v"
//`include "../AD_ADC_SIF/Src/AD_ADC_SIF.v"
//`include "../AD_ADC_SIF/Src/AD_ADC_SPI.v"

module ADC_SiTCP_V20(
// System
	OSC50M				,	// in		: System clock 50MHz
// EEPROM
	EEPROM_CS			,	// out	: Chip select
	EEPROM_SK			,	// out	: Serial data clock
	EEPROM_DI			,	// out	: Serial write data
	EEPROM_DO			,	// in		: Serial read data
// MII interface
	ETH_RSTn				,	// in		: Tx clock(2.5 or 25MHz)
	ETH_1000_LED ,
	// TX
	GTX_CLK             ,
	ETH_TX_CLK			,	// in		: Tx clock(2.5 or 25MHz)
	ETH_TX_EN			,	// out	: Tx enable
	ETH_TXD				,	// out	: Tx data[3:0]
	ETH_TX_ER			,	// out	: TX error
	// RX
	ETH_RX_CLK			,	// in	: Rx clock(2.5 or 25MHz)
	ETH_RX_DV			,	// in	: Rx data valid
	ETH_RXD				,	// in	: Rx data[3:0]
	ETH_RX_ER			,	// in	: Rx error
	ETH_CRS				,	// in	: Carrier sense
	ETH_COL				,	// in	: Collision detected
	// Management IF
	ETH_MDC				,	// out	: Clock for MDIO
	ETH_MDIO				,	// in		: data in
// ADC Interface 
	ADC_D_P				,   // Data (+) [31:0]
	ADC_D_N				,   // Data (-) [31:0]
	ADC_DCO_P			,   // Data Clock from ADC (+)[4:1]
	ADC_DCO_N			,   // Data Clock from ADC (-)[4:1]
	ADC_FCO_P			,   // Frame Clock from ADC (+)[4:1]
	ADC_FCO_N			,   // Frame Clock from ADC (-)[4:1]
	ADC_CLK_P			,   // ADC Clock (+)[4:1]
	ADC_CLK_N			,   // ADC Clock (-)[4:1]
	ADC_SCLK				,   // ADC SClock[4:1]
	ADC_CSB				,   // ADC Chip Slect[4:1]
	ADC_SDIO				,   // ADC Data[4:1]
// DAC
	DAC_CLKI		    ,   // DAC CLOCK
    DAC_SDI				,   //  
	DAC_STRI            ,   // 
	DAC_SDO             ,   //
	DAC_STRO	      	,   // 
//  I/O
	NIM_INn				,	// in		: NIM inputs[4:1]
	NIM_OUT				,	// out	: NIM output
	DIP_SW 				,	// in		: DIP_SW[3:0]
	TP_OUT                ,
	X_LED						// out	: LED[3:0]
);	

//-------- Input/Output -------------
	input				OSC50M			;

	output			EEPROM_CS		;
	output			EEPROM_SK		;
	output			EEPROM_DI		;
	input		    EEPROM_DO		;

	output			ETH_RSTn			;
	input  ETH_1000_LED ;
	output          GTX_CLK         ;
	input			ETH_TX_CLK		;
	output			ETH_TX_EN		;
	output	[7:0]	ETH_TXD			;
	output			ETH_TX_ER		;
	input			ETH_RX_CLK		;
	input			ETH_RX_DV		;
	input	[7:0]	ETH_RXD			;
	input			ETH_RX_ER		;
	input			ETH_CRS			;
	input			ETH_COL			;
	output			ETH_MDC			;
	inout			ETH_MDIO			;

	input	[63:0]	ADC_D_P			;
	input	[63:0]	ADC_D_N			;

	input	[8:1]	ADC_DCO_P		;
	input	[8:1]	ADC_DCO_N		;
	input	[8:1]	ADC_FCO_P		;
	input	[8:1]	ADC_FCO_N		;
	output	[8:1]	ADC_CLK_P		;
	output	[8:1]	ADC_CLK_N		;
	output	[8:1]	ADC_SCLK		;
	output	[8:1]	ADC_CSB			;
	inout	[8:1]	ADC_SDIO		;

	output			DAC_CLKI		;
	output			DAC_SDI			;
	output			DAC_STRI		;
    input           DAC_SDO         ;
    input           DAC_STRO        ;

	input	[4:1]	NIM_INn			;
	output			NIM_OUT			;
	input	[3:0]	DIP_SW			;
	output	[3:0]	X_LED			;
	output TP_OUT;

   parameter DATA_WIDTH   = 16;
   parameter CH_NUM       = 64;   //32  ?ｿｽ?ｿｽ 64

//------------------------------------------------------------------------------
//	Buffers
//------------------------------------------------------------------------------
	wire			ETH_RSTn			;

	wire			ETH_TX_EN		;
	wire	[7:0]	ETH_TXD			;
	wire			ETH_TX_ER		;

	wire			ETH_MDIO			;
	wire			ETH_MDOE			;
	wire			ETH_MDC			;
	wire			ETH_MDOUT		;

	wire	[8:1]	ADC_SCLK			;
	wire	[8:1]	ADC_CSB			;
	wire	[8:1]	ADC_SDIO			;

	wire			DAC_DIN			;
	wire			DAC_SCLK			;
	wire			DAC_SYNC			;

	wire			NIM_OUT			;

//	assign		NIM_OUT = 1'b1	; //   NIM_OUT?ｿｽ?ｿｽHigh?ｿｽﾉ固抵ｿｽ
//    if(REG_MODE[0] == 1)begin 
//	   assign		NIM_OUT = clk_count[4]; 
//	end else begin
//	   assign       NIM_OUT = sRST;
//	end
	
	wire	[3:0]	X_LED				;

	assign	ETH_MDIO	= (ETH_MDOE	? ETH_MDOUT : 1'bz);
				//ETH_MDOE?ｿｽ?ｿｽ?ｿｽ^?ｿｽﾈゑｿｽETH_MDIO=MDOUT?ｿｽA?ｿｽﾛ　1'bz
				
	wire			FORCE_DEFAULTn	;

	assign	FORCE_DEFAULTn	= DIP_SW[0];
				//DIP?ｿｽX?ｿｽC?ｿｽb?ｿｽ`?ｿｽﾌ茨ｿｽﾂゑｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽZ?ｿｽb?ｿｽg?ｿｽﾌス?ｿｽC?ｿｽb?ｿｽ`?ｿｽﾆゑｿｽ?ｿｽﾄ指?ｿｽ?ｿｽ
				
//test pin input trgger or NIM trigger SW				
				
	wire    TRG_INn    ;
    wire    TEST_SW    ;
    wire    TriG_In  ;
    wire    TesT_In  ;
    
//    assign  TriG_In = (~TEST_SW ? NIM_INn[1] : 1'b0);
    assign  TesT_In = ( TEST_SW ? NIM_INn[1] : 1'b0);
    
//    assign  TRG_INn = (~TEST_SW ? NIM_INn[1] : Trig_IN_sync);
    
//	assign	TRG_INn = NIM_INn[1];
//	assign	TRG_INn = Trig_IN_sync;
				//?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽﾅ暦ｿｽ?ｿｽp?ｿｽ?ｿｽ?ｿｽ?ｿｽg?ｿｽ?ｿｽ?ｿｽK?ｿｽ[?ｿｽi?ｿｽf?ｿｽ[?ｿｽ^?ｿｽ?ｿｽ?ｿｽM?ｿｽﾌタ?ｿｽC?ｿｽ~?ｿｽ?ｿｽ?ｿｽO?ｿｽj?ｿｽ?ｿｽNIM_IN1?ｿｽﾉ指?ｿｽ?ｿｽ
//------------------------------------------------------------------------------
//	System management
//------------------------------------------------------------------------------

//outside clock

    // assign  NIM_OUT =   OSC50M  ; // sahigash

//system clock change
    wire    sysClk_50M;
    
	assign	sysClk_50M	= (DIP_SW[1] ? OSC50M : NIM_INn[4]);    


// System clock

	wire			ibufOsc50m		;

	BUFG BUFG_OSC (
		.O				(ibufOsc50m	), // Clock buffer output
		.I				(sysClk_50M		)  // Clock buffer input
	);


// Reset generation

	wire			sysFds				;
	wire	[2:0]	sysFd				;

	FDS	SYS_FDS		(.D(1'b0)		, .C(ibufOsc50m), .Q(sysFds), .S(1'b0)); 
	FD	SYS_FD_0	(.D(sysFds)		, .C(ibufOsc50m), .Q(sysFd[0])); 
	FD	SYS_FD_1	(.D(sysFd[0])	, .C(ibufOsc50m), .Q(sysFd[1])); 
	FD	SYS_FD_2	(.D(sysFd[1])	, .C(ibufOsc50m), .Q(sysFd[2])); 

	wire			RST_PLL				;

	assign	RST_PLL		= (|sysFd[2:0])|DIP_SW[2];
									//sysFd[2:0]?ｿｽﾌ三?ｿｽ[?ｿｽqOR?ｿｽ?ｿｽH
									//DIP?ｿｽX?ｿｽC?ｿｽb?ｿｽ`?ｿｽﾅ具ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽZ?ｿｽb?ｿｽg


//Generate 20MHz clock

//----------------------------------------------------------------------------
//  Output     Output      Phase    Duty Cycle   Pk-to-Pk     Phase
//   Clock     Freq (MHz)  (degrees)    (%)     Jitter (ps)  Error (ps)
//----------------------------------------------------------------------------
// CLK_OUT1____20.000______0.000______50.0______249.363____164.985
//
//----------------------------------------------------------------------------
// Input Clock   Freq (MHz)    Input Jitter (UI)
//----------------------------------------------------------------------------
// __primary__________50.000____________0.010

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.

//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
	
	wire			CLK20M		;
	wire   CLK125M ;
	wire sysDcmLocked;
	wire           CLK160M     ;
		
  sys_mmcms instance_name
   (
   // Clock in ports
    .clk_in1(sysClk_50M),      // input clk_in1
    // Clock out ports
    .clk_out1(CLK160M),     // output clk_out1
    .clk_out2(CLK125M),    // output clk_out2
    .clk_out3(CLK20M),    // output clk_out3
    // Status and control signals
    .reset(RST_PLL),// input reset
    .locked(sysDcmLocked));      // output locked

	ODDR	GMII_ODDR (.Q(GTX_CLK), .C(CLK125M), .CE(1'b1), .D1(1'b1), .D2(1'b0), .R(1'b0), .S(1'b0));
	


	wire			aRstN	;
	wire			RST	;

	assign	aRstN	= sysDcmLocked;
	assign	RST	= ~sysDcmLocked;

	reg		[4:0]	rstCntr		;

	always@ (posedge CLK160M or negedge aRstN) begin
		if(!aRstN)begin
			rstCntr[4:0]	<= 5'd0;
		end else begin
			rstCntr[4:0]	<= (rstCntr[4] ? 5'h1F : rstCntr[4:0] + 5'd1);
											 //rstCntr[4]?ｿｽ?ｿｽ?ｿｽ^?ｿｽﾈゑｿｽrstCntr[4:0]=5'h1F?ｿｽA?ｿｽﾛ　rstCntr[4:0] + 5'd1
		end
	end

	wire	sRST		;
	wire	aRST		;

	FD	RST_FD1 (.D(~rstCntr[4]), .C(CLK160M), .Q(sRST));
                      //rstCntr[4]?ｿｽ?ｿｽ?ｿｽ^?ｿｽﾌとゑｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽsRST?ｿｽ?ｿｽ?ｿｽL?ｿｽ?ｿｽ
	FD	RST_FD2 (.D(sRST), .C(CLK160M), .Q(aRST));

//---------------------------------------------------------------------------------
//  THINNING
//---------------------------------------------------------------------------------
/*
	wire   [7:0]   REG_THINNING ;     //Thinning adc data [7:0]  default 8  2.5Msps  SYSCLK 20Msps
    reg     [7:0]  clk_count;
    reg            clk_enable;

    always@ (posedge CLK20M) begin
        if(sRST)begin
            clk_count[7:0] <= 8'd0;
            clk_enable <= 1'd0;
        end else begin
            if(clk_count[7:0] == (REG_THINNING[7:0] - 8'd1))begin //?ｿｽﾈゑｿｽ?ｿｽ?ｿｽREG_THINNING+1?ｿｽ?ｿｽ?ｿｽ?ｿｽ1?ｿｽﾉなゑｿｽ?ｿｽﾄゑｿｽ?ｿｽﾜゑｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ 
                clk_enable <= 1'd1;
                clk_count[7:0]  <= 8'd0;
            end else begin
                clk_enable <= 1'd0;
                clk_count[7:0] <= clk_count[7:0] + 8'd1;
            end
        end
    end
*/

	wire    [7:0]  REG_THINNING ;     //Thinning adc data [7:0]  default 8  2.5Msps  SYSCLK 20Msps
    reg     [10:0]  clk_count;
    reg             clk_enable;
              

    always@ (posedge CLK160M) begin
        if(sRST)begin
            clk_count[10:0] <= 11'd0;
            clk_enable <= 1'd0;
        end else begin
            if(clk_count[10:0] == ({REG_THINNING[7:0],3'h0}-11'h1))begin //?ｿｽﾈゑｿｽ?ｿｽ?ｿｽREG_THINNING+1?ｿｽ?ｿｽ?ｿｽ?ｿｽ1?ｿｽﾉなゑｿｽ?ｿｽﾄゑｿｽ?ｿｽﾜゑｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ 
                clk_enable <= 1'd1;
                clk_count[10:0]  <= 11'd0;
            end else begin
                clk_enable <= 1'd0;
                clk_count[10:0] <= clk_count[10:0] + 11'd1;
            end
        end
    end


//------------------------------------------------------------------------------
//  Trigger
//------------------------------------------------------------------------------
    wire		    irTrgInN	;
	reg			     intTrgIn	;
    reg     [1:0]   srTrgInN    ;
    
    //?ｿｽ^?ｿｽC?ｿｽ~?ｿｽ?ｿｽ?ｿｽO?ｿｽ?ｿｽclk_enable?ｿｽﾉ搾ｿｽ?ｿｽ墲ｹ?ｿｽ?ｿｽ  ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽTRG_INn?ｿｽ?ｿｽwidth?ｿｽ?ｿｽREG_THINNING?ｿｽN?ｿｽ?ｿｽ?ｿｽb?ｿｽN?ｿｽﾈ擾ｿｽ?ｿｽﾝ定す?ｿｽ?ｿｽ
    FD	TRG_FD_0	(.D(TRG_INn)		, .C(CLK160M), .Q(irTrgInN)); 

    always@ (posedge CLK160M) begin
        if(sRST)begin
            srTrgInN[1:0] <= 2'd0;
            intTrgIn <= 1'b0;
        end else begin
            if(clk_enable)begin
                srTrgInN[1:0] <= {srTrgInN[0],irTrgInN};
                intTrgIn <= (srTrgInN[1:0]==2'b10);//trigger?ｿｽ?ｿｽ?ｿｽﾌ確?ｿｽ?ｿｽ
            end
        end
    end

//------------------------------------------------------------------------------
//  ADC interface
//------------------------------------------------------------------------------

//	wire	[2:1]	intAdcClk; 16ch
//	wire	[4:1]	intAdcClk; 32ch
	wire	[8:1]	intAdcClk; 
	
/* 16ch
	ODDR2	ADC_CLK_ODDR_1 (.Q(intAdcClk[1]), .C0(CLK25M), .C1(~CLK25M), .CE(1'b1), .D0(1'b1), .D1(1'b0), .R(1'b0), .S(1'b0));
	ODDR2	ADC_CLK_ODDR_2 (.Q(intAdcClk[2]), .C0(CLK25M), .C1(~CLK25M), .CE(1'b1), .D0(1'b1), .D1(1'b0), .R(1'b0), .S(1'b0));
*/

/* 32ch
	ODDR	ADC_CLK_ODDR_1 (.Q(intAdcClk[1]), .C(CLK20M), .CE(1'b1), .D1(1'b1), .D2(1'b0), .R(1'b0), .S(1'b0));
	ODDR	ADC_CLK_ODDR_2 (.Q(intAdcClk[2]), .C(CLK20M), .CE(1'b1), .D1(1'b1), .D2(1'b0), .R(1'b0), .S(1'b0));
	ODDR	ADC_CLK_ODDR_3 (.Q(intAdcClk[3]), .C(CLK20M), .CE(1'b1), .D1(1'b1), .D2(1'b0), .R(1'b0), .S(1'b0));
	ODDR	ADC_CLK_ODDR_4 (.Q(intAdcClk[4]), .C(CLK20M), .CE(1'b1), .D1(1'b1), .D2(1'b0), .R(1'b0), .S(1'b0));
*/

	ODDR	ADC_CLK_ODDR_1 (.Q(intAdcClk[1]), .C(CLK20M), .CE(1'b1), .D1(1'b1), .D2(1'b0), .R(1'b0), .S(1'b0));
	ODDR	ADC_CLK_ODDR_2 (.Q(intAdcClk[2]), .C(CLK20M), .CE(1'b1), .D1(1'b1), .D2(1'b0), .R(1'b0), .S(1'b0));
	ODDR	ADC_CLK_ODDR_3 (.Q(intAdcClk[3]), .C(CLK20M), .CE(1'b1), .D1(1'b1), .D2(1'b0), .R(1'b0), .S(1'b0));
	ODDR	ADC_CLK_ODDR_4 (.Q(intAdcClk[4]), .C(CLK20M), .CE(1'b1), .D1(1'b1), .D2(1'b0), .R(1'b0), .S(1'b0));
	ODDR	ADC_CLK_ODDR_5 (.Q(intAdcClk[5]), .C(CLK20M), .CE(1'b1), .D1(1'b1), .D2(1'b0), .R(1'b0), .S(1'b0));
    ODDR    ADC_CLK_ODDR_6 (.Q(intAdcClk[6]), .C(CLK20M), .CE(1'b1), .D1(1'b1), .D2(1'b0), .R(1'b0), .S(1'b0));
    ODDR    ADC_CLK_ODDR_7 (.Q(intAdcClk[7]), .C(CLK20M), .CE(1'b1), .D1(1'b1), .D2(1'b0), .R(1'b0), .S(1'b0));
    ODDR    ADC_CLK_ODDR_8 (.Q(intAdcClk[8]), .C(CLK20M), .CE(1'b1), .D1(1'b1), .D2(1'b0), .R(1'b0), .S(1'b0));



/*16ch
	OBUFDS ADC_OBUFDS_1  ( .O(ADC_CLK_P[1]), .OB(ADC_CLK_N[1]), .I(intAdcClk[1]) );
	OBUFDS ADC_OBUFDS_2  ( .O(ADC_CLK_P[2]), .OB(ADC_CLK_N[2]), .I(intAdcClk[2]) );
*/

/////////////ADC_CLK?ｿｽﾌ番搾ｿｽ?ｿｽﾉ抵ｿｽ?ｿｽ?ｿｽ////////////////////

/*  32ch
	OBUFDS ADC_OBUFDS_1  ( .O(ADC_CLK_P[4]), .OB(ADC_CLK_N[4]), .I(intAdcClk[1]) );
	OBUFDS ADC_OBUFDS_2  ( .O(ADC_CLK_P[3]), .OB(ADC_CLK_N[3]), .I(intAdcClk[2]) );
	OBUFDS ADC_OBUFDS_3  ( .O(ADC_CLK_P[2]), .OB(ADC_CLK_N[2]), .I(intAdcClk[3]) );
	OBUFDS ADC_OBUFDS_4  ( .O(ADC_CLK_P[1]), .OB(ADC_CLK_N[1]), .I(intAdcClk[4]) );
*/

// 64ch //
	OBUFDS ADC_OBUFDS_1  ( .O(ADC_CLK_P[1]), .OB(ADC_CLK_N[1]), .I(intAdcClk[1]) );
	OBUFDS ADC_OBUFDS_2  ( .O(ADC_CLK_P[2]), .OB(ADC_CLK_N[2]), .I(intAdcClk[2]) );
	OBUFDS ADC_OBUFDS_3  ( .O(ADC_CLK_P[3]), .OB(ADC_CLK_N[3]), .I(intAdcClk[3]) );
	OBUFDS ADC_OBUFDS_4  ( .O(ADC_CLK_P[4]), .OB(ADC_CLK_N[4]), .I(intAdcClk[4]) );
	OBUFDS ADC_OBUFDS_5  ( .O(ADC_CLK_P[5]), .OB(ADC_CLK_N[5]), .I(intAdcClk[5]) );
    OBUFDS ADC_OBUFDS_6  ( .O(ADC_CLK_P[6]), .OB(ADC_CLK_N[6]), .I(intAdcClk[6]) );
    OBUFDS ADC_OBUFDS_7  ( .O(ADC_CLK_P[7]), .OB(ADC_CLK_N[7]), .I(intAdcClk[7]) );
    OBUFDS ADC_OBUFDS_8  ( .O(ADC_CLK_P[8]), .OB(ADC_CLK_N[8]), .I(intAdcClk[8]) );

/*
genvar j ; 
	wire	[15:0]	adcDd;
generate
	for (j=0;j<16;j=j+1) begin : Gen_Adc_Buf
	  IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_D (.I(ADC_D_P[j]), .IB(ADC_D_N[j]), .O(adcDd[j]) );
	end
endgenerate
*/

genvar j ; 
	wire	[63:0]	adcDd_pre;// [31:0] ?ｿｽ?ｿｽ [63:0]
	wire	[63:0]	adcDd;//[31:0] ?ｿｽ?ｿｽ [63:0]
generate
	for (j=0;j<64;j=j+1) begin : Gen_Adc_Buf
            if(j==0 || j==2 || j==24 || j==25|| j==29 || j==31 || j==38 || j==43|| j==51 )begin
                IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_D (.I(ADC_D_N[j]), .IB(ADC_D_P[j]), .O(adcDd_pre[j]) );
                assign adcDd[j] = ~adcDd_pre[j]; //?ｿｽd?ｿｽl?ｿｽﾆゑｿｽ?ｿｽ?ｿｽADC?ｿｽf?ｿｽ[?ｿｽ^?ｿｽ?ｿｽ?ｿｽ?ｿｽ0,2,17,19,24,25,26,27,28,29,30,31?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽs?ｿｽ?ｿｽ?ｿｽA?ｿｽT?ｿｽC?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽﾎになゑｿｽ?ｿｽﾄゑｿｽ?ｿｽ?ｿｽ
            end else begin                                 //////?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽA?ｿｽ?ｿｽ?ｿｽ?ｿｽﾉ使?ｿｽp?ｿｽﾚ的?ｿｽﾉゑｿｽ?ｿｽAADC?ｿｽM?ｿｽ?ｿｽ?ｿｽｽ転?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽﾄゑｿｽ?ｿｽ?ｿｽ///////
                 IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_D (.I(ADC_D_P[j]), .IB(ADC_D_N[j]), .O(adcDd_pre[j]) );
                assign adcDd[j] = adcDd_pre[j];
	   end
	end
endgenerate

//  16ch
//	wire	[2:1]	adcDc			;
//	wire	[2:1]	adcFc			;

// 32ch
//	wire	[4:1]	adcDc			;
//	wire	[4:1]	adcFc			;

// 64ch
	wire	[8:1]	adcDc			;
	wire	[8:1]	adcFc			;

/* 16ch
        IBUFGDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_DC1 (.I(ADC_DCO_P[1]), .IB(ADC_DCO_N[1]), .O(adcDc[1]) );
        IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_FC1 (.I(ADC_FCO_P[1]), .IB(ADC_FCO_N[1]), .O(adcFc[1]) );
    
        IBUFGDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_DC2 (.I(ADC_DCO_P[2]), .IB(ADC_DCO_N[2]), .O(adcDc[2]) );
        IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_FC2 (.I(ADC_FCO_P[2]), .IB(ADC_FCO_N[2]), .O(adcFc[2]) );
    */
    
    
    //////////ADC?ｿｽﾌ番搾ｿｽ?ｿｽﾉ抵ｿｽ?ｿｽ?ｿｽ/////////////////
    
    /* 32ch
        IBUFGDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_DC1 (.I(ADC_DCO_P[4]), .IB(ADC_DCO_N[4]), .O(adcDc[1]) );
        IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_FC1 (.I(ADC_FCO_P[4]), .IB(ADC_FCO_N[4]), .O(adcFc[1]) );
    
        IBUFGDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_DC2 (.I(ADC_DCO_P[3]), .IB(ADC_DCO_N[3]), .O(adcDc[2]) );
        IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_FC2 (.I(ADC_FCO_P[3]), .IB(ADC_FCO_N[3]), .O(adcFc[2]) );
    
        IBUFGDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_DC3 (.I(ADC_DCO_P[2]), .IB(ADC_DCO_N[2]), .O(adcDc[3]) );
        IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_FC3 (.I(ADC_FCO_P[2]), .IB(ADC_FCO_N[2]), .O(adcFc[3]) );
    
        IBUFGDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_DC4 (.I(ADC_DCO_P[1]), .IB(ADC_DCO_N[1]), .O(adcDc[4]) );
        IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_FC4 (.I(ADC_FCO_P[1]), .IB(ADC_FCO_N[1]), .O(adcFc[4]) );
    */ 
    
    
    // 64ch
        IBUFGDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_DC1 (.I(ADC_DCO_P[1]), .IB(ADC_DCO_N[1]), .O(adcDc[1]) );
        IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_FC1 (.I(ADC_FCO_P[1]), .IB(ADC_FCO_N[1]), .O(adcFc[1]) );
    
        IBUFGDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_DC2 (.I(ADC_DCO_P[2]), .IB(ADC_DCO_N[2]), .O(adcDc[2]) );
        IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_FC2 (.I(ADC_FCO_P[2]), .IB(ADC_FCO_N[2]), .O(adcFc[2]) );
    
        IBUFGDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_DC3 (.I(ADC_DCO_P[3]), .IB(ADC_DCO_N[3]), .O(adcDc[3]) );
        IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_FC3 (.I(ADC_FCO_P[3]), .IB(ADC_FCO_N[3]), .O(adcFc[3]) );
    
        IBUFGDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_DC4 (.I(ADC_DCO_P[4]), .IB(ADC_DCO_N[4]), .O(adcDc[4]) );
        IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_FC4 (.I(ADC_FCO_P[4]), .IB(ADC_FCO_N[4]), .O(adcFc[4]) );
        
        IBUFGDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_DC5 (.I(ADC_DCO_P[5]), .IB(ADC_DCO_N[5]), .O(adcDc[5]) );
        IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_FC5 (.I(ADC_FCO_P[5]), .IB(ADC_FCO_N[5]), .O(adcFc[5]) );
    
        IBUFGDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_DC6 (.I(ADC_DCO_P[6]), .IB(ADC_DCO_N[6]), .O(adcDc[6]) );
        IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_FC6 (.I(ADC_FCO_P[6]), .IB(ADC_FCO_N[6]), .O(adcFc[6]) );
    
        IBUFGDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_DC7 (.I(ADC_DCO_P[7]), .IB(ADC_DCO_N[7]), .O(adcDc[7]) );
        IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_FC7 (.I(ADC_FCO_P[7]), .IB(ADC_FCO_N[7]), .O(adcFc[7]) );
    
        IBUFGDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_DC8 (.I(ADC_DCO_P[8]), .IB(ADC_DCO_N[8]), .O(adcDc[8]) );
        IBUFDS #(.DIFF_TERM ("TRUE")) ADC_IBUFDS_FC8 (.I(ADC_FCO_P[8]), .IB(ADC_FCO_N[8]), .O(adcFc[8]) );
    
    
    
    
    /* 16ch
        wire    [12*8-1:0]    intAdcD0    ;
        wire    [12*8-1:0]    intAdcD1    ;
        wire    [2:1]    adcRxClk            ;  //?ｿｽﾇゑｿｽ?ｿｽﾉゑｿｽ?ｿｽg?ｿｽp?ｿｽ?ｿｽ?ｿｽ?ｿｽﾄゑｿｽ?ｿｽﾈゑｿｽ?ｿｽB
        wire    [2:1]    adcSync            ;  //?ｿｽﾇゑｿｽ?ｿｽﾉゑｿｽ?ｿｽg?ｿｽp?ｿｽ?ｿｽ?ｿｽ?ｿｽﾄゑｿｽ?ｿｽﾈゑｿｽ?ｿｽB
        wire    [2:1]    adcDs                ;
        wire    [2:1]    adcIfFrameOk    ;
    */
    
    /* 32ch
        wire    [12*8-1:0]    intAdcD0    ;
        wire    [12*8-1:0]    intAdcD1    ;
        wire    [12*8-1:0]    intAdcD2    ;
        wire    [12*8-1:0]    intAdcD3    ;
        wire    [4:1]    adcDs                ;
        wire    [4:1]    adcIfFrameOk    ;
    */
    
    // 64ch
        wire    [12*8-1:0]    intAdcD0    ;
        wire    [12*8-1:0]    intAdcD1    ;
        wire    [12*8-1:0]    intAdcD2    ;
        wire    [12*8-1:0]    intAdcD3    ;
        wire    [12*8-1:0]    intAdcD4    ;
        wire    [12*8-1:0]    intAdcD5    ;
        wire    [12*8-1:0]    intAdcD6    ;
        wire    [12*8-1:0]    intAdcD7    ;
        wire    [8:1]    adcDs                ;
        wire    [8:1]    adcIfFrameOk    ;

////////2014.04.03 add//////////////


/*
	wire	[4:1] adcDc_buf;
	
	BUFMR BUFMR_1
	(
		.O(adcDc_buf[1]), // 1-bit output: Clock output (connect to BUFIOs/BUFRs)
		.I(adcDc[1]) // 1-bit input: Clock input (Connect to IBUFG)
	);
	BUFMR BUFMR_2
	(
		.O(adcDc_buf[2]), // 1-bit output: Clock output (connect to BUFIOs/BUFRs)
		.I(adcDc[2]) // 1-bit input: Clock input (Connect to IBUFG)
	);
	BUFMR BUFMR_3
	(
		.O(adcDc_buf[3]), // 1-bit output: Clock output (connect to BUFIOs/BUFRs)
		.I(adcDc[3]) // 1-bit input: Clock input (Connect to IBUFG)
	);
	BUFMR BUFMR_4
	(
		.O(adcDc_buf[4]), // 1-bit output: Clock output (connect to BUFIOs/BUFRs)
		.I(adcDc[4]) // 1-bit input: Clock input (Connect to IBUFG)
	);
*/

// 32ch
//	wire	[4:1]	CLKIO	;

// 64ch
	wire	[8:1]	CLKIO	;

//	wire		CLKIO	;
//	BUFIO BUFIO_4 (.O(CLKIO),.I(adcDc[4]));	


/* 32ch
	BUFIO BUFIO_1 (.O(CLKIO[1]),.I(adcDc[1]));
	BUFIO BUFIO_2 (.O(CLKIO[2]),.I(adcDc[2]));
	BUFIO BUFIO_3 (.O(CLKIO[3]),.I(adcDc[3]));
	BUFIO BUFIO_4 (.O(CLKIO[4]),.I(adcDc[4]));
*/

// 64ch
	BUFIO BUFIO_1 (.O(CLKIO[1]),.I(adcDc[1]));
    BUFIO BUFIO_2 (.O(CLKIO[2]),.I(adcDc[2]));
    BUFIO BUFIO_3 (.O(CLKIO[3]),.I(adcDc[3]));
    BUFIO BUFIO_4 (.O(CLKIO[4]),.I(adcDc[4]));
	BUFIO BUFIO_5 (.O(CLKIO[5]),.I(adcDc[5]));
    BUFIO BUFIO_6 (.O(CLKIO[6]),.I(adcDc[6]));
    BUFIO BUFIO_7 (.O(CLKIO[7]),.I(adcDc[7]));
    BUFIO BUFIO_8 (.O(CLKIO[8]),.I(adcDc[8]));


// 32ch
//	wire	[4:1]	CLKR	;

// 64ch
    wire	[8:1]	CLKR	;

//16ch
    /*    wire        CLKR    ;
        BUFR #(
            .BUFR_DIVIDE("BYPASS"), // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
            .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
        ) BUFR_4 (
            .O        (CLKR    ),               // Clock buffer output
            .CE    (1'b1        ),            // Clock enable input
            .CLR    (1'b0        ),            // Clock buffer reset input
            .I        (adcDc[4])            // Clock buffer input
        );
    */
    
    
    
    /* 32ch
        BUFR #(
            .BUFR_DIVIDE("BYPASS"), // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
            .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
        ) BUFR_1 (
            .O        (CLKR[1]    ),            // Clock buffer output
            .CE    (1'b1        ),            // Clock enable input
            .CLR    (1'b0        ),            // Clock buffer reset input
            .I        (adcDc[1])            // Clock buffer input
        );
        BUFR #(
            .BUFR_DIVIDE("BYPASS"), // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
            .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
        ) BUFR_2 (
            .O        (CLKR[2]    ),            // Clock buffer output
            .CE    (1'b1        ),            // Clock enable input
            .CLR    (1'b0        ),            // Clock buffer reset input
            .I        (adcDc[2])            // Clock buffer input
        );
        BUFR #(
            .BUFR_DIVIDE("BYPASS"), // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
            .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
        ) BUFR_3 (
            .O        (CLKR[3]    ),            // Clock buffer output
            .CE    (1'b1        ),            // Clock enable input
            .CLR    (1'b0        ),            // Clock buffer reset input
            .I        (adcDc[3])            // Clock buffer input
        );
        BUFR #(
            .BUFR_DIVIDE("BYPASS"), // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
            .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
        ) BUFR_4 (
            .O        (CLKR[4]    ),            // Clock buffer output
            .CE    (1'b1        ),            // Clock enable input
            .CLR    (1'b0        ),            // Clock buffer reset input
            .I        (adcDc[4])            // Clock buffer input
        );
    */
    
    
    // 64ch
        BUFR #(
        .BUFR_DIVIDE("BYPASS"), // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
        .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
    ) BUFR_1 (
        .O        (CLKR[1]    ),            // Clock buffer output
        .CE    (1'b1        ),            // Clock enable input
        .CLR    (1'b0        ),            // Clock buffer reset input
        .I        (adcDc[1])            // Clock buffer input
    );
    BUFR #(
        .BUFR_DIVIDE("BYPASS"), // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
        .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
    ) BUFR_2 (
        .O        (CLKR[2]    ),            // Clock buffer output
        .CE    (1'b1        ),            // Clock enable input
        .CLR    (1'b0        ),            // Clock buffer reset input
        .I        (adcDc[2])            // Clock buffer input
    );
    BUFR #(
        .BUFR_DIVIDE("BYPASS"), // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
        .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
    ) BUFR_3 (
        .O        (CLKR[3]    ),            // Clock buffer output
        .CE    (1'b1        ),            // Clock enable input
        .CLR    (1'b0        ),            // Clock buffer reset input
        .I        (adcDc[3])            // Clock buffer input
    );
    BUFR #(
        .BUFR_DIVIDE("BYPASS"), // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
        .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
    ) BUFR_4 (
        .O        (CLKR[4]    ),            // Clock buffer output
        .CE    (1'b1        ),            // Clock enable input
        .CLR    (1'b0        ),            // Clock buffer reset input
        .I        (adcDc[4])            // Clock buffer input
    );
        BUFR #(
        .BUFR_DIVIDE("BYPASS"), // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
        .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
    ) BUFR_5 (
        .O        (CLKR[5]    ),            // Clock buffer output
        .CE    (1'b1        ),            // Clock enable input
        .CLR    (1'b0        ),            // Clock buffer reset input
        .I        (adcDc[5])            // Clock buffer input
    );
    BUFR #(
        .BUFR_DIVIDE("BYPASS"), // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
        .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
    ) BUFR_6 (
        .O        (CLKR[6]    ),            // Clock buffer output
        .CE    (1'b1        ),            // Clock enable input
        .CLR    (1'b0        ),            // Clock buffer reset input
        .I        (adcDc[6])            // Clock buffer input
    );
    BUFR #(
        .BUFR_DIVIDE("BYPASS"), // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
        .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
    ) BUFR_7 (
        .O        (CLKR[7]    ),            // Clock buffer output
        .CE    (1'b1        ),            // Clock enable input
        .CLR    (1'b0        ),            // Clock buffer reset input
        .I        (adcDc[7])            // Clock buffer input
    );
    BUFR #(
        .BUFR_DIVIDE("BYPASS"), // Values: "BYPASS, 1, 2, 3, 4, 5, 6, 7, 8"
        .SIM_DEVICE("7SERIES")  // Must be set to "7SERIES"
    ) BUFR_8 (
        .O        (CLKR[8]    ),            // Clock buffer output
        .CE    (1'b1        ),            // Clock enable input
        .CLR    (1'b0        ),            // Clock buffer reset input
        .I        (adcDc[8])            // Clock buffer input
    );



/////////////////////////

/* 16ch
	AD_ADC_SIF #(
		.DATA_WIDTH	(12	),
		.CH_NUM		(8	)
	)	AD_ADC_SIF_0 (
		.RST				(sRST					),	// in	: System reset
		// ADC
		.CLKIO				(adcDc[1]				),	// IO clock
		.CLKR					(adcDc[1]				),	// Regional clock
		.ADC_FC				(adcFc[1]				),	// in	: Frame
		.ADC_DD				(adcDd[7:0]				),	// in	: Data
		// System I/F(synchronized to ADC_DCO)
		.FRAME_OK			(adcIfFrameOk[1]		),	// out	: Frame error
		.ENB					(adcDs[1]				),	// out	: Clock enable
		.DATA					(intAdcD0[12*8-1:0]	)	// out	: Data
	);

	AD_ADC_SIF #(
		.DATA_WIDTH	(12	),
		.CH_NUM		(8	)
	)	AD_ADC_SIF_1(
		.RST					(sRST					),	// in	: System reset
		// ADC	
		.CLKIO				(adcDc[2]				),	// IO clock
		.CLKR					(adcDc[2]				),	// Regional clock
		.ADC_FC				(adcFc[2]				),	// in	: Frame
		.ADC_DD				(adcDd[15:8]			),	// in	: Data
		// System I/F(synchronized to ADC_DCO)
		.FRAME_OK			(adcIfFrameOk[2]		),	// out	: Frame error
		.ENB					(adcDs[2]				),	// out	: Clock enable
		.DATA					(intAdcD1[12*8-1:0]	)	// out	: Data
	);	
*/



/*  32ch
	AD_ADC_SIF #(
		.DATA_WIDTH	(12	),
		.CH_NUM		(8	)
	)	AD_ADC_SIF_1 (
		.RST					(aRST						),	// in	: System reset
		// ADC
		.CLKIO				(CLKIO[1]				),	// IO clock
		.CLKR					(CLKR[1]				),	// Regional clock
//		.CLKIO				(adcDc[1]		),	// IO clock
//		.CLKR					(adcDc[1]	),	// Regional clock
		.ADC_FC				(adcFc[1]				),	// in	: Frame
		.ADC_DD				(adcDd[7:0]				),	// in	: Data
		// System I/F(synchronized to ADC_DCO)
		.FRAME_OK			(adcIfFrameOk[1]		),	// out	: Frame error
		.ENB					(adcDs[1]				),	// out	: Clock enable
		.DATA					(intAdcD0[12*8-1:0]	)	// out	: Data //////?ｿｽg?ｿｽp?ｿｽﾚ的?ｿｽ?ｿｽ?ｿｽAADC?ｿｽM?ｿｽ?ｿｽ?ｿｽｽ転?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽﾄゑｿｽ?ｿｽ?ｿｽ///////
	);

	AD_ADC_SIF #(
		.DATA_WIDTH	(12	),
		.CH_NUM		(8	)
	)	AD_ADC_SIF_2(
		.RST					(aRST						),	// in	: System reset
		// ADC	
		.CLKIO				(CLKIO[2]				),	// IO clock
		.CLKR					(CLKR[2]				),	// Regional clock
//		.CLKIO				(adcDc[2]				),	// IO clock
//		.CLKR					(adcDc[2]				),	// Regional clock
		.ADC_FC				(adcFc[2]				),	// in	: Frame
		.ADC_DD				(adcDd[15:8]			),	// in	: Data
		// System I/F(synchronized to ADC_DCO)
		.FRAME_OK			(adcIfFrameOk[2]		),	// out	: Frame error
		.ENB					(adcDs[2]				),	// out	: Clock enable
		.DATA					(intAdcD1[12*8-1:0]	)	// out	: Data
	);
	
	AD_ADC_SIF #(
		.DATA_WIDTH	(12	),
		.CH_NUM		(8	)
	)	AD_ADC_SIF_3 (
		.RST					(aRST						),	// in	: System reset
		// ADC
		.CLKIO				(CLKIO[3]				),	// IO clock
		.CLKR					(CLKR[3]				),	// Regional clock
//		.CLKIO				(adcDc[3]				),	// IO clock
//		.CLKR					(adcDc[3]				),	// Regional clock
		.ADC_FC				(adcFc[3]				),	// in	: Frame
		.ADC_DD				(adcDd[23:16]				),	// in	: Data
		// System I/F(synchronized to ADC_DCO)
		.FRAME_OK			(adcIfFrameOk[3]		),	// out	: Frame error
		.ENB					(adcDs[3]				),	// out	: Clock enable
		.DATA					(intAdcD2[12*8-1:0]		)	// out	: Data
	);

	AD_ADC_SIF #(
		.DATA_WIDTH	(12	),
		.CH_NUM		(8	)
	)	AD_ADC_SIF_4(
		.RST					(aRST						),	// in	: System reset
		// ADC	
		.CLKIO				(CLKIO[4]				),	// IO clock
		.CLKR					(CLKR[4]				),	// Regional clock
//		.CLKIO				(adcDc[4]				),	// IO clock
//		.CLKR					(CLKR				),	// Regional clock
		.ADC_FC				(adcFc[4]				),	// in	: Frame
		.ADC_DD				(adcDd[31:24]			),	// in	: Data
		// System I/F(synchronized to ADC_DCO)
		.FRAME_OK			(adcIfFrameOk[4]		),	// out	: Frame error
		.ENB					(adcDs[4]				),	// out	: Clock enable
		.DATA					(intAdcD3[12*8-1:0]	)	// out	: Data
	);
	
*/




// 64ch
	AD_ADC_SIF #(
    .DATA_WIDTH    (12    ),
    .CH_NUM        (8    )
)    AD_ADC_SIF_1 (
    .RST                    (aRST                        ),    // in    : System reset
    // ADC
    .CLKIO                (CLKIO[1]                ),    // IO clock
    .CLKR                    (CLKR[1]                ),    // Regional clock
//        .CLKIO                (adcDc[1]        ),    // IO clock
//        .CLKR                    (adcDc[1]    ),    // Regional clock
    .ADC_FC                (adcFc[1]                ),    // in    : Frame
    .ADC_DD                (adcDd[7:0]                ),    // in    : Data
    // System I/F(synchronized to ADC_DCO)
    .FRAME_OK            (adcIfFrameOk[1]        ),    // out    : Frame error
    .ENB                    (adcDs[1]                ),    // out    : Clock enable
    .DATA                    (intAdcD0[12*8-1:0]    )    // out    : Data //////?ｿｽg?ｿｽp?ｿｽﾚ的?ｿｽ?ｿｽ?ｿｽAADC?ｿｽM?ｿｽ?ｿｽ?ｿｽｽ転?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽﾄゑｿｽ?ｿｽ?ｿｽ///////
);

    AD_ADC_SIF #(
    .DATA_WIDTH    (12    ),
    .CH_NUM        (8    )
)    AD_ADC_SIF_2(
    .RST                    (aRST                        ),    // in    : System reset
    // ADC    
    .CLKIO                (CLKIO[2]                ),    // IO clock
    .CLKR                    (CLKR[2]                ),    // Regional clock
//        .CLKIO                (adcDc[2]                ),    // IO clock
//        .CLKR                    (adcDc[2]                ),    // Regional clock
    .ADC_FC                (adcFc[2]                ),    // in    : Frame
    .ADC_DD                (adcDd[15:8]            ),    // in    : Data
    // System I/F(synchronized to ADC_DCO)
    .FRAME_OK            (adcIfFrameOk[2]        ),    // out    : Frame error
    .ENB                    (adcDs[2]                ),    // out    : Clock enable
    .DATA                    (intAdcD1[12*8-1:0]    )    // out    : Data
);

AD_ADC_SIF #(
    .DATA_WIDTH    (12    ),
    .CH_NUM        (8    )
)    AD_ADC_SIF_3 (
    .RST                    (aRST                        ),    // in    : System reset
    // ADC
    .CLKIO                (CLKIO[3]                ),    // IO clock
    .CLKR                    (CLKR[3]                ),    // Regional clock
//        .CLKIO                (adcDc[3]                ),    // IO clock
//        .CLKR                    (adcDc[3]                ),    // Regional clock
    .ADC_FC                (adcFc[3]                ),    // in    : Frame
    .ADC_DD                (adcDd[23:16]                ),    // in    : Data
    // System I/F(synchronized to ADC_DCO)
    .FRAME_OK            (adcIfFrameOk[3]        ),    // out    : Frame error
    .ENB                    (adcDs[3]                ),    // out    : Clock enable
    .DATA                    (intAdcD2[12*8-1:0]        )    // out    : Data
);

AD_ADC_SIF #(
    .DATA_WIDTH    (12    ),
    .CH_NUM        (8    )
)    AD_ADC_SIF_4(
    .RST                    (aRST                        ),    // in    : System reset
    // ADC    
    .CLKIO                (CLKIO[4]                ),    // IO clock
    .CLKR                    (CLKR[4]                ),    // Regional clock
//        .CLKIO                (adcDc[4]                ),    // IO clock
//        .CLKR                    (CLKR                ),    // Regional clock
    .ADC_FC                (adcFc[4]                ),    // in    : Frame
    .ADC_DD                (adcDd[31:24]            ),    // in    : Data
    // System I/F(synchronized to ADC_DCO)
    .FRAME_OK            (adcIfFrameOk[4]        ),    // out    : Frame error
    .ENB                    (adcDs[4]                ),    // out    : Clock enable
    .DATA                    (intAdcD3[12*8-1:0]    )    // out    : Data
);


	AD_ADC_SIF #(
		.DATA_WIDTH	(12	),
		.CH_NUM		(8	)
	)	AD_ADC_SIF_5 (
		.RST					(aRST					),	// in	: System reset
		// ADC
		.CLKIO				(CLKIO[5]				),	// IO clock
		.CLKR					(CLKR[5]				),	// Regional clock
//		.CLKIO				(adcDc[1]		),	// IO clock
//		.CLKR					(adcDc[1]	),	// Regional clock
		.ADC_FC				(adcFc[5]				),	// in	: Frame
		.ADC_DD				(adcDd[39:32]				),	// in	: Data
		// System I/F(synchronized to ADC_DCO)
		.FRAME_OK			(adcIfFrameOk[5]		),	// out	: Frame error
		.ENB					(adcDs[5]				),	// out	: Clock enable
		.DATA					(intAdcD4[12*8-1:0]	)	// out	: Data //////?ｿｽg?ｿｽp?ｿｽﾚ的?ｿｽ?ｿｽ?ｿｽAADC?ｿｽM?ｿｽ?ｿｽ?ｿｽｽ転?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽﾄゑｿｽ?ｿｽ?ｿｽ///////
	);

	AD_ADC_SIF #(
		.DATA_WIDTH	(12	),
		.CH_NUM		(8	)
	)	AD_ADC_SIF_6(
		.RST					(aRST						),	// in	: System reset
		// ADC	
		.CLKIO				(CLKIO[6]				),	// IO clock
		.CLKR					(CLKR[6]				),	// Regional clock
//		.CLKIO				(adcDc[2]				),	// IO clock
//		.CLKR					(adcDc[2]				),	// Regional clock
		.ADC_FC				(adcFc[6]				),	// in	: Frame
		.ADC_DD				(adcDd[47:40]			),	// in	: Data
		// System I/F(synchronized to ADC_DCO)
		.FRAME_OK			(adcIfFrameOk[6]		),	// out	: Frame error
		.ENB					(adcDs[6]				),	// out	: Clock enable
		.DATA					(intAdcD5[12*8-1:0]	)	// out	: Data
	);
	
	AD_ADC_SIF #(
		.DATA_WIDTH	(12	),
		.CH_NUM		(8	)
	)	AD_ADC_SIF_7 (
		.RST					(aRST						),	// in	: System reset
		// ADC
		.CLKIO				(CLKIO[7]				),	// IO clock
		.CLKR					(CLKR[7]				),	// Regional clock
//		.CLKIO				(adcDc[3]				),	// IO clock
//		.CLKR					(adcDc[3]				),	// Regional clock
		.ADC_FC				(adcFc[7]				),	// in	: Frame
		.ADC_DD				(adcDd[55:48]				),	// in	: Data
		// System I/F(synchronized to ADC_DCO)
		.FRAME_OK			(adcIfFrameOk[7]		),	// out	: Frame error
		.ENB					(adcDs[7]				),	// out	: Clock enable
		.DATA					(intAdcD6[12*8-1:0]		)	// out	: Data
	);

	AD_ADC_SIF #(
		.DATA_WIDTH	(12	),
		.CH_NUM		(8	)
	)	AD_ADC_SIF_8(
		.RST					(aRST				),	// in	: System reset
		// ADC	
		.CLKIO				(CLKIO[8]				),	// IO clock
		.CLKR					(CLKR[8]				),	// Regional clock
//		.CLKIO				(adcDc[4]				),	// IO clock
//		.CLKR					(CLKR				),	// Regional clock
		.ADC_FC				(adcFc[8]				),	// in	: Frame
		.ADC_DD				(adcDd[63:56]			),	// in	: Data
		// System I/F(synchronized to ADC_DCO)
		.FRAME_OK			(adcIfFrameOk[8]		),	// out	: Frame error
		.ENB					(adcDs[8]				),	// out	: Clock enable
		.DATA					(intAdcD7[12*8-1:0]	)	// out	: Data
	);


    reg		[12*64-1:0]	adcData	;
    
// 64ch
	    always@ (posedge CLKR[1]) begin		//?ｿｽ?ｿｽ?ｿｽW?ｿｽX?ｿｽ^?ｿｽ?ｿｽADC?ｿｽf?ｿｽ[?ｿｽ^?ｿｽﾌ格?ｿｽ[
           if(adcDs[1])begin
            adcData[12*1-1:12*0]    <= intAdcD0[12*1-1:12*0];
            adcData[12*2-1:12*1]    <= intAdcD0[12*2-1:12*1];
            adcData[12*3-1:12*2]    <= intAdcD0[12*3-1:12*2];
            adcData[12*4-1:12*3]    <= intAdcD0[12*4-1:12*3];
            adcData[12*5-1:12*4]    <= intAdcD0[12*5-1:12*4];
            adcData[12*6-1:12*5]    <= intAdcD0[12*6-1:12*5];
            adcData[12*7-1:12*6]    <= intAdcD0[12*7-1:12*6];
            adcData[12*8-1:12*7]    <= intAdcD0[12*8-1:12*7];

//            adcData[12*8*(i+1)-1:12*8*i]    <= intAdcD0[12*8-1:0];
           end
         end
  
    always@ (posedge CLKR[2]) begin
    if(adcDs[2])begin
        adcData[12* 9-1:12* 8]    <= intAdcD1[12*1-1:12*0];
        adcData[12*10-1:12* 9]    <= intAdcD1[12*2-1:12*1];
        adcData[12*11-1:12*10]    <= intAdcD1[12*3-1:12*2];
        adcData[12*12-1:12*11]    <= intAdcD1[12*4-1:12*3];
        adcData[12*13-1:12*12]    <= intAdcD1[12*5-1:12*4];
        adcData[12*14-1:12*13]    <= intAdcD1[12*6-1:12*5];
        adcData[12*15-1:12*14]    <= intAdcD1[12*7-1:12*6];
        adcData[12*16-1:12*15]    <= intAdcD1[12*8-1:12*7];
      end
    end

    always@ (posedge CLKR[3]) begin
    if(adcDs[3])begin
        adcData[12*17-1:12*16]    <= intAdcD2[12*1-1:12*0];
        adcData[12*18-1:12*17]    <= intAdcD2[12*2-1:12*1];
        adcData[12*19-1:12*18]    <= intAdcD2[12*3-1:12*2];
        adcData[12*20-1:12*19]    <= intAdcD2[12*4-1:12*3];
        adcData[12*21-1:12*20]    <= intAdcD2[12*5-1:12*4];
        adcData[12*22-1:12*21]    <= intAdcD2[12*6-1:12*5];
        adcData[12*23-1:12*22]    <= intAdcD2[12*7-1:12*6];
        adcData[12*24-1:12*23]    <= intAdcD2[12*8-1:12*7];
       end
     end

    always@ (posedge CLKR[4]) begin
    if(adcDs[4])begin
        adcData[12*25-1:12*24]    <= intAdcD3[12*1-1:12*0];
        adcData[12*26-1:12*25]    <= intAdcD3[12*2-1:12*1];
        adcData[12*27-1:12*26]    <= intAdcD3[12*3-1:12*2];
        adcData[12*28-1:12*27]    <= intAdcD3[12*4-1:12*3];
        adcData[12*29-1:12*28]    <= intAdcD3[12*5-1:12*4];
        adcData[12*30-1:12*29]    <= intAdcD3[12*6-1:12*5];
        adcData[12*31-1:12*30]    <= intAdcD3[12*7-1:12*6];
        adcData[12*32-1:12*31]    <= intAdcD3[12*8-1:12*7];
       end
    end	

   always@ (posedge CLKR[5]) begin		//?ｿｽ?ｿｽ?ｿｽW?ｿｽX?ｿｽ^?ｿｽ?ｿｽADC?ｿｽf?ｿｽ[?ｿｽ^?ｿｽﾌ格?ｿｽ[
        if(adcDs[5])begin
            adcData[12*33-1:12*32]    <= intAdcD4[12*1-1:12*0];
            adcData[12*34-1:12*33]    <= intAdcD4[12*2-1:12*1];
            adcData[12*35-1:12*34]    <= intAdcD4[12*3-1:12*2];
            adcData[12*36-1:12*35]    <= intAdcD4[12*4-1:12*3];
            adcData[12*37-1:12*36]    <= intAdcD4[12*5-1:12*4];
            adcData[12*38-1:12*37]    <= intAdcD4[12*6-1:12*5];
            adcData[12*39-1:12*38]    <= intAdcD4[12*7-1:12*6];
            adcData[12*40-1:12*39]    <= intAdcD4[12*8-1:12*7];
        end
    end

    always@ (posedge CLKR[6]) begin
        if(adcDs[6])begin
            adcData[12*41-1:12*40]    <= intAdcD5[12*1-1:12*0];
            adcData[12*42-1:12*41]    <= intAdcD5[12*2-1:12*1];
            adcData[12*43-1:12*42]    <= intAdcD5[12*3-1:12*2];
            adcData[12*44-1:12*43]    <= intAdcD5[12*4-1:12*3];
            adcData[12*45-1:12*44]    <= intAdcD5[12*5-1:12*4];
            adcData[12*46-1:12*45]    <= intAdcD5[12*6-1:12*5];
            adcData[12*47-1:12*46]    <= intAdcD5[12*7-1:12*6];
            adcData[12*48-1:12*47]    <= intAdcD5[12*8-1:12*7];
        end
    end

    always@ (posedge CLKR[7]) begin
        if(adcDs[7])begin
            adcData[12*49-1:12*48]    <= intAdcD6[12*1-1:12*0];
            adcData[12*50-1:12*49]    <= intAdcD6[12*2-1:12*1];
            adcData[12*51-1:12*50]    <= intAdcD6[12*3-1:12*2];
            adcData[12*52-1:12*51]    <= intAdcD6[12*4-1:12*3];
            adcData[12*53-1:12*52]    <= intAdcD6[12*5-1:12*4];
            adcData[12*54-1:12*53]    <= intAdcD6[12*6-1:12*5];
            adcData[12*55-1:12*54]    <= intAdcD6[12*7-1:12*6];
            adcData[12*56-1:12*55]    <= intAdcD6[12*8-1:12*7];
        end
    end
    
    always@ (posedge CLKR[8]) begin
        if(adcDs[8])begin
            adcData[12*57-1:12*56]    <= intAdcD7[12*1-1:12*0];
            adcData[12*58-1:12*57]    <= intAdcD7[12*2-1:12*1];
            adcData[12*59-1:12*58]    <= intAdcD7[12*3-1:12*2];
            adcData[12*60-1:12*59]    <= intAdcD7[12*4-1:12*3];
            adcData[12*61-1:12*60]    <= intAdcD7[12*5-1:12*4];
            adcData[12*62-1:12*61]    <= intAdcD7[12*6-1:12*5];
            adcData[12*63-1:12*62]    <= intAdcD7[12*7-1:12*6];
            adcData[12*64-1:12*63]    <= intAdcD7[12*8-1:12*7]; 
        end
    end

	wire			ADC_SYNC_OK			;

//	assign	ADC_SYNC_OK	= (&adcIfFrameOk[2:1]); 16ch
    //    assign    ADC_SYNC_OK    = (&adcIfFrameOk[4:1]); 32ch
        assign    ADC_SYNC_OK    = (&adcIfFrameOk[8:1]); //64ch
    
    //    assign    X_LED[2] = ADC_SYNC_OK;                    //ADC?ｿｽﾌデ?ｿｽ[?ｿｽ^?ｿｽ]?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽﾆシ?ｿｽ?ｿｽ?ｿｽN?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽﾄゑｿｽ?ｿｽ?ｿｽ?ｿｽLED?ｿｽ?ｿｽ?ｿｽ_?ｿｽ?ｿｽ
    
        assign    X_LED[0]    = adcIfFrameOk[1] & adcIfFrameOk[2] & adcIfFrameOk[3] & adcIfFrameOk[4];
        assign    X_LED[1]    = adcIfFrameOk[5] & adcIfFrameOk[6] & adcIfFrameOk[7] & adcIfFrameOk[8];
        assign    X_LED[2]    = DIP_SW[1];
        assign  X_LED[3] = CLK160M;


`ifdef SIM								//?ｿｽ_?ｿｽ?ｿｽ?ｿｽV?ｿｽ~?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ[?ｿｽV?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽs?ｿｽ?ｿｽ?ｿｽﾆゑｿｽSIM?ｿｽ?ｿｽ?ｿｽ`?ｿｽ?ｿｽ?ｿｽ?ｿｽﾆ楽?ｿｽH
	reg				SiTCP_ACTIVE		;
`else
	wire				SiTCP_ACTIVE		;
`endif
   
   wire             TRIG_FLG;
   wire             TRIG_ENABLE;
   assign TRIG_ENABLE = ~sRST & REG_TRIG_EN;

   TRIGGER TRIGGER(
                   // .CLK            ( CLK160M            ),
                   .CLK            ( adcDc[1]           ),
                   .RST            ( ~TRIG_ENABLE       ),
                   .ADC_DATA1      ( adcData[96-1:0]    ),
                   .ADC_DATA2      ( adcData[192-1:96]  ),
                   .ADC_DATA3      ( adcData[288-1:192] ),
                   .ADC_DATA4      ( adcData[384-1:288] ),
                   .ADC_DATA5      ( adcData[480-1:384] ),
                   .ADC_DATA6      ( adcData[576-1:480] ),
                   .ADC_DATA7      ( adcData[672-1:576] ),
                   .ADC_DATA8      ( adcData[768-1:672] ),
                   .TRIG_THR       ( REG_THR[11:0]      ),
                   .NUM_TRIG_CH    ( REG_NUMTRGCH[7:0]  ),
                   .TRIG_OUT       ( TRIG_FLG           )
	               );

   assign  NIM_OUT =   TRIG_FLG  ; // sahigash
   // assign  NIM_OUT =   CLKR[1]; // sahigash
   // assign  NIM_OUT =   adcDc[1]; // sahigash


//------------------------------------------------------------------------------
//	Data Buffer
//------------------------------------------------------------------------------
	wire	[15:0]	REG_DELAY			;//?ｿｽg?ｿｽ?ｿｽ?ｿｽK?ｿｽ[?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽb?ｿｽ`?ｿｽ?ｿｽ?ｿｽﾄゑｿｽ?ｿｽ?ｿｽﾇれだ?ｿｽ?ｿｽ?ｿｽO?ｿｽﾌデ?ｿｽ[?ｿｽ^?ｿｽ?ｿｽ]?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽ驍ｩ
												//?ｿｽT?ｿｽ?ｿｽ?ｿｽv?ｿｽ?ｿｽ?ｿｽ?ｿｽ?ｿｽA?ｿｽ?ｿｽ?ｿｽW?ｿｽX?ｿｽ^?ｿｽﾌ托ｿｽ?ｿｽ?ｿｽﾅ変更?ｿｽﾂ能?ｿｽB

    wire                REG_TRIG_EN         ;
    wire    [15:0]      REG_THR             ;
    wire    [7:0]       REG_NUMTRGCH        ;
	wire				RAW_SOD    			;
	wire	[31:0]		RAW_TRG_NUM			;
//	wire	[12*16-1:0]	RAW_ADC				;
//	wire	[12*32-1:0]	RAW_ADC				;  32ch
	wire	[12*64-1:0]	RAW_ADC				; //64ch
	
	ADC_SiTCP_RING		ADC_SiTCP_RING(
	// System
		.SYSCLK				(CLK160M				),	// in	: System clock
		.sRST				(~SiTCP_ACTIVE		),	// in	: System reset
	// Parameters
		.REG_DELAY			(REG_DELAY[15:0]		),	// in	: TRG delay [15:0]
    // Enable
		.ENABLE		        (clk_enable	),	// in	: Enable
	// ADC I/F
	//	.ADC_DATA			(adcData[12*16-1:0]	),	// in	: ADC data[191:0]
	//	.ADC_DATA			(adcData[12*32-1:0]	),	// in	: ADC data[383:0]  32ch
        .ADC_DATA            (adcData[12*64-1:0]),    // in    : ADC data[767:0]  64ch
	// Trigger I/F
		.TRIGGER			(intTrgIn			),	// in	: Trigger
	// Event buffer module I/F
		.RAW_SOD			(RAW_SOD			),	// out	: Start of data
		.RAW_TRG_NUM		(RAW_TRG_NUM[31:0]	),	// out	: Trigger Number[31:0]
	//	.RAW_ADC			(RAW_ADC[12*16-1:0]	)	// out	: Delayed ADC data[191:0]
	//	.RAW_ADC			(RAW_ADC[12*32-1:0]	)	// out	: Delayed ADC data[383:0] 32ch
         .RAW_ADC            (RAW_ADC[12*64-1:0] )    // out    : Delayed ADC data[767:0] 64ch
    );

	wire			SiTCP_TX_AFULL	;
	wire			SiTCP_TX_WE		;
	wire	[7:0]	SiTCP_TX_WD		;

	wire	[23:0]REG_HD_ID		;
	wire	[15:0]	REG_LEN			;
	wire	[1:0]	REG_MODE		;

	ADC_SiTCP_RAW		ADC_SiTCP_RAW(
	// System
		.SYSCLK				(CLK160M				),	// in	: System clock
		.sRST				(~SiTCP_ACTIVE		),	// in	: System reset
	// Parameters
		.REG_HD_ID			(REG_HD_ID[23:0]	),	// in	: Header ID[23:0]
		.REG_WINDOW			(REG_LEN[15:0]		),	// in	: Window size [7:0]
		.REG_MODE			(REG_MODE[1:0]		),	// in	: Mode [1:0]
	// Enable
        .ENABLE		        (clk_enable             ),	// in	: Enable
	// BUF_DELAY I/F
		.RING_SOD			(RAW_SOD			),	// in	: Start of data
		.RING_TRG_NUM		(RAW_TRG_NUM[31:0]	),	// in	: Trigger Number[31:0]
	//	.RING_ADC			(RAW_ADC[12*16-1:0]	),	// in	: Delayed ADC data[191:0]
		.RING_ADC			(RAW_ADC[12*64-1:0]	),	// in	: Delayed ADC data[383:0]
	// SiTCP I/F
		.SiTCP_TX_AFULL	    (SiTCP_TX_AFULL	    ),	// in		: Almost full flag of a TCP Tx FIFO
		.SiTCP_TX_WE		(SiTCP_TX_WE		),	// out	: TCP Tx Data write enable
		.SiTCP_TX_WD		(SiTCP_TX_WD[7:0]	)	// out	: TCP Tx Data[7:0]
	);

`ifdef SIM
	assign	REG_DELAY[15:0]		= 8'd10;
	assign	REG_TRIG_EN		    = 1'b1;
	assign	REG_THR[15:0]		= 16'd1000;
	assign	REG_NUMTRGCH[7:0]		= 8'd3;
	assign	REG_HD_ID[23:0]	= 24'h012345;
	assign	REG_LEN[15:0]		= 16'd0;
	
	assign	SiTCP_TX_AFULL 	= 1'b0;

`else
/*******************************************************************************
*     Network Processor, Tomohisa Uchida                                       *
*******************************************************************************/
	wire			SiTCP_CLOSE_REQ	;
	wire			TIM_1US				;
	wire            TIM_1MS            ;
    wire            DAC_SDI             ;

	wire			SiTCP_RST			;
	wire           reg_RST              ;    //?ｿｽ?ｿｽ?ｿｽW?ｿｽX?ｿｽ^?ｿｽﾌ?ｿｽ?ｿｽZ?ｿｽb?ｿｽg

	wire	[31:0]RBCP_ADDR			;
	wire	[7:0]	RBCP_WD				;
	wire			RBCP_WE				;
	wire			RBCP_RE				;
	wire			RBCP_ACK				;
	wire	[7:0]	RBCP_RD				;
	
	wire   GMII_TX_CLK        ;
	

	

	
	
BUFGMUX #(
    )
    BUFGMUX_inst (
       .O(GMII_TX_CLK),   // 1-bit output: Clock output
       .I0(ETH_TX_CLK), // 1-bit input: Clock input (S=0)
       .I1(CLK125M), // 1-bit input: Clock input (S=1)
       .S(DIP_SW[3])    // 1-bit input: Clock select
    );

	//assign		NIM_OUT = DAC_STRI; 
	
//	 WRAP_SiTCP_MII_XC6S_8K	#(.TIM_PERIOD (8'd25))
	 WRAP_SiTCP_GMII_XC7A_32K	#(.TIM_PERIOD (8'd160))   //MII?ｿｽg?ｿｽp
	 SiTCP(
		.CLK					(CLK160M			),	// in	: System Clock >15MHz
		.RST					(RST				),	// in	: System reset
		.TIM_1MS				(TIM_1MS			),	// out	:
		.TIM_1US                (TIM_1US            ),
	// Configuration parameters
		.FORCE_DEFAULTn		(FORCE_DEFAULTn	),	// in	: Load default parameters
		.EXT_IP_ADDR			(32'h0			),	// in	: IP address[31:0]
		.EXT_TCP_PORT			(16'h0			),	// in	: TCP port #[15:0]
		.EXT_RBCP_PORT			(16'h0			),	// in	: RBCP port #[15:0]
		.PHY_ADDR				(5'd0				),	// in	: PHY-device MIF address[4:0]
	// EEPROM
		.EEPROM_CS				(EEPROM_CS		),	// out	: Chip select
		.EEPROM_SK				(EEPROM_SK		),	// out	: Serial data clock
		.EEPROM_DI				(EEPROM_DI		),	// out	: Serial write data
		.EEPROM_DO				(EEPROM_DO		),	// in	: Serial read data
		// user data, intialial values are stored in the EEPROM, 0xFFFF_FC3C-3F
		.USR_REG_X3C			(),	// out	: Stored at 0xFFFF_FF3C
		.USR_REG_X3D			(),	// out	: Stored at 0xFFFF_FF3D
		.USR_REG_X3E			(),	// out	: Stored at 0xFFFF_FF3E
		.USR_REG_X3F			(),	// out	: Stored at 0xFFFF_FF3F
/*
	// MII interface
		.MII_RSTn				(ETH_RSTn		),	// out	: PHY reset
		// TX
		.MII_TX_CLK				(ETH_TX_CLK		),	// in	: Tx clock
		.MII_TX_EN				(ETH_TX_EN		),	// out	: Tx enable
		.MII_TXD					(ETH_TXD[3:0]	),	// out	: Tx data[3:0]
		.MII_TX_ER				(ETH_TX_ER		),	// out	: TX error
		// RX
		.MII_RX_CLK				(ETH_RX_CLK		),	// in	: Rx clock
		.MII_RX_DV				(ETH_RX_DV		),	// in	: Rx data valid
		.MII_RXD					(ETH_RXD[3:0]	),	// in	: Rx data[3:0]
		.MII_RX_ER				(ETH_RX_ER		),	// in	: Rx error
		.MII_CRS					(ETH_CRS			),	// in	: Carrier sense
		.MII_COL					(ETH_COL			),	// in	: Collision detected
		// Management IF
		.MII_MDC					(ETH_MDC			),	// out	: Clock for MDIO
		.MII_MDIO_IN			(ETH_MDIO		),	// in	: Data
		.MII_MDIO_OUT			(ETH_MDOUT		),	// out	: Data
		.MII_MDIO_OE			(ETH_MDOE		),	// out	: MDIO output enable
*/
	// MII interface
		.GMII_RSTn				(ETH_RSTn		),	// out	: PHY reset
		.GMII_1000M				(DIP_SW[3]			), // in    : GMII mode(1000Mbps) 
		// TX
		.GMII_TX_CLK			(GMII_TX_CLK	),	// in	: Tx clock
		.GMII_TX_EN				(ETH_TX_EN		),	// out	: Tx enable
		.GMII_TXD				(ETH_TXD[7:0]	),	// out	: Tx data[3:0]
		.GMII_TX_ER				(ETH_TX_ER		),	// out	: TX error
		// RX
		.GMII_RX_CLK			(ETH_RX_CLK		),	// in	: Rx clock
		.GMII_RX_DV				(ETH_RX_DV		),	// in	: Rx data valid
		.GMII_RXD				(ETH_RXD[7:0]	),	// in	: Rx data[3:0]
		.GMII_RX_ER				(ETH_RX_ER		),	// in	: Rx error
		.GMII_CRS				(ETH_CRS		),	// in	: Carrier sense
		.GMII_COL				(ETH_COL		),	// in	: Collision detected
		// Management IF
		.GMII_MDC				(ETH_MDC		),	// out	: Clock for MDIO
		.GMII_MDIO_IN			(ETH_MDIO		),	// in	: Data
		.GMII_MDIO_OUT			(ETH_MDOUT		),	// out	: Data
		.GMII_MDIO_OE			(ETH_MDOE		),	// out	: MDIO output enable

	// User I/F
		.SiTCP_RST				(SiTCP_RST		),	// out	: Reset for SiTCP and related circuits
		// TCP connection control
		.TCP_OPEN_REQ			(1'b0				),	// in	: Reserved input, shoud be 0
		.TCP_OPEN_ACK			(SiTCP_ACTIVE	),	// out	: Acknowledge for open (=Socket busy)
		.TCP_ERROR				(),	// out	: TCP error, its active period is equal to MSL
		.TCP_CLOSE_REQ			(SiTCP_CLOSE_REQ		),	// out	: Connection close request
		.TCP_CLOSE_ACK			(SiTCP_CLOSE_REQ		),	// in	: Acknowledge for closing
		// FIFO I/F
		.TCP_RX_WC				(16'h0			),	// in	: Rx FIFO write count[15:0] (Unused bits should be set 1)
		.TCP_RX_WR				(),	// out	: Write enable
		.TCP_RX_DATA			(),	// out	: Write data[7:0]
		.TCP_TX_FULL			(SiTCP_TX_AFULL			),	// out	: Almost full flag
		.TCP_TX_WR				(SiTCP_TX_WE			),	// in	: Write enable
		.TCP_TX_DATA			(SiTCP_TX_WD[7:0]		),	// in	: Write data[7:0]
		// RBCP
		.RBCP_ACT				(),	// out	: RBCP active
		.RBCP_ADDR				(RBCP_ADDR[31:0]		),	// out	: Address[31:0]
		.RBCP_WD				(RBCP_WD[7:0]			),	// out	: Data[7:0]
		.RBCP_WE				(RBCP_WE				),	// out	: Write enable
		.RBCP_RE				(RBCP_RE				),	// out	: Read enable
		.RBCP_ACK				(RBCP_ACK				),	// in	: Access acknowledge
		.RBCP_RD				(RBCP_RD[7:0]			)	// in	: Read data[7:0]
	);

//	wire	[2:1]	intAscSdioIn	;
	wire	[8:1]	intAscSdioIn	;
	wire			intAscSdioOut	;
	wire			intAscSdioEn	;
/* 16ch
        IOBUF adc_iobuf1 ( .IO(ADC_SDIO[1]), .O(intAscSdioIn[1]), .I(intAscSdioOut), .T(intAscSdioEn));
        IOBUF adc_iobuf2 ( .IO(ADC_SDIO[2]), .O(intAscSdioIn[2]), .I(intAscSdioOut), .T(intAscSdioEn));
    */
    /* 32ch
        IOBUF adc_iobuf1 ( .IO(ADC_SDIO[1]), .O(intAscSdioIn[1]), .I(intAscSdioOut), .T(intAscSdioEn));
        IOBUF adc_iobuf2 ( .IO(ADC_SDIO[2]), .O(intAscSdioIn[2]), .I(intAscSdioOut), .T(intAscSdioEn));
        IOBUF adc_iobuf3 ( .IO(ADC_SDIO[3]), .O(intAscSdioIn[3]), .I(intAscSdioOut), .T(intAscSdioEn));
        IOBUF adc_iobuf4 ( .IO(ADC_SDIO[4]), .O(intAscSdioIn[4]), .I(intAscSdioOut), .T(intAscSdioEn));
    */
    
    //64ch
        assign  ADC_SDIO[1] = (intAscSdioEn ? 1'bz : intAscSdioOut);
        assign  ADC_SDIO[2] = (intAscSdioEn ? 1'bz : intAscSdioOut);
        assign  ADC_SDIO[3] = (intAscSdioEn ? 1'bz : intAscSdioOut);
        assign  ADC_SDIO[4] = (intAscSdioEn ? 1'bz : intAscSdioOut);
        assign  ADC_SDIO[5] = (intAscSdioEn ? 1'bz : intAscSdioOut);
        assign  ADC_SDIO[6] = (intAscSdioEn ? 1'bz : intAscSdioOut);
        assign  ADC_SDIO[7] = (intAscSdioEn ? 1'bz : intAscSdioOut);
        assign  ADC_SDIO[8] = (intAscSdioEn ? 1'bz : intAscSdioOut);
        
	LOC_REG				LOC_REG(
		.CLK					(CLK160M					),	// in	: System clock
		.RST					(SiTCP_RST				),	// in	: System reset
		.TIM_1MS				(TIM_1MS					),	// in	: 1us interrupt
        .TIM_1US                (TIM_1US                ), 
		// ADC I/F
/*
		.ADC_SCLK			(ADC_SCLK[2:1]			),	// out	: SPI clock[6:1]
		.ADC_CSB				(ADC_CSB[2:1]			),	// out	: SPI Chip enable
		.ADC_SDIO_IN		(intAscSdioIn[2:1]	),	// out	: SPI data input[2:1]
*/
		.ADC_SCLK			(ADC_SCLK[8:1]			),	// out	: SPI clock[4:1]
		.ADC_CSB			(ADC_CSB[8:1]			),	// out	: SPI Chip enable
		.ADC_SDIO_IN		(ADC_SDIO[8:1]	),	// in 	: SPI data input[2:1]

		.ADC_SDIO_OUT		(intAscSdioOut			),	// out	: SPI data output
		.ADC_SDIO_EN		(intAscSdioEn			),	// out	: SPI data direction

		// DAC I/F
		.DAC_CLKI			(DAC_CLKI),			// out : DAC Serial interface Clock
		.DAC_SDI			(DAC_SDI),			// out : DAC Serial interface Enable
		.DAC_STRI			(DAC_STRI),	
		.NIM_OUT            (NIM_OUT),		// out : DAC DATA
		//TEST SW
		.TEST_SW            (TEST_SW),
		
	// Register I/F
		.LOC_ADDR			(RBCP_ADDR[31:0]		),	// in	: Address[31:0]
		.LOC_WD				(RBCP_WD[7:0]			),	// in	: Data[7:0]
		.LOC_WE				(RBCP_WE					),	// in	: Write enable
		.LOC_RE				(RBCP_RE					),	// in	: Read enable
		.LOC_ACK				(RBCP_ACK				),	// out	: Access acknowledge
		.LOC_RD				(RBCP_RD[7:0]			),	// out	: Read data[7:0]
	// Registers
		.REG_MODE			(REG_MODE[1:0]        ),	// out	: Processing mode[1:0]
		.REG_STATUS0		(),
		.REG_TRG_STATUS	(0						),	//
		.REG_WINDOW			(),	// out	: Window size[6:0]
		.REG_LEN				(REG_LEN[15:0]			),	// out	: Data length[15:0]
		.REG_DELAY			(REG_DELAY[15:0]		),	// out	: Delay time[15:0]
		.REG_TRIG_EN			(REG_TRIG_EN		),	// out	: Trigger enable
		.REG_THR			(REG_THR[15:0]		),	// out	: Trigger threshold[15:0]
		.REG_NUMTRGCH		(REG_NUMTRGCH[7:0]		),	// out	: The number of channels used for trigger [5:0] // <- note!
		.REG_0AX				(REG_HD_ID[23:16]		),
		.REG_0BX				(REG_HD_ID[15: 8]		),
		.REG_0CX				(REG_HD_ID[ 7: 0]		),
		.REG_0DX				(REG_THINNING[7:0]	),	// in	: Thinning adc data [7:0]
	// Pedestal for ADC sum calculation
		.REG_ADC_TH			(),	// out	: ADC threshold[9:0]
		.REG_ADC_PDSTL		()		// out	: Pedestal/sampling [479:0]
	);

`endif

//--------------------------------------------------------------------
//TEST PIN INPUT
//--------------------------------------------------------------------

     reg [9:0] Test_count;  
     reg test_127US ;  
     reg [1:0]test_sync;
     reg Trig_IN_sync;
     reg [1:0] Trig_sync; 
     reg [5:0]  tp_NIM   ;     
     wire NIM_in;
     
     assign  TRG_INn = (~TEST_SW ? NIM_INn[1] : Trig_IN_sync);

     FD	NIM_FD_0	(.D(TesT_In), .C(CLK160M), .Q(NIM_in)); 
     
     always@(posedge CLK160M)begin
        if (RST) begin
          Test_count <= 0;
        end else begin
             if(TIM_1US)begin
                 Test_count[9:0] <= Test_count[9:0] + 10'b1; //test count[6]?ｿｽﾍ趣ｿｽ?ｿｽ?ｿｽ=127us?ｿｽ?ｿｽCLK
             end  
        end         
     end     

     always@(posedge CLK160M)begin
        test_sync[1:0] <= {test_sync[0],Test_count[6]};
        test_127US <= (test_sync[1:0]==2'b10);
     end  
     
     
     always@(posedge CLK160M)begin
        if (RST) begin
          Trig_IN_sync <= 0;
        end else begin
            if(test_127US)begin
              Trig_sync[1:0] <= {Trig_sync[0],NIM_in};
              Trig_IN_sync <= (Trig_sync[1:0]==2'b10);      
            end  
        end         
     end          


     always@(posedge CLK160M)begin
        if (RST) begin
          tp_NIM[5:0] <= 0;
        end else begin
            if(test_127US)begin
              tp_NIM[0]   <=  Trig_IN_sync  ;
              tp_NIM[1]   <=  tp_NIM[0]   ;
              tp_NIM[2]   <=  tp_NIM[1]   ;
              tp_NIM[3]   <=  tp_NIM[2]   ;
              tp_NIM[4]   <=  tp_NIM[3]   ;
              tp_NIM[5]   <=  tp_NIM[4]   ;            
            end 
        end         
     end          
 
        assign    TP_OUT    = tp_NIM[5];           

	


/*	reg		[31:0]	counter;

	always @(posedge CLK20M) begin
		if (sRST) begin
			counter[31:0]	<= 32'd0;
		end else begin
			counter[31:0]	<= counter[31:0] + 32'd1;
		end
	end
	*/
	
//	assign reg_RST = DIP_SW[1];        //?ｿｽ?ｿｽ?ｿｽW?ｿｽX?ｿｽ^?ｿｽﾌ?ｿｽ?ｿｽZ?ｿｽb?ｿｽg

//	assign	X_LED[3]	= counter[23];
//	assign	X_LED[2:1]	= 2'd0;
//	assign	X_LED[0]	= ADC_SYNC_OK;
//	assign	X_LED[1]	= 1'd0;   //X_LED[2]?ｿｽ?ｿｽSYNC?ｿｽﾅ使?ｿｽp

/*
    ila_0 ila_0(
        .clk(CLKR[6]),
        .probe0(intAdcD5[11:0]),
        .probe1(adcIfFrameOk[6]),
        .probe2(adcDs[6])
    );


    ila_1 ila_1(
        .clk(CLK160M),
        .probe0(clk_enable),
        .probe1(adcData[12*33-1:12*32]),
        .probe2(RAW_SOD),
        .probe3(RAW_ADC[12*33-1:12*32])
    );
*/
endmodule
//-------------------------------------------------------------------
