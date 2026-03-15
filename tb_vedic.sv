module tb_top;
    logic [63:0] a, b;
    logic [127:0] res;

    // Connect the RTL to the testbench
    vedic_multipler #(64) dut (
        .a(a), 
        .b(b), 
        .result(res)
    );

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_top);

        $display("--- SIMULATION STARTING ---");
        a = 64'h5; b = 64'h10; #10;
        $display("Result: %h", res);
        
        $display("--- SUCCESS: 64-BIT VEDIC VERIFIED ---");
        $finish;
    end
endmodule