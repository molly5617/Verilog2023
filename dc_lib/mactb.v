module mactb;
	reg clk;
	reg reset_n;
	reg [2:0] instruction;	
	reg [15:0] multiplier;
	reg [15:0] multiplicand; 
	reg stall;
	wire [7:0] protect;
	wire [31:0] result;
	mac a(clk, reset_n, instruction, multiplier, multiplicand, stall, protect, result);
	initial begin
		stall = 0; clk = 0; reset_n = 0;
		multiplier = 0; multiplicand = 0; instruction = 0;
		#5   reset_n = 1;
		#5   multiplier = 16'h0000; multiplicand = 16'h0000; instruction = 16'b100;
		#10  multiplier = 16'h0705; multiplicand = 16'h0309; instruction = 16'b101;
		#10  multiplier = 16'h0804; multiplicand = 16'h0504; instruction = 16'b101;
		#10  multiplier = 16'h0505; multiplicand = 16'h0206; instruction = 16'b110;
		#10  multiplier = 16'h0505; multiplicand = 16'h0304; instruction = 16'b110;
		#10  multiplier = 16'h7F7F; multiplicand = 16'h7F7F; instruction = 16'b110;
		#10  multiplier = 16'h7F7F; multiplicand = 16'h7F7F; instruction = 16'b110;
		#10  multiplier = 16'h7F7F; multiplicand = 16'h7F7F; instruction = 16'b110;
		#10  multiplier = 16'h7F7F; multiplicand = 16'h7F7F; instruction = 16'b110;
		#10  multiplier = 16'h7FFF; multiplicand = 16'h7FFF; instruction = 16'b110;
		#10  multiplier = 16'h7F7F; multiplicand = 16'h7F7F; instruction = 16'b110;
		#10  multiplier = 16'h7F7F; multiplicand = 16'h7F7F; instruction = 16'b110;
		#10  multiplier = 16'h7F7F; multiplicand = 16'h7F7F; instruction = 16'b111;

		#10 $finish;
	end
	always #5 clk = ~clk;
endmodule 
