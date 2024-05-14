library ieee;
use ieee.std_logic_1164.all;

entity encoder is 
	port (
	in3, in2, in1, in0 : in STD_LOGIC;
	out1, out0 : out STD_LOGIC);
end encoder;

architecture struct of encoder is 
	signal int_out1, int_out0 : STD_LOGIC;
	begin
		int_out1<=in3 or in2;
		int_out0<=in1 or in3;
		out1<=int_out1;
		out0<=int_out0;
end struct;