module write_operation(to_reg, Addr, we);		//write_operation
	input we;
	input [2:0] Addr;
	output [7:0] to_reg;
	wire [7:0] w_a;
	
	_3_to_8_decoder U0_decoder(w_a, Addr);		//decoding Addr
	
	/* When we is true, writing access */
	_and2 U1_and2(to_reg[0], we, w_a[0]);
	_and2 U2_and2(to_reg[1], we, w_a[1]);
	_and2 U3_and2(to_reg[2], we, w_a[2]);
	_and2 U4_and2(to_reg[3], we, w_a[3]);
	_and2 U5_and2(to_reg[4], we, w_a[4]);
	_and2 U6_and2(to_reg[5], we, w_a[5]);
	_and2 U7_and2(to_reg[6], we, w_a[6]);
	_and2 U8_and2(to_reg[7], we, w_a[7]);
endmodule

