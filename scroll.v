module scroll_shift_reg (clk, rst, tick_1hz, pause, select_in, id_stream, chars_out);

    input clk;
    input rst;
    input tick_1hz;
    input pause;
    input [1:0] select_in; // Added Switch Input
    input [63:0] id_stream;
    output [15:0] chars_out;
    
    reg [63:0] reg_data;
    reg [1:0] last_select; // Memory to store previous switch position

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_data <= id_stream;
            last_select <= select_in;
        end else begin
            // --- CHANGE DETECTOR LOGIC ---
            // If the current switch position is NOT the same as the last one...
            if (select_in != last_select) begin
                reg_data <= id_stream;   // Reload the new ID immediately
                last_select <= select_in; // Update the "Last" memory
            end 
            // --- SCROLL LOGIC ---
            else if (tick_1hz && !pause) begin
                // Circular Shift Left
                reg_data <= {reg_data[59:0], reg_data[63:60]};
            end
        end
    end

    assign chars_out = reg_data[63:48];

endmodule