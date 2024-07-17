library ieee;
use ieee.std_logic_1164.all;

-----------------------------------------------------------------
--
--
--
--
-----------------------------------------------------------------
entity SignExtend_16_to_32Bit is
	port (
	input : in STD_LOGIC_VECTOR(15 downto 0);
	output : out STD_LOGIC_VECTOR(31 downto 0));
end entity;

architecture struct of SignExtend_16_to_32Bit is
	signal int_vec : STD_LOGIC_VECTOR(31 downto 0);
	begin
		int_vec(15 downto 0)<=input(15 downto 0);
		int_vec(16)<=input(15);
		int_vec(17)<=input(15);
		int_vec(18)<=input(15);
		int_vec(19)<=input(15);
		int_vec(20)<=input(15);
		int_vec(21)<=input(15);
		int_vec(22)<=input(15);
		int_vec(23)<=input(15);
		int_vec(24)<=input(15);
		int_vec(25)<=input(15);
		int_vec(26)<=input(15);
		int_vec(27)<=input(15);
		int_vec(28)<=input(15);
		int_vec(29)<=input(15);
		int_vec(30)<=input(15);
		int_vec(31)<=input(15);

		output<=int_vec;
end struct;
