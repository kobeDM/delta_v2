`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/06/05 09:50:18
// Design Name: 
// Module Name: TEST_S
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


module TEST_S;
    reg CLK ;
    reg RST ;
    reg TIM_1US ;
    reg  [31:0]LOC_ADDR ;				
    reg   [7:0]  LOC_WD  ; 
    reg     LOC_WE   ;   
    reg   LOC_RE                ;   
    reg REG_STATUS0			;   
    reg [15:0] REG_TRG_STATUS   ;   
    
   
    wire DAC_STRI ;
    wire DAC_SDI ;
    wire DAC_CLKI ;
  



    

    
    
    LOC_REG uut(
    .CLK(CLK),
    .RST(RST),
    .TIM_1US(TIM_1US),
    .LOC_ADDR(LOC_ADDR),
    .LOC_WD(LOC_WD),
    .LOC_WE(LOC_WE),
    .LOC_RE(LOC_RE),
    .REG_STATUS0(REG_STATUS0),
    .REG_TRG_STATUS(REG_TRG_STATUS),
   
    .DAC_STRI(DAC_STRI),
    .DAC_SDI(DAC_SDI),
    .DAC_CLKI(DAC_CLKI)
  
    
    );
    
    parameter STEP=20;
           always #(STEP/2)
           CLK = ~CLK;
           initial CLK=0;
           
           always #(40)
                      TIM_1US = ~TIM_1US;
                      initial TIM_1US=0 ;
           
    
    initial begin
    LOC_ADDR = 32'h00000000;LOC_WE = 1'b0;LOC_WD = 8'h00; //
    #10 RST = 1'b1;
    #10 RST = 1'b0;
    
   
    
 ///  #200 LOC_ADDR = 32'h0000001D;LOC_WE = 1'b1;LOC_WD = 8'h01;
       ///      #200  LOC_ADDR = 32'h0000001D;LOC_WE = 1'b0;LOC_WD = 8'h01;
              
    
          #200 LOC_ADDR = 32'h0000001C;LOC_WE = 1'b1;LOC_WD = 8'h01;
            #200  LOC_ADDR = 32'h0000001C;LOC_WE = 1'b0;LOC_WD = 8'h01;

 
    
      #200 LOC_ADDR = 32'h0000001B;LOC_WE = 1'b1;LOC_WD = 8'h0f;
      #200 LOC_ADDR = 32'h0000001B;LOC_WE = 1'b0;LOC_WD = 8'h0f;   
        
        
           
     
    
   
    
   
    

    
   

    
     
   
    
    
    
    
    
    
    
    
    
    
   end 
endmodule