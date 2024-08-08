module fifo(d_out, full, empty, wr_ack, wr_err, rd_ack, rd_err, data_count, clk, reset_n, rd_en, wr_en, d_in);		//first-in-first-out module
	input clk, reset_n, rd_en, wr_en;
	input [31:0] d_in;
	output full, empty, wr_ack, wr_err, rd_ack, rd_err;
	output [3:0]data_count;
	output [31:0] d_out;
	
	wire we, re;
	wire [2:0] cur_state, cur_head, cur_tail, next_state, next_head, next_tail;
	wire [3:0] next_data_count;
	wire [31:0] w_d_out, w_d_out_reg;
	
	fifo_ns U0_fifo_ns(next_state, wr_en, rd_en, data_count, cur_state);					//next state logic
	
	fifo_cal_addr U1_fifo_cal_addr(we, re, next_head, next_tail, next_data_count, next_state, cur_head, cur_tail, data_count);		//calculate next address
	
	//register of state, head, tail, data_count
	register3_r U2_0_register3_r(cur_state, clk, reset_n, next_state);
	register3_r U2_1_register3_r(cur_head, clk, reset_n, next_head);
	register3_r U2_2_register3_r(cur_tail, clk, reset_n, next_tail);
	register4_r U2_3_register4_r(data_count, clk, reset_n, next_data_count);
	
	fifo_out U3_fifo_out(full, empty, wr_ack, wr_err, rd_ack, rd_err, data_count, cur_state);		//output logic
	
	Register_file U4_0_Register_file(w_d_out, clk, reset_n, cur_tail, d_in, we, cur_head);		//Register file
	mx2_32bits U4_1_Registerer_file(w_d_out_reg, 32'b0, w_d_out, re);										//MUX for reading
	register32_r_en U4_1_register32_r_en(d_out, clk, reset_n, 1'b1, w_d_out_reg);								//register of d_out
	
	endmodule
	