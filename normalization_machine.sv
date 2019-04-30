/**
 * Normalization machine
 *                                  ___________
 *      (24-bit)fraction  ----------|         |---------- normalized rounded fraction (23-bit)
 *      (8-bit) exponent  ----------|_________|---------- normalized exponent (8-bit)
 *      (1-bit sign) ----------------------------s-------- (1-bit sign)
 *
 * @Author: Abdullah khaled (A-Siam) 
 */
module normalization_machine(
		input logic [23:0] fraction,
		input logic [7:0] exponent,
		output logic [22:0] n_fraction,
		output logic [7:0] n_exponenet,
		output overflow
	);
logic carry;
always @(fraction) begin
	
	if (fraction[23] != 0) begin
	// rounding algorithm w/ example
	// we know that 1101 has 2 rounding possabilites 111 or 110 to fit in 3bit representation 
	// sub 1101-111 was greater than 1101-110
	//then 110 should be selected
	//else do the opesite procedural 
	n_fraction = fraction>>1;
	if ((fraction - n_fraction) > (fraction - {n_fraction[22:1],~n_fraction[0]})) begin
		n_fraction = {n_fraction[22:1],~n_fraction[0]};
	end
		{carry,n_exponenet} = exponent+1;
	end
	if (carry) begin
		overflow = 1;
	end
end

endmodule