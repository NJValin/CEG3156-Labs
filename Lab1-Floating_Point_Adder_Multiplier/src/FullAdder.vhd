library ieee;
use ieee.std_logic_1164.all;

entity FullAdder is
	port (
	A, B, Cin : in STD_LOGIC;
	SUM, Cout : out STD_LOGIC);
end entity;

architecture struc of FullAdder is
	begin
	SUM <=Cin xor (A xor B);
	Cout <= (Cin and (A xor B)) or (A and B);
end architecture;