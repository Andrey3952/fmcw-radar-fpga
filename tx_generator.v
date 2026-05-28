`timescale 1ns / 1ps

module tx_generator(
    input wire clk, rst,
    output wire [7:0] wave_out
);

wire [15:0] phase_wire;

dds_chirp dds(
    .clk(clk),
    .rst(rst),
    .phase(phase_wire)
);

sine_lut lut(
    .clk(clk),
    .rst(rst),
    .phase_in(phase_wire),
    .sine_out(wave_out)
);

endmodule