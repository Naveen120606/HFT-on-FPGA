`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2025 23:20:43
// Design Name: 
// Module Name: RAM_module
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


module RAM_module 
#(parameter msg_width = 16,
parameter mem_height = 32,
parameter addr = 5
)
(input clk,
input rst,
input we,
//input [addr-1:0] w_addr,
input w_increase,
input [msg_width-1:0] data_in,
output reg [msg_width-1:0] data_out
    );
    
    reg[addr-1:0] w_addr;
    reg[addr-1:0] r_addr;
    reg [msg_width-1:0] mem [0:mem_height-1]; 
    always @(negedge clk) begin
        if(rst) begin
            data_out<=16'b0;
            r_addr<=5'b0;
            w_addr<=5'b0;
        end
        else begin
            if(we) begin
                mem[w_addr] <= data_in;
                w_addr<=w_increase?(w_addr+1'b1):w_addr;
            end 
            else begin
                data_out <= mem[r_addr];
                r_addr <= r_addr + 1'b1;
            end
         end
    end
                
endmodule
