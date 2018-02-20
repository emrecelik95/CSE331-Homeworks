module mips_registers
( read_data_1, read_data_2, write_data, read_reg_1, read_reg_2, write_reg, signal_reg_write, clk );

	output reg[31:0] read_data_1, read_data_2;      // rs ve rt contentleri
	input [31:0] write_data;								// yazılacak data
	input [4:0] read_reg_1, read_reg_2, write_reg;	// rs ve rd adressleri
	input signal_reg_write, clk;							// registera yazma sinyali ve clock
	

	reg [31:0] registers [31:0];							// registerlar
	

initial begin
	$readmemb("registers.mem",registers);
end

// clock pozitif iken yazma yap
always @(posedge clk) begin
		
	
		if(signal_reg_write == 1'b1)
		begin
			registers[write_reg] = write_data;
			//$writememb("res_registers.mem",registers);
		end
			
end

// clock negatif iken okuma yap
always @(negedge clk) begin

	read_data_1 = registers[read_reg_1];
	read_data_2 = registers[read_reg_2];

end


endmodule