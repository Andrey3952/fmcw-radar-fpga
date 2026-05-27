`timescale 1ns / 1ps

module top_level (
    input  wire clk_50m,
    input  wire rst_btn,
    input  wire spi_clk,
    input  wire spi_mosi,
    input  wire spi_cs,
    output wire spi_miso,
    output wire [7:0] led
);

    SPI my_spi_slave (
        .clk(clk_50m),
        .rst(1'b1),           // Ресет надійно вимкнено
        .CLK(spi_clk),
        .MOSI(spi_mosi),
        .CS(spi_cs),
        .MISO(spi_miso),
        .data_rx(led),        // Знову підключаємо сюди діоди!
        .rx_done(),
        .data_tx(8'hCA)
    );

endmodule