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

module TB_DIVIDER;

   reg        CLK                ;
   reg        DIVISOR_TVALID     ;
   reg [15:0] DIVISOR_TDATA      ;
   reg        DIVIDEND_TVALID    ;
   reg [23:0] DIVIDEND_TDATA     ;
   wire        DOUT_TVALID        ;
   wire [23:0] DOUT_TDATA         ;
   
   div_gen_0 uut(
                 .aclk                  ( CLK             ),
                 .s_axis_divisor_tvalid ( DIVISOR_TVALID  ),
                 .s_axis_divisor_tdata  ( DIVISOR_TDATA   ),
                 .s_axis_dividend_tvalid( DIVIDEND_TVALID ),
                 .s_axis_dividend_tdata ( DIVIDEND_TDATA  ),
                 .m_axis_dout_tvalid    ( DOUT_TVALID     ),
                 .m_axis_dout_tdata     ( DOUT_TDATA      )
                 );
   
   parameter STEP=20;
   always #(STEP/2)
     CLK = ~CLK;
   initial CLK=0;

   initial begin
      DIVISOR_TVALID  <= 1'b1;
      DIVIDEND_TVALID <= 1'b1;
      DIVISOR_TDATA   <= 16'd3;
      DIVIDEND_TDATA  <= 24'd0;
   end

   always@ (posedge CLK) begin
      DIVIDEND_TDATA <= DIVIDEND_TDATA + 24'd1;
   end
   
endmodule
