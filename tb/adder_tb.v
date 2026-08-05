module adder_tb;
    parameter N = 4;

    reg [N-1:0] A, B;
    reg c_in;
    wire [N-1:0] sum;
    wire c_out;

    // cla_adder #(.N(N)) DUT(sum, c_out, A, B, c_in); // cla_adder is not parameterized, it is for 4 bits.
    rc_adder #(.N(N)) DUT(sum, c_out, A, B, c_in); // rc_adder is parameterized.

    initial begin
        $dumpfile("./sim/waveform.vcd");
        $dumpvars(0, adder_tb);
    end

    initial begin
        $monitor($time, "\n A: %d | B: %d | c_in: %b | sum: %d | c_out: %b \n", A, B, c_in, sum, c_out);

        A = 5; B = 6; c_in = 1;
        #10 A = 6; B = 15; c_in = 0;
        #10 A = 15; B = 2; c_in = 1;
        #10 A = 11; B = 7; c_in = 0;
        #10 A = 4; B = 9; c_in = 1;
        #10 A = 15; B = 3; c_in = 0;
        #10 A = 13; B = 7; c_in = 1;
        #10 $finish;

    end
endmodule