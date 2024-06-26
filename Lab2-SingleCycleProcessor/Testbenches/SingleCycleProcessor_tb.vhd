library ieee;
use ieee.std_logic_1164.all;

entity SingleCycleProcessor_tb is
end entity;

architecture test of SingleCycleProcessor_tb is
	signal ValueSelect : STD_LOGIC_VECTOR(2 downto 0) :="000";
	signal GClock : STD_LOGIC :='0';
	signal GReset : STD_LOGIC :='1';
	signal MuxOut : STD_LOGIC_VECTOR(7 downto 0);
	signal InstructionOut : STD_LOGIC_VECTOR(31 downto 0);
	signal BranchOut, ZeroOut, MemWriteOut, RegWriteOut : STD_LOGIC :='0';

		-- Procedure for generating the clock
	procedure clk_gen(signal clk : out STD_LOGIC; constant PERIOD : time) is
			  constant HighTime : time := PERIOD/2;
			  constant LowTime : time := PERIOD/2;
		begin
			assert (HighTime /= 0 fs) report "High time is 0" severity FAILURE;
			loop
				clk<='0';
				wait for LowTime;
				clk<='1';
				wait for HighTime;
			end loop;
	end procedure;

	begin
		DUT : entity work.SingleCycleProcessor(struct)
			port map (
				ValueSelect,
				GClock, GReset,
				MuxOut,
				InstructionOut,
				BranchOut, ZeroOut, MemWriteOut, RegWriteOut);

		--test clock 10 MHz
		clk_gen(GClock, 100 ns);

		--Stimulus
		process is 
			begin
				wait for 2 ns;
				GReset<='0';
				ValueSelect<="010";
				wait for 3098 ns;
		end process;
end test;
