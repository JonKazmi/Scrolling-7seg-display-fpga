module display_multiplexer (clk, rst, tick_500hz, seg_in, bcd_7seg, disp_en);

    input clk;
    input rst;
    input tick_500hz;
    input [27:0] seg_in;
    output [6:0] bcd_7seg;
    output [3:0] disp_en;

    reg [6:0] bcd_7seg;
    reg [3:0] disp_en;
    reg [1:0] counter;

    always @(posedge clk or posedge rst) begin
        if (rst)
            counter <= 0;
        else if (tick_500hz)
            counter <= counter + 1;
    end

    // Anode Logic (0 = Select)
    always @(counter or seg_in) begin
        case (counter)
            2'b00: begin // Rightmost
                disp_en = 4'b1110; 
                bcd_7seg = seg_in[6:0];
            end
            2'b01: begin
                disp_en = 4'b1101; 
                bcd_7seg = seg_in[13:7];
            end
            2'b10: begin
                disp_en = 4'b1011; 
                bcd_7seg = seg_in[20:14];
            end
            2'b11: begin // Leftmost
                disp_en = 4'b0111; 
                bcd_7seg = seg_in[27:21];
            end
            default: begin
                disp_en = 4'b1111;
                bcd_7seg = 7'b0000000;
            end
        endcase
    end
endmodule