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

logic carryExp;
logic [1:0]carryFra;

always @(a or b) begin

	{Asign,Apower,Afraction} = a;
	{Bsign,Bpower,Bfraction} = b;	




	// clac fraction (1.f1)(1.f2)=(1.fo) 
	{carryFra,Ofraction_HI,Ofraction_LO}=({1'b1,Afraction}*{1'b1,Bfraction})
	
	// exponent is biased by 127 so (000000011)
	//               represented in (100000010)
	{carryExp,Opower} = Apower + Bpower - 8'd127 ;
		
	
	Osign = Asign ^ Bsign;
	
	// normlizing number for case carryfraction has one at end
	if (carryFra[1])
		begin
		{carryExp,Opower} = Opower + 8'b1; 
		Ofraction_HI = {carryFra[0],Ofraction_HI[22:1]};
		end
	//check the exponent
	if (carryExp)
		$display("overflow"); 
		
	op = {Osign , Opower , Ofraction_HI};
	
	
end
	
endmodule