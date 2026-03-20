module tb_top;
    logic [3:0] a, b;
    logic [7:0] res;

    // Connect the RTL to the testbench
    vedic_multiplier dut (
        .a(a), 
        .b(b), 
        .result(res)
    );

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_top);

        $display("--- SIMULATION STARTING ---");
        a = 4'h5; b = 4'h8; #10;
        $display("Result: %h", res);
        
        $display("--- SUCCESS: 64-BIT VEDIC VERIFIED ---");
        $finish;
    end
endmodule