library ieee;
use ieee.std_logic_1164.all;

entity FourOneMultiplex is
	port (
		in3, in2, in1, in0 : in std_logic;
		sel1, sel0 : in std_logic;
		muxOut : out std_logic);
end FourOneMultiplex;

architecture struct of FourOneMultiplex is
	signal intA, intB, intC, intD : STD_LOGIC;
	begin
		intA <= in3 and sel1 and sel0;
		intB <= in2 and sel1 and (not sel0);
		intC <= in1 and (not sel1) and sel0;
		intD <= in0 and (not sel1) and (not sel0);
		
		muxOut <= intA or intB or intC or intD;
end architecture;
	