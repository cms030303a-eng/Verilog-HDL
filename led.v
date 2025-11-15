module led(iCLK, iRESETn, oLED, iUP, iDOWN);
input iCLK, iRESETn;
input iUP, iDOWN;
output [7:0] oLED;

reg [7:0] led;
wire MYCLK;

assign oLED = led;

freq_div UFD (.iCLK(iCLK), .iRESETn(iRESETn), .oMYCLK(MYCLK));

//S0 ready, S1 up, S2 down
reg [1:0] curr_state, next_state;
localparam S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;


always @(posedge MYCLK) begin
	case(curr_state)
		S0 :
			led = 0;
		S1 :
			led = led + 8'd1;
		S2 :
			led = led - 8'd1;
		default : led = led;
	endcase
end

always @(posedge MYCLK or negedge iRESETn) begin
	if(!iRESETn) 
		curr_state <= S0;
	else
		curr_state <= next_state;
end

always @(iUP or iDOWN) begin
		if(!iUP)
			next_state = S1;
		else if(!iDOWN)
			next_state = S2;
		else
			next_state = curr_state;
end

endmodule