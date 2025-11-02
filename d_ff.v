module d_ff(iCLK, iCLEARn, iPRESETn,iD, oQ, oQn);
input iCLK, iCLEARn, iPRESETn;
input iD;
output oQ,oQn;

reg oQ;

assign oQn = ~oQ;

always @(posedge iCLK or negedge iCLEARn or negedge iPRESETn) begin
	if(!iCLEARn)
		oQ <= 0;
	else if(!iPRESETn)
		oQ <= 1;
	else
		oQ <= iD;
end
endmodule
