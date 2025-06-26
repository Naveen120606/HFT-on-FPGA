`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.04.2025 23:27:23
// Design Name: 
// Module Name: Top_module_1
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



module Top_module_1(
input clk,rst,we,enable,
input w_increase,
input[15:0] data_in,
input show,
//input[13:0] current_price,
//input[1:0] stock_id,
output reg buy_signal,
output reg sell_signal,
//output [9:0]   bought,   
output reg[15:0]  profit
//output [1:0]stock_iden
//output [15:0] ram_data
    );
    
    wire [15:0] ram_data;
    wire ema_buy;
    wire ema_sell;
//    wire [1:0] stock_id_ema;

    wire RSI_buy;
    wire RSI_sell;
//    wire [1:0] stock_id_algo;

    wire mom_buy;
    wire mom_sell;
//    wire [1:0] stock_id_mom;

    reg buy_signal_reg,sell_signal_reg;
    wire[15:0] profit_reg;

    debouncing_circuit for_show(clk,rst,show,show_db);
    
    RAM_module ram_inst(
        .clk(clk),
        .rst(rst),
        .we(we),
        .w_increase(w_increase),
        .data_in(data_in),
        .data_out(ram_data)
    );
    
    
    Momentum_ignition algo_inst1(
        .enable(enable),
        .clk(clk),
        .rst(rst),
        .data_in(ram_data),
        .buy_signal(mom_buy),
        .sell_signal(mom_sell),
        .stock_idd(stock_idd)
    );
    
    RSI_algorithm algo_inst2(
        .enable(enable),
        .clk(clk),
        .rst(rst),
        .price_in(ram_data),
        .buy_signal(RSI_buy),
        .sell_signal(RSI_sell),
        .stock_id_out(stock_id_out)
    );
    
    exponential_moving_average algo_inst3(
        .enable(enable),
        .clk(clk),
        .rst(rst),
        .data_in(ram_data),
        .buy_signal(ema_buy),
        .sell_signal(ema_sell),
        .stock_idd(stock_iden)
    );
    
    kelly kelly_inst (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .data_in(data_in),
        .RSI_buy(RSI_buy),
        .EMA_buy(ema_buy),
        .Momentum_buy(mom_buy),
        .RSI_sell(RSI_sell),
        .EMA_sell(ema_sell),
        .Momentum_sell(mom_sell),
        .bought(bought),
        .profit(profit_reg),
        .stock_id(stock_id)
    );
    
    always @(*) begin
            buy_signal_reg = (mom_buy & RSI_buy) | (RSI_buy & ema_buy) | (ema_buy & mom_buy); 
            sell_signal_reg = (mom_sell & RSI_sell) | (mom_sell & ema_sell) | (RSI_sell & ema_sell);
    end
    
    always @(posedge clk) begin
        if(rst) begin
            buy_signal <= 1'b0;
            sell_signal <= 1'b0;
            profit <= 1'b0;
        end
        else begin
            if(show_db) begin
                buy_signal <= buy_signal_reg;
                sell_signal <= sell_signal_reg;
                profit <= profit_reg;
            end
            else begin
                buy_signal <= buy_signal;
                sell_signal <= sell_signal;
                profit <= profit;
            end
        end
    end
endmodule
