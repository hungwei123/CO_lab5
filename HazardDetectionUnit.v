module HazardDetectionUnit(
ID_EX_MemRead_i,
IF_ID_Reg_RS_i,
IF_ID_Reg_RT_i,
ID_EX_Reg_RT_i,
PC_Src_i,
IF_ID_Write_o,
PC_Write_o,
IF_Flush_o,
ID_Flush_o,
EX_Flush_o
);

input ID_EX_MemRead_i;
input [5-1:0] IF_ID_Reg_RS_i;
input [5-1:0] IF_ID_Reg_RT_i;
input [5-1:0] ID_EX_Reg_RT_i;
input PC_Src_i;

output reg IF_ID_Write_o;
output reg PC_Write_o;
output reg IF_Flush_o;
output reg ID_Flush_o;
output reg EX_Flush_o;

always @(*) begin
	// load-use hazard
	if ( ID_EX_MemRead_i == 1 && ( (ID_EX_Reg_RT_i == IF_ID_Reg_RS_i) || (ID_EX_Reg_RT_i == IF_ID_Reg_RT_i) ) ) begin
		PC_Write_o = 0;
		IF_ID_Write_o = 0;
		ID_Flush_o = 1; // mux: 0 input
		IF_Flush_o = 0;
		EX_Flush_o = 0;
	end
	// branch, jump hazard
	else if (PC_Src_i == 1) begin
		PC_Write_o = 0;
		IF_ID_Write_o = 0;
		ID_Flush_o = 1;
		IF_Flush_o = 1;
		EX_Flush_o = 1;
	end
	else begin
		PC_Write_o = 1;
		IF_ID_Write_o = 1;
		ID_Flush_o = 0;
		IF_Flush_o = 0;
		EX_Flush_o = 0;
	end
end

endmodule