module MUX_EX_Flush_MEM(
EX_Flush_i,
Branch_i,
Jump_i,
MemRead_i,
MemWrite_i,
Branch_o,
Jump_o,
MemRead_o,
MemWrite_o
);

input EX_Flush_i;
input Branch_i;
input Jump_i;
input MemRead_i;
input MemWrite_i;

output reg Branch_o;
output reg Jump_o;
output reg MemRead_o;
output reg MemWrite_o;

always @(*) begin
if(EX_Flush_i == 0) begin
	Branch_o = Branch_i;
	Jump_o = Jump_i;
	MemRead_o = MemRead_i;
	MemWrite_o = MemWrite_i;
end
else begin
	Branch_o = 0;
	Jump_o = 0;
	MemRead_o = 0;
	MemWrite_o = 0;
end
end

endmodule
