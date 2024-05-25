library ieee;
use ieee.std_logic_1164.all;

entity Comparator_nBit is
	generic (
		n : integer := 8);
	port (
		A, B : in STD_LOGIC_VECTOR(n-1 downto 0);
		AEB, ALTB, AGTB : out STD_LOGIC);--AEB := A equals B; ALB:=A less than B; AGB := A greater than B
end Comparator_nBit;

architecture struct of Comparator_nBit is
	signal i, u, temp : STD_LOGIC_VECTOR(n-1 downto 0);
	signal intAEB, intAGTB : STD_LOGIC;
	begin
		i <= not (A xor B); --XNOR of each
		
		temp(0) <= i(0);
		gen: for k in 1 to n-1 generate
			temp(k)<=i(k) and temp(k-1);
		end generate gen;
		AEB <= temp(n-1);
end struct;
		