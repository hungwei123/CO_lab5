module ID_EX(
clk,
rst,
ALUSrc_i, 
RegDst_i, 
ALUOp_i, 
ALUSrc_o, 
RegDst_o, 
ALUOp_o, 
Branch_i,
BranchType_i,
Jump_i,
MemRead_i, 
MemWrite_i, 
Branch_o,
BranchType_o,
Jump_o,
MemRead_o, 
MemWrite_o, 
RegWrite_i,
MemToReg_i,
RegWrite_o,
MemToReg_o,
PCadd4_i,
RSData_i,
RTData_i,
Sign_Extend_i,
IF_ID_Reg_RS_i,
IF_ID_Reg_RT_i,
IF_ID_Reg_RD_i,
PCadd4_o,
RSData_o,
RTData_o,
Sign_Extend_o,
IF_ID_Reg_RS_o,
IF_ID_Reg_RT_o,
IF_ID_Reg_RD_o,
Instr_i,
Instr_o
);

input clk;
input rst;

// EX control signal
input ALUSrc_i;
input RegDst_i;
input [3-1:0] ALUOp_i;
input BranchType_i;
output reg ALUSrc_o;
output reg RegDst_o;
output reg [3-1:0] ALUOp_o;
output reg BranchType_o;

// MEM control signal
input Branch_i;
input Jump_i;
input MemRead_i;
input MemWrite_i;
output reg Branch_o;
output reg Jump_o;
output reg MemRead_o;
output reg MemWrite_o;

// WB control signal
input RegWrite_i;
input MemToReg_i;
output reg RegWrite_o;
output reg MemToReg_o;


input [32-1:0] PCadd4_i;
input [32-1:0] RSData_i;
input [32-1:0] RTData_i;
input [32-1:0] Sign_Extend_i;
input [5-1:0] IF_ID_Reg_RS_i;
input [5-1:0] IF_ID_Reg_RT_i;
input [5-1:0] IF_ID_Reg_RD_i;
input [32-1:0] Instr_i;

output reg [32-1:0] PCadd4_o;
output reg [32-1:0] RSData_o;
output reg [32-1:0] RTData_o;
output reg [32-1:0] Sign_Extend_o;
output reg [5-1:0] IF_ID_Reg_RS_o;
output reg [5-1:0] IF_ID_Reg_RT_o;
output reg [5-1:0] IF_ID_Reg_RD_o;
output reg [32-1:0] Instr_o;

always @(posedge clk) begin
	/*if (rst == 1) begin
		ALUSrc_o <= 0;
		RegDst_o <= 0;
		ALUOp_o <= 3'b0;
		Branch_o <= 0;
		BranchType_o <= 0;
		Jump_o <= 0;
		MemRead_o <= 0;
		MemWrite_o <= 0;
		RegWrite_o <= 0;
		MemToReg_o <= 0;
		PCadd4_o <= 32'b0;
		RSData_o <= 32'b0;
		RTData_o <= 32'b0;
		Sign_Extend_o <= 32'b0;
		IF_ID_Reg_RS_o <= 5'b0;
		IF_ID_Reg_RT_o <= 5'b0;
		IF_ID_Reg_RD_o <= 5'b0;
		Instr_o <= 0;
	end*/
	//else begin
		ALUSrc_o <= ALUSrc_i;
		RegDst_o <= RegDst_i;
		ALUOp_o <= ALUOp_i;
		Branch_o <= Branch_i;
		BranchType_o <= BranchType_i;
		Jump_o <= Jump_i;
		MemRead_o <= MemRead_i;
		MemWrite_o <= MemWrite_i;
		RegWrite_o <= RegWrite_i;
		MemToReg_o <= MemToReg_i;
		PCadd4_o <= PCadd4_i;
		RSData_o <= RSData_i;
		RTData_o <= RTData_i;
		Sign_Extend_o <= Sign_Extend_i;
		IF_ID_Reg_RS_o <= IF_ID_Reg_RS_i;
		IF_ID_Reg_RT_o <= IF_ID_Reg_RT_i;
		IF_ID_Reg_RD_o <= IF_ID_Reg_RD_i;
		Instr_o <= Instr_i;
	//end
	//$display("RT & extended: %d %d", IF_ID_Reg_RT_i, Sign_Extend_i);
end

endmodule