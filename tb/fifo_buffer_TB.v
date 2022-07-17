module fifo_buffer_TB();

reg sclock, sreset_n;
reg swrite_enable, sread_enable;
reg [7:0] sdata_in;
reg [5:0] sfull_thres;
wire [7:0] sdata_out;
wire sempty, sfull;

fifo_buffer dut
(
	.clock(sclock),
	.reset_n(sreset_n),
	.write_enable(swrite_enable),
	.read_enable(sread_enable),
	.data_in(sdata_in),
	.full_thres(sfull_thres),
	.data_out(sdata_out),
	.empty(sempty),
	.full(sfull)
);

initial begin
	sclock = 0;
forever #2
	sclock = ~sclock;
end

initial begin
	sreset_n = 0;
	sfull_thres = 32;
#4
	sreset_n = 1;
	sdata_in = 120;
	swrite_enable = 1;
	sread_enable = 0;
#200
	swrite_enable = 0;
	sread_enable = 1;
#200
	$stop;
end

endmodule