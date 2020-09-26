module mem_stage(
	input logic clk, nrst,
	input logic fn_e, we_e,
	input logic [31:0] alu_res, // inputs to mem stage (currently ALU result only)
	output logic [31:0] result, // final output that will be written back in register file PIPE #6
	output logic we
	);

	// registers
	logic [31:0] aluresultReg6;
	logic fnReg6, weReg6;
	
	// PIPE
	always_ff @(posedge clk, negedge nrst)
	  begin
		if (!nrst)
		  begin
			aluresultReg6 <= 0;
			fnReg6 	      <= 0;
			weReg6 	      <= 0;
		  end
		else
		  begin
			aluresultReg6 <= alu_res;
			fnReg6 	      <= fn_e;
			weReg6 	      <= we_e;
		  end
	  end
	
	// output (will be replaced by mux to select between data) and the selection signal is fnReg6
	assign result = aluresultReg6;
	
	assign we = weReg6;

endmodule