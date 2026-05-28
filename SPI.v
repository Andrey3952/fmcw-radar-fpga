`timescale 1ns / 1ps
module SPI(
    input wire clk, rst,
    input  wire CLK,
    input  wire MOSI,
    input  wire CS, 
    output wire MISO,
    output reg [7:0] data_rx,
    output reg rx_done,
    input wire [7:0] data_tx
);

reg CLK1, CLK2, CLK3;
reg MOSI1, MOSI2;
reg CS1, CS2;
 

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        CLK1 <= 1'b1;
        CLK2 <= 1'b1;
        CLK3 <= 1'b1;
        CS1 <= 1'b1;
        CS2 <= 1'b1;
        MOSI1 <= 1'b1;
        MOSI2 <= 1'b1;
    end else begin
        CLK1 <= CLK;
        CLK2 <= CLK1;
        CLK3 <= CLK2;
        CS1 <= CS;
        CS2 <= CS1;
        MOSI1 <= MOSI;
        MOSI2 <= MOSI1;
    end
end

wire clk_rising = CLK2 & ~CLK3  ;
wire clk_falling = ~CLK2 & CLK3 ;

reg [2:0] bit_cnt;
reg [7:0] shift_reg;


always @(posedge clk or negedge rst) begin
    if(!rst)begin
        bit_cnt <= 3'b0;
        shift_reg <= 8'b0;
        data_rx <= 8'b0;
        rx_done <= 1'b0;
    end else begin
        rx_done <= 1'b0;
        if(CS2 == 1'b1)begin
            bit_cnt <= 3'b0;
        end else if (clk_rising) begin
            shift_reg <= {shift_reg[6:0], MOSI2};
            bit_cnt <= bit_cnt + 1'b1;
            if(bit_cnt == 3'd7) begin
                data_rx <= {shift_reg[6:0], MOSI2};
                rx_done <= 1'b1;
            end
        end 
    end
end


reg [7:0] tx_reg;

always @(posedge clk or negedge rst) begin
    if(!rst)begin
        tx_reg <= 8'b0;
    end else if(CS2 == 1'b1)begin
        tx_reg <= data_tx;
    end else if(clk_falling) begin
        tx_reg <= {tx_reg[6:0], 1'b0};
    end
end

assign MISO = (CS2 == 1'b0) ? tx_reg[7] : 1'bz;
    

endmodule