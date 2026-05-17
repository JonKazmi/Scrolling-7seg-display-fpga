module id_storage (id_1, id_2, id_3);

    output [63:0] id_1;
    output [63:0] id_2;
    output [63:0] id_3;

    // --- MAPPING KEY ---
    // 5=S, E=P, F=Dash, D=Blank, A=E, B=L, C=C
    
    // ID 1: SP24-ELC-098---- (Unchanged)
    // Hex: 5 E 2 4 F A B C F 0 9 8 D D D D
    assign id_1 = 64'h5E24FABCF098DDDD;

    // ID 2: SP24-ELC-094---- (Updated)
    // Hex: 5 E 2 4 F A B C F 0 9 4 D D D D
    assign id_2 = 64'h5E24FABCF094DDDD;

    // ID 3: SP24-ELC-065---- (Updated)
    // Hex: 5 E 2 4 F A B C F 0 6 5 D D D D
    assign id_3 = 64'h5E24FABCF065DDDD;

endmodule