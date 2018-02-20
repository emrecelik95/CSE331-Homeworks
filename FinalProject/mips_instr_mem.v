module mips_instr_mem(instruction, program_counter);
input [31:0] program_counter;  // okunacak indis
output [31:0] instruction;		 // output olarak verilecek instruction

reg [31:0] instr_mem [255:0];  // tum instructionlar

initial begin
	$readmemb("instruction.mem", instr_mem);
end

// instructionu oku
assign instruction = instr_mem[program_counter];

endmodule