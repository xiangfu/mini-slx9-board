module blinking(clk, led, led1, RxD, TxD, GPout);
   // By defaule the led blinking on 32K crystal
   // Change the COUNTER_SIZE to 23 for 20M or 50M crystal
   `define COUNTER_SIZE 23
   `define COUNTER_ARRAY_SIZE 24

   input clk;
   output led;
   output led1;
   input RxD;
   output TxD;
   output [7:0] GPout;

   wire 	RxD_data_ready;
   wire [7:0] 	RxD_data;
   reg 		TxD_data_ready;
   reg [7:0] 	GPout;
   reg [7:0] 	GPin;

   reg [`COUNTER_SIZE:0] counter;
   reg 			 enable = 1'b1;


   async_receiver deserializer(.clk(clk), .RxD(RxD), .RxD_data_ready(RxD_data_ready), .RxD_data(RxD_data));
   async_transmitter serializer(.clk(clk), .TxD(TxD), .TxD_start(TxD_data_ready), .TxD_data(GPin));

   always @(posedge clk) begin
	if (RxD_data_ready) GPout <= RxD_data;

	if (enable == 1'b1) counter <= counter + 1;
	if (RxD_data == 8'h70) enable <= 1'b1;
	if (RxD_data == 8'h73) enable <= 1'b0;
	if (counter == `COUNTER_ARRAY_SIZE'h800000) begin
	     TxD_data_ready <= 1'b1;
	     GPin <= 8'h42;	// outout B when light
	end
	if (counter == `COUNTER_ARRAY_SIZE'h000000) begin
	     TxD_data_ready <= 1'b1;
	     GPin <= 8'h5a;	// output Z when off
	end
	if ((counter == `COUNTER_ARRAY_SIZE'h800001) ||
	    (counter == `COUNTER_ARRAY_SIZE'h000001)) begin
	     TxD_data_ready <= 1'b0;
	end
    end

   assign led = counter[`COUNTER_SIZE];
   assign led1 = RxD_data[0];
   assign led2 = GPin[0];
endmodule
