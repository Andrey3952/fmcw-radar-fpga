`timescale 1ns / 1ps

module radar_top (
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
        .rst(rst_btn),           
        .CLK(spi_clk),
        .MOSI(spi_mosi),
        .CS(spi_cs),
        .MISO(spi_miso),
        .data_rx(led),        
        .rx_done(),
        .data_tx(8'hCA)
    );

endmodule