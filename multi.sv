module multi(
			 output logic [31:0] op,  //O/P
			 input logic [31:0] a,
			 input logic [31:0] b
			 );

logic [22:0]Ofraction_HI; //fraction will neglict any bit after ofraction[22]
logic [22:0]Ofraction_LO;
logic Osign;
logic [7:0]Opower;
logic [22:0]Afraction ;
logic [22:0]Bfraction ;
logic [7:0] Apower;
logic [7:0] Bpower;
logic Asign;
logic Bsign;

logic [1:0]carryExp;
logic [2:0]carryFra;

// TODO delete 
// logic [32:0]big;
// logic [45:0]mu;
// logic [45:0]sh1;
// logic [45:0]sh2;
// logic [50:0]su;

// TODO move intial to always statment so number updates conteniusly
initial begin
{Asign,Apower,Afraction} = a;
{Bsign,Bpower,Bfraction} = b;	
end

always @(a or b) begin
	
	// adding brances solve an problem in order of adding
	{carryFra,Ofraction_HI,Ofraction_LO} = ((Afraction*Bfraction) + (Afraction<<23) + (Bfraction<<23));
	
	// exponent is biased by 127 so (000000011)
	//               represented in (100000010)
	{carryExp,Opower} = Apower + Bpower - 127 + carryFra;
	
	Osign = Asign ^ Bsign;
	
	// normlizing number for case of ofraction > 1
	if (carryFra)
		Ofraction_HI = Ofraction_HI>>1;
	
	//check the exponent
	if (carryExp)
		$display("overflow"); 
		
	op = {Osign , Opower , Ofraction_HI};
	
	
end
	
endmodule