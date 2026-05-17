module pause_toggle (clk, rst, pulse_in, pause_sig);

    input clk;
    input rst;
    input pulse_in;
    output pause_sig;
    reg pause_sig;

    reg last_pulse;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pause_sig <= 0;
            last_pulse <= 0;
        end else begin
            if (pulse_in == 1 && last_pulse == 0) begin
                pause_sig <= ~pause_sig;
            end
            last_pulse <= pulse_in;
        end
    end
endmodule