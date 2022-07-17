module uart_tx
(
	input clock, reset_n,
	input tx_start, tx_baud,
	input [7:0] data_in,
	output tx_done,
	output reg tx
);

localparam STATE_IDLE =	2'b00;
localparam STATE_START = 2'b01;
localparam STATE_DATA = 2'b10;
localparam STATE_STOP = 2'b11;

reg [8:0] buffer_in;
reg [1:0] state, state_next;
reg [3:0] bit_counter;

// STATE REGISTER
always@(posedge clock) begin
	if(reset_n == 0)
		state <= STATE_IDLE;
	else
		state <= state_next;
end

// NEXT STATE
always@(*) begin
	state_next = state;
	
	case(state)
		STATE_IDLE: begin
			if(tx_start == 1 & tx_baud == 1)
				state_next = STATE_START;
		end
		
		STATE_START: begin
			if(tx_baud == 1)
				state_next = STATE_DATA;
		end
		
		STATE_DATA: begin
			if(bit_counter == 4'b1000 & tx_baud == 1)
				state_next = STATE_STOP;
		end
		
		STATE_STOP: begin
			if(tx_baud == 1 & tx_start == 1)
				state_next = STATE_IDLE;
			else if(tx_baud == 1)
				state_next = STATE_IDLE;
		end
		
		default: state_next = STATE_IDLE;
	endcase
end

// BUFFER IN
always@(posedge clock) begin
	if(reset_n == 0)
		buffer_in <= 0;
	else
		if(state == STATE_IDLE & tx_start == 1)
			buffer_in <= {^data_in, data_in};
		else
			if(state == STATE_DATA & tx_baud == 1)
				buffer_in <= buffer_in >> 1;
			else
				buffer_in <= buffer_in;
end


// BIT COUNTER
always@(posedge clock)begin
	if(reset_n == 0)
		bit_counter <= 0;
	else begin
		if(tx_baud == 1)
			bit_counter <= bit_counter + 1;
		if(state != STATE_DATA & tx_baud == 1)
			bit_counter <= 0;
	end
end

// TX
always@(*) begin
	if(state == STATE_START)
		tx = 0;
	else
		if(state == STATE_IDLE || state == STATE_STOP)
			tx = 1;
		else
			if(state == STATE_DATA)
				tx = buffer_in[0];
end
	
// TX_DONE
assign tx_done = (state == STATE_STOP & tx_baud == 1);

endmodule