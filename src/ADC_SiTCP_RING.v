/*******************************************************************************
*                                                                              *
* System      : ADC SiTCP module                                               *
* Version     : v 0.0.0 2012/03/02                                             *
*                                                                              *
* Description : Delay Buffer                                                   *
*                                                                              *
* Designer    : Tomohisa Uchida                                                *
*                                                                              *
*                Copyright (c) 2012 Tomohisa Uchida                            *
*                All rights reserved                                           *
*                                                                              *
*******************************************************************************/
module ADC_SiTCP_RING(
// System
	SYSCLK				,	// in	: System clock
	sRST					,	// in	: System reset
// Parameters
	REG_DELAY			,	// in	: TRG delay [15:0]
// Enable
    ENABLE              ,
// ADC I/F
 //ADC_DATA				,	// in	: ADC data[191:0]
	ADC_DATA				,	// in	: ADC data[383:0]
// Trigger I/F	
	TRIGGER				,	// in	: Trigger
// Event buffer module I/F
	RAW_SOD				,	// out	: Start of data
	RAW_TRG_NUM			,	// out	: Trigger Number[31:0]
 //RAW_ADC					// out	: Delayed ADC data[191:0]
 	RAW_ADC					// out	: Delayed ADC data[383:0]
);



//-------- Input/Output -------------
	input				SYSCLK			;
	input				sRST			;

	input	[15:0]		REG_DELAY		;
	
	input               ENABLE          ;

//	input	[12*16-1:0]	ADC_DATA		; 16ch
//	input	[12*32-1:0]	ADC_DATA		; 32ch
    input	[12*64-1:0]	ADC_DATA		; //64ch
	input				TRIGGER   		;

	output				RAW_SOD			;
	output	[31:0]		RAW_TRG_NUM		;
//	output	[12*16-1:0]	RAW_ADC			; 16ch
//	output	[12*32-1:0]	RAW_ADC			; 32ch
	output	[12*64-1:0]	RAW_ADC			;//64ch

//------ output signals -----
	wire				RAW_SOD			;
	wire	[31:0]		RAW_TRG_NUM		;
//	wire	[12*16-1:0]	RAW_ADC			; 16ch
//	wire	[12*32-1:0]	RAW_ADC			; 32ch
	wire	[12*64-1:0]	RAW_ADC			;//64ch



//------------------------------------------------------------------------------
//	Input registers
//------------------------------------------------------------------------------
	reg		[15:0]	    irDelay			;

	always@ (posedge SYSCLK) begin
		irDelay[15:0]	<= REG_DELAY[15:0];       //パラメータの代入
	end


    
//------------------------------------------------------------------------------
//	Pre-prosess
//------------------------------------------------------------------------------
    
   	reg		[1:0]	irTrg	= 0	;
//	reg		[15:0]	slrTrg		;
 	reg		[7:0]	slrTrg	= 0	;
 	
	always@ (posedge SYSCLK) begin
	   if(sRST)begin
	       irTrg[1:0] <= 2'd0;
	       slrTrg[7:0] <= 8'd0;
	   end else begin
	       if(ENABLE == 1)begin
		      irTrg[1:0]	<= {irTrg[0],TRIGGER};       //TRIGGERは1clock分しかwidthがない

//		      slrTrg[15:0]	<= {slrTrg[14:0],(irTrg[1:0]==2'b01)};
		      slrTrg[7:0]	<= {slrTrg[6:0],(irTrg[1:0]==2'b01)};  //TRIGGERのタイミングとSODのタイミングを調整(ADC_DATAとRAW_DATAはDelayがなくても多少ずれるため)
           end
       end
	end

//------------------------------------------------------------------------------
//	Delay buffer
//------------------------------------------------------------------------------

//	reg		[12*16-1:0]	wd				; 16ch
//	reg		[12*32-1:0]	wd				; 32ch
	reg		[12*64-1:0]	wd				;//64ch

	genvar p ; 
	generate
//	 for (p=0;p<16;p=p+1) begin : WD_Gen 
//	 for (p=0;p<32;p=p+1) begin : WD_Gen 
	 for (p=0;p<64;p=p+1) begin : WD_Gen 
		always@ (posedge SYSCLK) begin
		  if(ENABLE == 1)begin
			 wd[12*p+11:12*p]	<= ADC_DATA[12*p+11:12*p];
		  end
		end
	 end
	endgenerate

	reg		[11:0]	wa			;

	always@ (posedge SYSCLK) begin
	   if(ENABLE == 1)begin
	       if(sRST)begin
			 wa[11:0]	<= 12'd0;
		   end else begin
			wa[11:0]	<= wa[11:0] + 12'd1;
		   end
	   end
	end

	reg		[11:0]	ra			;
//	wire	[191:0]	rd			; 16ch
//  wire    [383:0] rd       ; 32ch
    wire    [767:0] rd  ;//64ch


    
    /////////64ch////////////////////////////////////////////////////
         generate
         genvar i;
           for (i=0; i<96; i=i+1)
             begin: mem_gen_8_4K_generate
                 mem_gen_8_4K ADC_MEM_0 (
                  .clka       (SYSCLK),    // input wire clka
                  .ena        (ENABLE),      // input wire ena
                  .wea        (1'b1),      // input wire [0 : 0] wea
                  .addra      (wa[11:0]),  // input wire [11 : 0] addra
                  .dina       (wd[8*(i+1)-1:8*i]),    // input wire [7 : 0] dina
                  .clkb       (SYSCLK),    // input wire clkb
                  .enb        (ENABLE),      // input wire enb
                  .addrb      (ra[11:0]),  // input wire [11 : 0] addrb  ??????-12'd1?????
                   .doutb      (rd[8*(i+1)-1:8*i])  // output wire [7 : 0] doutb
                  );
             end
          endgenerate
    
        always@ (posedge SYSCLK) begin
           if(ENABLE == 1)begin   // コメントアウトするとビットばけする
    //               ra[7:0]    <= wa[7:0] - irDelay[15:0];
                   ra[11:0]    <= wa[11:0] - irDelay[11:0] ;
           end
        end

//------------------------------------------------------------------------------
//    Output
//------------------------------------------------------------------------------
            reg                orSod    = 1'd0    ;
        
            always@ (posedge SYSCLK) begin
               if(sRST)begin
                   orSod <= 1'd0;
               end else begin
                   if(ENABLE == 1)begin
        //                 orSod    <= slrTrg[15];
                              orSod    <= slrTrg[0];
                   end
               end
            end
            reg        [31:0]    trgCntr    = 0        ;
        
            always@ (posedge SYSCLK) begin
               if(sRST)begin
                   trgCntr[31:0]    <= 32'd0;
               end else begin
                   if(ENABLE == 1)begin
                       trgCntr[31:0]    <= (orSod ? trgCntr[31:0] + 32'd1 : trgCntr[31:0]);
                   end
               end
            end
        
            assign    RAW_SOD                = orSod;
            assign    RAW_TRG_NUM[31:0]    = trgCntr[31:0];
        //    assign    RAW_ADC[12*16-1:0]    = rd[12*16-1:0]; 16ch
        //    assign    RAW_ADC[12*32-1:0]    = rd[12*32-1:0]; 32ch
            assign    RAW_ADC[12*64-1:0]    = rd[12*64-1:0];//64ch
        
        //------------------------------------------------------------------------------
        endmodule
