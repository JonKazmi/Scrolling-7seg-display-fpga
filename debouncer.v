module debouncer (clk, tick_100hz, noisy_in, clean_out);

    input clk;
    input tick_100hz;
    input noisy_in;
    output clean_out;
    reg clean_out;

    reg [3:0] shift_reg;

    always @(posedge clk) begin
        if (tick_100hz) begin
            shift_reg <= {shift_reg[2:0], noisy_in};
            
            // Output 1 only if stable high
            if (shift_reg == 4'b1111)
                clean_out <= 1;
            else
                clean_out <= 0;
        end
    end
endmodule