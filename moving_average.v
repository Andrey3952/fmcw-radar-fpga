`timescale 1ns / 1ps

module moving_average (
    input wire clk,
    rst,
    input wire signed [15:0] mix_in,
    output reg signed [15:0] filter_out
);

    reg signed [15:0] shift_reg[15:0];
    reg signed [19:0] sum;

    integer i;
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (i = 15; i >= 0; i = i - 1) begin
                shift_reg[i] <= 16'b0;
            end
            sum <= 20'b0;
            filter_out <= 16'b0;
        end else begin
            for (i = 15; i > 0; i = i - 1) begin
                shift_reg[i] <= shift_reg[i-1];
            end
            shift_reg[0] <= mix_in;
            sum <= shift_reg[0] + shift_reg[1] + shift_reg[2] + shift_reg[3] +
                   shift_reg[4] + shift_reg[5] + shift_reg[6] + shift_reg[7] +
                   shift_reg[8] + shift_reg[9] + shift_reg[10] + shift_reg[11] +
                   shift_reg[12] + shift_reg[13] + shift_reg[14] + shift_reg[15];
            filter_out <= sum >>> 4;
        end
    end



endmodule
