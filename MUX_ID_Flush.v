module MUX_ID_Flush(
ID_Flush_i,
RegWrite_i,
ALUOp_i, 
ALUSrc_i, 
RegDst_i, 
Branch_i, 
Jump_i, 
MemRead_i, 
MemWrite_i, 
MemtoReg_i, 
BranchType_i,
RegWrite_o,
ALUOp_o, 
ALUSrc_o, 
RegDst_o, 
Branch_o, 
Jump_o, 
MemRead_o, 
MemWrite_o, 
MemtoReg_o, 
BranchType_o
);

input ID_Flush_i;
input RegWrite_i;
input [3-1:0] ALUOp_i; 
input ALUSrc_i; 
input RegDst_i; 
input Branch_i; 
input Jump_i; 
input MemRead_i; 
input MemWrite_i; 
input MemtoReg_i; 
input BranchType_i;

output reg RegWrite_o;
output reg [3-1:0] ALUOp_o; 
output reg ALUSrc_o; 
output reg RegDst_o; 
output reg Branch_o; 
output reg Jump_o; 
output reg MemRead_o; 
output reg MemWrite_o; 
output reg MemtoReg_o; 
output reg BranchType_o;

always @(*) begin
if(ID_Flush_i == 0) begin
	RegWrite_o = RegWrite_i;
	ALUOp_o = ALUOp_i;
	ALUSrc_o = ALUSrc_i;
	RegDst_o = RegDst_i;
	Branch_o = Branch_i;
	Jump_o = Jump_i; //MEM
	MemRead_o = MemRead_i;
	MemWrite_o = MemWrite_i;
	MemtoReg_o = MemtoReg_i;
	BranchType_o = BranchType_i; //EX
end
else begin
	RegWrite_o = 0;
	ALUOp_o = 0;
	ALUSrc_o = 0;
	RegDst_o = 0;
	Branch_o = 0;
	Jump_o = 0;
	MemRead_o = 0;
	MemWrite_o = 0;
	MemtoReg_o = 0;
	BranchType_o = 0;
end
end

endmodule
