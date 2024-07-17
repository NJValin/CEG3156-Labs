library ieee;
use ieee.std_logic_1164.all;

entity Mux2x1_nBit is
	generic (n:integer:=8);
	port (
		in1, in0 : in STD_LOGIC_VECTOR(n-1 downto 0);
		sel : in STD_LOGIC;
		output : out STD_LOGIC_VECTOR(n-1 downto 0));
end Mux2x1_nBit;

architecture struct of Mux2x1_nBit is
	begin
		MuxGen : for i in 0 to n-1 generate
			Muxi : entity work.Mux2x1bit(str)
				port map (
					sel,
					A=>in0(i), B=>in1(i),
					O=>output(i));
		end generate;
end struct;