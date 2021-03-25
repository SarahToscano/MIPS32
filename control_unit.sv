module control_unit(input logic clk,
					 input logic rst,
					 input logic [5:0] Op,
					 input logic [5:0] Funct,
					 output logic MemtoReg,
					 output logic RegDst,
					 output logic IorD,
					 output logic AluSrcA,
					 output logic IRWrite,
					 output logic MemWrite,
					 output logic PCWrite,
					 output logic Branch,
					 output logic RegWrite,
					 output logic BranchNE,
					 output logic [1:0] PCSrc,
					 output logic [1:0] AluSrcB,
					 output logic [2:0] AluControl);
	
	typedef enum logic [3:0]{state0,state1,state2,state3,state4,state5,state6,state7,state8,state9,state10,state11,state12,state13,state14,state15} State;
	State this_state;
	State next_state;
	logic [2:0] ALUOp;
	logic [3:0] curr_state;

	assign curr_state = this_state;

	always_ff@(posedge clk)begin		
		if(rst)
			this_state = state0;
		else
			this_state = next_state;
	end
	
	always_comb begin
		case(this_state)
			//S0 ---> FETCH
			state0: begin
				IorD = 1'b0;
				AluSrcA = 1'b0;
				AluSrcB = 2'b01;
				ALUOp = 3'b000;
				PCSrc = 2'b00;
				IRWrite = 1'b1;
				PCWrite = 1'b1;
				//outras sa�das em default
				BranchNE = 1'b0;
				MemWrite = 1'b0;
				RegDst = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b0;
				Branch = 1'b0;
				
				next_state = state1;
			end
			
			//S1 ---> DECODE
			state1: begin
				AluSrcA = 1'b0;
				AluSrcB = 2'b11;
				ALUOp = 3'b000;
				//outras sa�das em default
				BranchNE = 1'b0;
				IorD = 1'b0;
				MemWrite = 1'b0;
				IRWrite = 1'b0;
				RegDst = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b0;
				Branch = 1'b0;
				PCWrite = 1'b0;
				PCSrc = 2'b00;
			
				case(Op)
					//INSTRU��O SW OU LW ---- > S2
					6'b100011:
						next_state = state2;
					//INSTRU��O LW OU SW ---- > S2
					6'b101011:
						next_state = state2;
					//INSTRU��O R ---- > S6
					6'b000000:
						next_state = state6;
					//INSTRU��O BRANCH ---> S8
					6'b000100:
						next_state = state8;
					//INSTRU��O ADDI ---- > S9
					6'b001000:
						next_state = state9;
					//INSTRU��O J ---- > S11
					6'b000010:
						next_state = state11;
					//INSTRU��O ORI ---- > S12
					6'b001101:
						next_state = state12;
					//INSTRU��O XORI ---- > S13
					6'b001110:
						next_state = state13;
					//INSTRU��O SLTI ---- > S14
					6'b001010:
						next_state = state14;
					//INSTRU��O BNE ---- > S15
					6'b000101:
						next_state = state15;
						
					default:
						next_state = state0;
				endcase
			end
			
			//S2 ---> MEMADR
			state2: begin
				
				AluSrcA = 1'b1;
				AluSrcB = 2'b10;
				ALUOp = 3'b000;
				//outras sa�das em default
				BranchNE = 1'b0;
				IorD = 1'b0;
				MemWrite = 1'b0;
				IRWrite = 1'b0;
				RegDst = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b0;
				Branch = 1'b0;
				PCWrite = 1'b0;
				PCSrc = 2'b00;
				
				case(Op)
					//INSTRU��O LW ---- > S3
					6'b100011:
						next_state = state3;
						
					//INSTRU��O SW ---- > S5
					6'b101011:
						next_state = state5;
						
					default:
						next_state = state0;
				endcase
			end
			
			//S3 ---> MEMREAD
			state3: begin
				
				IorD = 1'b1;
				//outras sa�das em default
				BranchNE = 1'b0;
				MemWrite = 1'b0;
				IRWrite = 1'b0;
				RegDst = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b0;
				AluSrcA = 1'b0;
				AluSrcB = 2'b00;
				ALUOp = 3'b000;
				Branch = 1'b0;
				PCWrite = 1'b0;
				PCSrc = 2'b00;
				
				next_state = state4;
				
			end
			
			//S4 ---> MEM WRITEBACK
			state4: begin
				RegDst = 1'b0;
				MemtoReg = 1'b1;
				RegWrite = 1'b1;
				//outras sa�das em default
				BranchNE = 1'b0;
				IorD = 1'b0;
				MemWrite = 1'b0;
				IRWrite = 1'b0;
				AluSrcA = 1'b0;
				AluSrcB = 2'b00;
				ALUOp = 3'b000;
				Branch = 1'b0;
				PCWrite = 1'b0;
				PCSrc = 2'b00;
				
				next_state = state0;
			
			end
			
			//S5 ---> MEMWRITE
			state5: begin
				IorD = 1'b1;
				MemWrite = 1'b1;
				//outras sa�das em default
				BranchNE = 1'b0;
				IRWrite = 1'b0;
				RegDst = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b0;
				AluSrcA = 1'b0;
				AluSrcB = 2'b00;
				ALUOp = 3'b000;
				Branch = 1'b0;
				PCWrite = 1'b0;
				PCSrc = 2'b00;
				
				next_state = state0;
			
			end
			
			//S6 ---> EXECUTE
			state6: begin
				AluSrcA = 1'b1;
				AluSrcB = 2'b00;
				ALUOp = 3'b010;
				//outras sa�das em default
				BranchNE = 1'b0;
				IorD = 1'b0;
				MemWrite = 1'b0;
				IRWrite = 1'b0;
				RegDst = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b0;
				Branch = 1'b0;
				PCWrite = 1'b0;
				PCSrc = 2'b00;
				
				next_state = state7;
			end
			
			//S7 ---> WRITEBACK
			state7: begin
				RegDst = 1'b1;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				//outras sa�das em default
				BranchNE = 1'b0;
				IorD = 1'b0;
				MemWrite = 1'b0;
				IRWrite = 1'b0;
				AluSrcA = 1'b0;
				AluSrcB = 2'b00;
				ALUOp = 3'b000;
				Branch = 1'b0;
				PCWrite = 1'b0;
				PCSrc = 2'b00;
				
				next_state = state0;
			end
			
			//S8 ---> BRANCH
			state8: begin
				AluSrcA = 1'b1;
				AluSrcB = 2'b00;
				ALUOp = 3'b001;
				PCSrc = 2'b01;
				Branch = 1'b1;
				//outras sa�das em default
				BranchNE = 1'b0;
				IorD = 1'b0;
				MemWrite = 1'b0;
				IRWrite = 1'b0;
				RegDst = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b0;
				PCWrite = 1'b0;
				
				next_state = state0;
			end
			
			//S9 ---> ADDI EXECUTE
			state9: begin
				AluSrcA = 1'b1;
				AluSrcB = 2'b10;
				ALUOp = 3'b000;
				//outras sa�das em default
				BranchNE = 1'b0;
				IorD = 1'b0;
				MemWrite = 1'b0;
				IRWrite = 1'b0;
				RegDst = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b0;
				Branch = 1'b0;
				PCWrite = 1'b0;
				PCSrc = 2'b00;
				
				next_state = state10;
			end
			
			//S10 ---> ADDI WRITEBACK
			state10: begin
				RegDst = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b1;
				//outras sa�das em default
				BranchNE = 1'b0;
				IorD = 1'b0;
				MemWrite = 1'b0;
				IRWrite = 1'b0;
				AluSrcA = 1'b0;
				AluSrcB = 2'b00;
				ALUOp = 3'b000;
				Branch = 1'b0;
				PCWrite = 1'b0;
				PCSrc = 2'b00;
				
				next_state = state0;
			end
			
			//S11 ---> JUMP
			state11: begin
				PCWrite = 1'b1;
				PCSrc = 2'b10;
				//outras sa�das em default
				BranchNE = 1'b0;
				IorD = 1'b0;
				MemWrite = 1'b0;
				IRWrite = 1'b0;
				RegDst = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b0;
				AluSrcA = 1'b0;
				AluSrcB = 2'b00;
				ALUOp = 3'b000;
				Branch = 1'b0;
				
				next_state = state0;
			end	
			
			//S12 ---> ORI
			state12: begin
				AluSrcA = 1'b1;
				AluSrcB = 2'b10;
				ALUOp = 3'b110;
				//outras sa�das em default
				PCSrc = 2'b00;
				Branch = 1'b0;
				BranchNE = 1'b0;
				IorD = 1'b0;
				MemWrite = 1'b0;
				IRWrite = 1'b0;
				RegDst = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b0;
				PCWrite = 1'b0;
				
				next_state = state0;
			end
			
			//S13 ---> XORI EXECUTE
			state13: begin 
				AluSrcA = 1'b1;
				AluSrcB = 2'b10;
				ALUOp = 3'b111;
				//outras sa�das em default
				BranchNE = 1'b0;
				Branch = 1'b0;
				PCSrc = 2'b00;
				IorD = 1'b0;
				MemWrite = 1'b0;
				IRWrite = 1'b0;
				RegDst = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b0;
				PCWrite = 1'b0;
				// pr�ximo est�gio -> ORI WRITEBACK, que � igual ao wirteback do addi...
				next_state = state10;
			end

			//S14 ---> SLTI EXECUTE 
			state14: begin
				AluSrcA = 1'b1;
				AluSrcB = 2'b10;
				ALUOp = 2'b011;
				//outras sa�das em default
				BranchNE = 1'b0;
				Branch = 1'b0;
				PCSrc = 2'b00;
				IorD = 1'b0;
				MemWrite = 1'b0;
				IRWrite = 1'b0;
				RegDst = 1'b0;
				MemtoReg = 1'b0;
				RegWrite = 1'b0;
				PCWrite = 1'b0;
				// pr�ximo est�gio -> XORI WRITEBACK, que � igual ao wirteback do addi...
				next_state = state10;
			end
			
			//S15 ---> BNE
			state15: begin
				AluSrcA = 1'b1;
				AluSrcB = 2'b00;
				PCSrc = 2'b01;
				ALUOp = 3'b100;
				Branch = 1'b1;
				//outras sa�das em default
				BranchNE = 1'b1;
				RegWrite = 1'b0;
				RegDst = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 1'b0;
				IorD = 1'b0;
				IRWrite = 1'b0;
				PCWrite = 1'b0;
				next_state = state0;
			end
			
			default: begin
				IorD = 1'bx;
				MemWrite = 1'b0;
				IRWrite = 1'b0;
				RegDst = 1'bx;
				MemtoReg = 1'bx;
				RegWrite = 1'b0;
				AluSrcA = 1'bx;
				AluSrcB = 2'bxx;
				ALUOp = 3'b000;
				Branch = 1'b0;
				BranchNE = 1'b0;
				PCWrite = 1'b0;
				PCSrc = 2'bxx;
				
				next_state = state0;
			end
			
		endcase


	//Atribui��o de ALUControl
		case(ALUOp)
			3'b000://add
				AluControl = 3'b010;
			
			3'b001://BEQ
				AluControl = 3'b110;

			3'b100: //BNE 
				AluControl = 3'b110;
				
			3'b110: //ORI 
				AluControl = 3'b001;
				
			3'b111: //XORI 
				AluControl = 3'b011;
				
			3'b011: //SLTI 
				AluControl = 3'b111;				
						// BNE -> subtract
						// SLTI -> subtract
						//ORI -> OR
						//XORI -> XOR
						
			3'b010:begin
				
				case(Funct)
					6'b100000://ADD
						AluControl = 3'b010;
			
					6'b100010://SUB
						AluControl = 3'b110;
				
					6'b100100://AND
						AluControl = 3'b000;
					
					6'b100101://OR
						AluControl = 3'b001;
					
					6'b101010://SLT
						AluControl = 3'b111;
					
					6'b100111://NOR
						AluControl = 3'b100;
						
					6'b100110://XOR
						AluControl = 3'b011;
					default:
						AluControl = 3'b000;
				endcase
				
			end
			
			default:
				AluControl = 3'b000;
			
		endcase

	end

	
endmodule
