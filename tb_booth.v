`timescale 1ns/1ps

module tb_booth_multiplier;
    // --- Signals ---
    reg  [3:0] M, Q;
    reg        CLK, AR;
    wire [7:0] Product;
    
    // THE FIX: Intermediate signed net for the monitor
    wire signed [7:0] signed_product;
    assign signed_product = Product;

    // --- Instantiation ---
    booth_multiplier_4bit uut (
        .M(M),
        .Q(Q),
        .CLK(CLK),
        .AR(AR),
        .Product(Product)
    );

    // --- Clock Generation ---
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;  // 10 ns period
    end

   // Stimulus
    initial begin
        // Initialize
        AR = 1; M = 0; Q = 0;
        #10;
        AR = 0;

        // --- TEST 1: 7 * 7 = 49 ---
        M = 4'b0111; Q = 4'b1001;
        #50; // Wait for completion
        
        // --- TEST 2: -8 * -8 = 64 ---
        AR = 1; #10; AR = 0;
        M = 4'b1000; Q = 4'b1000;
        #50;

        // --- TEST 3: -8 * 7 = -56 ---
        AR = 1; #10; AR = 0;
        M = 4'b1000; Q = 4'b0111;
        #50;

        // --- TEST 4: 7 * 0 = 0 ---
        AR = 1; #10; AR = 0;
        M = 4'b0111; Q = 4'b0000;
        #50;

        // --- TEST 5: -1 * -1 = 1 ---
        AR = 1; #10; AR = 0;
        M = 4'b1111; Q = 4'b1111;
        #50;

        $display("Robust Testing Complete.");
        $finish;
    end

    // --- Monitor / Output ---
    initial begin
        // Print header for readability
        $display("---------------------------------------------------------------------------------");
        $display("  Time |  M (Bin) | Acc (Bin) | Q (Bin) | Q-1 | Cnt | Prod (Bin) | Prod (Dec)");
        $display("---------------------------------------------------------------------------------");
        
        // Monitor tracks changes and prints them formatted
        // Replaced $signed(Product) with the intermediate net signed_product
        $monitor("%6t |   %b   |   %b   |   %b  |  %b  |  %d  |  %b  | %4d",
                 $time,
                 uut.Mval,
                 uut.Accval,
                 uut.Qval,
                 uut.q_1val,
                 uut.cnt_res,
                 Product,
                 signed_product); 
    end
endmodule