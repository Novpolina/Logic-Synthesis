module pwm_generator #(
    parameter WIDTH = 8
)(
    input wire clk,
    input wire rst_n,
    input wire [WIDTH-1:0] duty_cycle,
    input wire enable,
    output reg pwm_out
);

    reg [WIDTH-1:0] counter;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 0;
            pwm_out <= 1'b0;
        end else if (enable) begin
            counter <= counter + 1'b1;
            
            if (counter < duty_cycle)
                pwm_out <= 1'b1;
            else
                pwm_out <= 1'b0;
        end
    end

endmodule