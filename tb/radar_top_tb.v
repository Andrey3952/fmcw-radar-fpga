`timescale 1ns / 1ps

module radar_top_tb;

    reg tb_clk;
    reg tb_rst;
    wire signed [15:0] tb_radar_out;

    radar_top radar (
        .clk_50m  (tb_clk),
        .rst_btn  (tb_rst),
        .radar_out(tb_radar_out)
    );


    always #10 tb_clk = ~tb_clk;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, radar_top_tb);

        tb_clk = 1'b0;
        tb_rst = 1'b0;

        #100;

        tb_rst = 1'b1;
        #2800000;
        $finish;
    end

endmodule
