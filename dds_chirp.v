`timescale 1ns / 1ps
module dds_chirp(
    input wire clk, rst,
    output reg [15:0] phase
);

localparam [15:0] FREQ_STEP = 16'd5;

reg [15:0] freq_acc;
reg [15:0] phase_acc;


always @(posedge clk or negedge rst) begin
    if (!rst) begin
        phase <= 16'b0;
        phase_acc <= 16'b0;
        freq_acc <= 16'b0;
    end else begin
        freq_acc <= freq_acc + FREQ_STEP;
        phase_acc <= phase_acc + freq_acc;
        phase <= phase_acc;
    end
end


endmodule