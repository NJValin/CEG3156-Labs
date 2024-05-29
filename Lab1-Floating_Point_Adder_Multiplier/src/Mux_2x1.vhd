library ieee;
use ieee.std_logic_1164.all;

entity Mux_2x1 is
	port(
	in0, in1 : in STD_LOGIC;
	sel : in STD_LOGIC;
	muxOut : out STD_LOGIC);
end Mux_2x1;

architecture struct of Mux_2x1 is
	signal out1, out0 : STD_LOGIC;
	begin
		out1 <= in1 and sel;
		out0 <= in0 and (not sel);
		muxOut <= out1 or out0;
end struct;