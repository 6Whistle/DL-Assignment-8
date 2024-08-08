module fifo_ns(next_state, wr_en, rd_en, data_count, state);		//next state of fifo
	parameter INIT = 3'b000;
	parameter NO_OP = 3'b001;
	parameter WRITE = 3'b010;
	parameter WR_ERROR = 3'b011;
	parameter READ = 3'b100;
	parameter RD_ERROR = 3'b101;
	
	input wr_en, rd_en;
	input [2:0] state;
	input [3:0] data_count;
	output reg [2:0] next_state;
	
	always@ (wr_en, rd_en, data_count, state) begin
		case(state)
			INIT :	if(wr_en == 1 & rd_en == 0)	next_state = WRITE;				//init -> write
						else if(wr_en == 0 & rd_en == 1)	next_state = RD_ERROR;		//init -> rd_error(no data)
						else	next_state = NO_OP;												//init -> no_op
						
			NO_OP : 	if(wr_en == 1 & rd_en == 0)	begin	
							if(data_count != 4'b1000)	next_state = WRITE;				//no_op -> write
							else	next_state = WR_ERROR;										//no_op -> wr_error(full data)
							end
						else if(wr_en == 0 & rd_en == 1)	begin
							if(data_count != 4'b0000)	next_state = READ;				//no_op -> read
							else next_state = RD_ERROR;										//no_op -> rd_error(empty data)
							end
						else	next_state = NO_OP;												//no_op -> no_op
			
			WRITE :	if(wr_en == 1 & rd_en == 0)	begin
							if(data_count != 4'b1000)	next_state = WRITE;				//write -> write
							else	next_state = WR_ERROR;										//write -> wr_error(full data)
							end
						else if(wr_en == 0 & rd_en == 1)	next_state = READ;			//write -> read
						else	next_state = NO_OP;												//write -> no_op
			
			WR_ERROR :	if(wr_en == 1 & rd_en == 0)	next_state = WR_ERROR;		//wr_error -> wr_error
							else if(wr_en == 0 & rd_en == 1)	next_state = READ;		//wr_error -> read
							else	next_state = NO_OP;											//wr_error -> no_op
			
			READ :	if(wr_en == 1 & rd_en == 0)	next_state = WRITE;				//read -> write
						else if(wr_en == 0 & rd_en == 1) begin	
							if(data_count != 4'b0000)	next_state = READ;				//read -> read
							else	next_state = RD_ERROR;										//read -> rd_error(empty data)
							end																		//read -> no_op
						else	next_state = NO_OP;
			
			RD_ERROR :	if(wr_en == 1 & rd_en == 0)	next_state = WRITE;			//rd_error -> write
							else if(wr_en == 0 & rd_en == 1)	next_state = RD_ERROR;	//rd_error -> rd_error
							else	next_state = NO_OP;											//rd_error -> no_op
			default : next_state = 3'bxxx;
			endcase
		end
	endmodule
						