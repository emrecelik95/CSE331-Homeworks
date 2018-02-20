module mips_testbench ();
reg clock;
wire result;

mips_core test(clock);


// (Instruction sayisi) x (2) sayisi kadar clock 
initial begin
	#50 clock = 0; #50 clock=~clock;
	#50 clock=~clock; #50 clock=~clock;
	#50 clock=~clock; #50 clock=~clock;
	//depend instrucion number 
end

// islemler bitince register ve memory sonucunu dosyaya yazma
initial begin
 #2500
 $writememb("res_registers.mem", test.registers.registers);
 $writememb("res_data.mem", test.mips_data_mem.data_mem);
end

endmodule