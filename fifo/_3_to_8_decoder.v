module _3_to_8_decoder(q, d);		//3 to 8 decoder module
	input [2:0] d;
	output reg [7:0] q;
	
	always@(d) begin			//decoding...
		case(d)
			3'b000:	q = 8'b0000_0001;		//d = 0;
			3'b001:	q = 8'b0000_0010;		//d = 1;
			3'b010:	q = 8'b0000_0100;		//d = 2;
			3'b011:	q = 8'b0000_1000;		//d = 3;
			3'b100:	q = 8'b0001_0000;		//d = 4;
			3'b101:	q = 8'b0010_0000;		//d = 5;
			3'b110:	q = 8'b0100_0000;		//d = 6;
			3'b111:	q = 8'b1000_0000;		//d = 7;
			default : q = 8'hx;
			endcase
		end
endmodule
