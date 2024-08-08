module read_operation(Data, Addr, from_reg0, from_reg_1, from_reg_2, from_reg3, from_reg4, from_reg5, from_reg6, from_reg7);		//read operation
	input [31:0] from_reg0, from_reg_1, from_reg_2, from_reg3, from_reg4, from_reg5, from_reg6, from_reg7;
	input [2:0] Addr;
	output [31:0] Data;

	_8_to_1_MUX U0_MUX(Data, Addr, from_reg0, from_reg_1, from_reg_2, from_reg3, from_reg4, from_reg5, from_reg6, from_reg7);		//Seleted by Addr

endmodule
