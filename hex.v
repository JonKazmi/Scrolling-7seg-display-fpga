module hex_to_7seg_decoder (hex_in, seg_out);

    input [15:0] hex_in;
    output [27:0] seg_out;
    reg [27:0] seg_out;

    reg [3:0] digit_val;
    reg [6:0] decoded_val;
    integer i;

    // ACTIVE LOW MAPPING (Logic 0 = Light ON)
    // Order: G F E D C B A
    always @(hex_in) begin
        for (i = 0; i < 4; i = i + 1) begin
            case (i)
                0: digit_val = hex_in[3:0];
                1: digit_val = hex_in[7:4];
                2: digit_val = hex_in[11:8];
                3: digit_val = hex_in[15:12];
            endcase

            case (digit_val)
                // Numbers
                4'h0: decoded_val = 7'b1000000; // 0
                4'h1: decoded_val = 7'b1111001; // 1
                4'h2: decoded_val = 7'b0100100; // 2
                4'h3: decoded_val = 7'b0110000; // 3
                4'h4: decoded_val = 7'b0011001; // 4
                4'h5: decoded_val = 7'b0010010; // 5 (S)
                4'h6: decoded_val = 7'b0000010; // 6
                4'h7: decoded_val = 7'b1111000; // 7
                4'h8: decoded_val = 7'b0000000; // 8
                4'h9: decoded_val = 7'b0010000; // 9
                
                // Letters
                4'hA: decoded_val = 7'b0000110; // E
                4'hB: decoded_val = 7'b1000111; // L
                4'hC: decoded_val = 7'b1000110; // C
                4'hD: decoded_val = 7'b1111111; // Blank
                4'hE: decoded_val = 7'b0001100; // P
                4'hF: decoded_val = 7'b0111111; // - (Dash)
                default: decoded_val = 7'b1111111; // Blank
            endcase

            case (i)
                0: seg_out[6:0]   = decoded_val;
                1: seg_out[13:7]  = decoded_val;
                2: seg_out[20:14] = decoded_val;
                3: seg_out[27:21] = decoded_val;
            endcase
        end
    end
endmodule