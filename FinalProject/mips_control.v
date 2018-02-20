module mips_control(op, fn, clk, write_reg, sig_branch, sig_mem_read, sig_mem_write, sig_mem_to_reg, sig_reg_write, pc_source, rd, rt, sig_sb, sig_sh);

	input [5:0] op;				// op code
	input clk;						// clock
	input [5:0] fn;				// func code
	output reg[4:0] write_reg;	// write register
	output reg sig_branch;		// branch sinyali
	output reg sig_mem_read;	// memory read sinyali
	output reg sig_mem_write;	// sinyali write sinyali
	output reg sig_mem_to_reg;	// memory den registera yazma sinyali
	output reg sig_reg_write;	// register write sinyali
	output reg pc_source;		// pc source
	output [4:0] rd;				// rd adress
	output [4:0] rt;				// rt adress
	output reg sig_sb;			// store byte sinyali
	output reg sig_sh;			// store half word sinyali
	
// R- Type
wire[5:0] addOP = 6'b100000;
wire[5:0] adduOP = 6'b100001;
wire[5:0] subOP = 6'b100010;
wire[5:0] andOP = 6'b100100;
wire[5:0] orOP = 6'b100101;
wire[5:0] sraOP = 6'b000011;
wire[5:0] srlOP = 6'b000010;
wire[5:0] sllOP = 6'b000000;
wire[5:0] sltuOP = 6'b101011;

wire[5:0] jrOP = 6'b001000;
wire[5:0] norOP = 6'b100111;
wire[5:0] sltOP = 6'b101010;
wire[5:0] subuOP = 6'b100011;
///////////////////////////////
// I - Type
wire[5:0] addiOP = 6'b001000;
wire[5:0] addiuOP = 6'b001001;

wire[5:0] andiOP = 6'b001100;
wire[5:0] beqOP = 6'b000100;
wire[5:0] bneOP = 6'b000101;
wire[5:0] lbuOP = 6'b100100;
wire[5:0] lhuOP = 6'b100101;
wire[5:0] llOP = 6'b110000;
wire[5:0] luiOP = 6'b001111;
wire[5:0] lwOP = 6'b100011;
wire[5:0] oriOP = 6'b001101;
wire[5:0] sltiOP = 6'b001010;
wire[5:0] sltiuOP = 6'b001011;
wire[5:0] sbOP = 6'b101000;
wire[5:0] scOP = 6'b111000;
wire[5:0] shOP = 6'b101001;
wire[5:0] swOP = 6'b101011;

///////////////////////////////

// J - Type
//////////////////////////////
wire[5:0] jOP = 6'b000010;
wire[5:0] jalOP = 6'b000011;
//////////////////////////////
	
// clock negatif durumda calisir
always @(negedge clk)
begin
	pc_source = 0;
	sig_mem_write = 0;
	sig_mem_read = 0;
	sig_branch = 0;
	sig_reg_write = 0;
	sig_mem_to_reg = 0;
	sig_sb = 0;
	sig_sh = 0;
	
	if(op == 6'b0) // r typle lar
	begin
		write_reg = rd;   // her zaman rd ye yazılır
		sig_reg_write = 1'b1; // çogu zaman yazma yapılır
		
		if(fn == jrOP)  // jr de register yazma yok
		begin
			pc_source = 1;
			sig_reg_write = 1'b0;
		end
	end
	
	else 
	begin
		write_reg = rt;  // yazılacak sa rt ye yazılır
		sig_reg_write = 1; // register write çoğunlukla var
		
		if(op == beqOP || op == bneOP)
		begin
			sig_reg_write = 1'b0;
			sig_branch = 1;
		end
		
		else if(op == lwOP || op == llOP)
		begin
			sig_mem_read = 1;
			sig_mem_to_reg = 1;
		end
		
		else if(op == lbuOP)
		begin
			sig_mem_read = 1;
			sig_mem_to_reg = 1;
		end
		
		else if(op == luiOP)
		begin
			
		end
		
		else if(op == swOP || op == sbOP || op == shOP)
		begin
			sig_mem_write = 1;
			sig_reg_write = 0;
			
			if(op == sbOP)
				sig_sb = 1;
			else if(op == shOP)
				sig_sh = 1;
		end
		
		else if(op == jOP)
			sig_mem_write = 0;
		
		else if(op == jalOP)
		begin
			write_reg = 5'b11111;
		end
		
		
	end
end
endmodule