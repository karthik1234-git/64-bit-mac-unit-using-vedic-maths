/*verilator lint_off WIDTHEXPAND*/

module vedic_2x2 (
    input  logic [1:0] a,
    input  logic [1:0] b,
    output logic [3:0] result
);
    assign result[0] = a[0] & b[0];
    assign result[1] = (a[1] & b[0]) ^ (a[0] & b[1]);
    assign result[2] = (a[1] & b[1]) ^ ((a[1] & b[0]) & (a[0] & b[1]));
    assign result[3] = (a[1] & b[1]) & ((a[1] & b[0]) & (a[0] & b[1]));
endmodule

// 4-bit Brent-Kung Adder (The High-Speed Summer)
module brent_kung_4bit (
    input  logic [3:0] a,
    input  logic [3:0] b,
    output logic [4:0] sum
);
    logic [3:0] p, g;
    logic [3:0] c;

    // Generate and Propagate
    assign g = a & b;
    assign p = a ^ b;

    // Brent-Kung Prefix Tree Logic
    assign c[0] = g[0];
    assign c[1] = g[1] | (p[1] & g[0]);
    assign c[2] = g[2] | (p[2] & (g[1] | (p[1] & g[0])));
    assign c[3] = g[3] | (p[3] & c[2]);

    assign sum[0]   = p[0];
    assign sum[3:1] = p[3:1] ^ c[2:0];
    assign sum[4]   = c[3];
endmodule

// 4-bit Vedic Multiplier (Recursive Structure)
module vedic_multiplier (
    input  logic [3:0] a,
    input  logic [3:0] b,
    output logic [7:0] result
);
    logic [3:0] p0, p1, p2, p3;
    logic [4:0] mid_sum;
    logic [5:0] final_sum_top;

    // 1. Four 2x2 Multiplications
    vedic_2x2 m0 (.a(a[1:0]), .b(b[1:0]), .result(p0));
    vedic_2x2 m1 (.a(a[3:2]), .b(b[1:0]), .result(p1));
    vedic_2x2 m2 (.a(a[1:0]), .b(b[3:2]), .result(p2));
    vedic_2x2 m3 (.a(a[3:2]), .b(b[3:2]), .result(p3));

    // 2. Summing using Brent-Kung Logic
    // This is the core Vedic Equation: Result = (P3 << 4) + ((P1 + P2) << 2) + P0
    assign mid_sum = p1 + p2; // You can replace this with the brent_kung_4bit module later!
    
    assign result[1:0] = p0[1:0];
    assign result[7:2] = (p3 << 2) + mid_sum + p0[3:2];

endmodule