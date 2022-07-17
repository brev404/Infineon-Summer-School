module tx_baud_gen
(
	input clock, reset_n,
	input[1:0] baudrate_select,
	output reg tx_baud
);

reg [6:0]num;

always@(posedge clock) begin
	if(reset_n == 0)
		num <= 0;
	else
		num <= num + 1;
end

//BAUDRATE GENERATOR WITH 4 SELECTIONS
always@(*) begin 
	case(baudrate_select)
		0: tx_baud = (4'b1111 == num[3:0]) ? 1 : 0;
		1: tx_baud = (5'b11111 == num[4:0]) ? 1 : 0;
		2: tx_baud = (6'b111111 == num[5:0]) ? 1 : 0;
		3: tx_baud = (7'b1111111 == num[6:0]) ? 1 : 0;
		default: tx_baud = 0;
	endcase
end

endmodule