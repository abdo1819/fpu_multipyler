module multi(
			 output logic [31:0] op,  //O/P
			 input logic [31:0] a,
			 input logic [31:0] b
			 );

logic [22:0]Ofraction_HI; //fraction will neglict any bit after ofraction[22]
logic [22:0]Ofraction_LO;
logic Osign;
logic [5:0]Opower;
logic [22:0]Afraction ;
logic [22:0]Bfraction ;
logic [5:0] Apower;
logic [5:0] Bpower;
logic Asign;
logic Bsign;

logic carryExp;
logic carryFra;

initial begin
{Asign,Apower,Afraction} = a;
{Bsign,Bpower,Bfraction} = b;	
end

always @(a or b) begin
	
	{carryFra,Ofraction_HI,Ofraction_LO} = (Afraction*Bfraction + Afraction<<23 + Bfraction<<23);
	
	
	{carryExp,Opower} = Apower + Bpower + carryFra;
	
	Osign = Asign ^ Bsign;
	// normlizing number for case of ofraction > 1
	if (carryFra)
		op = {Osign , Opower , Ofraction_HI<<1};
	else
		op = {Osign , Opower , Ofraction_HI};
	//check the exponent
	if (carryExp)
		$display("overflow"); 
end
	
endmodule