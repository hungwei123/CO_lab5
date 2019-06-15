module Forwarding(
EX_MEM_Reg_RD,
MEM_WB_Reg_RD,
ID_EX_Reg_RS,
ID_EX_Reg_RT,
EX_MEM_RegWrite,
MEM_WB_RegWrite,
ForwardA,
ForwardB
);

input [5-1:0] EX_MEM_Reg_RD;
input [5-1:0] MEM_WB_Reg_RD;
input [5-1:0] ID_EX_Reg_RS;
input [5-1:0] ID_EX_Reg_RT;
input EX_MEM_RegWrite;
input MEM_WB_RegWrite;

output reg [2-1:0] ForwardA;
output reg [2-1:0] ForwardB;
reg if_ex_hazardA;
reg if_ex_hazardB;

always @(*) begin
	ForwardA = 2'b00;
	ForwardB = 2'b00;
	if_ex_hazardA = 0;
	if_ex_hazardB = 0;
	if ((EX_MEM_RegWrite == 1) && (EX_MEM_Reg_RD != 0) && (EX_MEM_Reg_RD == ID_EX_Reg_RS)) begin
		ForwardA = 2'b10;
		if_ex_hazardA = 1;
	end
	if ((EX_MEM_RegWrite == 1) && (EX_MEM_Reg_RD != 0) && (EX_MEM_Reg_RD == ID_EX_Reg_RT)) begin
		ForwardB = 2'b10;
		if_ex_hazardB = 1;
	end
	if((MEM_WB_RegWrite == 1) && (MEM_WB_Reg_RD != 0) && (!if_ex_hazardA) && (MEM_WB_Reg_RD == ID_EX_Reg_RS)) begin
		ForwardA = 2'b01;
	end
	if((MEM_WB_RegWrite == 1) && (MEM_WB_Reg_RD != 0) && (!if_ex_hazardB) && (MEM_WB_Reg_RD == ID_EX_Reg_RT)) begin
		ForwardB = 2'b01;
	end
end

endmodule