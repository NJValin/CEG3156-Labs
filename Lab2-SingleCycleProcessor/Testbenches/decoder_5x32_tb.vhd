library ieee;
use ieee.std_logic_1164.all;

entity decoder_5x32_tb is
end entity;

architecture test of decoder_5x32_tb is
	signal input : STD_LOGIC_VECTOR(4 downto 0);
	signal en : STD_LOGIC := '1';
	signal output : STD_LOGIC_VECTOR(31 downto 0);
	begin
		DUT : entity work.decoder_5x32(struct)
			port map (
				input,
				en,
				output);
		process is
			begin
				input <= "00000";
				wait for 2 ns;
				assert output="00000000000000000000000000000001" report "00000" severity error;
				wait for 10 ns;

				input <= "00001";
				wait for 2 ns;
				assert output="00000000000000000000000000000010" report "00001" severity error;
				wait for 10 ns;

				input <="00010";
				wait for 2 ns;
				assert output="00000000000000000000000000000100" report "00010" severity error;
				wait for 10 ns;

				input <="00011";
				wait for 2 ns;
				assert output="00000000000000000000000000001000" report "00011" severity error;
				wait for 10 ns;

				input <="00100";
				wait for 2 ns;
				assert output="00000000000000000000000000010000" report "00100" severity error;
				wait for 10 ns;

				input <="00101";
				wait for 2 ns;
				assert output="00000000000000000000000000100000" report "00101" severity error;
				wait for 10 ns;

				input <="00110";
				wait for 2 ns;
				assert output="00000000000000000000000001000000" report "00110" severity error;
				wait for 10 ns;

				input <="00111";
				wait for 2 ns;
				assert output="00000000000000000000000010000000" report "00111" severity error;
				wait for 10 ns;

				input <="01000";
				wait for 2 ns;
				assert output="00000000000000000000000100000000" report "01000" severity error;
				wait for 10 ns;

				input <="01001";
				wait for 2 ns;
				assert output="00000000000000000000001000000000" report "01001" severity error;
				wait for 10 ns;

				input <="01010";
				wait for 2 ns;
				assert output="00000000000000000000010000000000" report "01010" severity error;
				wait for 10 ns;

				input <="01011";
				wait for 2 ns;
				assert output="00000000000000000000100000000000" report "01011" severity error;
				wait for 10 ns;

				input <="01100";
				wait for 2 ns;
				assert output="00000000000000000001000000000000" report "01100" severity error;
				wait for 10 ns;

				input <="01101";
				wait for 2 ns;
				assert output="00000000000000000010000000000000" report "01101" severity error;
				wait for 10 ns;
				
				input <="01110";
				wait for 2 ns;
				assert output="00000000000000000100000000000000" report "01110" severity error;
				wait for 10 ns;

				input <="01111";
				wait for 2 ns;
				assert output="00000000000000001000000000000000" report "01111" severity error;
				wait for 10 ns;

				input <="10000";
				wait for 2 ns;
				assert output="00000000000000010000000000000000" report "10000" severity error;
				wait for 10 ns;

				input <="10001";
				wait for 2 ns;
				assert output="00000000000000100000000000000000" report "10001" severity error;
				wait for 10 ns;

				input <="10010";
				wait for 2 ns;
				assert output="00000000000001000000000000000000" report "10010" severity error;
				wait for 10 ns;

				input <="10011";
				wait for 2 ns;
				assert output="00000000000010000000000000000000" report "10011" severity error;
				wait for 10 ns;

				input <="10100";
				wait for 2 ns;
				assert output="00000000000100000000000000000000" report "10100" severity error;
				wait for 10 ns;

				input <="10101";
				wait for 2 ns;
				assert output="00000000001000000000000000000000" report "10100" severity error;
				wait for 10 ns;

				input <="10110";
				wait for 2 ns;
				assert output="00000000010000000000000000000000" report "10101" severity error;
				wait for 10 ns;

				input <="10111";
				wait for 2 ns;
				assert output="00000000100000000000000000000000" report "10110" severity error;
				wait for 10 ns;

				input <="11000";
				wait for 2 ns;
				assert output="00000001000000000000000000000000" report "10111" severity error;
				wait for 10 ns;

				input <="11001";
				wait for 2 ns;
				assert output="00000010000000000000000000000000" report "11000" severity error;
				wait for 10 ns;

				input <="11010";
				wait for 2 ns;
				assert output="00000100000000000000000000000000" report "11001" severity error;
				wait for 10 ns;

				input <="11011";
				wait for 2 ns;
				assert output="00001000000000000000000000000000" report "11010" severity error;
				wait for 10 ns;

				input <="11100";
				wait for 2 ns;
				assert output="00010000000000000000000000000000" report "11011" severity error;
				wait for 10 ns;

				input <="11101";
				wait for 2 ns;
				assert output="00100000000000000000000000000000" report "11100" severity error;
				wait for 10 ns;

				input <="11110";
				wait for 2 ns;
				assert output="01000000000000000000000000000000" report "11101" severity error;
				wait for 10 ns;

				input <="11111";
				wait for 2 ns;
				assert output="10000000000000000000000000000000" report "11110" severity error;
				wait for 10 ns;
				
				report "Test Passed" severity note;
		end process;
end test;
