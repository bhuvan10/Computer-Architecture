module RegFile(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);
   input clk;
        input reset,RegWrite;
        input [1:0] ReadReg1,ReadReg2,WriteReg;
        input [31:0] WriteData;
        output [31:0] ReadData1,ReadData2;
   wire [3:0][31:0] regOut;
        reg [31:0] regIn;
        wire [3:0] decoderOut;
        wire [3:0] regClk;
        decoder_2to4 dec1( decoderOut, WriteReg );
        assign regClk[0] = (clk & RegWrite & decoderOut[0]);
        assign regClk[1] = (clk & RegWrite & decoderOut[1]);
        assign regClk[2] = (clk & RegWrite & decoderOut[2]);
        assign regClk[3] = (clk & RegWrite & decoderOut[3]);

        reg_32bit r0( regOut[0], regIn, regClk[0], reset );
        reg_32bit r1( regOut[1], regIn, regClk[1], reset );
        reg_32bit r2( regOut[2], regIn, regClk[2], reset );
        reg_32bit r3( regOut[3], regIn, regClk[3], reset );

        mux_4to1 m1( ReadData1, regOut[0] , regOut[1] , regOut[2], regOut[3], ReadReg1 );
        mux_4to1 m2( ReadData2, regOut[0] , regOut[1] , regOut[2] , regOut[3], ReadReg2 );
endmodule