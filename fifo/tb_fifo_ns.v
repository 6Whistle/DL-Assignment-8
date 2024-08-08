`timescale 1ns/100ps

module tb_fifo_ns;			//testbench of fifo_ns
	reg tb_wr_en, tb_rd_en;
	reg [2:0]tb_state;
	reg [3:0]tb_data_count;
	wire [2:0]tb_next_state;
	
	
	//state
	parameter INIT = 3'b000;
	parameter NO_OP = 3'b001;
	parameter WRITE = 3'b010;
	parameter WR_ERROR = 3'b011;
	parameter READ = 3'b100;
	parameter RD_ERROR = 3'b101;
	
	fifo_ns U0_fifo_ns(tb_next_state, tb_wr_en, tb_rd_en, tb_data_count, tb_state);
	
	initial begin
		//When state = INIT
		tb_state = INIT; tb_wr_en = 0; tb_rd_en = 0; tb_data_count = 4'b0000; #10;
		tb_state = INIT; tb_wr_en = 1; tb_rd_en = 0; tb_data_count = 4'b0000; #10;
		tb_state = INIT; tb_wr_en = 0; tb_rd_en = 1; tb_data_count = 4'b0000; #10;
		
		//When state = NO_OP
		tb_state = NO_OP; tb_wr_en = 0; tb_rd_en = 0; tb_data_count = 4'b0000; #10;
		tb_state = NO_OP; tb_wr_en = 1; tb_rd_en = 0; tb_data_count = 4'b0000; #10;
		tb_state = NO_OP; tb_wr_en = 0; tb_rd_en = 1; tb_data_count = 4'b0000; #10;
		tb_state = NO_OP; tb_wr_en = 1; tb_rd_en = 0; tb_data_count = 4'b1000; #10;
		tb_state = NO_OP; tb_wr_en = 0; tb_rd_en = 1; tb_data_count = 4'b1000; #10;
		
		//When state = WRITE
		tb_state = WRITE; tb_wr_en = 0; tb_rd_en = 0; tb_data_count = 4'b0000; #10;
		tb_state = WRITE; tb_wr_en = 1; tb_rd_en = 0; tb_data_count = 4'b0000; #10;
		tb_state = WRITE; tb_wr_en = 0; tb_rd_en = 1; tb_data_count = 4'b0000; #10;
		tb_state = WRITE; tb_wr_en = 1; tb_rd_en = 0; tb_data_count = 4'b1000; #10;
		tb_state = WRITE; tb_wr_en = 0; tb_rd_en = 1; tb_data_count = 4'b1000; #10;
		
		//When state = WR_ERROR
		tb_state = WR_ERROR; tb_wr_en = 0; tb_rd_en = 0; tb_data_count = 4'b1000; #10;
		tb_state = WR_ERROR; tb_wr_en = 1; tb_rd_en = 0; tb_data_count = 4'b1000; #10;
		tb_state = WR_ERROR; tb_wr_en = 0; tb_rd_en = 1; tb_data_count = 4'b1000; #10;
		
		//When state = READ
		tb_state = READ; tb_wr_en = 0; tb_rd_en = 0; tb_data_count = 4'b0000; #10;
		tb_state = READ; tb_wr_en = 1; tb_rd_en = 0; tb_data_count = 4'b0000; #10;
		tb_state = READ; tb_wr_en = 0; tb_rd_en = 1; tb_data_count = 4'b0000; #10;
		tb_state = READ; tb_wr_en = 1; tb_rd_en = 0; tb_data_count = 4'b1000; #10;
		tb_state = READ; tb_wr_en = 0; tb_rd_en = 1; tb_data_count = 4'b1000; #10;
		
		//When state = RD ERROR
		tb_state = RD_ERROR; tb_wr_en = 0; tb_rd_en = 0; tb_data_count = 4'b0000; #10;
		tb_state = RD_ERROR; tb_wr_en = 1; tb_rd_en = 0; tb_data_count = 4'b0000; #10;
		tb_state = RD_ERROR; tb_wr_en = 0; tb_rd_en = 1; tb_data_count = 4'b0000; #10;
		
	end
endmodule
