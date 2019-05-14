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

logic ones_Apower = &Apower;
logic zeros_Apower = ~|Apower;
logic zero_Afraction = ~|Afraction;

logic ones_Bpower = &Bpower;
logic zeros_Bpower = ~|Bpower;
logic zero_Bfraction = ~|Bfraction;


logic carryExp;
logic [2:0] carryFra;

logic [31:0] nan = 32'b01111111100000000000000000000001 ;

always @(a or b) begin

	{Asign,Apower,Afraction} = a;
	{Bsign,Bpower,Bfraction} = b;	

	//TODO: special cases
	// nan or nan => nan
	// inf and 0  => nan
	// inf and anything => inf
	// 0   and 0  => 0

	// if or b is nan
	if ((ones_Apower & ~zero_Afraction) | (ones_Bpower & ~zero_Bfraction)) 
		// nan 255 exp , non zero frac 
		op = nan;

	else if ((ones_Apower & zero_Afraction)) // a is inf (255,zeros)
	begin
		if ((zero_Bpower & zero_Bfraction)) // b is 0 (0,0)
			op = nan; // inf and 0 => nan
		else
			op = a;  // inf and otherthings => inf

	else if ((ones_Bpower & zero_Bfraction)) // b is inf (255,zeros)
	begin
		if ((zero_Apower & zero_Afraction)) // a is 0
			op = nan; // inf and 0 => nan
		else
			op = b; // inf and otherthings => inf
		
	// clac fraction (1+f1)(1+f2)=(1+f1*f2+f1+f2) 
	{carryFra,Ofraction_HI,Ofraction_LO} = ((Afraction*Bfraction) + (Afraction<<23) + (Bfraction<<23));
	
	// exponent is biased by 127 so (000000011)
	//               represented in (100000010)
	{carryExp,Opower} = Apower + Bpower - 8'd127 ;
		
	
	Osign = Asign ^ Bsign;
	
	// normlizing number for case of ofraction > 2
	if (carryFra)
		begin
		{carryExp,Opower} = Opower + 8'b1; 
		Ofraction_HI = Ofraction_HI>>1;
		Ofraction_HI[0] = Ofraction_LO[22];
		end
	//check the exponent
	if (carryExp)
		$display("overflow"); 
		
	op = {Osign , Opower , Ofraction_HI};
	
	
end
	
endmodule