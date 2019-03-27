module multi(
			 output logic [31:0] OP,  //O/P
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

initial begin
{Asign,Apower,Afraction} = a;
{Bsign,Bpower,Bfraction} = b;	
end

always @(a or b) begin
	{Ofraction_HI,Ofraction_LO} = (Afraction*Bfraction + Afraction<<23 + Bfraction<<23);
	Opower = Apower + Bpower;
	Osign = Asign ^ Bsign;
	OP = {Osign , Opower , Ofraction_HI};
	//check the exponent
end
	
endmodule