module Branch_Or_Jump(
Branch_Addr_i,
Jump_Addr_i,
If_Branch_i,
If_Jump_i,
Addr_o,
PCSrc_o
);

input [32-1:0] Branch_Addr_i;
input [32-1:0] Jump_Addr_i;
input If_Branch_i;
input If_Jump_i;
output reg [32-1:0] Addr_o;
output reg  PCSrc_o;

always @(*) begin
	if (If_Branch_i == 1) begin
		PCSrc_o = 1;
		Addr_o = Branch_Addr_i;
	end
	else if (If_Jump_i == 1) begin
		PCSrc_o = 1;
		Addr_o = Jump_Addr_i;
	end
	else begin
		PCSrc_o = 0;
		Addr_o = 0;
	end
	//$display("branch: %d", If_Branch_i);
end

endmodule