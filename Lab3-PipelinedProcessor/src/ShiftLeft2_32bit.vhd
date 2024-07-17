library ieee;
use ieee.std_logic_1164.all;

entity ShiftLeft2_32bit is
	port (
	input : in STD_LOGIC_VECTOR(31 downto 0);
	output : out STD_LOGIC_VECTOR(31 downto 0));
end entity;

architecture struct of ShiftLeft2_32bit is 
	begin
		output(31 downto 2)<=input(29 downto 0);
		output(1 downto 0)<="00";
end struct;
