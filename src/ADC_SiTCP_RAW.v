/*******************************************************************************
*                                                                              *
* System      : ADC SiTCP module                                               *
* Version     : v 0.0.0 2012/03/02                                             *
*                 0.0.1 2012/08/02 T.Uchida, fix a problem of multi-trigger    *
*                                                                              *
* Description : Top Module                                                     *
*                                                                              *
* Designer    : Tomohisa Uchida                                                *
*                                                                              *
*                Copyright (c) 2012 Tomohisa Uchida                            *
*                All rights reserved                                           *
*                                                                              *
*******************************************************************************/
module ADC_SiTCP_RAW(
// System
	SYSCLK				,	// in	: System clock
	sRST					,	// in	: System reset
// Parameters
	REG_HD_ID			,	// in	: Header ID[23:0]
	REG_WINDOW			,	// in	: Window size [15:0]
	REG_MODE            ,   // in   : Mode [1:0]
// Enable
    ENABLE              ,
// BUF_DELAY I/F
	RING_SOD			,	// in	: Start of data
	RING_TRG_NUM		,	// in	: Trigger Number[31:0]
 //RING_ADC				,	// in	: Delayed ADC data[191:0]
	RING_ADC			,	// in	: Delayed ADC data[383:0]
// SiTCP I/F
	SiTCP_TX_AFULL		,	// in	: Almost full flag of a TCP Tx FIFO
	SiTCP_TX_WE			,	// out	: TCP Tx Data write enable
	SiTCP_TX_WD				// out	: TCP Tx Data[7:0]
);

//-------- Input/Output -------------
	input			SYSCLK				;
	input			sRST				;

	input	[23:0]	REG_HD_ID			;
	input	[15:0]	REG_WINDOW			;
	input	[1:0]	REG_MODE			;
	
	input           ENABLE              ;
	
	input				RING_SOD		;
	input	[31:0]		RING_TRG_NUM	;
//	input	[12*16-1:0]	RING_ADC		; 16ch
    //    input    [12*32-1:0]    RING_ADC        ; 32ch
        input    [12*64-1:0]    RING_ADC        ;
	
	input			SiTCP_TX_AFULL		;
	output			SiTCP_TX_WE			;
	output	[7:0]	SiTCP_TX_WD			;

//------ output signals -----
	wire			SiTCP_TX_WE			;
	wire	[7:0]	SiTCP_TX_WD			;

//------------------------------------------------------------------------------
//	Input registers
//------------------------------------------------------------------------------
	reg     [15:0]	irWindow		;
	reg     [23:0]	irHdId			;
	reg     [16:0]	irLength		;
	reg     [1:0]  irMode          ;

	always@ (posedge SYSCLK) begin         //パラメータの代入
		irWindow[15:0]	<= REG_WINDOW[15:0];
		irHdId[23:0]	<= REG_HD_ID[23:0];
		irLength[16:0]	<= {1'b0,irWindow[15:0]} + 17'd1;

		irMode[1:0]     <= REG_MODE[1:0];
	end

//	reg		[12*16-1:0]	irAdcData		    ;
//	reg		[12*32-1:0]	irAdcData	    	; 32ch
	reg		[12*64-1:0]	irAdcData	    	; //64ch
	reg		[31:0]		irTrgCunt	    	;
	reg		[3:0]		irSod		    	;
//	reg		[8:0]		wa			      	;
	reg		[12:0]		wa			      	;

	reg				rdBusy			;

	always@ (posedge SYSCLK) begin
	   if(sRST)begin
	       irTrgCunt[31:0] <= 32'd0;
	       irSod[3:0] <= 4'd0;
//	       wa[8:0] <= 9'd0;
	       wa[12:0] <= 13'd0;
	   end else begin
	       if(ENABLE == 1)begin
//		      irAdcData[12*16-1:0]	<= RING_ADC[12*16-1:0];  16ch
           //              irAdcData[12*32-1:0]    <= RING_ADC[12*32-1:0];  32ch
                         irAdcData[12*64-1:0]    <= RING_ADC[12*64-1:0]; //64ch
       
    		  if(RING_SOD & !rdBusy)begin
	       		  irTrgCunt[31:0]		<= RING_TRG_NUM[31:0];   //TRiGGERnumberは0からスタート
		      end
		    
		      irSod[3:0]	<= {irSod[2:0],RING_SOD & !rdBusy};

    		  if(RING_SOD & !rdBusy)begin
//	       		  wa[8:0]	<= 9'h100;
	       		  wa[12:0]	<= 13'h1000;   //最上位bitを立ち上げて、下の条件にはいらせる
		      end else begin
//			      wa[8:0]	<= (wa[8] ? wa[8:0] + 9'd1 : 9'd0);
			      wa[12:0]	<= (wa[12] ? wa[12:0] + 13'd1 : 13'd0);
		      end
		  end
	   end
	end

//------------------------------------------------------------------------------
//	Buffer
//------------------------------------------------------------------------------

//	wire	[12*16-1:0]	wd		;
	wire	[12*64-1:0]	wd		;
	wire				we		;

//	assign	wd[12*16-1:0]	= irAdcData[12*16-1:0];16ch
    //    assign    wd[12*32-1:0]    = irAdcData[12*32-1:0];32ch
        assign    wd[12*64-1:0]    = irAdcData[12*64-1:0];//64ch
	assign	we					= wa[12];
/*
	reg		[13:0]		ra			;
	wire		[12*16-1:0]	rd			;
*/
	reg		[18:0]		ra			;
	wire	[12*64-1:0]	rd			;  //32--64


/*16ch
	mem_64_256		ADC_MEM_0 (
		.clka			(SYSCLK			),
		.wea			(we				), // Bus [0 : 0] 
		.addra		(wa[7:0]			), // Bus [7 : 0] 
		.dina			(wd[63:0]		), // Bus [63 : 0] 
		.clkb			(SYSCLK			),
		.addrb		(ra[12:5]		), // Bus [7 : 0] 
		.doutb		(rd[63:0]		) // Bus [63 : 0] 
	);

	mem_64_256		ADC_MEM_1 (
		.clka			(SYSCLK			),
		.wea			(we				), // Bus [0 : 0] 
		.addra		(wa[7:0]			), // Bus [7 : 0] 
		.dina			(wd[127:64]		), // Bus [63 : 0] 
		.clkb			(SYSCLK			),
		.addrb		(ra[12:5]		), // Bus [7 : 0] 
		.doutb		(rd[127:64]		) // Bus [63 : 0] 
	);

	mem_64_256		ADC_MEM_2 (
		.clka			(SYSCLK			),
		.wea			(we				), // Bus [0 : 0] 
		.addra		(wa[7:0]			), // Bus [7 : 0] 
		.dina			(wd[191:128]	), // Bus [63 : 0] 
		.clkb			(SYSCLK			),
		.addrb		(ra[12:5]		), // Bus [7 : 0] 
		.doutb		(rd[191:128]	) // Bus [63 : 0] 
	);
*/

/*32ch
    mem_gen_8_4K ADC_MEM_0 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[7:0]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[7:0])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_1 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[15:8]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[15:8])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_2 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[23:16]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[23:16])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_3 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[31:24]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[31:24])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_4 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[39:32]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[39:32])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_5 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[47:40]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[47:40])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_6 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[55:48]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[55:48])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_7 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[63:56]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[63:56])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_8 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[71:64]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[71:64])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_9 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[79:72]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[79:72])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_10 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[87:80]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[87:80])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_11 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[95:88]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[95:88])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_12 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[103:96]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[103:96])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_13 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[111:104]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[111:104])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_14 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[119:112]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[119:112])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_15 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[127:120]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[127:120])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_16 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[135:128]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[135:128])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_17 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[143:136]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[143:136])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_18 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[151:144]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[151:144])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_19 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[159:152]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[159:152])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_20 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[167:160]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[167:160])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_21 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[175:168]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[175:168])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_22 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[183:176]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[183:176])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_23 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[191:184]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[191:184])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_24 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[199:192]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[199:192])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_25 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[207:200]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[207:200])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_26 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[215:208]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[215:208])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_27 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[223:216]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[223:216])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_28 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[231:224]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[231:224])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_29 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[239:232]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[239:232])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_30 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[247:240]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[247:240])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_31 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[255:248]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[255:248])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_32 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[263:256]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[263:256])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_33 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[271:264]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[271:264])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_34 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[279:272]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[279:272])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_35 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[287:280]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[287:280])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_36 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[295:288]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[295:288])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_37 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[303:296]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[303:296])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_38 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[311:304]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[311:304])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_39 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[319:312]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[319:312])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_40 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[327:320]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[327:320])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_41 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[335:328]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[335:328])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_42 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[343:336]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[343:336])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_43 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[351:344]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[351:344])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_44 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[359:352]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[359:352])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_45 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[367:360]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[367:360])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_46 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[375:368]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[375:368])  // output wire [7 : 0] doutb
    );

    mem_gen_8_4K ADC_MEM_47 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[383:376]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[17:6]),  // input wire [11 : 0] addrb
        .doutb      (rd[383:376])  // output wire [7 : 0] doutb
    );
*/

     generate
     genvar i;
        for (i=0; i<96; i=i+1)
     begin: mem_generate
      mem_gen_8_4K ADC_MEM_0 (
        .clka       (SYSCLK),    // input wire clka
        .ena        (ENABLE),      // input wire ena
        .wea        (we),      // input wire [0 : 0] wea
        .addra      (wa[11:0]),  // input wire [11 : 0] addra
        .dina       (wd[8*(i+1)-1:8*i]),    // input wire [7 : 0] dina
        .clkb       (SYSCLK),    // input wire clkb
        .enb        (1'b1),      // input wire enb
        .addrb      (ra[18:7]),  // input wire [11 : 0] addrb
        .doutb      (rd[8*(i+1)-1:8*i])  // output wire [7 : 0] doutb
      );
      end
      endgenerate
      


	
	reg				hdSend		;
	reg		[22:0]	len	        ;
	reg		[4:0]	ha			;

	always@ (posedge SYSCLK) begin
		if(sRST)begin
			rdBusy	<= 1'd0;
			hdSend	<= 1'd0;
		end else begin
			rdBusy	<= ~len[22] & (irSod[3] | rdBusy);
			hdSend	<= ~ha[4]   & (irSod[3] | hdSend);
		end
	end

	reg				rdEnb		;
	reg				hdEnb		;

	always@ (posedge SYSCLK) begin
		if(sRST)begin
			rdEnb	<= 1'd0;
			hdEnb	<= 1'd0;
		end else begin
			rdEnb	<= ~len[22] & rdBusy & ~hdSend & ~SiTCP_TX_AFULL;
			hdEnb	<= ~ha[4]   & rdBusy &  hdSend & ~SiTCP_TX_AFULL;
		end

		if(!rdBusy)begin
			ha[4:0]		<= 5'd15;
//			ra[13:0]	<= 14'd0;
			ra[18:0]	<= 19'd0;
			len[22:0]	<= {1'b0,~irWindow[15:0],6'd0};
		end else begin
			if(hdEnb)begin
				ha[4:0]	<= ha[4:0] - 5'd1;
			end
			if(rdEnb)begin
//				ra[13:0]	<= ra[13:0] + 14'd1;
				ra[18:0]	<= ra[18:0] + 19'd1;
				len[22:0]	<= len[22:0] + 24'd1;
			end
		end
	end

	reg				hdVal		;
	reg		[3:0]	rdHa		;
//	reg		[4:0]	rdRa		;
	reg		[6:0]	rdRa		;
//	reg		[1:0]	rdVal		;1bitで足りる
	reg				rdVal		;

	always@ (posedge SYSCLK) begin
		rdHa[3:0]	<=  ha[3:0];
		hdVal		<= ~ha[4] & hdEnb;

//		rdRa[4:0]	<=  ra[4:0];
		rdRa[6:0]	<=  ra[6:0];
//		rdVal[0]	<= ~len[21] & rdEnb;
		rdVal		<= ~len[22] & rdEnb;
	end

	reg		[3:0]	dlyRdHa		;
	reg				dlyHdVal		;
//	reg		[4:0]	dlyRdRa		;
	reg		[6:0]	dlyRdRa		;
	reg				dlyRdVal		;

	always@ (posedge SYSCLK) begin
		dlyRdHa[3:0]	<= rdHa[3:0];
		dlyHdVal		<= hdVal;

//		dlyRdRa[4:0]	<= rdRa[4:0];
		dlyRdRa[6:0]	<= rdRa[6:0];
		dlyRdVal		<= rdVal;
	end

	reg		[7:0]	rdHdData	;
	reg				rdHdVal	;
	reg		[7:0]	rdAdcData;
	reg				rdAdcVal	;

	wire	[31:0]	length		;

	assign	length[31:0]	= {9'd0,irLength[16:0],6'd0}; //*64ch

	always@ (posedge SYSCLK) begin
		case(dlyRdHa[3:0])
			4'd15:	rdHdData[7:0]	<= 8'hFF;	// Unused
			4'd14:	rdHdData[7:0]	<= 8'hFF;	// Unused
			4'd13:	rdHdData[7:0]	<= 8'h55;	// Unused
			4'd12:	rdHdData[7:0]	<= 8'h55;	// Unused
			4'd11:	rdHdData[7:0]	<= irMode[0];	// Mode
			4'd10:	rdHdData[7:0]	<= irHdId[23:16];   //HeaderID
			4'd9:	rdHdData[7:0]	<= irHdId[15: 8];   //
			4'd8:	rdHdData[7:0]	<= irHdId[ 7: 0];   //
			4'd7:	rdHdData[7:0]	<= length[31:24];	// Length
			4'd6:	rdHdData[7:0]	<= length[23:16];
			4'd5:	rdHdData[7:0]	<= length[15: 8];
			4'd4:	rdHdData[7:0]	<= length[ 7: 0];
			4'd3:	rdHdData[7:0]	<= irTrgCunt[31:24];	// Trigger count
			4'd2:	rdHdData[7:0]	<= irTrgCunt[23:16];
			4'd1:	rdHdData[7:0]	<= irTrgCunt[15: 8];
			default:rdHdData[7:0]	<= irTrgCunt[ 7: 0];
		endcase
		
		rdHdVal		<= dlyHdVal;
/*
		case(4:0])
			5'd0: rdAdcData[7:0]	<= {4'd0,rd[12*0+11:12*0+8]};
			5'd1: rdAdcData[7:0]	<= rd[12*0+7:12*0];
			5'd2: rdAdcData[7:0]	<= {4'd0,rd[12*1+11:12*1+8]};
			5'd3: rdAdcData[7:0]	<= rd[12*1+7:12*1];
			5'd4: rdAdcData[7:0]	<= {4'd0,rd[12*2+11:12*2+8]};
			5'd5: rdAdcData[7:0]	<= rd[12*2+7:12*2];
			5'd6: rdAdcData[7:0]	<= {4'd0,rd[12*3+11:12*3+8]};
			5'd7: rdAdcData[7:0]	<= rd[12*3+7:12*3];
			5'd8: rdAdcData[7:0]	<= {4'd0,rd[12*4+11:12*4+8]};
			5'd9: rdAdcData[7:0]	<= rd[12*4+7:12*4];
			5'd10:rdAdcData[7:0]	<= {4'd0,rd[12*5+11:12*5+8]};
			5'd11:rdAdcData[7:0]	<= rd[12*5+7:12*5];
			5'd12:rdAdcData[7:0]	<= {4'd0,rd[12*6+11:12*6+8]};
			5'd13:rdAdcData[7:0]	<= rd[12*6+7:12*6];
			5'd14:rdAdcData[7:0]	<= {4'd0,rd[12*7+11:12*7+8]};
			5'd15:rdAdcData[7:0]	<= rd[12*7+7:12*7];
			5'd16:rdAdcData[7:0]	<= {4'd0,rd[12*8+11:12*8+8]};
			5'd17:rdAdcData[7:0]	<= rd[12*8+7:12*8];
			5'd18:rdAdcData[7:0]	<= {4'd0,rd[12*9+11:12*9+8]};
			5'd19:rdAdcData[7:0]	<= rd[12*9+7:12*9];
			5'd20:rdAdcData[7:0]	<= {4'd0,rd[12*10+11:12*10+8]};
			5'd21:rdAdcData[7:0]	<= rd[12*10+7:12*10];
			5'd22:rdAdcData[7:0]	<= {4'd0,rd[12*11+11:12*11+8]};
			5'd23:rdAdcData[7:0]	<= rd[12*11+7:12*11];
			5'd24:rdAdcData[7:0]	<= {4'd0,rd[12*12+11:12*12+8]};
			5'd25:rdAdcData[7:0]	<= rd[12*12+7:12*12];
			5'd26:rdAdcData[7:0]	<= {4'd0,rd[12*13+11:12*13+8]};
			5'd27:rdAdcData[7:0]	<= rd[12*13+7:12*13];
			5'd28:rdAdcData[7:0]	<= {4'd0,rd[12*14+11:12*14+8]};
			5'd29:rdAdcData[7:0]	<= rd[12*14+7:12*14];
			5'd30:rdAdcData[7:0]	<= {4'd0,rd[12*15+11:12*15+8]};
			5'd31:rdAdcData[7:0]	<= rd[12*15+7:12*15];
		endcase
*/

/*32ch
		case(5:0])
			6'd0: rdAdcData[7:0]	<= {4'd0,rd[12*0+11:12*0+8]};
			6'd1: rdAdcData[7:0]	<= rd[12*0+7:12*0];
			6'd2: rdAdcData[7:0]	<= {4'd0,rd[12*1+11:12*1+8]};
			6'd3: rdAdcData[7:0]	<= rd[12*1+7:12*1];
			6'd4: rdAdcData[7:0]	<= {4'd0,rd[12*2+11:12*2+8]};
			6'd5: rdAdcData[7:0]	<= rd[12*2+7:12*2];
			6'd6: rdAdcData[7:0]	<= {4'd0,rd[12*3+11:12*3+8]};
			6'd7: rdAdcData[7:0]	<= rd[12*3+7:12*3];
			6'd8: rdAdcData[7:0]	<= {4'd0,rd[12*4+11:12*4+8]};
			6'd9: rdAdcData[7:0]	<= rd[12*4+7:12*4];
			6'd10:rdAdcData[7:0]	<= {4'd0,rd[12*5+11:12*5+8]};
			6'd11:rdAdcData[7:0]	<= rd[12*5+7:12*5];
			6'd12:rdAdcData[7:0]	<= {4'd0,rd[12*6+11:12*6+8]};
			6'd13:rdAdcData[7:0]	<= rd[12*6+7:12*6];
			6'd14:rdAdcData[7:0]	<= {4'd0,rd[12*7+11:12*7+8]};
			6'd15:rdAdcData[7:0]	<= rd[12*7+7:12*7];
			6'd16:rdAdcData[7:0]	<= {4'd0,rd[12*8+11:12*8+8]};
			6'd17:rdAdcData[7:0]	<= rd[12*8+7:12*8];
			6'd18:rdAdcData[7:0]	<= {4'd0,rd[12*9+11:12*9+8]};
			6'd19:rdAdcData[7:0]	<= rd[12*9+7:12*9];
			6'd20:rdAdcData[7:0]	<= {4'd0,rd[12*10+11:12*10+8]};
			6'd21:rdAdcData[7:0]	<= rd[12*10+7:12*10];
			6'd22:rdAdcData[7:0]	<= {4'd0,rd[12*11+11:12*11+8]};
			6'd23:rdAdcData[7:0]	<= rd[12*11+7:12*11];
			6'd24:rdAdcData[7:0]	<= {4'd0,rd[12*12+11:12*12+8]};
			6'd25:rdAdcData[7:0]	<= rd[12*12+7:12*12];
			6'd26:rdAdcData[7:0]	<= {4'd0,rd[12*13+11:12*13+8]};
			6'd27:rdAdcData[7:0]	<= rd[12*13+7:12*13];
			6'd28:rdAdcData[7:0]	<= {4'd0,rd[12*14+11:12*14+8]};
			6'd29:rdAdcData[7:0]	<= rd[12*14+7:12*14];
			6'd30:rdAdcData[7:0]	<= {4'd0,rd[12*15+11:12*15+8]};
			6'd31:rdAdcData[7:0]	<= rd[12*15+7:12*15];
			6'd32:rdAdcData[7:0]	<= {4'd0,rd[12*16+11:12*16+8]};
			6'd33:rdAdcData[7:0]	<= rd[12*16+7:12*16];
			6'd34:rdAdcData[7:0]	<= {4'd0,rd[12*17+11:12*17+8]};
			6'd35:rdAdcData[7:0]	<= rd[12*17+7:12*17];
			6'd36:rdAdcData[7:0]	<= {4'd0,rd[12*18+11:12*18+8]};
			6'd37:rdAdcData[7:0]	<= rd[12*18+7:12*18];
			6'd38:rdAdcData[7:0]	<= {4'd0,rd[12*19+11:12*19+8]};
			6'd39:rdAdcData[7:0]	<= rd[12*19+7:12*19];
			6'd40:rdAdcData[7:0]	<= {4'd0,rd[12*20+11:12*20+8]};
			6'd41:rdAdcData[7:0]	<= rd[12*20+7:12*20];
			6'd42:rdAdcData[7:0]	<= {4'd0,rd[12*21+11:12*21+8]};
			6'd43:rdAdcData[7:0]	<= rd[12*21+7:12*21];
			6'd44:rdAdcData[7:0]	<= {4'd0,rd[12*22+11:12*22+8]};
			6'd45:rdAdcData[7:0]	<= rd[12*22+7:12*22];
			6'd46:rdAdcData[7:0]	<= {4'd0,rd[12*23+11:12*23+8]};
			6'd47:rdAdcData[7:0]	<= rd[12*23+7:12*23];
			6'd48:rdAdcData[7:0]	<= {4'd0,rd[12*24+11:12*24+8]};
			6'd49:rdAdcData[7:0]	<= rd[12*24+7:12*24];
			6'd50:rdAdcData[7:0]	<= {4'd0,rd[12*25+11:12*25+8]};
			6'd51:rdAdcData[7:0]	<= rd[12*25+7:12*25];
			6'd52:rdAdcData[7:0]	<= {4'd0,rd[12*26+11:12*26+8]};
			6'd53:rdAdcData[7:0]	<= rd[12*26+7:12*26];
			6'd54:rdAdcData[7:0]	<= {4'd0,rd[12*27+11:12*27+8]};
			6'd55:rdAdcData[7:0]	<= rd[12*27+7:12*27];
			6'd56:rdAdcData[7:0]	<= {4'd0,rd[12*28+11:12*28+8]};
			6'd57:rdAdcData[7:0]	<= rd[12*28+7:12*28];
			6'd58:rdAdcData[7:0]	<= {4'd0,rd[12*29+11:12*29+8]};
			6'd59:rdAdcData[7:0]	<= rd[12*29+7:12*29];
			6'd60:rdAdcData[7:0]	<= {4'd0,rd[12*30+11:12*30+8]};
			6'd61:rdAdcData[7:0]	<= rd[12*30+7:12*30];
			6'd62:rdAdcData[7:0]	<= {4'd0,rd[12*31+11:12*31+8]};
			6'd63:rdAdcData[7:0]	<= rd[12*31+7:12*31];
		endcase
*/

		case(dlyRdRa[6:0])   // [6:0]
			7'd0: rdAdcData[7:0]	<= {4'd0,rd[12*0+11:12*0+8]}; // 
			7'd1: rdAdcData[7:0]	<= rd[12*0+7:12*0];
			7'd2: rdAdcData[7:0]	<= {4'd0,rd[12*1+11:12*1+8]};
			7'd3: rdAdcData[7:0]	<= rd[12*1+7:12*1];
			7'd4: rdAdcData[7:0]	<= {4'd0,rd[12*2+11:12*2+8]};
			7'd5: rdAdcData[7:0]	<= rd[12*2+7:12*2];
			7'd6: rdAdcData[7:0]	<= {4'd0,rd[12*3+11:12*3+8]};
			7'd7: rdAdcData[7:0]	<= rd[12*3+7:12*3];
			7'd8: rdAdcData[7:0]	<= {4'd0,rd[12*4+11:12*4+8]};
			7'd9: rdAdcData[7:0]	<= rd[12*4+7:12*4];
			7'd10:rdAdcData[7:0]	<= {4'd0,rd[12*5+11:12*5+8]};
			7'd11:rdAdcData[7:0]	<= rd[12*5+7:12*5];
			7'd12:rdAdcData[7:0]	<= {4'd0,rd[12*6+11:12*6+8]};
			7'd13:rdAdcData[7:0]	<= rd[12*6+7:12*6];
			7'd14:rdAdcData[7:0]	<= {4'd0,rd[12*7+11:12*7+8]};
			7'd15:rdAdcData[7:0]	<= rd[12*7+7:12*7];
			7'd16:rdAdcData[7:0]	<= {4'd0,rd[12*8+11:12*8+8]};
			7'd17:rdAdcData[7:0]	<= rd[12*8+7:12*8];
			7'd18:rdAdcData[7:0]	<= {4'd0,rd[12*9+11:12*9+8]};
			7'd19:rdAdcData[7:0]	<= rd[12*9+7:12*9];
			7'd20:rdAdcData[7:0]	<= {4'd0,rd[12*10+11:12*10+8]};
			7'd21:rdAdcData[7:0]	<= rd[12*10+7:12*10];
			7'd22:rdAdcData[7:0]	<= {4'd0,rd[12*11+11:12*11+8]};
			7'd23:rdAdcData[7:0]	<= rd[12*11+7:12*11];
			7'd24:rdAdcData[7:0]	<= {4'd0,rd[12*12+11:12*12+8]};
			7'd25:rdAdcData[7:0]	<= rd[12*12+7:12*12];
			7'd26:rdAdcData[7:0]	<= {4'd0,rd[12*13+11:12*13+8]};
			7'd27:rdAdcData[7:0]	<= rd[12*13+7:12*13];
			7'd28:rdAdcData[7:0]	<= {4'd0,rd[12*14+11:12*14+8]};
			7'd29:rdAdcData[7:0]	<= rd[12*14+7:12*14];
			7'd30:rdAdcData[7:0]	<= {4'd0,rd[12*15+11:12*15+8]};
			7'd31:rdAdcData[7:0]	<= rd[12*15+7:12*15];
			7'd32:rdAdcData[7:0]	<= {4'd0,rd[12*16+11:12*16+8]};
			7'd33:rdAdcData[7:0]	<= rd[12*16+7:12*16];
			7'd34:rdAdcData[7:0]	<= {4'd0,rd[12*17+11:12*17+8]};
			7'd35:rdAdcData[7:0]	<= rd[12*17+7:12*17];
			7'd36:rdAdcData[7:0]	<= {4'd0,rd[12*18+11:12*18+8]};
			7'd37:rdAdcData[7:0]	<= rd[12*18+7:12*18];
			7'd38:rdAdcData[7:0]	<= {4'd0,rd[12*19+11:12*19+8]};
			7'd39:rdAdcData[7:0]	<= rd[12*19+7:12*19];
			7'd40:rdAdcData[7:0]	<= {4'd0,rd[12*20+11:12*20+8]};
			7'd41:rdAdcData[7:0]	<= rd[12*20+7:12*20];
			7'd42:rdAdcData[7:0]	<= {4'd0,rd[12*21+11:12*21+8]};
			7'd43:rdAdcData[7:0]	<= rd[12*21+7:12*21];
			7'd44:rdAdcData[7:0]	<= {4'd0,rd[12*22+11:12*22+8]};
			7'd45:rdAdcData[7:0]	<= rd[12*22+7:12*22];
			7'd46:rdAdcData[7:0]	<= {4'd0,rd[12*23+11:12*23+8]};
			7'd47:rdAdcData[7:0]	<= rd[12*23+7:12*23];
			7'd48:rdAdcData[7:0]	<= {4'd0,rd[12*24+11:12*24+8]};
			7'd49:rdAdcData[7:0]	<= rd[12*24+7:12*24];
			7'd50:rdAdcData[7:0]	<= {4'd0,rd[12*25+11:12*25+8]};
			7'd51:rdAdcData[7:0]	<= rd[12*25+7:12*25];
			7'd52:rdAdcData[7:0]	<= {4'd0,rd[12*26+11:12*26+8]};
			7'd53:rdAdcData[7:0]	<= rd[12*26+7:12*26];
			7'd54:rdAdcData[7:0]	<= {4'd0,rd[12*27+11:12*27+8]};
			7'd55:rdAdcData[7:0]	<= rd[12*27+7:12*27];
			7'd56:rdAdcData[7:0]	<= {4'd0,rd[12*28+11:12*28+8]};
			7'd57:rdAdcData[7:0]	<= rd[12*28+7:12*28];
			7'd58:rdAdcData[7:0]	<= {4'd0,rd[12*29+11:12*29+8]};
			7'd59:rdAdcData[7:0]	<= rd[12*29+7:12*29];
			7'd60:rdAdcData[7:0]	<= {4'd0,rd[12*30+11:12*30+8]};
			7'd61:rdAdcData[7:0]	<= rd[12*30+7:12*30];
			7'd62:rdAdcData[7:0]	<= {4'd0,rd[12*31+11:12*31+8]};
			7'd63:rdAdcData[7:0]	<= rd[12*31+7:12*31];
			7'd64: rdAdcData[7:0]	<= {4'd0,rd[12*32+11:12*32+8]}; 
            7'd65: rdAdcData[7:0]    <= rd[12*32+7:12*32];
            7'd66: rdAdcData[7:0]    <= {4'd0,rd[12*33+11:12*33+8]};
            7'd67: rdAdcData[7:0]    <= rd[12*33+7:12*33];
            7'd68: rdAdcData[7:0]    <= {4'd0,rd[12*34+11:12*34+8]};
            7'd69: rdAdcData[7:0]    <= rd[12*34+7:12*34];
            7'd70: rdAdcData[7:0]    <= {4'd0,rd[12*35+11:12*35+8]};
            7'd71: rdAdcData[7:0]    <= rd[12*35+7:12*35];
            7'd72: rdAdcData[7:0]    <= {4'd0,rd[12*36+11:12*36+8]};
            7'd73: rdAdcData[7:0]    <= rd[12*36+7:12*36];
            7'd74:rdAdcData[7:0]    <= {4'd0,rd[12*37+11:12*37+8]};
            7'd75:rdAdcData[7:0]    <= rd[12*37+7:12*37];
            7'd76:rdAdcData[7:0]    <= {4'd0,rd[12*38+11:12*38+8]};
            7'd77:rdAdcData[7:0]    <= rd[12*38+7:12*38];
            7'd78:rdAdcData[7:0]    <= {4'd0,rd[12*39+11:12*39+8]};
            7'd79:rdAdcData[7:0]    <= rd[12*39+7:12*39];
            7'd80:rdAdcData[7:0]    <= {4'd0,rd[12*40+11:12*40+8]};
            7'd81:rdAdcData[7:0]    <= rd[12*40+7:12*40];
            7'd82:rdAdcData[7:0]    <= {4'd0,rd[12*41+11:12*41+8]};
            7'd83:rdAdcData[7:0]    <= rd[12*41+7:12*41];
            7'd84:rdAdcData[7:0]    <= {4'd0,rd[12*42+11:12*42+8]};
            7'd85:rdAdcData[7:0]    <= rd[12*42+7:12*42];
            7'd86:rdAdcData[7:0]    <= {4'd0,rd[12*43+11:12*43+8]};
            7'd87:rdAdcData[7:0]    <= rd[12*43+7:12*43];
            7'd88:rdAdcData[7:0]    <= {4'd0,rd[12*44+11:12*44+8]};
            7'd89:rdAdcData[7:0]    <= rd[12*44+7:12*44];
            7'd90:rdAdcData[7:0]    <= {4'd0,rd[12*45+11:12*45+8]};
            7'd91:rdAdcData[7:0]    <= rd[12*45+7:12*45];
            7'd92:rdAdcData[7:0]    <= {4'd0,rd[12*46+11:12*46+8]};
            7'd93:rdAdcData[7:0]    <= rd[12*46+7:12*46];
            7'd94:rdAdcData[7:0]    <= {4'd0,rd[12*47+11:12*47+8]};
            7'd95:rdAdcData[7:0]    <= rd[12*47+7:12*47];
            7'd96:rdAdcData[7:0]    <= {4'd0,rd[12*48+11:12*48+8]};
            7'd97:rdAdcData[7:0]    <= rd[12*48+7:12*48];
            7'd98:rdAdcData[7:0]    <= {4'd0,rd[12*49+11:12*49+8]};
            7'd99:rdAdcData[7:0]    <= rd[12*49+7:12*49];
            7'd100:rdAdcData[7:0]    <= {4'd0,rd[12*50+11:12*50+8]};
            7'd101:rdAdcData[7:0]    <= rd[12*50+7:12*50];
            7'd102:rdAdcData[7:0]    <= {4'd0,rd[12*51+11:12*51+8]};
            7'd103:rdAdcData[7:0]    <= rd[12*51+7:12*51];
            7'd104:rdAdcData[7:0]    <= {4'd0,rd[12*52+11:12*52+8]};
            7'd105:rdAdcData[7:0]    <= rd[12*52+7:12*52];
            7'd106:rdAdcData[7:0]    <= {4'd0,rd[12*53+11:12*53+8]};
            7'd107:rdAdcData[7:0]    <= rd[12*53+7:12*53];
            7'd108:rdAdcData[7:0]    <= {4'd0,rd[12*54+11:12*54+8]};
            7'd109:rdAdcData[7:0]    <= rd[12*54+7:12*54];
            7'd110:rdAdcData[7:0]    <= {4'd0,rd[12*55+11:12*55+8]};
            7'd111:rdAdcData[7:0]    <= rd[12*55+7:12*55];
            7'd112:rdAdcData[7:0]    <= {4'd0,rd[12*56+11:12*56+8]};
            7'd113:rdAdcData[7:0]    <= rd[12*56+7:12*56];
            7'd114:rdAdcData[7:0]    <= {4'd0,rd[12*57+11:12*57+8]};
            7'd115:rdAdcData[7:0]    <= rd[12*57+7:12*57];
            7'd116:rdAdcData[7:0]    <= {4'd0,rd[12*58+11:12*58+8]};
            7'd117:rdAdcData[7:0]    <= rd[12*58+7:12*58];
            7'd118:rdAdcData[7:0]    <= {4'd0,rd[12*59+11:12*59+8]};
            7'd119:rdAdcData[7:0]    <= rd[12*59+7:12*59];
            7'd120:rdAdcData[7:0]    <= {4'd0,rd[12*60+11:12*60+8]};
            7'd121:rdAdcData[7:0]    <= rd[12*60+7:12*60];
            7'd122:rdAdcData[7:0]    <= {4'd0,rd[12*61+11:12*61+8]};
            7'd123:rdAdcData[7:0]    <= rd[12*61+7:12*61];
            7'd124:rdAdcData[7:0]    <= {4'd0,rd[12*62+11:12*62+8]};
            7'd125:rdAdcData[7:0]    <= rd[12*62+7:12*62];
            7'd126:rdAdcData[7:0]    <= {4'd0,rd[12*63+11:12*63+8]};
            7'd127:rdAdcData[7:0]    <= rd[12*63+7:12*63];
        endcase

		rdAdcVal	<= dlyRdVal;
	end

	reg				orSitcpWe		;
	reg		[7:0]	orSitcpWd		;

	always@ (posedge SYSCLK) begin
		if(sRST)begin
			orSitcpWe		<= 1'b0;
			orSitcpWd[7:0]	<= 8'd0;
		end else begin
			orSitcpWe		<= rdHdVal | rdAdcVal;
			orSitcpWd[7:0]	<=	(rdHdVal	? rdHdData[7:0]		: 8'd0)|
								(rdAdcVal	? rdAdcData[7:0]	: 8'd0);
		end
	end

	assign	SiTCP_TX_WE			= orSitcpWe;
	assign	SiTCP_TX_WD[7:0]	= orSitcpWd[7:0];

//------------------------------------------------------------------------------
endmodule
