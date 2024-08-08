module register4_r(q, clk, reset_n, d);	//4-bits reset_n register
	input clk, reset_n;
	input [3:0] d;
	output reg [3:0] q;
	
	always@(posedge clk or negedge reset_n)		//Operate when clk and reset_n is changed
	begin
		if(reset_n == 0)		q <= 4'b0;			//reset
		else						q <= d;				//store
	end
endmodule
