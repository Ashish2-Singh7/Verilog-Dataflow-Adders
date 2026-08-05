module rc_adder(sum, c_Out, A, B, c_In);

    parameter N = 4;

    input [N-1:0] A, B;
    input c_In;
    output [N-1:0] sum;
    output c_Out;

/*
    // Behavioural modelling (will synthesize into optimized adder for both cla and rc)
    output reg [N-1:0] sum;
    output reg c_Out;
    always @(*) begin
        {c_Out, sum} = A + B + c_In;
    end
*/


    // Dataflow modelling (for 4bits, this makes the adder truly rc or cla depending on the implementation )

    wire [N:0] carr;

    assign carr[0] = c_In;

    genvar i;

    generate 
        for (i = 0; i<N; i = i+1 ) begin : adder_loop
        assign carr[i+1] = ((A[i] ^ B[i]) & carr[i]) | A[i] & B[i];
        assign sum[i] = A[i] ^ B[i] ^ carr[i];
        
    end
    endgenerate
    assign c_Out = carr[N];

endmodule