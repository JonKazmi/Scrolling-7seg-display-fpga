module top_module (clk, reset_in, pause_in, select_in, bcd_7seg, dp, disp_en);

    input clk;
    input reset_in;
    input pause_in;
    input [1:0] select_in;
    output [6:0] bcd_7seg;
    output dp;
    output [3:0] disp_en;

    // Force Dot OFF
    assign dp = 1; // Active Low (1=OFF)

    wire tick_1hz, tick_500hz, tick_100hz;
    wire pause_clean, pause_state;
    wire [63:0] id1_w, id2_w, id3_w, sel_id;
    wire [15:0] chars_w;
    wire [27:0] pats_w;

    clk_divider u1 (
        .clk(clk), 
        .tick_1hz(tick_1hz), 
        .tick_500hz(tick_500hz), 
        .tick_100hz(tick_100hz)
    );

    debouncer u2_pause (
        .clk(clk), 
        .tick_100hz(tick_100hz), 
        .noisy_in(pause_in), 
        .clean_out(pause_clean)
    );

    pause_toggle u3 (
        .clk(clk), 
        .rst(reset_in), 
        .pulse_in(pause_clean), 
        .pause_sig(pause_state)
    );

    id_storage u4 (
        .id_1(id1_w), 
        .id_2(id2_w), 
        .id_3(id3_w)
    );

    id_mux u5 (
        .select_in(select_in), 
        .id_1(id1_w), 
        .id_2(id2_w), 
        .id_3(id3_w), 
        .id_stream(sel_id)
    );

    // UPDATED: Now connected to select_in
    scroll_shift_reg u6 (
        .clk(clk), 
        .rst(reset_in), 
        .tick_1hz(tick_1hz), 
        .pause(pause_state), 
        .select_in(select_in), // <--- WIRED HERE
        .id_stream(sel_id), 
        .chars_out(chars_w)
    );

    hex_to_7seg_decoder u7 (
        .hex_in(chars_w), 
        .seg_out(pats_w)
    );

    display_multiplexer u8 (
        .clk(clk), 
        .rst(reset_in), 
        .tick_500hz(tick_500hz), 
        .seg_in(pats_w), 
        .bcd_7seg(bcd_7seg), 
        .disp_en(disp_en)
    );
endmodule