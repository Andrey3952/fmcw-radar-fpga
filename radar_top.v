`timescale 1ns / 1ps

module radar_top (
    input wire clk_50m,
    input wire rst_btn,
    input wire spi_clk,
    input wire spi_mosi,
    input wire spi_cs,
    output wire spi_miso,
    output wire [7:0] led,
    output wire signed [15:0] radar_out
);
    wire [7:0] tx_wave, rx_wave;
    wire [10:0] target_delay = 11'd500;
    wire signed [15:0] mixed_wave;


    SPI my_spi_slave (
        .clk(clk_50m),
        .rst(rst_btn),
        .CLK(spi_clk),
        .MOSI(spi_mosi),
        .CS(spi_cs),
        .MISO(spi_miso),
        .data_rx(led),
        .rx_done(),
        .data_tx(8'hCA)
    );

    tx_generator chirp (
        .clk(clk_50m),
        .rst(rst_btn),
        .wave_out(tx_wave)
    );

    target_echo echo_chirp (
        .clk(clk_50m),
        .rst(rst_btn),
        .echo_in(tx_wave),
        .delay_val(target_delay),
        .echo_out(rx_wave)
    );

    mixer mixer (
        .clk(clk_50m),
        .rst(rst_btn),
        .tx_in(tx_wave),
        .rx_in(rx_wave),
        .mix_out(mixed_wave)
    );

    moving_average fir (
        .clk(clk_50m),
        .rst(rst_btn),
        .filter_out(radar_out),
        .mix_in(mixed_wave)
    );









endmodule
