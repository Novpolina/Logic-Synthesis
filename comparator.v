module comparator_2bit_reg (
    input wire clk,
    input wire rst_n,
    input wire [1:0] a,
    input wire [1:0] b,
    output reg less
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            less <= 1'b0;
        end else begin
            if (a < b) begin
                less <= 1'b1;
            end else begin
                less <= 1'b0;
            end
        end
    end

endmodule