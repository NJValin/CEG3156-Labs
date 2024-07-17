LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity Mux4x1Bit is
	Port (A, B, C, D : in std_logic;
			M : in std_logic_vector(1 downto 0);
			O : out std_logic
	);
End Mux4x1Bit;

Architecture str of Mux4x1Bit is

Begin

O <= (A and (not M(1)) and (not M(0))) or (B and (not M(1)) and ( M(0))) or (C and (M(1)) and (not M(0)))  or (D and (M(1)) and (M(0)));

End str;