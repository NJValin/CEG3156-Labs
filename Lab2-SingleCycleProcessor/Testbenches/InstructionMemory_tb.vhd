library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity InstructionMemory_tb is
end entity;

architecture test of InstructionMemory_tb is
	signal Address : STD_LOGIC_VECTOR(7 downto 0):="00000000";
	signal CurrentInstruction : STD_LOGIC_VECTOR(31 downto 0);
	signal clk : STD_LOGIC :='0';
	
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
	clk_gen(clk, 10 ns);
	DUT : entity work.InstructionMemory(SYN)
		port map (
			address=>Address,
			clken=>'0',
			q=>CurrentInstruction);
	
	stimulus : process is 
		begin
			wait for 10 ns;
			Address <="00000001";
			wait for 10 ns;
			Address <="00000010";
			wait for 10 ns;
			Address <="00000011";
			wait for 10 ns;
			Address <="00000100";
			wait for 10 ns;
			Address <="00000101";
			wait for 10 ns;
			Address <="00000110";
			wait for 10 ns;
			Address <="00000111";
			wait for 230 ns;
	end process;
end test;
