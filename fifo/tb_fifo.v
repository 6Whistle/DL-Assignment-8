`timescale 1ns/100ps

module tb_fifo;				//testbench of fifo
	reg clk, reset_n, rd_en, wr_en;
	reg [31:0]d_in;
	wire full, empty, wr_ack, wr_err, rd_ack, rd_err;
	wire [3:0]data_count;
	wire [31:0]d_out;
	
	fifo U0_fifo(d_out, full, empty, wr_ack, wr_err, rd_ack, rd_err, data_count, clk, reset_n, rd_en, wr_en, d_in);
	
	always begin clk = 0; #5; clk = 1; #5; end
	
	initial begin
		reset_n = 0; rd_en = 0; wr_en = 0; d_in = 32'h0000_0000; #10;			//setting
		
		reset_n = 1; rd_en = 0; wr_en = 0; d_in = 32'h1111_1111; #10;			//do nothing(empty)
		
		reset_n = 1; rd_en = 1; wr_en = 0; d_in = 32'h0000_0000; #10;			//rd_error
		
		reset_n = 1; rd_en = 0; wr_en = 1; d_in = 32'h1000_0000; #10;			//write 8 times
		reset_n = 1; rd_en = 0; wr_en = 1; d_in = 32'h2000_0000; #10;
		reset_n = 1; rd_en = 0; wr_en = 1; d_in = 32'h3000_0000; #10;
		reset_n = 1; rd_en = 0; wr_en = 1; d_in = 32'h4000_0000; #10;
		reset_n = 1; rd_en = 0; wr_en = 1; d_in = 32'h5000_0000; #10;
		reset_n = 1; rd_en = 0; wr_en = 1; d_in = 32'h6000_0000; #10;
		reset_n = 1; rd_en = 0; wr_en = 1; d_in = 32'h7000_0000; #10;
		reset_n = 1; rd_en = 0; wr_en = 1; d_in = 32'h8000_0000; #10;			//(full)
		
		reset_n = 1; rd_en = 0; wr_en = 1; d_in = 32'h9000_0000; #10;			//wr_error
		
		reset_n = 1; rd_en = 0; wr_en = 0; d_in = 32'h9000_0000; #10;			//do nothing(full)
		
		reset_n = 1; rd_en = 1; wr_en = 0; d_in = 32'h0000_0000; #10;			//read 8 times
		reset_n = 1; rd_en = 1; wr_en = 0; d_in = 32'h0000_0000; #10;
		reset_n = 1; rd_en = 1; wr_en = 0; d_in = 32'h0000_0000; #10;
		reset_n = 1; rd_en = 1; wr_en = 0; d_in = 32'h0000_0000; #10;
		reset_n = 1; rd_en = 1; wr_en = 0; d_in = 32'h0000_0000; #10;
		reset_n = 1; rd_en = 1; wr_en = 0; d_in = 32'h0000_0000; #10;
		reset_n = 1; rd_en = 1; wr_en = 0; d_in = 32'h0000_0000; #10;
		reset_n = 1; rd_en = 1; wr_en = 0; d_in = 32'h0000_0000; #10;			//(empty)
		
		reset_n = 1; rd_en = 1; wr_en = 0; d_in = 32'h0000_0000; #10;			//rd_error
		
		reset_n = 1; rd_en = 0; wr_en = 0; d_in = 32'h1000_0000; #10;			//do_nothing(empty)
		
		reset_n = 1; rd_en = 0; wr_en = 1; d_in = 32'h1111_1111; #10;			//write
		
		reset_n = 1; rd_en = 1; wr_en = 0; d_in = 32'h0000_0000; #10;			//read
		
		
		reset_n = 0;	#10;
		$stop;
		end
	endmodule
		
		