module IF_ID(clk, rst, PCadd4_i, instruction_i, IF_Flush_i, IF_ID_write_i, PCadd4_o, instruction_o);

input clk;
input rst;

input [32-1:0] PCadd4_i;
input [32-1:0] instruction_i;
input IF_Flush_i;
input IF_ID_write_i;

output reg [32-1:0] PCadd4_o;
output reg [32-1:0] instruction_o;

always @(posedge clk) begin
	/*if(rst == 1) begin
		PCadd4_o <= 32'b0;
		instruction_o <= 32'b0;
	end*/
	if (IF_Flush_i == 1) begin
		PCadd4_o <= 32'b0;
		instruction_o <= 32'b0;
	end
	else if (IF_ID_write_i == 1) begin
		PCadd4_o <= PCadd4_i;
		instruction_o <= instruction_i;
	end
end

endmodule