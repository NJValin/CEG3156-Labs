library ieee;
use ieee.std_logic_1164.all;

entity Mux8x1_nBit is 
	generic (
		n : integer := 8);
	port (
		in7, in6, in5, in4, in3, in2, in1, in0 : in STD_LOGIC_VECTOR(n-1 downto 0) := (0=>'0', others=>'0');
		sel : in STD_LOGIC_VECTOR(2 downto 0);
		MuxOut : out STD_LOGIC_VECTOR(n-1 downto 0));
end entity;

architecture struct of Mux8x1_nBit is
	
	begin
		gen: for i in 0 to n-1 generate
			ithMux : entity work.Mux8x1(struct)
				port map (
					in7(i), in6(i), in5(i), in4(i), in3(i), in2(i), in1(i), in0(i),
					sel,
					MuxOut(i));
		end generate gen;

end struct;

