module fifo_cal_addr(we, re, next_head, next_tail, next_data_count, state, head, tail, data_count);		//calculate next address
	input [2:0] state, head, tail;
	input [3:0] data_count;	
	output reg we, re;
	output reg [2:0] next_head, next_tail;
	output reg [3:0] next_data_count;
	
	//state
	parameter INIT = 3'b000;
	parameter NO_OP = 3'b001;
	parameter WRITE = 3'b010;
	parameter WR_ERROR = 3'b011;
	parameter READ = 3'b100;
	parameter RD_ERROR = 3'b101;
	
	wire[3:0] add_head, add_tail, add_count, sub_count;
	
	
	cla4 U0_cla4(add_head , w0_1, head, 4'b0001, 1'b0);			//num of head + 1
	cla4 U1_cla4(add_tail, w1_1, tail, 4'b0001, 1'b0);				//num of tail + 1
	cla4 U2_cla4(add_count, w2_1, data_count, 4'b0001, 1'b0);	//num of data_count + 1
	cla4 U3_cla4(sub_count , w3_1, data_count, 4'b1111, 1'b0);	//num of data_count - 1
	
	always@(state, head, tail, data_count) begin
		case(state)
			INIT : begin			//when state = init
				next_head = head; next_tail = tail; next_data_count = data_count;
				we = 1'b0; re = 1'b0;
				end
			NO_OP : begin			//when state = no_op
				next_head = head; next_tail = tail; next_data_count = data_count;
				we = 1'b0; re = 1'b0;
				end
			WRITE : begin			//when state = write, tail++, data_count++, we = 1
				next_head = head; next_tail = add_tail[2:0]; next_data_count = add_count;
				we = 1'b1; re = 1'b0;
				end
			WR_ERROR : begin		//when state = wr_error
				next_head = head; next_tail = tail; next_data_count = data_count;
				we = 1'b0; re = 1'b0;
				end
			READ : begin			//when state = read, head++, data_count--, re = 1			
				next_head = add_head[2:0]; next_tail = tail; next_data_count = sub_count;
				we = 1'b0; re = 1'b1;
				end
			RD_ERROR : begin		//when state = rd_error
				next_head = head; next_tail = tail; next_data_count = data_count;
				we = 1'b0; re = 1'b0;
				end
			default :  begin
				next_head = 1'bx; next_tail = 1'bx; next_data_count = 4'bxxxx;
				we = 1'bx; re = 1'bx;
				end
			endcase
		end
	endmodule
				