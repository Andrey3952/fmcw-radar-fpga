`timescale 1ns / 1ps
module sine_lut(
    input wire clk, rst,
    input wire [15:0] phase_in,
    output reg [7:0] sine_out

);

reg [7:0] rom_memory [0:255];

initial begin
$readmemh("matlab/sine.hex", rom_memory);
end

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        sine_out <= 8'b0;
    end else begin
        sine_out <= rom_memory[phase_in[15:8]];
    end
end


endmodule