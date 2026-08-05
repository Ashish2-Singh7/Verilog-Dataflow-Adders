module cla_adder(sum, c_Out, A, B, c_In);

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

    wire p0, p1, p2, p3;
    wire g0, g1, g2, g3;
    wire [4:0] carr;

    assign p0 = A[0] ^ B[0],
           p1 = A[1] ^ B[1],
           p2 = A[2] ^ B[2],
           p3 = A[3] ^ B[3];
    assign g0 = A[0] & B[0],
           g1 = A[1] & B[1],
           g2 = A[2] & B[2],
           g3 = A[3] & B[3];

    assign carr[0] = c_In,
           carr[1] = (p0 & c_In) | g0,
           carr[2] = (p1 & ((p0 & c_In) | g0)) | g1,
           carr[3] = (p2 & ((p1 & ((p0 & c_In) | g0)) | g1)) | g2,
           carr[4] = (p3 & ((p2 & ((p1 & ((p0 & c_In) | g0)) | g1)) | g2)) | g3;

    assign c_Out = carr[4];

    genvar i;

    generate 
        for (i = 0; i<=3; i = i+1 ) begin : adder_loop
        assign sum[i] = A[i] ^ B[i] ^ carr[i];
    end
    endgenerate
    
endmodule