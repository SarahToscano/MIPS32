module datapath
(	 
	 input logic clk,
	 input logic reset,
	 input logic IorD,
	 input logic ALUSrcA,
	 input logic [1:0] ALUSrcB,
	 input logic [1:0] PCSrc,
	 input logic IRWrite, 
	 input logic PCWrite,
	 input logic RegDst, 
	 input logic MemtoReg, 
	 input logic RegWrite, 
	 input logic Branch,
	 input logic  [31:0] RD,
	 input logic [2:0]ALUControl,
	 input logic BranchNE,

	 output logic [05:0] OP, Funct,
	 output logic [31:0] ADR, WD,
	 output logic overflow
);
	logic [31:0] outputIR;
	logic [31:0] outputMDR;
	logic [31:0] outputData;
	logic [4:0] outputMux5Bit;
	logic [31:0] RD1;
	logic [31:0] RD2;
	logic [31:0] A;
	logic [31:0] B;
	logic [31:0] SrcA;
	logic [31:0] SrcB;
	logic [31:0] outputExtensor;
	logic [31:0] outputLSHIFT;
	logic [27:0] outputExtensorMuxPc;
	logic [31:0] ALUresult;
	logic [31:0] ALUoutput;
	logic [31:0] inputPC;
	logic [31:0] outputPC;
	logic [31:0] outputMUXtoPC;
	logic PCEn, Zero;
	logic MemWrite;
	logic Zero_out;
	
	
	assign inputPC = reset? 32'd0 :	outputMUXtoPC;
	logic [31:0]qa;

	mux2 mux_BNE(Zero, !Zero, BranchNE, Zero_out);
	assign PCEn =  (PCWrite | (Branch&Zero_out));
	
	pc PCreg(reset, clk, PCEn, inputPC, outputPC);
	mux2_32 muxIORD (outputPC,ALUoutput,IorD,ADR); //primeiro uso do PC out
	registradorEnReset IR(clk, reset, IRWrite, RD[31:0], outputIR[31:0]); //-
	mdr MDR(reset, clk, 1'b1, RD, outputMDR);//sempre escreve, com enable 1

	assign Funct=outputIR[5:0];
	assign OP=outputIR[31:26];

	mux2_5 blocomux25 (outputIR[20:16], outputIR[15:11], RegDst, outputMux5Bit);//saida daqui entrada do banco reg
	mux2_32 blocomux232 (ALUoutput, outputMDR, MemtoReg, outputData);
	
	regbank_32 reg_bank(clk,RegWrite,reset,outputData,	outputIR[25:21],outputIR[20:16],outputMux5Bit,RD1,RD2);
	reg32 RD1reg (reset, clk, 1'b1, RD1, A); 
	reg32 RD2reg (reset, clk, 1'b1, RD2, B); 

	assign WD = B;

	extensor Singmn (outputIR[15:0],outputExtensor);
	LSHIFT2 bocoLshift (outputExtensor,outputLSHIFT);
	mux2_32 mux2entradaula (outputPC, A, ALUSrcA, SrcA); //srcA = entrada da ULA
	mux4_32 blocomux432 (B, 32'b00000000000000000000000000000100,outputExtensor,outputLSHIFT, ALUSrcB, SrcB); //srcB = entrada da ULA

	ula_32 ALU(SrcA,SrcB, ALUControl, ALUresult, Zero, overflow);
	//uladec ULA32(outputIR[5:0],ALUOp,SrcA,SrcB,ALUresult,Zero);
	reg32 regULA(reset, clk, 1'b1, ALUresult, ALUoutput); 
	LSHIFT2_26 lshIFT26(outputIR[25:0], outputExtensorMuxPc);
	mux3 mux332 ( ALUresult,ALUoutput,{outputPC[31:28], outputExtensorMuxPc[27:0]},PCSrc, outputMUXtoPC);

	
endmodule