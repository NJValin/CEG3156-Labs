LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity FullAdder1Bit is
	port(A, B, cin : in std_logic;
		  S, cout: out std_logic
	);
	
End FullAdder1Bit;

Architecture str of FullAdder1Bit is

Begin

S <= A xor B xor cin;

cout <= (a and b) or (a and cin) or (b and cin);

End str;