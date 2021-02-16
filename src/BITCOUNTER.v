// `timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Institute: Kobe Univ.
// Engineer: Satoshi Higashino
// Email: higashino@people.kobe-u.ac.jp
// 
// Create Date: 2020/09/22 13:19:41
// Module Name: BITCOUNTER
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module BITCOUNTER(
                  CNT_CLK    , // in
                  CNT_RST    , // in
                  CNT_INPUT  , // in
                  CNT_OUTPUT   // out
                  );

   input            CNT_CLK    ;
   input            CNT_RST    ;
   input [63:0]     CNT_INPUT  ;
   output [7:0]     CNT_OUTPUT ;

   reg [63:0]       SOURCE_1   ;
   reg [63:0]       SOURCE_2   ;
   reg [63:0]       SOURCE_4   ;
   reg [63:0]       SOURCE_8   ;
   reg [63:0]       SOURCE_16  ;
   reg [63:0]       SOURCE_32  ;

   always @( posedge CNT_CLK or posedge CNT_RST ) begin
      if( CNT_RST == 1'b1 )
        SOURCE_1 <= 64'h0;
      else
        SOURCE_1 <= ( CNT_INPUT & 64'h5555555555555555) + ({1'b0,CNT_INPUT[63:1]} & 64'h5555555555555555);
   end

   always @( posedge CNT_CLK or posedge CNT_RST ) begin
      if( CNT_RST == 1'b1 )
        SOURCE_2 <= 64'h0;
      else
        SOURCE_2 <= ( SOURCE_1 & 64'h3333333333333333) + ({2'b0,SOURCE_1[63:2]} & 64'h3333333333333333);
   end

   always @( posedge CNT_CLK or posedge CNT_RST ) begin
      if( CNT_RST == 1'b1 )
        SOURCE_4 <= 64'h0;
      else
        SOURCE_4 <= ( SOURCE_2 & 64'h0f0f0f0f0f0f0f0f) + ({4'b0,SOURCE_2[63:4]} & 64'h0f0f0f0f0f0f0f0f);
   end

   always @( posedge CNT_CLK or posedge CNT_RST ) begin
      if( CNT_RST == 1'b1 )
        SOURCE_8 <= 64'h0;
      else
        SOURCE_8 <= ( SOURCE_4 & 64'h00ff00ff00ff00ff) + ({8'b0,SOURCE_4[63:8]} & 64'h00ff00ff00ff00ff);
   end

   always @( posedge CNT_CLK or posedge CNT_RST ) begin
      if( CNT_RST == 1'b1 )
        SOURCE_16 <= 64'h0;
      else
        SOURCE_16 <= ( SOURCE_8 & 64'h0000ffff0000ffff) + ({16'b0,SOURCE_8[63:16]} & 64'h0000ffff0000ffff);
   end
   
   always @( posedge CNT_CLK or posedge CNT_RST ) begin
      if( CNT_RST == 1'b1 )
        SOURCE_32 <= 64'h0;
      else
        SOURCE_32 <= ( SOURCE_16 & 64'h00000000ffffffff) + ({32'b0,SOURCE_16[63:32]} & 64'h00000000ffffffff);
   end

   assign CNT_OUTPUT = SOURCE_32[7:0];

endmodule
