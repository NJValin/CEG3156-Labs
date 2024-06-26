library ieee;
use ieee.std_logic_1164.all;

entity decoder_5x32 is 
	port (
		input : in STD_LOGIC_VECTOR(4 downto 0);
		en : in STD_LOGIC;
		output : out STD_LOGIC_VECTOR(31 downto 0) := (others=>'0'));
end entity;

architecture struct of decoder_5x32 is
	
	begin
		output(31) <= input(4) and input(3) and input(2) and input(1) and input(0) and en;
		output(30) <= input(4) and input(3) and input(2) and input(1) and (not input(0)) and en;
		output(29) <= input(4) and input(3) and input(2) and (not input(1)) and input(0) and en;
		output(28) <= input(4) and input(3) and input(2) and (not input(1)) and not input(0) and en;
		output(27) <= input(4) and input(3) and not input(2) and input(1) and input(0) and en;
		output(26) <= input(4) and input(3) and not input(2) and input(1) and not input(0) and en;
		output(25) <= input(4) and input(3) and not input(2) and not input(1) and input(0) and en;
		output(24) <= input(4) and input(3) and not input(2) and not input(1) and not input(0) and en;
		output(23) <= input(4) and not input(3) and input(2) and input(1) and input(0) and en;
		output(22) <= input(4) and not input(3) and input(2) and input(1) and (not input(0)) and en;
		output(21) <= input(4) and not input(3) and input(2) and (not input(1)) and input(0) and en;
		output(20) <= input(4) and not input(3) and input(2) and (not input(1)) and not input(0) and en;
		output(19) <= input(4) and not input(3) and not input(2) and input(1) and input(0) and en;
		output(18) <= input(4) and not input(3) and not input(2) and input(1) and not input(0) and en;
		output(17) <= input(4) and not input(3) and not input(2) and not input(1) and input(0) and en;
		output(16) <= input(4) and not input(3) and not input(2) and not input(1) and not input(0) and en;
		output(15) <= not input(4) and input(3) and input(2) and input(1) and input(0) and en;
		output(14) <= not input(4) and input(3) and input(2) and input(1) and (not input(0)) and en;
		output(13) <= not input(4) and input(3) and input(2) and (not input(1)) and input(0) and en;
		output(12) <= not input(4) and input(3) and input(2) and (not input(1)) and not input(0) and en;
		output(11) <= not input(4) and input(3) and not input(2) and input(1) and input(0) and en;
		output(10) <= not input(4) and input(3) and not input(2) and input(1) and not input(0) and en;
		output(9) <= not input(4) and input(3) and not input(2) and not input(1) and input(0) and en;
		output(8) <= not input(4) and input(3) and not input(2) and not input(1) and not input(0) and en;
		output(7) <= not input(4) and not input(3) and input(2) and input(1) and input(0) and en;
		output(6) <= not input(4) and not input(3) and input(2) and input(1) and (not input(0)) and en;
		output(5) <= not input(4) and not input(3) and input(2) and (not input(1)) and input(0) and en;
		output(4) <= not input(4) and not input(3) and input(2) and (not input(1)) and not input(0) and en;
		output(3) <= not input(4) and not input(3) and not input(2) and input(1) and input(0) and en;
		output(2) <= not input(4) and not input(3) and not input(2) and input(1) and not input(0) and en;
		output(1) <= not input(4) and not input(3) and not input(2) and not input(1) and input(0) and en;
		output(0) <= not input(4) and not input(3) and not input(2) and not input(1) and not input(0) and en;
end struct;