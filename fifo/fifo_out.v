module fifo_out(full, empty, wr_ack, wr_err, rd_ack, rd_err, data_count, state);		//fifo's output logic
	input [2:0]state;
	input [3:0]data_count;
	output reg full, empty, wr_ack, wr_err, rd_ack, rd_err;
	
	//state
	parameter INIT = 3'b000;
	parameter NO_OP = 3'b001;
	parameter WRITE = 3'b010;
	parameter WR_ERROR = 3'b011;
	parameter READ = 3'b100;
	parameter RD_ERROR = 3'b101;
	
	always@(state, data_count) begin
	 case(state)
		INIT : begin	//when init, empty = 1, else = 0
			full = 1'b0; empty = 1'b1; wr_ack = 1'b0;
			wr_err = 1'b0; rd_ack = 1'b0; rd_err = 1'b0;
			end
			
		NO_OP : begin	//when no_op
			if(data_count == 4'b0000)	begin full = 1'b0; empty = 1'b1; end			//if data is empty -> empty = 1
			else if(data_count == 4'b1000) 	begin full = 1'b1; empty = 1'b0; end	//if data is full -> full = 1
			else begin	full = 1'b0; empty = 1'b0; end										//else -> full and empty = 0
			 
			wr_ack = 1'b0; wr_err = 1'b0; rd_ack = 1'b0; rd_err = 1'b0;					//others = 0
			end
			
		WRITE : begin	//when write
			if(data_count == 4'b1000) 	begin full = 1'b1; empty = 1'b0; end			//if data is full -> full = 1
			else begin	full = 1'b0; empty = 1'b0; end										//else full = 0
			 
			wr_ack = 1'b1; wr_err = 1'b0; rd_ack = 1'b0; rd_err = 1'b0;					//wr_act = 1, others = 0
			end
			
		WR_ERROR : begin	//when wr_error
			full = 1'b1; empty = 1'b0; 															//full = 1, wr_error = 1
			wr_ack = 1'b0; wr_err = 1'b1; rd_ack = 1'b0; rd_err = 1'b0;
			end
			
		READ : begin	//when read
			if(data_count == 4'b0000)	begin full = 1'b0; empty = 1'b1; end			//if data is empty -> empty = 1
			else begin	full = 1'b0; empty = 1'b0; end										//else empty = 0
			 
			wr_ack = 1'b0; wr_err = 1'b0; rd_ack = 1'b1; rd_err = 1'b0;					//rd_act = 1, others = 0
			end
			
		RD_ERROR : begin	//when rd_error
			full = 1'b0; empty = 1'b1;																//empty = 1, rd_error = 1
			wr_ack = 1'b0; wr_err = 1'b0; rd_ack = 1'b0; rd_err = 1'b1;
			end
			
		default : begin
			full = 1'bx; empty = 1'bx; wr_ack = 1'bx;
			wr_err = 1'bx; rd_ack = 1'bx; rd_err = 1'bx;
			end
			
		endcase
	end
	endmodule
	
	
				