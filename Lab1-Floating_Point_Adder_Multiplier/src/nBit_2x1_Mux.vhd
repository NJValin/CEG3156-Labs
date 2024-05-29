library ieee;
use ieee.std_logic_1164.all;

entity nBit_2x1_Mux is
	generic (
		n : integer := 8);
	port (
		in0, in1 : in STD_LOGIC_VECTOR(n-1 downto 0);
		sel : in STD_LOGIC;
		muxOut : out STD_LOGIC_VECTOR(n-1 downto 0));
end nBit_2x1_Mux;

architecture struct of nBit_2x1_Mux is
	
	begin
		genLoop : for i in 0 to n-1 generate
			Mux_i : entity work.Mux_2x1(struct)
				port map (
					in0=>in0(i), in1=>in1(i),
					sel=>sel,
					muxOut=>muxOut(i));
		end generate;
end struct;