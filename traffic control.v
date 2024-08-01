module tb_traffic_light_controller;
    reg clk;
    reg reset;
    reg Sa;
    reg Sb;
    wire Ra;
    wire Ga;
    wire Ya;
    wire Rb;
    wire Gb;
    wire Yb;

    traffic_light_controller uut (
        .clk(clk),
        .reset(reset),
        .Sa(Sa),
        .Sb(Sb),
        .Ra(Ra),
        .Ga(Ga),
        .Ya(Ya),
        .Rb(Rb),
        .Gb(Gb),
        .Yb(Yb)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 10 time units clock period
    end

    // Stimulus generation
    initial begin
        // Initialize signals
        reset = 1;
        Sa = 0;
        Sb = 0;

        // Apply reset
        #10;
        reset = 0;

        // Simulate sensor inputs
        #20 Sa = 1;  // Direction A vehicle detected
        #30 Sa = 0;  // Direction A vehicle gone
        #40 Sb = 1;  // Direction B vehicle detected
        #50 Sb = 0;  // Direction B vehicle gone

        // Add more stimulus as needed
        #100;
        $stop;  // End simulation
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %0d: Ra = %b, Ga = %b, Ya = %b, Rb = %b, Gb = %b, Yb = %b", $time, Ra, Ga, Ya, Rb, Gb, Yb);
    end

endmodule
