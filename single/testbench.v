`include "singleCycle.v"
module singleCycleTest;
    reg clock;
	singleCycle test (
		clock
	);

	initial begin
		// Initialize Inputs
		clock = 0;
        $dumpfile("test.lxt");
        $dumpvars(0, test);
        #500;
        $stop;
	end

    integer i = 0;

    always #10 begin
        $display("Time: %d, clock = %d, PC = 0x%H", i, clock, test.pcOut);
        $display("[$s0] = 0x%H, [$s1] = 0x%H, [$s2] = 0x%H", test.registerFile.registers[16], test.registerFile.registers[17], test.registerFile.registers[18]);
        $display("[$s3] = 0x%H, [$s4] = 0x%H, [$s5] = 0x%H", test.registerFile.registers[19], test.registerFile.registers[20], test.registerFile.registers[21]);
        $display("[$s6] = 0x%H, [$s7] = 0x%H, [$t0] = 0x%H", test.registerFile.registers[22], test.registerFile.registers[23], test.registerFile.registers[8]);
        $display("[$t1] = 0x%H, [$t2] = 0x%H, [$t3] = 0x%H", test.registerFile.registers[9], test.registerFile.registers[10], test.registerFile.registers[11]);
        $display("[$t4] = 0x%H, [$t5] = 0x%H, [$t6] = 0x%H", test.registerFile.registers[12], test.registerFile.registers[13], test.registerFile.registers[14]);
        $display("[$t7] = 0x%H", test.registerFile.registers[15]);
        $display("----------------------------------------------------------");
        clock = ~clock;
        if (clock == 1'b1) begin
            i = i + 1;
        end
    end

endmodule