library ieee;
use ieee.std_logic_1164.all;

entity RegisterFile_32_8bit_tb is
end entity;

architecture test of RegisterFile_32_8bit_tb is

	signal ReadReg1, ReadReg2 : STD_LOGIC_VECTOR(4 downto 0) := "00000";
	signal WriteReg :  STD_LOGIC_VECTOR(4 downto 0) :="00000";
	signal WriteData :  STD_LOGIC_VECTOR(7 downto 0) := "00000000";
	signal async_clr :  STD_LOGIC := '1';
	signal clk : STD_LOGIC := '0';
	signal RegWrite :  STD_LOGIC := '0'; --Control signal to allow writing do regfile
	signal ReadData1, ReadData2 :  STD_LOGIC_VECTOR(7 downto 0);

	--
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
		DUT : entity work.RegisterFile_32_8bit(struct)
			port map (
				ReadReg1, ReadReg2,
				WriteReg,
				WriteData,
				clk, async_clr,
				RegWrite,
				ReadData1, ReadData2);
		
		clk_gen(clk, 10 ns);
		Stimulus : process is
			begin
				wait for 500 ps;
				async_clr <='0';
				WriteData <= "00000001";
				WriteReg <= "00000";
				RegWrite <='1';
				wait for 10 ns;
				RegWrite <= '0';
				ReadReg1 <= "00000";
				assert ReadData1="00000001" report "Failed to read register 1" severity error;

				WriteData <= "00000010";
				WriteReg <= "00001";
				RegWrite <='1';
				wait for 10 ns;
				RegWrite <= '0';
				ReadReg2 <= "00001";

				wait for 390 ns;

		end process;
end test;
