module uart_transmitter
(
	input [7:0] data_i,
	input data_write_i, clock_i, reset_n_i,
	input [5:0] data_buffer_full_thres_i,
	input [1:0] baudrate_select_i,
	output data_buffer_full_o,
	output uart_tx_o
);

wire empty;
wire fifo_read;
wire [7:0] data;
wire tx_baud;

fifo_buffer FIFO
(
	.clock(clock_i),
	.reset_n(reset_n_i),
	.full_thres(data_buffer_full_thres_i),
	.write_enable(data_write_i),
	.read_enable(fifo_read),
	.data_in(data_i),
	.data_out(data),
	.full(data_buffer_full_o),
	.empty(empty)
);

tx_baud_gen TX_BAUD_GEN
(
	.clock(clock_i),
	.reset_n(reset_n_i),
	.baudrate_select(baudrate_select_i),
	.tx_baud(tx_baud)
);

uart_tx UART_TX
(
	.clock(clock_i),
	.reset_n(reset_n_i),
	.tx_start(~empty),
	.tx_baud(tx_baud),
	.data_in(data),
	.tx_done(fifo_read),
	.tx(uart_tx_o)
);

endmodule