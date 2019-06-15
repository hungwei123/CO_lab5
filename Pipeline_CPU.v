module Pipeline_CPU( clk_i, rst_n );

//I/O port
input		clk_i;
input       rst_n;

//Internal Signles
wire [32-1:0] instruction, pc_i, pc_o, rsData, rtData, rdData;
wire [32-1:0] extended, zeroFilled, rtData_before, aluResult, shifterResult;
wire [32-1:0] data_read, result_mux3to1, shiftExtended, pcAdd4, jumpAddr, branchAddr, ifBranch; //ifBranch no
wire [32-1:0] shiftJump;
wire [32-1:0] IF_ID_instruction, IF_ID_pcAdd4, ID_EX_pcAdd4, ID_EX_rsData, ID_EX_rtData_before, ID_EX_extended;
wire [32-1:0] EX_MEM_jumpAddr, EX_MEM_branchAddr, EX_MEM_result_mux3to1, EX_MEM_rtData_middle, MEM_WB_data_read, MEM_WB_result_mux3to1;
wire [32-1:0] pc_Addr, rtData_middle, rsData_after, ID_EX_instruction;
wire [5-1:0] writeAddr, ID_EX_regRS, ID_EX_regRT, ID_EX_regRD, writeReg, EX_MEM_writeReg, MEM_WB_writeReg;
wire [4-1:0] aluOperation;
wire [3-1:0] aluOP, ID_aluOP, ID_EX_aluOP;
wire [2-1:0] furSlt, forwardA, forwardB;
wire regWrite, aluSrc, aluZero, aluZero_not, aluOverflow, shiftLR, regDst, memToReg;
wire branch, jump, memRead, memWrite, branchType;
wire ifZero, pcSrc;
wire IF_flush, ID_flush, EX_flush, IF_ID_write, EX_MEM_ifZero, PC_write, If_Branch;
wire ID_regWrite, ID_aluSrc, ID_regDst, ID_branch, ID_jump, ID_memRead, ID_memWrite, ID_memToReg, ID_branchType;
wire ID_EX_regWrite, ID_EX_aluSrc, ID_EX_regDst, ID_EX_branch, ID_EX_jump, ID_EX_memRead, ID_EX_memWrite, ID_EX_memToReg, ID_EX_branchType;
wire EX_branch, EX_branchType, EX_jump, EX_memRead, EX_memWrite, EX_regWrite, EX_memToReg;
wire EX_MEM_branch, EX_MEM_branchType, EX_MEM_jump, EX_MEM_memRead, EX_MEM_memWrite, EX_MEM_regWrite, EX_MEM_memToReg;
wire MEM_WB_regWrite, MEM_WB_memToReg;
//modules


HazardDetectionUnit HD(
.ID_EX_MemRead_i(ID_EX_memRead),
.IF_ID_Reg_RS_i(IF_ID_instruction[25:21]),
.IF_ID_Reg_RT_i(IF_ID_instruction[20:16]),
.ID_EX_Reg_RT_i(ID_EX_regRT),
.PC_Src_i(pcSrc),
.IF_ID_Write_o(IF_ID_write),
.PC_Write_o(PC_write),
.IF_Flush_o(IF_flush),
.ID_Flush_o(ID_flush),
.EX_Flush_o(EX_flush)
);

Branch_Or_Jump B_or_J(
.Branch_Addr_i(EX_MEM_branchAddr),
.Jump_Addr_i(EX_MEM_jumpAddr),
.If_Branch_i(If_Branch),
.If_Jump_i(EX_MEM_jump),
.Addr_o(pc_Addr),
.PCSrc_o(pcSrc)
);

IF_ID IFID(
.clk(clk_i),
.rst(rst_n),
.PCadd4_i(pcAdd4), 
.instruction_i(instruction), 
.IF_Flush_i(IF_flush),
.IF_ID_write_i(IF_ID_write), 
.PCadd4_o(IF_ID_pcAdd4), 
.instruction_o(IF_ID_instruction)
);

ID_EX IDEX(
.clk(clk_i),
.rst(rst_n),
.ALUSrc_i(ID_aluSrc), 
.RegDst_i(ID_regDst), 
.ALUOp_i(ID_aluOP), 
.ALUSrc_o(ID_EX_aluSrc), 
.RegDst_o(ID_EX_regDst), 
.ALUOp_o(ID_EX_aluOP), 
.Branch_i(ID_branch),
.BranchType_i(ID_branchType),
.Jump_i(ID_jump),
.MemRead_i(ID_memRead),
.MemWrite_i(ID_memWrite), 
.Branch_o(ID_EX_branch),
.BranchType_o(ID_EX_branchType),
.Jump_o(ID_EX_jump),
.MemRead_o(ID_EX_memRead),
.MemWrite_o(ID_EX_memWrite),
.RegWrite_i(ID_regWrite),
.MemToReg_i(ID_memToReg),
.RegWrite_o(ID_EX_regWrite),
.MemToReg_o(ID_EX_memToReg),
.PCadd4_i(IF_ID_pcAdd4),
.RSData_i(rsData),
.RTData_i(rtData_before),
.Sign_Extend_i(extended),
.IF_ID_Reg_RS_i(IF_ID_instruction[25:21]),
.IF_ID_Reg_RT_i(IF_ID_instruction[20:16]),
.IF_ID_Reg_RD_i(IF_ID_instruction[15:11]),
.PCadd4_o(ID_EX_pcAdd4),
.RSData_o(ID_EX_rsData),
.RTData_o(ID_EX_rtData_before),
.Sign_Extend_o(ID_EX_extended),
.IF_ID_Reg_RS_o(ID_EX_regRS),
.IF_ID_Reg_RT_o(ID_EX_regRT),
.IF_ID_Reg_RD_o(ID_EX_regRD),
.Instr_i(IF_ID_instruction),
.Instr_o(ID_EX_instruction)
);

EX_MEM EXMEM(
.clk(clk_i),
.rst(rst_n),
.Branch_i(EX_branch),
.Jump_i(EX_jump),
.MemRead_i(EX_memRead),
.MemWrite_i(EX_memWrite),
.Branch_o(EX_MEM_branch),
.Jump_o(EX_MEM_jump),
.MemRead_o(EX_MEM_memRead),
.MemWrite_o(EX_MEM_memWrite),
.RegWrite_i(EX_regWrite),
.MemToReg_i(EX_memToReg),
.RegWrite_o(EX_MEM_regWrite),
.MemToReg_o(EX_MEM_memToReg),
.Jump_Addr_i(jumpAddr),
.Branch_Addr_i(branchAddr),
.ALU_Result_i(result_mux3to1),
.Zero_i(ifZero),
.RT_Data_i(rtData_middle),
.Dest_Reg_i(writeReg),
.Jump_Addr_o(EX_MEM_jumpAddr),
.Branch_Addr_o(EX_MEM_branchAddr),
.ALU_Result_o(EX_MEM_result_mux3to1),
.Zero_o(EX_MEM_ifZero),
.RT_Data_o(EX_MEM_rtData_middle),
.Dest_Reg_o(EX_MEM_writeReg)
);

MEM_WB MEMWB(
.clk(clk_i),
.rst(rst_n),
.RegWrite_i(EX_MEM_regWrite),
.MemToReg_i(EX_MEM_memToReg),
.RegWrite_o(MEM_WB_regWrite),
.MemToReg_o(MEM_WB_memToReg),
.DM_out_i(data_read),
.ALU_res_i(EX_MEM_result_mux3to1),
.Reg_RD_i(EX_MEM_writeReg),
.DM_out_o(MEM_WB_data_read),
.ALU_res_o(MEM_WB_result_mux3to1),
.Reg_RD_o(MEM_WB_writeReg)
);

Forwarding FW(
.EX_MEM_Reg_RD(EX_MEM_writeReg),
.MEM_WB_Reg_RD(MEM_WB_writeReg),
.ID_EX_Reg_RS(ID_EX_regRS),
.ID_EX_Reg_RT(ID_EX_regRT),
.EX_MEM_RegWrite(EX_MEM_regWrite),
.MEM_WB_RegWrite(MEM_WB_regWrite),
.ForwardA(forwardA),
.ForwardB(forwardB)
);

MUX_ID_Flush MUX_IDflush(
.ID_Flush_i(ID_flush),
.RegWrite_i(regWrite),
.ALUOp_i(aluOP), 
.ALUSrc_i(aluSrc), 
.RegDst_i(regDst), 
.Branch_i(branch), 
.Jump_i(jump), 
.MemRead_i(memRead), 
.MemWrite_i(memWrite), 
.MemtoReg_i(memToReg), 
.BranchType_i(branchType),
.RegWrite_o(ID_regWrite),
.ALUOp_o(ID_aluOP), 
.ALUSrc_o(ID_aluSrc), 
.RegDst_o(ID_regDst), 
.Branch_o(ID_branch), 
.Jump_o(ID_jump), 
.MemRead_o(ID_memRead), 
.MemWrite_o(ID_memWrite), 
.MemtoReg_o(ID_memToReg), 
.BranchType_o(ID_branchType)
);

MUX_EX_Flush_MEM MUX_EXflushMEM(
.EX_Flush_i(EX_flush),
.Branch_i(ID_EX_branch),
.Jump_i(ID_EX_jump),
.MemRead_i(ID_EX_memRead),
.MemWrite_i(ID_EX_memWrite),
.Branch_o(EX_branch),
.Jump_o(EX_jump),
.MemRead_o(EX_memRead),
.MemWrite_o(EX_memWrite)
);

MUX_EX_Flush_WB MUX_EXflushWB(
.EX_Flush_i(EX_flush),
.RegWrite_i(ID_EX_regWrite),
.MemtoReg_i(ID_EX_memToReg), 
.RegWrite_o(EX_regWrite), 
.MemtoReg_o(EX_memToReg)
);

Mux3to1 #(.size(32)) Mux_Forward_A(
.data0_i(ID_EX_rsData),
.data1_i(rdData),	
.data2_i(EX_MEM_result_mux3to1),
.select_i(forwardA),
.data_o(rsData_after)  
);

Mux3to1 #(.size(32)) Mux_Forward_B(
.data0_i(ID_EX_rtData_before),
.data1_i(rdData),	
.data2_i(EX_MEM_result_mux3to1),
.select_i(forwardB),
.data_o(rtData_middle)  
);

// ------old code-------

Program_Counter PC(      
.clk_i(clk_i),
.rst_n(rst_n),
.pc_in_i(pc_i),   
.pc_out_o(pc_o),
.PCWrite_i(PC_write)
);
	


Adder Adder1(
.src1_i(pc_o),     
.src2_i(32'd4),
.sum_o(pcAdd4)    
);
	


Instr_Memory IM(
.pc_addr_i(pc_o),  
 .instr_o(instruction)    
 );


// new one
Mux2to1 #(.size(5)) Mux_Write_Reg(
.data0_i(ID_EX_regRT),
.data1_i(ID_EX_regRD),
.select_i(ID_EX_regDst),
.data_o(writeReg)
);	
		


Reg_File RF(
.clk_i(clk_i),      
.rst_n(rst_n) ,     
.RSaddr_i(IF_ID_instruction[25:21]),  
.RTaddr_i(IF_ID_instruction[20:16]),  
.Wrtaddr_i(MEM_WB_writeReg),
.Wrtdata_i(rdData),
.RegWrite_i(MEM_WB_regWrite),
.RSdata_o(rsData) ,  
.RTdata_o(rtData_before)          
 );
	


Decoder Decoder(
.instr_op_i(IF_ID_instruction[31:26]), 
.RegWrite_o(regWrite),    
.ALUOp_o(aluOP),   
.ALUSrc_o(aluSrc),   
.RegDst_o(regDst),
.Branch_o(branch),
.BranchType_o(branchType),
.Jump_o(jump),
.MemRead_o(memRead),
.MemWrite_o(memWrite),
.MemtoReg_o(memToReg)
);


ALU_Ctrl AC(
.funct_i(ID_EX_instruction[5:0]),
.ALUOp_i(ID_EX_aluOP),   
.ALU_operation_o(aluOperation),
.leftRight_o(shiftLR),
.FURslt_o(furSlt) 
);
	
Sign_Extend SE(
.data_i(IF_ID_instruction[15:0]),
.data_o(extended)
);

Zero_Filled ZF(
.data_i(IF_ID_instruction[15:0]),
.data_o(zeroFilled)     
);
		
Mux2to1 #(.size(32)) ALU_src2Src(
.data0_i(rtData_middle),
.data1_i(ID_EX_extended),
.select_i(ID_EX_aluSrc),
.data_o(rtData)
);	
		
ALU ALU(	
.aluSrc1(rsData_after),
.aluSrc2(rtData),
.ALU_operation_i(aluOperation),	
.result(aluResult),	
.zero(aluZero),	
.overflow(aluOverflow)
);
		
Shifter shifter( 	
.result(shifterResult), 	
.leftRight(shiftLR),	
.shamt(ID_EX_instruction[10:6]),
.sftSrc(rtData) 	
);

Mux3to1 #(.size(32)) 
RDdata_Source(
.data0_i(aluResult),
.data1_i(shifterResult),	
.data2_i(zeroFilled),
.select_i(furSlt),
.data_o(result_mux3to1)  
);			

Data_Memory DM(
.clk_i(clk_i),
.addr_i(EX_MEM_result_mux3to1),
.data_i(EX_MEM_rtData_middle),
.MemRead_i(EX_MEM_memRead),
.MemWrite_i(EX_MEM_memWrite),
.data_o(data_read)
);

Mux2to1 #(.size(32)) mem_to_reg(
.data0_i(MEM_WB_result_mux3to1),
.data1_i(MEM_WB_data_read),
.select_i(MEM_WB_memToReg),
.data_o(rdData)
);

Mux2to1 #(.size(1)) if_zero(
.data0_i(aluZero),
.data1_i(aluZero_not),
.select_i(ID_EX_branchType),
.data_o(ifZero)
);

Adder Adder2(
.src1_i(ID_EX_pcAdd4),     
.src2_i(shiftExtended),
.sum_o(branchAddr) 
);

Shifter shift_jump( 	
.result(shiftJump), 	
.leftRight(1'b1), // left
.shamt(5'b00010),
.sftSrc(ID_EX_instruction)
);

Shifter shift_extended( 	
.result(shiftExtended), 	
.leftRight(1'b1), // left
.shamt(5'b00010),
.sftSrc(ID_EX_extended)
);

Mux2to1 #(.size(32)) to_PC(
.data0_i(pcAdd4),
.data1_i(pc_Addr),
.select_i(pcSrc),
.data_o(pc_i)
);

assign aluZero_not = ~aluZero;
assign If_Branch = EX_MEM_branch & EX_MEM_ifZero;
assign jumpAddr = {ID_EX_pcAdd4[31:28], shiftJump[27:0]};

endmodule



