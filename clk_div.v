module clk_divider (clk, tick_1hz, tick_500hz, tick_100hz);

    input clk;
    output tick_1hz;
    output tick_500hz;
    output tick_100hz;

    reg tick_1hz;
    reg tick_500hz;
    reg tick_100hz;

    reg [31:0] ctr_1hz;
    reg [31:0] ctr_500hz;
    reg [31:0] ctr_100hz;

    // Constants for 50 MHz Clock
    parameter LIM_1HZ   = 49999999;
    parameter LIM_500HZ = 99999;
    parameter LIM_100HZ = 499999;

    always @(posedge clk) begin
        // 1 Hz Tick
        if (ctr_1hz == LIM_1HZ) begin
            ctr_1hz <= 0;
            tick_1hz <= 1;
        end else begin
            ctr_1hz <= ctr_1hz + 1;
            tick_1hz <= 0;
        end

        // 500 Hz Tick
        if (ctr_500hz == LIM_500HZ) begin
            ctr_500hz <= 0;
            tick_500hz <= 1;
        end else begin
            ctr_500hz <= ctr_500hz + 1;
            tick_500hz <= 0;
        end

        // 100 Hz Tick
        if (ctr_100hz == LIM_100HZ) begin
            ctr_100hz <= 0;
            tick_100hz <= 1;
        end else begin
            ctr_100hz <= ctr_100hz + 1;
            tick_100hz <= 0;
        end
    end
endmodule