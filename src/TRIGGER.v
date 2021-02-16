// `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institute: Kobe Univ.
// Engineer: Satoshi Higashino
// Email: higashino@people.kobe-u.ac.jp
// 
// Create Date: 2020/09/15 15:37:42
// Module Name: TRIGGER
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module CALC_OFFSET #(
                     parameter CH_NUM          = 64                    ,
                     parameter CH_NUM_S        = 65                    ,
                     parameter ADC_WIDTH       = 12                    , // 12 bit / channel
                     parameter ADC_WIDTH_S     = 13                    , // 13 bit / channel (signed)
                     parameter ADC_CH_NUM      = 8                     ,
                     parameter FIFO_DEPTH      = 10                    , // 10 bit
                     parameter ADC_TOTAL_WIDTH = ADC_WIDTH * ADC_CH_NUM, // 96 bit
                     parameter ADC_SUM_WIDTH   = ADC_WIDTH + FIFO_DEPTH, // 22 bit
                     parameter ADC_SUM_WIDTH_S = ADC_SUM_WIDTH + 1       // 23 bit (signed)
                     )
   (
    CLK         , // in
    RST         , // in
    ENABLE      , // in
    FIFO_ADDVAR , // in
    FIFO_SUBVAR , // in
    VALID       , // out
    OFFSET        // out
    );
   (* mark_debug = "true" *) input                  CLK         ;
   (* mark_debug = "true" *) input                  RST         ;
   (* mark_debug = "true" *) input                  ENABLE      ;
   (* mark_debug = "true" *) input  [ADC_WIDTH-1:0] FIFO_ADDVAR ;
   (* mark_debug = "true" *) input  [ADC_WIDTH-1:0] FIFO_SUBVAR ;
   (* mark_debug = "true" *) output                 VALID       ;
   (* mark_debug = "true" *) output [ADC_WIDTH-1:0] OFFSET      ;

   wire signed [ADC_WIDTH_S-1:0] FIFO_ADDVAR_S;
   wire signed [ADC_WIDTH_S-1:0] FIFO_SUBVAR_S;
   wire signed [ADC_WIDTH_S-1:0] FIFO_DIFF_S  ;
   reg  signed [ADC_WIDTH_S-1:0] FIFO_DIFF    ;

   assign FIFO_ADDVAR_S = $signed({1'b0, FIFO_ADDVAR});
   assign FIFO_SUBVAR_S = $signed({1'b0, FIFO_SUBVAR});

   c_addsub_0 CALC_ADC_DIFF(
                            .A      ( FIFO_ADDVAR_S  ),
                            .B      ( FIFO_SUBVAR_S  ),
                            .CLK    ( CLK            ),
                            .BYPASS ( 1'b0           ),
                            .S      ( FIFO_DIFF_S    )
                            );

   always@ ( posedge CLK or posedge RST ) begin
      if( RST == 1'b1 ) begin
         FIFO_DIFF <= 0;
      end else begin
         FIFO_DIFF <= FIFO_DIFF_S;
      end
   end
   
   wire signed [ADC_SUM_WIDTH_S-1:0] ADC_ALL_VAR_S;
   c_accum_0 CALC_ADC_SUM(
                          // .B     ( FIFO_DIFF_S   ),
                          .B     ( FIFO_DIFF     ),
                          .CLK   ( CLK           ),
                          .SCLR  ( RST           ),
                          .Q     ( ADC_ALL_VAR_S )
                          );

   (* mark_debug = "true" *) reg [ADC_SUM_WIDTH-1:0]          ADC_ALL_VAR;
   always@ (posedge CLK ) begin
      ADC_ALL_VAR <= ADC_ALL_VAR_S[ADC_SUM_WIDTH-1:0];
   end
   
   wire [37:0]              OFFSET_WIRE;
   wire [23:0]              ADC_ALL_VAR_DIV;
   assign ADC_ALL_VAR_DIV = {2'b00, ADC_ALL_VAR};
   div_gen_0 CALC_ADC_OFFSET (
                              .aclk                   ( CLK             ),
                              .s_axis_divisor_tvalid  ( ENABLE          ),
                              .s_axis_divisor_tdata   ( 16'd1023        ),
                              .s_axis_dividend_tvalid ( ENABLE          ),
                              .s_axis_dividend_tdata  ( ADC_ALL_VAR_DIV ),
                              .m_axis_dout_tvalid     ( VALID           ),
                              .m_axis_dout_tdata      ( OFFSET_WIRE     )
                              );
   
   assign OFFSET = VALID ? OFFSET_WIRE[37:16] : 12'd0;
endmodule

module CALC_TRUE_ADC #(
                       parameter CH_NUM          = 64                    ,
                       parameter CH_NUM_S        = 65                    ,
                       parameter ADC_WIDTH       = 12                    , // 12 bit / channel
                       parameter ADC_WIDTH_S     = 13                    , // 13 bit / channel (signed)
                       parameter ADC_CH_NUM      = 8                     ,
                       parameter FIFO_DEPTH      = 10                    , // 10 bit
                       parameter ADC_TOTAL_WIDTH = ADC_WIDTH * ADC_CH_NUM, // 96 bit
                       parameter ADC_SUM_WIDTH   = ADC_WIDTH + FIFO_DEPTH, // 22 bit
                       parameter ADC_SUM_WIDTH_S = ADC_SUM_WIDTH + 1       // 23 bit (signed)
                       )
   (
    CLK,         // in
    ADC_INPUT,   // in
    ADC_OFFSET,  // in
    ADC_TRUE_VAR // out
    );

   input                  CLK         ;
   input  [ADC_WIDTH-1:0] ADC_INPUT   ;
   input  [ADC_WIDTH-1:0] ADC_OFFSET  ;
   output [ADC_WIDTH-1:0] ADC_TRUE_VAR;

   wire signed [ADC_WIDTH_S-1:0] ADC_INPUT_S;
   wire signed [ADC_WIDTH_S-1:0] ADC_OFFSET_S;
   wire signed [ADC_WIDTH_S-1:0] ADC_TRUE_VAR_S;
   assign ADC_INPUT_S  = $signed({1'b0, ADC_INPUT });
   assign ADC_OFFSET_S = $signed({1'b0, ADC_OFFSET});
   
   c_addsub_1 OFFSET_SUBTRACT(
                              .A      ( ADC_INPUT_S    ),
                              .B      ( ADC_OFFSET_S   ),
                              .CLK    ( CLK            ),
                              .S      ( ADC_TRUE_VAR_S )
                              );

   // check sign: return 0 if a true ADC value is minus
   assign ADC_TRUE_VAR = (ADC_TRUE_VAR_S[ADC_WIDTH_S-1]) ? 12'd0 : ADC_TRUE_VAR_S[ADC_WIDTH-1:0];
   
endmodule


module CALC_DECISION #(
                       parameter CH_NUM          = 64                    ,
                       parameter CH_NUM_S        = 65                    ,
                       parameter ADC_WIDTH       = 12                    , // 12 bit / channel
                       parameter ADC_WIDTH_S     = 13                    , // 13 bit / channel (signed)
                       parameter ADC_CH_NUM      = 8                     ,
                       parameter FIFO_DEPTH      = 10                    , // 10 bit
                       parameter ADC_TOTAL_WIDTH = ADC_WIDTH * ADC_CH_NUM, // 96 bit
                       parameter ADC_SUM_WIDTH   = ADC_WIDTH + FIFO_DEPTH, // 22 bit
                       parameter ADC_SUM_WIDTH_S = ADC_SUM_WIDTH + 1       // 23 bit (signed)
                       )
   (
    CLK,
    ADC_VAL,       // in
    ADC_THRESHOLD, // in
    ENABLE,        // in
    DECISION       // out
    );
   
   input                  CLK          ;
   input [ADC_WIDTH-1:0]  ADC_VAL      ;
   input [ADC_WIDTH-1:0]  ADC_THRESHOLD;
   input                  ENABLE       ;
   output                 DECISION     ;
   
   wire signed [ADC_WIDTH_S-1:0] ADC_VAL_S;
   wire signed [ADC_WIDTH_S-1:0] ADC_THRESHOLD_S;
   assign ADC_VAL_S       = ENABLE ? $signed({1'b0, ADC_VAL      }) : 0;
   assign ADC_THRESHOLD_S = $signed({1'b0, ADC_THRESHOLD});
     
   wire signed [ADC_WIDTH_S-1:0] ADC_DIFF_THR_S;
   c_addsub_1 THR_SUBTRACT(
                           .A      ( ADC_VAL_S       ),
                           .B      ( ADC_THRESHOLD_S ),
                           .CLK    ( CLK             ),
                           .S      ( ADC_DIFF_THR_S  )
                           );

   reg                           DECISION_REG;
   always@ ( posedge CLK ) begin
      if( ENABLE == 1'b0 ) begin
         DECISION_REG <= 1'b0;
      end else begin
         if( ADC_DIFF_THR_S[ADC_WIDTH_S-1] ) begin
            DECISION_REG <= 1'b0;
         end else begin
            DECISION_REG <= 1'b1;
         end
      end
   end
   
   assign DECISION = DECISION_REG;
   
endmodule   



module TRIGGER (
                CLK             , // in
                RST             , // in
                ADC_DATA1       , // in
                ADC_DATA2       , // in
                ADC_DATA3       , // in
                ADC_DATA4       , // in
                ADC_DATA5       , // in
                ADC_DATA6       , // in
                ADC_DATA7       , // in
                ADC_DATA8       , // in
                TRIG_THR        , // in
                NUM_TRIG_CH     , // in
                TRIG_OUT          // out
                );
   
   input           CLK          ;
   input           RST          ;
   input [95:0]    ADC_DATA1    ;
   input [95:0]    ADC_DATA2    ;
   input [95:0]    ADC_DATA3    ;
   input [95:0]    ADC_DATA4    ;
   input [95:0]    ADC_DATA5    ;
   input [95:0]    ADC_DATA6    ;
   input [95:0]    ADC_DATA7    ;
   input [95:0]    ADC_DATA8    ;
   input [11:0]    TRIG_THR     ;
   input [7:0]     NUM_TRIG_CH  ;
   output          TRIG_OUT     ;

   // define parameters
   parameter CH_NUM          = 64                    ;
   parameter CH_NUM_S        = 65                    ;
   parameter ADC_WIDTH       = 12                    ; // 12 bit / channel
   parameter ADC_WIDTH_S     = 13                    ; // 13 bit / channel (signed)
   parameter ADC_CH_NUM      = 8                     ;
   parameter FIFO_DEPTH      = 10                    ; // 10 bit
   parameter ADC_TOTAL_WIDTH = ADC_WIDTH * ADC_CH_NUM; // 96 bit
   parameter ADC_SUM_WIDTH   = ADC_WIDTH + FIFO_DEPTH; // 22 bit
   parameter ADC_SUM_WIDTH_S = ADC_SUM_WIDTH + 1     ; // 23 bit (signed)
   
   /////////////////////////////////////////////////////////
   // prepare FIFO's
   /////////////////////////////////////////////////////////
   
   // !!! important !!!: FIFO needs to have some times (some clocks) after that RST is turned off
   reg [7:0] FIFO_RST_COUNTER;
   (* mark_debug = "true" *) reg       FIFO_RST;
   always@ ( posedge CLK or posedge RST ) begin
      if( RST == 1'b1 ) begin
         FIFO_RST         <= 1'b1;
         FIFO_RST_COUNTER <= 8'b0;
      end else begin
         if( FIFO_RST == 1'b1 ) begin
            if( FIFO_RST_COUNTER != 8'hff ) begin
               FIFO_RST_COUNTER <= FIFO_RST_COUNTER + 8'b1;
            end else begin
               FIFO_RST <= 1'b0;
            end
         end else begin
            FIFO_RST_COUNTER <= 8'b0;
         end
      end
   end

   reg [ADC_WIDTH*CH_NUM-1:0] ADC_FIFO_INPUT;
   always@ ( posedge CLK or posedge RST ) begin
      if( RST == 1'b1 ) begin
         ADC_FIFO_INPUT <= 0;
      end else begin
         ADC_FIFO_INPUT[ADC_TOTAL_WIDTH*0+ADC_TOTAL_WIDTH-1:ADC_TOTAL_WIDTH*0] <= ADC_DATA1[ADC_TOTAL_WIDTH-1:0];
         ADC_FIFO_INPUT[ADC_TOTAL_WIDTH*1+ADC_TOTAL_WIDTH-1:ADC_TOTAL_WIDTH*1] <= ADC_DATA2[ADC_TOTAL_WIDTH-1:0];
         ADC_FIFO_INPUT[ADC_TOTAL_WIDTH*2+ADC_TOTAL_WIDTH-1:ADC_TOTAL_WIDTH*2] <= ADC_DATA3[ADC_TOTAL_WIDTH-1:0];
         ADC_FIFO_INPUT[ADC_TOTAL_WIDTH*3+ADC_TOTAL_WIDTH-1:ADC_TOTAL_WIDTH*3] <= ADC_DATA4[ADC_TOTAL_WIDTH-1:0];
         ADC_FIFO_INPUT[ADC_TOTAL_WIDTH*4+ADC_TOTAL_WIDTH-1:ADC_TOTAL_WIDTH*4] <= ADC_DATA5[ADC_TOTAL_WIDTH-1:0];
         ADC_FIFO_INPUT[ADC_TOTAL_WIDTH*5+ADC_TOTAL_WIDTH-1:ADC_TOTAL_WIDTH*5] <= ADC_DATA6[ADC_TOTAL_WIDTH-1:0];
         ADC_FIFO_INPUT[ADC_TOTAL_WIDTH*6+ADC_TOTAL_WIDTH-1:ADC_TOTAL_WIDTH*6] <= ADC_DATA7[ADC_TOTAL_WIDTH-1:0];
         ADC_FIFO_INPUT[ADC_TOTAL_WIDTH*7+ADC_TOTAL_WIDTH-1:ADC_TOTAL_WIDTH*7] <= ADC_DATA8[ADC_TOTAL_WIDTH-1:0];
      end
   end
   
   (* mark_debug = "true" *) wire [CH_NUM-1:0]           FULL_FLGS         ;
   (* mark_debug = "true" *) wire [CH_NUM-1:0]           PROG_FULL_FLGS    ; // set to be ([total depth] - 1)
   (* mark_debug = "true" *) wire FIFO_GLOBAL_WE    ;
   (* mark_debug = "true" *) wire FIFO_GLOBAL_RE    ;
   reg                         FIFO_GLOBAL_WE_REG;
   reg                         FIFO_GLOBAL_RE_REG;
   wire [CH_NUM-1:0]           EMPTY_FLGS        ; // assined to FIFO's but not used at this time

   always@ ( posedge CLK or posedge RST ) begin
      if( RST == 1'b1 ) begin
         FIFO_GLOBAL_WE_REG <= 1'b0;
      end else begin
         if( FIFO_RST == 1'b0 ) begin
            if( FULL_FLGS == 64'b0 ) begin
               FIFO_GLOBAL_WE_REG <= 1'b1;
            end else begin
               FIFO_GLOBAL_WE_REG <= 1'b0;
            end
         end else begin
            FIFO_GLOBAL_WE_REG <= 1'b0;
         end
      end      
   end

   always@ (posedge CLK or posedge RST ) begin
      if( RST == 1'b1 ) begin
         FIFO_GLOBAL_RE_REG <= 1'b0;
      end else begin
         if( FULL_FLGS == 64'b0 ) begin
            if( PROG_FULL_FLGS == 64'hffffffffffffffff ) begin
               FIFO_GLOBAL_RE_REG <= 1'b1;
            end else begin
               FIFO_GLOBAL_RE_REG <= 1'b0;
            end
         end else begin
            FIFO_GLOBAL_RE_REG <= 1'b0;
         end
      end      
   end

   assign FIFO_GLOBAL_WE = FIFO_GLOBAL_WE_REG;
   assign FIFO_GLOBAL_RE = FIFO_GLOBAL_RE_REG;

   wire [ADC_WIDTH*CH_NUM-1:0] ADC_FIFO_OUTPUT ;
   genvar                      i;
   generate
      for( i=0; i<CH_NUM; i=i+1 ) begin: FIFO_GEN
         fifo_generator_0 TRIG_FIFO (
                                     .clk       ( CLK                                                  ),
                                     .rst       ( RST                                                  ),
                                     .din       ( ADC_FIFO_INPUT[ADC_WIDTH*i+ADC_WIDTH-1:ADC_WIDTH*i]  ),
                                     .wr_en     ( FIFO_GLOBAL_WE                                       ),
                                     .rd_en     ( FIFO_GLOBAL_RE                                       ),
                                     .dout      ( ADC_FIFO_OUTPUT[ADC_WIDTH*i+ADC_WIDTH-1:ADC_WIDTH*i] ),
                                     .full      ( FULL_FLGS[i]                                         ),
                                     .prog_full ( PROG_FULL_FLGS[i]                                    ),
                                     .empty     ( EMPTY_FLGS[i]                                        )
                                     );
      end // block: FIFO_GEN
   endgenerate
   
   /////////////////////////////////////////////////////////
   // calculate offset values for each channel
   /////////////////////////////////////////////////////////

   reg  OFFSET_ENABLE;
   always@ ( posedge CLK or posedge RST ) begin
      if( RST == 1'b1 ) begin
         OFFSET_ENABLE <= 1'b0;
      end else begin
         if( ( FIFO_GLOBAL_WE & FIFO_GLOBAL_RE ) == 1'b1 ) begin
            OFFSET_ENABLE <= 1'b1;
         end else begin
            OFFSET_ENABLE <= 1'b0;
         end
      end
   end // always@ ( posedge CLK or posedge RST )

   reg [ADC_WIDTH*CH_NUM-1:0] ADC_OFFSET_ADDVAR;
   reg [ADC_WIDTH*CH_NUM-1:0] ADC_OFFSET_SUBVAR;
   always@ ( posedge CLK or posedge RST ) begin
      if( RST == 1'b1 ) begin
         ADC_OFFSET_ADDVAR <= 0;
         ADC_OFFSET_SUBVAR <= 0;
      end else begin
         ADC_OFFSET_ADDVAR <= ADC_FIFO_INPUT;
         if( OFFSET_ENABLE == 1'b1 ) begin
            ADC_OFFSET_SUBVAR <= ADC_FIFO_OUTPUT;
         end else begin
            ADC_OFFSET_SUBVAR <= 0;
         end
      end
   end
   
   wire [ADC_WIDTH*CH_NUM-1:0] ADC_OFFSET_WIRE ;
   wire [CH_NUM-1:0]           OFFSET_VALID    ;
   genvar                      j               ;
   generate 
      for( j=0; j<CH_NUM; j=j+1 ) begin: CALC_OFFSET_GEN
         CALC_OFFSET #(
                       .CH_NUM          ( CH_NUM          ),
                       .ADC_WIDTH       ( ADC_WIDTH       ),
                       .ADC_WIDTH_S     ( ADC_WIDTH_S     ),
                       .ADC_CH_NUM      ( ADC_CH_NUM      ),
                       .FIFO_DEPTH      ( FIFO_DEPTH      ),
                       .ADC_TOTAL_WIDTH ( ADC_TOTAL_WIDTH ),
                       .ADC_SUM_WIDTH   ( ADC_SUM_WIDTH   ),
                       .ADC_SUM_WIDTH_S ( ADC_SUM_WIDTH_S )
                       )
         CALC_OFFSET (
                      .CLK              ( CLK                                                    ),
                      .RST              ( FIFO_RST                                               ),
                      .ENABLE           ( OFFSET_ENABLE                                          ),
                      .FIFO_ADDVAR      ( ADC_OFFSET_ADDVAR[ADC_WIDTH*j+ADC_WIDTH-1:ADC_WIDTH*j] ),
                      .FIFO_SUBVAR      ( ADC_OFFSET_SUBVAR[ADC_WIDTH*j+ADC_WIDTH-1:ADC_WIDTH*j] ),
                      .VALID            ( OFFSET_VALID     [j]                                   ),
                      .OFFSET           ( ADC_OFFSET_WIRE  [ADC_WIDTH*j+ADC_WIDTH-1:ADC_WIDTH*j] )
                      );
      end
   endgenerate

   reg [ADC_WIDTH*CH_NUM-1:0] ADC_OFFSET;
   always@ ( posedge CLK ) begin
      ADC_OFFSET <= ADC_OFFSET_WIRE;
   end
   
   
   reg OFFSET_ALL_VALID;
   always@ ( posedge CLK or posedge RST ) begin
      if( RST == 1'b1 ) begin
         OFFSET_ALL_VALID <= 1'b0;
      end else begin
         if( OFFSET_VALID == 64'hffffffffffffffff ) begin
            OFFSET_ALL_VALID <= 1'b1;
         end else begin
            OFFSET_ALL_VALID <= 1'b0;
         end
      end
   end   

   wire [ADC_WIDTH*CH_NUM-1:0] ADC_TRUE_VALUE;
   genvar l;
   generate
      for( l=0; l<CH_NUM; l=l+1 ) begin: CALC_TRUE_ADC_GEN
         CALC_TRUE_ADC CALC_TRUE_ADC (
                                      .CLK          ( CLK                                                  ),
                                      .ADC_INPUT    ( ADC_FIFO_INPUT [ADC_WIDTH*l+ADC_WIDTH-1:ADC_WIDTH*l] ),
                                      .ADC_OFFSET   ( ADC_OFFSET     [ADC_WIDTH*l+ADC_WIDTH-1:ADC_WIDTH*l] ),
                                      .ADC_TRUE_VAR ( ADC_TRUE_VALUE [ADC_WIDTH*l+ADC_WIDTH-1:ADC_WIDTH*l] )
                                      );
      end
   endgenerate

   // compare true ADC values with a threshold
   wire [CH_NUM-1:0] CH_THR_FLGS;


   // check threshold
   genvar            m;
   generate
      for( m=0; m<CH_NUM; m=m+1 ) begin
         CALC_DECISION CALC_DECISION (
                                      .CLK           ( CLK                                                 ),
                                      .ADC_VAL       ( ADC_TRUE_VALUE[ADC_WIDTH*m+ADC_WIDTH-1:ADC_WIDTH*m] ),
                                      .ADC_THRESHOLD ( TRIG_THR                                            ),
                                      .ENABLE        ( OFFSET_ALL_VALID                                    ),
                                      .DECISION      ( CH_THR_FLGS[m]                                      )
                                      );
      end
   endgenerate
   
   reg [CH_NUM-1:0] CH_THR_FLGS_REG;
   always@ ( posedge CLK or posedge RST ) begin
      if( RST == 1'b1 ) begin
         CH_THR_FLGS_REG <= 0;
      end else begin
         CH_THR_FLGS_REG <= CH_THR_FLGS;
      end
   end
   
   // check the number of channels that exceed a threshold
   wire [7:0]        NUM_HIT_CH ;
   BITCOUNTER BITCOUNTER (
                          .CNT_CLK    ( CLK                         ),
                          .CNT_RST    ( FIFO_RST                    ),
                          .CNT_INPUT  ( CH_THR_FLGS_REG[CH_NUM-1:0] ),
                          .CNT_OUTPUT ( NUM_HIT_CH[7:0]             )
                          );

   wire signed [8:0] NUM_HIT_CH_S;
   wire signed [8:0] NUM_TRIG_CH_S;
   wire signed [8:0] DIFF_CH_S;
   assign NUM_HIT_CH_S  = $signed({1'b0,NUM_HIT_CH});
   assign NUM_TRIG_CH_S = $signed({1'b0,NUM_TRIG_CH});
   
   c_addsub_2 NUMCH_SUBTRACT(
                             .A      ( NUM_HIT_CH_S    ),
                             .B      ( NUM_TRIG_CH_S   ),
                             .CLK    ( CLK             ),
                             .S      ( DIFF_CH_S       )
                             );
   
   assign TRIG_OUT = ( NUM_HIT_CH == NUM_TRIG_CH ) ? 1'b1 : 1'b0;
   
endmodule
