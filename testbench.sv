module testbench();

    reg clk;
    reg [31:0] a,b,opexp;
    logic [31:0] op;
    reg [31:0] vectornum,errors;
    reg [65:0] testvectors[1000:0];


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
        if(opexp !== op)
            begin
                $display("error input = %b",{a,b});
                // $display("output = %b (%b exp)",{op,opexp});
                errors = errors+1;
            end
            vectornum = vectornum +1;

        if(testvectors[vectornum] ===95'bx) begin
              $display("%d test complate with %d errors" , vectornum , errors);
        end
    end
    
endmodule