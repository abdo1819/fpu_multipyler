module testbench();

    reg clk;
    reg [31:0] a,b,opexp;
    logic [31:0] op;
    reg [31:0] vectornum,errors;
    reg [96:0] testvectors[1000:0];

    logic compare;
    shortreal opr;
    shortreal opexpr;
    shortreal diff;

multi m(.a,.b,.op);

always 
    begin
        clk =1; #5; clk = 0; #5;
    end

initial begin
    $readmemh("mult.tv", testvectors);
    vectornum = 0; errors = 0;
end

always @(posedge clk)
    begin
        #1; {a,b,opexp} = testvectors[vectornum];
    end
    
always @(negedge clk)
    begin
        opr = $bitstoshortreal(op);
        opexpr = $bitstoshortreal(opexp);
        diff = opr-opexpr;
        if(diff < 0)
            diff = diff * -1;
        // if( diff > 0.1)
        if  (~(( (opexp === op) | (diff < 0.1) )))
            begin
                $display("error input = %h __ %h",a,b);
                $display("a = %b\nb = %b",a,b);

                $display("output = %h  __ %f",op ,opr);
                $display("exp    = %h  __ %f",opexp ,opexpr);	
                errors = errors+1;
            end
            vectornum = vectornum +1;

        if(testvectors[vectornum] ===97'bx) begin
              $display("%d test complate with %d errors" , vectornum , errors);
              $stop();
        end
    end
    
endmodule
