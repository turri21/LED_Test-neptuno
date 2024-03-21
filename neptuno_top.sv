`timescale 1ns / 1ps
`default_nettype none

module neptuno_top (
    clk,           // Input clock on development board: 50Mhz
    rst_n,         // Enter the reset button on the development board
    led            // Output LED light, used to control the LED on the development board
);

	
//===========================================================================
// PORT declarations
//===========================================================================

input clk;
input rst_n;
output led;
	
//Register definition
reg [31:0] timer;                  
reg led;


//===========================================================================
// Counter counting: loop counting 0~2 seconds
//===========================================================================
	
always @(posedge clk or negedge rst_n) begin   //Detect the rising edge of clock and the falling edge of reset
  if (~rst_n)                           //Reset signal is active low
     timer <= 0;                       //Counter cleared
  else if (timer == 32'd99_999_999)     //The crystal oscillator used in the development board is 50MHz, counting in 2 seconds (50M*2-1=99_999_999)
     timer <= 0;                       //The counter counts up to 2 seconds and is cleared to zero.
  else
     timer <= timer + 1'b1;  //Counter increments by 1
end


//===========================================================================
// LED light control
//===========================================================================

always @(posedge clk or negedge rst_n) begin  //Detect the rising edge of clock and the falling edge of reset
  if (~rst_n)                          //Reset signal is active low
    led <= 1'b1;                     //LED light output is high
  else if (timer == 32'd49_999_999)    //The counter counts up to 1 second,
    led <= 1'b0;                     //LED lights up
  else if (timer == 32'd99_999_999)    //The counter counts up to 2 seconds,
    led <= 1'b1;                     //LED off
end

endmodule
