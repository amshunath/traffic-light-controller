module traffic_light_controller (
    input clk,
    input reset,
    input Sa,  // Sensor for direction A
    input Sb,  // Sensor for direction B
    output reg Ra, // Red light for direction A
    output reg Ga, // Green light for direction A
    output reg Ya, // Yellow light for direction A
    output reg Rb, // Red light for direction B
    output reg Gb, // Green light for direction B
    output reg Yb  // Yellow light for direction B
);

    typedef enum logic [3:0] {
        STATE_A_GREEN = 4'd0,
        STATE_A_YELLOW = 4'd1,
        STATE_B_GREEN = 4'd2,
        STATE_B_YELLOW = 4'd3
    } state_t;

    state_t state, next_state;

    // logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= STATE_A_GREEN;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        // Default outputs
        Ra = 0;
        Ga = 0;
        Ya = 0;
        Rb = 0;
        Gb = 0;
        Yb = 0;
        
        case (state)
            STATE_A_GREEN: begin
                Ga = 1;
                Rb = 1;
                if (Sb)
                    next_state = STATE_A_YELLOW;
                else
                    next_state = STATE_A_GREEN;
            end
            STATE_A_YELLOW: begin
                Ya = 1;
                Rb = 1;
                next_state = STATE_B_GREEN;
            end
            STATE_B_GREEN: begin
                Ra = 1;
                Gb = 1;
                if (Sa)
                    next_state = STATE_B_YELLOW;
                else
                    next_state = STATE_B_GREEN;
            end
            STATE_B_YELLOW: begin
                Ra = 1;
                Yb = 1;
                next_state = STATE_A_GREEN;
            end
            default: begin
                next_state = STATE_A_GREEN;
            end
        endcase
    end

endmodule
