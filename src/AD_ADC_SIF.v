/*******************************************************************************
*                                                                              *
* Function    : Serial data interface for ADC of analog devices corp.          *
* Version     : v 0.1.0 2010/12/19                                             *
* Designer    : Tomohisa Uchida                                                *
*                                                                              *
*                Copyright (c) 2010 Tomohisa Uchida                            *
*                All rights reserved                                           *
*                                                                              *
*******************************************************************************/
module AD_ADC_SIF #(
//		parameter DATA_WIDTH   = 10,
		parameter DATA_WIDTH   = 12,
		parameter CH_NUM   = 8
	)
	(
// System
	RST					,	// in	: System reset
// ADC
	CLKIO				,	// IO clock
	CLKR				,	// Regional clock (or system clock)
//	ADC_DC				,	// in	: Clock
	ADC_FC				,	// in	: Frame
	ADC_DD				,	// in	: Data
// System I/F(synchronized to ADC_DCO)
	FRAME_OK			,	// out	: Frame error
	ENB					,	// out	: Clock enable
	DATA					// out	: Data
);

//-------- Input/Output -------------
	input			RST				;

	input							CLKR		;
	input							CLKIO		;
	input							ADC_FC		;
	input	[CH_NUM-1:0]			ADC_DD		;

	output			FRAME_OK	;
	output							ENB			;
	output	[CH_NUM*DATA_WIDTH-1:0]	DATA		;

//------ output signals -----
	wire							ENB			;
	wire	[CH_NUM*DATA_WIDTH-1:0]	DATA		;

	wire			CLK_ERR		;
	wire			FRAME_OK	;

//------------------------------------------------------------------------------
//	Reset
//------------------------------------------------------------------------------
	reg		[5:0]	rstCntr	;

	always@ (posedge CLKR or posedge RST) begin
		if(RST)begin
			rstCntr[5:0]	<= 6'h20;
		end else begin
			rstCntr[5:0]	<= rstCntr[5:0] +  {5'd0,rstCntr[5]};
		end
	end

	wire			intRst		;

	FD	RST_FD (.D(rstCntr[5]), .C(CLK20M), .Q(intRst));

//------------------------------------------------------------------------------
//	Input registers
//------------------------------------------------------------------------------
	wire	[1:0]	irAdcFc		;

`ifdef SPARTAN_SERIES
	IDDR2 #(.DDR_ALIGNMENT("C0"),.INIT_Q0(1'b0),.INIT_Q1(1'b0),.SRTYPE("SYNC")) IDDR_FD (.C0(CLKIO),.C1(~CLKIO),.CE(1'b1),.R(intRst),.S(1'b0),.D(ADC_FC),.Q0(irAdcFc[0]),.Q1(irAdcFc[1]));
`else
	IDDR #(.DDR_CLK_EDGE("SAME_EDGE"),.SRTYPE("SYNC")) IDDR_FC(.C(CLKIO), .R(intRst), .CE(1'b1), .S(1'b0), .D(ADC_FC), .Q1(irAdcFc[0]), .Q2(irAdcFc[1]));
`endif

	reg		[2:0]	smpAdcFc	;

	always@ (posedge CLKR) begin
		smpAdcFc[2:0]	<= {smpAdcFc[0],irAdcFc[1:0]};
	end

	reg		[DATA_WIDTH-1:0]	regFc;
	reg				detSof		;
	reg				frmErr		;

	always@ (posedge CLKR) begin
		regFc[DATA_WIDTH-1:0]	<= {regFc[DATA_WIDTH-3:0],smpAdcFc[2:1]};
		detSof	<= (regFc[1:0]==2'b00) & (smpAdcFc[2:1]==2'b11);

		frmErr	<= (regFc[1:0]==2'b01) & (smpAdcFc[2:1]==2'b00);
	end

genvar i ; 

	wire	[CH_NUM*2-1:0]	irAdcDd;
	reg		[CH_NUM*3-1:0]	smpAdcDd;
	reg		[CH_NUM*DATA_WIDTH-1:0]	regDd;
	reg		[CH_NUM*DATA_WIDTH-1:0]	orDd;

generate
	for (i=0;i<CH_NUM;i=i+1) begin : Gen_Adc_Data
`ifdef SPARTAN_SERIES
		IDDR2 #(.DDR_ALIGNMENT("C0"),.INIT_Q0(1'b0),.INIT_Q1(1'b0),.SRTYPE("SYNC")) IDDR_FD (.C0(CLKIO),.C1(~CLKIO),.CE(1'b1),.R(1'b0),.S(1'b0),.D(ADC_DD[i]),.Q0(irAdcDd[2*i]),.Q1(irAdcDd[2*i+1]));
`else
		IDDR #(.DDR_CLK_EDGE("SAME_EDGE"),.SRTYPE("SYNC")) IDDR_FD(.C(CLKIO), .R(intRst), .CE(1'b1), .S(1'b0), .D(ADC_DD[i]), .Q1(irAdcDd[2*i]), .Q2(irAdcDd[2*i+1]));
`endif
		always@ (posedge CLKR) begin
			smpAdcDd[3*(i+1)-1:3*i]	<= {smpAdcDd[3*i],irAdcDd[2*i+1:2*i]};
		end

		always@ (posedge CLKR) begin
			regDd[(i+1)*DATA_WIDTH-1:i*DATA_WIDTH]	<= {regDd[(i+1)*DATA_WIDTH-3:i*DATA_WIDTH],smpAdcDd[3*i+2:3*i+1]};
		end
	end
endgenerate

	always@ (posedge CLKR) begin
		orDd <= regDd;
	end

	assign	ENB		= detSof;
	assign	DATA	= orDd;

//------------------------------------------------------------------------------
//	Error Detection
//------------------------------------------------------------------------------
	reg		[DATA_WIDTH/4:0]	frmCntr;
	reg		[DATA_WIDTH/4:0]	frmBuf;
	reg							detFrmOk;

	always@ (posedge CLKR) begin
		if(intRst)begin
			frmCntr			<= 0;
			frmBuf			<= 0;
			detFrmOk		<= 0;
		end else begin
			if(detSof)begin
				frmCntr	<= 0;
				frmBuf	<= frmCntr;
			end else begin
				frmCntr	<= frmCntr + 1;
				frmBuf	<= frmBuf;
			end

			detFrmOk	<= (frmBuf == DATA_WIDTH/2-1);
		end
	end

	assign	FRAME_OK	= detFrmOk;

//------------------------------------------------------------------------------
endmodule
