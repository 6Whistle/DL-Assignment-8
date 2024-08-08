module _8_to_1_MUX(d_out, sel, a, b, c, d, e, f, g, h);			//8_to_1 MUX
	input [31:0] a, b, c, d, e, f, g, h;
	input [2:0] sel;
	output reg [31:0] d_out;
	
/* Selected by sel */
	always@(sel, a, b, c, d, e, f, g, h) begin
		case(sel)
			3'b000 : d_out = a;
			3'b001 : d_out = b;
			3'b010 : d_out = c;
			3'b011 : d_out = d;
			3'b100 : d_out = e;
			3'b101 : d_out = f;
			3'b110 : d_out = g;
			3'b111 : d_out = h;
			default : d_out = 3'bx;
		endcase
	end
endmodule

			