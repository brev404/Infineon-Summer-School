module tx_baud_gen_TB();

reg sclock, sreset_n;
reg [1:0] sbaudrate_select;
wire stx_baud;

tx_baud_gen dut
(
	.clock(sclock),
	.reset_n(sreset_n),
	.baudrate_select(sbaudrate_select),
	.tx_baud(stx_baud)
);

initial begin
	sclock = 0;
forever #2
	sclock = ~sclock;
end

initial begin
	sreset_n = 0;
	sbaudrate_select = 1;
#3
	sreset_n = 1;
#100
	$stop;
end

endmodule