module EX_MEM(
clk,
rst,
Branch_i,
Jump_i,
MemRead_i,
MemWrite_i,
Branch_o,
Jump_o,
MemRead_o,
MemWrite_o,
RegWrite_i,
MemToReg_i,
RegWrite_o,
MemToReg_o,
Jump_Addr_i,
Branch_Addr_i,
ALU_Result_i,
Zero_i,
RT_Data_i,
Dest_Reg_i,
Jump_Addr_o,
Branch_Addr_o,
ALU_Result_o,
Zero_o,
RT_Data_o,
Dest_Reg_o
);

input clk;
input rst;

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

input [32-1:0] Jump_Addr_i;
input [32-1:0] Branch_Addr_i;
input [32-1:0] ALU_Result_i;
input Zero_i;
input [32-1:0] RT_Data_i;
input [5-1:0] Dest_Reg_i;
output reg [32-1:0] Jump_Addr_o;
output reg [32-1:0] Branch_Addr_o;
output reg [32-1:0] ALU_Result_o;
output reg Zero_o;
output reg [32-1:0] RT_Data_o;
output reg [5-1:0] Dest_Reg_o;

always @(posedge clk) begin
	/*if (rst) begin
		Branch_o <= 0;
		Jump_o <= 0;
		MemRead_o <= 0;
		MemWrite_o <= 0;
		RegWrite_o <= 0;
		MemToReg_o <= 0;
		Jump_Addr_o <= 0;
		Branch_Addr_o <= 32'b0;
		ALU_Result_o <= 32'b0;
		Zero_o <= 0;
		RT_Data_o <= 32'b0;
		Dest_Reg_o <= 5'b0;
	end*/
	//else begin
		Branch_o <= Branch_i;
		Jump_o <= Jump_i;
		MemRead_o <= MemRead_i;
		MemWrite_o <= MemWrite_i;
		RegWrite_o <= RegWrite_i;
		MemToReg_o <= MemToReg_i;
		Jump_Addr_o <= Jump_Addr_i;
		Branch_Addr_o <= Branch_Addr_i;
		ALU_Result_o <= ALU_Result_i;
		Zero_o <= Zero_i;
		RT_Data_o <= RT_Data_i;
		Dest_Reg_o <= Dest_Reg_i;
	//end
	//$display("ALU & WriteReg: %d %d",ALU_Result_i, Dest_Reg_i);
	//$display("zero: %d", Zero_i);
end

endmodule