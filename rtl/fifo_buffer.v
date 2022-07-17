module fifo_buffer
(
	input clock, reset_n,
	input write_enable, read_enable,
	input [7:0] data_in,
	input [5:0] full_thres,
	output [7:0] data_out,
	output empty, full
);

wire wr_en_mem, rd_en_mem;
reg [4:0] write_ptr, read_ptr;
reg [5:0] fifo_cnt;
reg [7:0] memory [0:31];

//CONTROL
assign	wr_en_mem = write_enable & ~full;
assign	rd_en_mem = read_enable & ~empty;
assign	full = fifo_cnt == full_thres;
assign	empty = fifo_cnt == 0;

always@(posedge clock) begin
	//FIFO COUNTER
	if(reset_n == 0)
		fifo_cnt <= 0;
	else begin
		if((wr_en_mem == 0) & (rd_en_mem == 1))
			fifo_cnt <= fifo_cnt - 1;
		if((wr_en_mem == 1) & (rd_en_mem == 0))
			fifo_cnt <= fifo_cnt + 1;
	end
	
	//WRITE_PTR
	if(reset_n == 0)
		write_ptr <= 0;
	else
		if(wr_en_mem == 1)
			write_ptr <= write_ptr + 1;
		else
			write_ptr <= write_ptr;
	//READ_PTR
	if(reset_n == 0)
		read_ptr <= 0;
	else
		if(rd_en_mem == 1)
			read_ptr <= read_ptr + 1;
		else
			read_ptr <= read_ptr;
end

// RAM
always@(posedge clock) begin
	if(wr_en_mem)
		memory[write_ptr] <= data_in;
end

assign data_out = memory[read_ptr];

endmodule