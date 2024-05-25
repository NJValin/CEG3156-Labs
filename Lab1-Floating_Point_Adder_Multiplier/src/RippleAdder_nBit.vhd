library ieee;
use ieee.std_logic_1164.all;

entity RippleAdder_nBit is
	generic (
		n : integer := 8);
	port (
		A, B : in STD_LOGIC_VECTOR(n-1 downto 0);
		sub : in STD_LOGIC;
		result : out STD_LOGIC_VECTOR(n-1 downto 0);
		V : out STD_LOGIC :='0');
end RippleAdder_nBit;

architecture struct of RippleAdder_nBit is
	signal carryOuts, Binput : STD_LOGIC_VECTOR(n-1 downto 0);
	
	component FullAdder is
		port (
			A, B, Cin : in STD_LOGIC;
			SUM, Cout : out STD_LOGIC);
	end component;
	begin
		Binput(0) <= B(0) xor sub;
		adder0 : FullAdder
			port map (
				A=>A(0), B=>Binput(0),
				Cin=>sub,
				SUM=>result(0),
				Cout=>carryOuts(0));
				
		loop1: for i in 1 to n-1 generate
			Binput(i)<= B(i) xor sub;
			adderX : FullAdder
				port map (
					A=>A(i), B=>Binput(i), Cin=>carryOuts(i-1),
					SUM=>result(i),
					Cout=>carryOuts(i));
		end generate loop1;
		
		V<=carryOuts(n-1) xor carryOuts(n-2);
end struct;