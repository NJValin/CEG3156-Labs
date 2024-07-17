library ieee;
use ieee.std_logic_1164.all;

entity Mux4x1_nBit is
	generic (n:integer:=8);
	port (
		in3, in2, in1, in0 : in STD_LOGIC_VECTOR(n-1 downto 0);
		sel : in STD_LOGIC_VECTOR(1 downto 0);
		output : out STD_LOGIC_VECTOR(n-1 downto 0));
end Mux4x1_nBit;

architecture struct of Mux4x1_nBit is
	begin
		MuxGen : for i in 0 to n-1 generate
			Muxi : entity work.Mux4x1Bit(str)
				port map (
					A=>in0(i), B=>in1(i), C=>in2(i), D=>in3(i),
					M=>sel,
					O=>output(i));
		end generate;
end struct;

