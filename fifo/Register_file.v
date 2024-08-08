module Register_file(rData, clk, reset_n, wAddr, wData, we, rAddr);		//RF module
 input clk, reset_n, we;
 input[2:0] wAddr, rAddr;
 input[31:0] wData;
 output[31:0] rData;
 
 wire [7:0] to_reg;
 wire [31:0] from_reg[7:0];
 
 write_operation U0_write_operation(to_reg, wAddr, we);			//Write block
 register32_8 U1_register32_8(from_reg[0], from_reg[1], from_reg[2], from_reg[3], from_reg[4], from_reg[5], from_reg[6], from_reg[7], clk, reset_n, to_reg, wData);		//Reg
 read_operation U2_read_operation(rData, rAddr, from_reg[0], from_reg[1], from_reg[2], from_reg[3], from_reg[4], from_reg[5], from_reg[6], from_reg[7]);		//Read block
 
 
endmodule 
