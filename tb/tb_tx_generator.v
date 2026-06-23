`timescale 1ns / 1ps

module tb_tx_generator;

reg tb_clk;
reg tb_rst;
wire [7:0] tb_wave_out;

tx_generator generator(
    .clk(tb_clk),
    .rst(tb_rst),
    .wave_out(tb_wave_out)
);

always #10 tb_clk = ~tb_clk;

initial begin
$dumpfile("dump.vcd");
$dumpvars(0,tb_tx_generator);

tb_clk = 1'b0;
tb_rst = 1'b0;

#100;

tb_rst = 1'b1;
#2800000;
$finish;
end

endmodule