`timescale 1ns / 1ps
module target_echo (
	input wire clk, rst,
	input wire [7:0] echo_in,
	input wire [10:0] delay_val,
	output reg [7:0] echo_out

);

reg [7:0] ram_buffer [0:2047];
reg [10:0] wr_ptr;
always @(posedge clk or negedge rst)begin
	if (!rst) begin
		wr_ptr <= 11'b0;
		echo_out <= 8'b0;
	end else begin
		ram_buffer[wr_ptr] <= echo_in;
		echo_out <= ram_buffer[wr_ptr - delay_val];
		wr_ptr <= wr_ptr + 1;
	end
end 


endmodule