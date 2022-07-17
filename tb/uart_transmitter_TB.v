module uart_transmitter_TB();

wire suart_tx_o;
wire sdata_buffer_full_o;
reg [7:0] sdata_i;
reg [5:0] sdata_buffer_full_thres_i;
reg sdata_write_i, sclock_i, sreset_n_i;
reg [1:0] sbaudrate_select_i;

uart_transmitter dut
(
	.data_i(sdata_i),
	.data_write_i(sdata_write_i),
	.data_buffer_full_o(sdata_buffer_full_o),
	.data_buffer_full_thres_i(sdata_buffer_full_thres_i),
	.baudrate_select_i(sbaudrate_select_i),
	.clock_i(sclock_i),
	.reset_n_i(sreset_n_i),
	.uart_tx_o(suart_tx_o)
);

initial begin
	sclock_i = 0;
forever #2
	sclock_i = ~sclock_i;
end

initial begin
	sreset_n_i = 0;
	sdata_buffer_full_thres_i = 32;
	sdata_i = 8'b10101110;
	sbaudrate_select_i = 0;
	sdata_write_i = 0;
#4
	sreset_n_i = 1;
	sdata_write_i = 1;
#400
	sdata_write_i = 0;
#400
	$stop;
end

endmodule