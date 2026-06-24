`timescale 1ns / 1ps 
module mixer(
	input wire clk, rst,   
	input wire [7:0] tx_in, rx_in,
	output reg signed [15:0] mix_out
);

wire signed [8:0] tx_signed;
wire signed [8:0] rx_signed;

assign tx_signed = tx_in - 128;
assign rx_signed = rx_in - 128;

always @(posedge clk or negedge rst) begin
	if(!rst) begin
		mix_out <= 0;
	end else begin
		mix_out <= tx_signed * rx_signed;
	end
end


endmodule 