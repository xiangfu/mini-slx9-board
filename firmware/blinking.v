module blinking(input clk, output led);
   `define COUNTER_SIZE 14
   // By defaule the led blinking on 32K crystal
   // Change the COUNTER_SIZE to 23 for 20M or 50M crystal

   reg [`COUNTER_SIZE:0] counter;
   always @(posedge clk) counter <= counter + 1;
   assign led = counter[`COUNTER_SIZE];
endmodule
