`timescale 1ns/100ps

module tb_fifo_cal_addr;		//testbench of fifo_cal_addr
	
	reg [2:0]tb_head, tb_tail, tb_state;
	reg [3:0]tb_data_count;
	wire tb_we, tb_re;
	wire [2:0]tb_next_head, tb_next_tail;
	wire [3:0]tb_next_data_count;
	
	//state
	parameter INIT = 3'b000;
	parameter NO_OP = 3'b001;
	parameter WRITE = 3'b010;
	parameter WR_ERROR = 3'b011;
	parameter READ = 3'b100;
	parameter RD_ERROR = 3'b101;
	
	fifo_cal_addr U0_fifo_cal_addr(tb_we, tb_re, tb_next_head, tb_next_tail, tb_next_data_count, tb_state, tb_head, tb_tail, tb_data_count);
	
	initial begin
		//When state = INIT
		tb_state = INIT; tb_head = 3'b000; tb_tail = 3'b000; tb_data_count = 4'b0000; #10;	
		
		//When state = NO_OP
		tb_state = NO_OP; tb_head = 3'b000; tb_tail = 3'b000; tb_data_count = 4'b0000; #10;
		tb_state = NO_OP; tb_head = 3'b010; tb_tail = 3'b011; tb_data_count = 4'b0001; #10;
		tb_state = NO_OP; tb_head = 3'b111; tb_tail = 3'b111; tb_data_count = 4'b1000; #10;
		
		//When state = WRITE
		tb_state = WRITE; tb_head = 3'b000; tb_tail = 3'b000; tb_data_count = 4'b0000; #10;
		tb_state = WRITE; tb_head = 3'b110; tb_tail = 3'b111; tb_data_count = 4'b0001; #10;
		tb_state = WRITE; tb_head = 3'b101; tb_tail = 3'b100; tb_data_count = 4'b0111; #10;
		
		//When State = WR_ERROR
		tb_state = WR_ERROR; tb_head = 3'b101; tb_tail = 3'b101; tb_data_count = 4'b1000; #10;
		
		//When state = READ
		tb_state = READ; tb_head = 3'b000; tb_tail = 3'b000; tb_data_count = 4'b1000; #10;
		tb_state = READ; tb_head = 3'b110; tb_tail = 3'b000; tb_data_count = 4'b0011; #10;
		tb_state = READ; tb_head = 3'b101; tb_tail = 3'b110; tb_data_count = 4'b0001; #10;
		
		//When state = RD_ERROR
		tb_state = RD_ERROR; tb_head = 3'b010; tb_tail = 3'b010; tb_data_count = 4'b0000; #10;
		
	end
endmodule
