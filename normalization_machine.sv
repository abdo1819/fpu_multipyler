/**
 * Normalization machine
 *                                  ___________
 *      (24-bit)fraction  ----------|         |---------- normalized fraction (23-bit)
 *      (8-bit) exponent  ----------|_________|---------- normalized exponent (8-bit)
 *      (1-bit sign) ------------------------------------ (1-bit sign)
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
		n_fraction = fraction>>1;
		{carry,n_exponenet} = exponent+1;
	end
	if (carry) begin
		overflow = 1;
	end
end

endmodule