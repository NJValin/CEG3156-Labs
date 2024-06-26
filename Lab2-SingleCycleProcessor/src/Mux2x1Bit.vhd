library ieee;
USE ieee.std_logic_1164.ALL;

Entity Mux2x1Bit is
	port(S : in std_logic;
		  A, B : in std_logic;
		  O : out std_logic
	);
End Mux2x1Bit;

Architecture str of Mux2x1Bit is

Begin

O <= (A and (not S)) or (B and S);

End str;