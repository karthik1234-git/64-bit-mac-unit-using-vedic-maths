/* verilator lint_off UNUSED */
module vedic_multipler #(parameter N = 64) (
    input  logic [N-1:0] a,
    input  logic [N-1:0] b,
    output logic [(2*N)-1:0] result
);
    // You will put your Brent-Kung and Recursive Vedic logic here
    assign result = a * b; 
endmodule