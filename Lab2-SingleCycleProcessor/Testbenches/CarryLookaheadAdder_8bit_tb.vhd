library ieee;
use ieee.std_logic_1164.all;

entity CarryLookaheadAdder_8bit_tb is
end entity;

architecture test of CarryLookaheadAdder_8bit_tb is
	signal A, B, Sum : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
	signal sub: STD_LOGIC := '0';
	signal V : STD_LOGIC;
	signal intSub, intB : STD_LOGIC_VECTOR(7 downto 0);
	begin

	DUT : entity work.CarryLookaheadAdder_8Bit(struct)
		port map (
		A, B,
		sub,
		V,
		Sum);

		stimulus : process is
		begin

			A<="00101110";
			B<="10111010";
			wait for 4 ns;
			assert Sum="11101000" report "Failed on 11101000"  severity error;
			assert V='0' report "Detecting overflow" severity error;
			wait for 16 ns;

			A<="10110011";
			B<="10100011";
			wait for 4 ns;
			assert sum = "01010110" report "Failed on 01010110" severity error;
			assert V='1' report "Failed to detect overflow" severity error;

			report "Testbench done" severity note;
			wait for 400 ns;
			
			


		end process;
end test;
