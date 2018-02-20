module mips_core(clock);
input clock;

wire [31:0] instruction;

wire[31:0] rtCont;
wire[31:0] rsCont;

reg[31:0] writeData;
wire[4:0] writeReg;

reg[31:0] PC = 32'b0;

reg pcChanged = 1'b0;

wire signal_reg_write;

// instruction okuma modulu
mips_instr_mem instructionmem(instruction, PC);
// instruction fetch
wire [5:0] op = instruction[31:26];
wire [4:0] rs = instruction[25:21];
wire [4:0] rt = instruction[20:16];
wire [4:0] rd = instruction[15:11];
wire [4:0] sa = instruction[10:6];
wire [5:0] fn = instruction[5:0];

wire[15:0] imm = instruction[15:0];
wire[25:0] jumpAdr = instruction[25:0];

wire[5:0] jOP = 6'b000010;
wire[5:0] jalOP = 6'b000011;

wire[5:0] lbuOP = 6'b100100;
wire[5:0] lhuOP = 6'b100101;

wire [31:0] read_data_mem;
wire [31:0] mem_address;
wire [31:0] write_data_mem;
wire sig_mem_read, sig_mem_write;

wire sig_branch;
wire sig_mem_to_reg;
wire pc_source;

wire sig_sb, sig_sh;

wire [31:0] alu_out;

// control modulu, sinyalleri initialize ediyor
mips_control control(op, fn , clock, writeReg, sig_branch, sig_mem_read, sig_mem_write, sig_mem_to_reg, signal_reg_write, pc_source,rd ,rt, sig_sb, sig_sh);
// register modulu
mips_registers registers(rsCont,rtCont,writeData,rs,rt,writeReg,signal_reg_write,clock);
// alu modulu
mips_alu alu(alu_out, rsCont, rtCont, op, fn, sa, imm);
// memory modulu
mips_data_mem mips_data_mem(read_data_mem, mem_address, write_data_mem, sig_mem_read, sig_mem_write, sig_sb, sig_sh, clock);

assign mem_address = alu_out;  
assign write_data_mem = rtCont;


// instrucitonun isi bitince, pozitif clock ta yeni
// instruction icin PC atamaları
always @(posedge clock)
begin 
	if (pc_source == 1)     // instruction jr ise
		PC = alu_out;
	else if(op == jOP)		// instruction jump şse
	begin
		PC = {PC[31:28], 2'b0, jumpAdr};
	end
	else if(op == jalOP)		// instruction jal ise
		PC = {PC[31:28], 2'b0, jumpAdr};
	else if(sig_branch == 1 && alu_out == 32'b1)  // branch sinyali varsa ve branch yapabiliyorsa
		PC = PC + $signed(imm);
	else
		PC = PC+1;
end	 

// writeData'ya atama yaparken, instructiona göre farklılık gösteren bit representasyonu
always @(alu_out or read_data_mem)
begin
	
	if(sig_mem_to_reg == 1)
		if(op == lbuOP)
			writeData = {24'b0, read_data_mem[8:0]};
		else if(op == lhuOP)
			writeData = {16'b0, read_data_mem[15:0]};
		else 
			writeData = read_data_mem;
	else if(op == jalOP)
			writeData = PC + 4'b0001;
	else
		writeData = alu_out;
			
end

/*
initial begin
$monitor("instruction: %32b, RS: %32b, RT: %32b,  signal: %b, clock : %b , RD adress: %5b, result = %32b",
			instruction, rsCont,rtCont, signal_reg_write, clock, rd, alu_out);
end
*/

endmodule