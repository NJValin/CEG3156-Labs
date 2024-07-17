library ieee;
use ieee.std_logic_1164.all;

entity D_ff is 
	port (
		i_d, i_clk, i_clr, i_set : in STD_LOGIC;
		o_Q, o_Qbar : out STD_LOGIC);
end D_ff;

architecture struct of D_ff is 
	signal intA, intS, intR, intB, clrBar, setBar, intQ, intQbar : STD_LOGIC;
	begin
		--intermediate signals
		clrBar <= not i_clr;
		setBar <= not i_set;
		intA <= not(setBar and intS and intB);
		intS <= not (intA and i_clk and clrBar);
		intR <= not(intS and i_clk and intB);
		intB <= not(intR and i_d and clrBar);
		
		
		
		intQ <= not(setBar and intS and intQbar);
		intQbar <= not(intQ and intR and clrBar);
		--Output driver
		o_Q <= intQ;
		o_Qbar <= intQbar;
		
end architecture struct;