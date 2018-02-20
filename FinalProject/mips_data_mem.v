module mips_data_mem (read_data, mem_address, write_data, sig_mem_read, sig_mem_write, sig_sb, sig_sh, clk);
output reg[31:0] read_data;    // okunan memory datası
input [31:0] mem_address;		 // okunacak memory adresi
input [31:0] write_data;		 // yazılacak data
input sig_mem_read;				 // memory'den okuma sinyali
input sig_mem_write;				 // memory'e yazma sinyali
input sig_sb;						 // store byte sinyali
input sig_sh;						 // store half word sinyali
input clk;	
	
reg [31:0] data_mem  [255:0];	 // memory

initial begin
	$readmemb("data.mem", data_mem);
end

// inputların degisimine gore okuma veya yazma yapan block
always @(mem_address or sig_mem_read) begin
	if (sig_mem_read) begin
		read_data = data_mem[mem_address];
	end
end

always @(posedge clk) begin
	
	if (sig_mem_write) begin
		if(sig_sb == 1)
			data_mem[mem_address][7:0] = write_data[7:0];
		else if(sig_sh == 1)
			data_mem[mem_address][15:0] = write_data[15:0];
		else
			data_mem[mem_address] = write_data[31:0];
	end

end



endmodule