`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.04.2025 04:44:48
// Design Name: 
// Module Name: debouncing_circuit
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


module debouncing_circuit(
    input clk, reset, bounce,
    output reg button_raise
    );
    
    wire button;

debouncer_delayed(clk, reset, bounce, button);
    
    reg button_old;
    
    always @(posedge clk) begin
    if (button_old != button && button == 1'b1) button_raise <= 1'b1;
    else button_raise <= 0;
    
    button_old <= button;
end
    
endmodule
