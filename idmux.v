module id_mux (select_in, id_1, id_2, id_3, id_stream);

    input [1:0] select_in;
    input [63:0] id_1;
    input [63:0] id_2;
    input [63:0] id_3;
    output [63:0] id_stream;
    reg [63:0] id_stream;

    always @(select_in or id_1 or id_2 or id_3) begin
        case (select_in)
            2'b00: id_stream = id_1;
            2'b01: id_stream = id_2;
            2'b10: id_stream = id_3;
            default: id_stream = 64'hDDDDDDDDDDDDDDDD;
        endcase
    end
endmodule