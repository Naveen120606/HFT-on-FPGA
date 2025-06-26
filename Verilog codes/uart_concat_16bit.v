`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2025 04:36:50
// Design Name: 
// Module Name: uart_concat_16bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_concat_16bit (
    input clk,
    input rst,
    input [7:0] rx_data,
    input       rx_data_valid,
    output reg [15:0] data_16bit,
    output reg        data_16bit_valid
);

    reg [7:0] byte_buffer;
    reg       has_first_byte;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            has_first_byte    <= 1'b0;
            byte_buffer       <= 8'd0;
            data_16bit        <= 16'd0;
            data_16bit_valid  <= 1'b0;
        end else begin
            data_16bit_valid <= 1'b0; // default low

            if (rx_data_valid) begin
                if (!has_first_byte) begin
                    byte_buffer    <= rx_data;
                    has_first_byte <= 1'b1;
                end else begin
                    data_16bit       <= {byte_buffer, rx_data}; // MSB first
                    data_16bit_valid <= 1'b1;
                    has_first_byte   <= 1'b0;
                end
            end
        end
    end
endmodule

