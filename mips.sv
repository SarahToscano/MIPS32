module mips(
            input clk,
            input rst,
            input logic [31:0] RD,
            output logic [31:0] ADR, WD,
            output logic MemWrite, overflow
            );

    logic IorD;
    logic ALUSrcA;
    logic IRWrite;
    logic PCWrite;
    logic RegDst;
    logic MemtoReg;
    logic RegWrite;
    logic Branch;
    logic [1:0] ALUSrcB;
    logic [1:0] ALUOp;
    logic [1:0] PCSrc;
    logic [05:0] OP;
    logic [05:0] Funct;
    logic BranchNE;
    logic [2:0]ALUControl;

    datapath datapath(clk,rst,IorD,ALUSrcA, ALUSrcB, PCSrc,IRWrite, PCWrite, RegDst,MemtoReg, 
                     RegWrite, Branch, RD, ALUControl,BranchNE,OP, Funct, ADR, WD, overflow);

	control_unit FSM_controller(clk, reset, OP, Funct,MemtoReg,RegDst,IorD,ALUSrcA,IRWrite,
                                MemWrite,PCWrite,Branch,RegWrite,BranchNE,PCSrc,ALUSrcB,ALUControl);


endmodule
