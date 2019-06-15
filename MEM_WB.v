module MEM_WB(
clk,
rst,
RegWrite_i,
MemToReg_i,
RegWrite_o,
MemToReg_o,
DM_out_i,
ALU_res_i,
Reg_RD_i,
DM_out_o,
ALU_res_o,
Reg_RD_o
);

input clk;
input rst;

// WB control signal
input RegWrite_i;
input MemToReg_i;
output reg RegWrite_o;
output reg MemToReg_o;

input [32-1:0] DM_out_i;
input [32-1:0] ALU_res_i;
input [5-1:0] Reg_RD_i;
output reg [32-1:0] DM_out_o;
output reg [32-1:0] ALU_res_o;
output reg [5-1:0] Reg_RD_o;

always @(posedge clk) begin
	/*if (rst) begin
		RegWrite_o <= 0;
		MemToReg_o <= 0;
		DM_out_o <= 32'b0;
		ALU_res_o <= 32'b0;
		Reg_RD_o <= 5'b0;
	end*/
	//else begin
		RegWrite_o <= RegWrite_i;
		MemToReg_o <= MemToReg_i;
		DM_out_o <= DM_out_i;
		ALU_res_o <= ALU_res_i;
		Reg_RD_o <= Reg_RD_i;
	//end
	//$display("Res: %d", ALU_res_o);
end

endmodule