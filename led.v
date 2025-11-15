module led(iCLK, iRESETn, oLED, iUP, iDOWN);
input iCLK, iRESETn;
input iUP, iDOWN;
output [7:0] oLED;

reg [7:0] led;
wire MYCLK;

assign oLED = led;

freq_div UFD (.iCLK(iCLK), .iRESETn(iRESETn), .oMYCLK(MYCLK));

always @(posedge MYCLK or negedge iRESETn) begin
	if(!iRESETn)
		led <= 0;
	else
		led <= led + 1;
end

endmodule