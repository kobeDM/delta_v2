`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institute: Kobe Univ.
// Engineer: Satoshi Higashino
// Email: higashino@people.kobe-u.ac.jp
// 
// Create Date: 2020/09/24 16:52:54
// Module Name: TB_TRIGGER
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module TB_TRIGGER;

   reg CLK                ;
   reg RST                ;
   reg [95:0] ADC_DATA1   ;
   reg [95:0] ADC_DATA2   ;
   reg [95:0] ADC_DATA3   ;
   reg [95:0] ADC_DATA4   ;
   reg [95:0] ADC_DATA5   ;
   reg [95:0] ADC_DATA6   ;
   reg [95:0] ADC_DATA7   ;
   reg [95:0] ADC_DATA8   ;
   reg [11:0] TRIG_THR    ;
   reg [7:0]  NUM_TRIG_CH ;
   
   wire       TRIG_OUT    ;
   
   TRIGGER uut(
               .CLK         ( CLK         ),
               .RST         ( RST         ),
               .ADC_DATA1   ( ADC_DATA1   ),
               .ADC_DATA2   ( ADC_DATA2   ),
               .ADC_DATA3   ( ADC_DATA3   ),
               .ADC_DATA4   ( ADC_DATA4   ),
               .ADC_DATA5   ( ADC_DATA5   ),
               .ADC_DATA6   ( ADC_DATA6   ),
               .ADC_DATA7   ( ADC_DATA7   ),
               .ADC_DATA8   ( ADC_DATA8   ),
               .TRIG_THR    ( TRIG_THR    ),
               .NUM_TRIG_CH ( NUM_TRIG_CH ),
               .TRIG_OUT    ( TRIG_OUT    )
               );
   
   parameter STEP=20;
   always #(STEP/2)
     CLK = ~CLK;
   initial CLK=0;

   initial begin
      RST <= 1'b1;
      #100 RST <= 1'b0;
      #10000000 RST <= 1'b1;
   end      

   initial begin
      TRIG_THR <= 12'd20;
      NUM_TRIG_CH <= 8'd3;
   end

   reg [11:0] COUNTER;
   always@ (posedge CLK) begin
      if( RST == 1'b1 ) begin
         COUNTER <= 0;
      end else begin
         COUNTER <= COUNTER + 12'b1;
      end
   end
   
   genvar     i;
   generate
      for( i=0; i<8;i=i+1 ) begin
         always@ (posedge CLK) begin
            if( RST == 1'b1 ) begin
               ADC_DATA1[12*i+11:12*i] <= 12'd0;
               ADC_DATA2[12*i+11:12*i] <= 12'd0;
               ADC_DATA3[12*i+11:12*i] <= 12'd0;
               ADC_DATA4[12*i+11:12*i] <= 12'd0;
               ADC_DATA5[12*i+11:12*i] <= 12'd0;
               ADC_DATA6[12*i+11:12*i] <= 12'd0;
               ADC_DATA7[12*i+11:12*i] <= 12'd0;
               ADC_DATA8[12*i+11:12*i] <= 12'd0;
            end else begin
               if( COUNTER == 12'd1500 ) begin
                  ADC_DATA1[12*i+11:12*i] <= 12'hfff;
                  ADC_DATA2[12*i+11:12*i] <= 12'hff;
                  ADC_DATA3[12*i+11:12*i] <= 12'hff;
                  ADC_DATA4[12*i+11:12*i] <= 12'hff;
                  ADC_DATA5[12*i+11:12*i] <= 12'hff;
                  ADC_DATA6[12*i+11:12*i] <= 12'hff;
                  ADC_DATA7[12*i+11:12*i] <= 12'hff;
                  ADC_DATA8[12*i+11:12*i] <= 12'hff;
               end else begin
                  ADC_DATA1[12*i+11:12*i] <= 12'hff;
                  ADC_DATA2[12*i+11:12*i] <= 12'hff;
                  ADC_DATA3[12*i+11:12*i] <= 12'hff;
                  ADC_DATA4[12*i+11:12*i] <= 12'hff;
                  ADC_DATA5[12*i+11:12*i] <= 12'hff;
                  ADC_DATA6[12*i+11:12*i] <= 12'hff;
                  ADC_DATA7[12*i+11:12*i] <= 12'hff;
                  ADC_DATA8[12*i+11:12*i] <= 12'hff;
                  // ADC_DATA1[12*i+11:12*i] <= ADC_DATA1[12*i+11:12*i] + 12'b1;
                  // ADC_DATA2[12*i+11:12*i] <= ADC_DATA2[12*i+11:12*i] + 12'b1;
                  // ADC_DATA3[12*i+11:12*i] <= ADC_DATA3[12*i+11:12*i] + 12'b1;
                  // ADC_DATA4[12*i+11:12*i] <= ADC_DATA4[12*i+11:12*i] + 12'b1;
                  // ADC_DATA5[12*i+11:12*i] <= ADC_DATA5[12*i+11:12*i] + 12'b1;
                  // ADC_DATA6[12*i+11:12*i] <= ADC_DATA6[12*i+11:12*i] + 12'b1;
                  // ADC_DATA7[12*i+11:12*i] <= ADC_DATA7[12*i+11:12*i] + 12'b1;
                  // ADC_DATA8[12*i+11:12*i] <= ADC_DATA8[12*i+11:12*i] + 12'b1;
               end
            end
         end
      end
   endgenerate
   
endmodule
