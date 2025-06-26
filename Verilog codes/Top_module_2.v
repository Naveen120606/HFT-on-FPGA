`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2025 23:27:23
// Design Name: 
// Module Name: Top_module_2
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

module Top_module_2 (
    input clk, reset_n,
    
    // Receiver port
    input rd_uart,      // left push button
    output rx_empty,    // LED0
    input rx,           
    
    // Transmitter port
    input [7:0] w_data, // SW0 -> SW7
    input wr_uart,      // right push button
    output tx_full,     // LED1
    output tx,
//    output[7:0] data_out,
    // Sseg signals
    output [6:0] sseg,
    output [0:7] AN,
    output DP,
    
    input rst,we,enable,
    input show,
    output buy_signal,
    output sell_signal,   
    output [13:0]  profit
);
    
    terminal_demo uart_msg(
    .clk(clk),
    .reset_n(reset_n),
    .rd_uart(rd_uart),      // left push button
    .rx_empty(rx_empty),    // LED0
    .rx(rx),           
    
    // Transmitter port
    .w_data(w_data), // SW0 -> SW7
    .wr_uart(wr_uart),      // right push button
    .tx_full(tx_full),     // LED1
    .tx(tx),
    .data_out(data_out),
    // Sseg signals
    .sseg(sseg),
    .AN(AN),
    .DP(DP)
    );
    
    uart_concat_16bit concat(
    .clk(clk),
    .rst(rst),
    .rx_data(data_out),
    .rx_data_valid(rd_uart),
    .data_16bit(data_16bit),
    .data_16bit_valid(data_16bit_valid)
    );
    
    Top_module_1 algo_logic(
    .clk(clk),
    .rst(rst),
    .we(we),
    .enable(enable),
    .w_increase(data_16bit_valid),
    .data_in(data_16bit),
    .show(show),
    .buy_signal(buy_signal),
    .sell_signal(sell_signal),  
    .profit(profit)
    );
    
endmodule