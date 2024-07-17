library ieee;
use ieee.std_logic_1164.all;

entity Mux_32x1_nBit is
	generic (n : integer :=8);
	port (
		in0, in1, in2, in3, in4,in5, in6, in7, in8 : in STD_LOGIC_VECTOR(n-1 downto 0) := (0=>'0', others=>'0');
		in9, in10, in11, in12, in13,in14, in15, in16, in17 : in STD_LOGIC_VECTOR(n-1 downto 0) := (0=>'0', others=>'0');
		in18, in19, in20, in21, in22,in23, in24, in25, in26 : in STD_LOGIC_VECTOR(n-1 downto 0) := (0=>'0', others=>'0');
		in27, in28, in29, in30, in31 : in STD_LOGIC_VECTOR(n-1 downto 0) := (0=>'0', others=>'0');
		sel : in STD_LOGIC_VECTOR(4 downto 0);
		MuxOut : out STD_LOGIC_VECTOR(n-1 downto 0));
end entity;

architecture struct of Mux_32x1_nBit is
	begin
		loop1 : for i in 0 to n-1 generate
			MuxI : entity work.Mux_32x1(struct)
				port map (
				in0(i), in1(i), in2(i), in3(i), in4(i),in5(i), in6(i), in7(i), in8(i),
				in9(i), in10(i), in11(i), in12(i), in13(i),in14(i), in15(i), in16(i), in17(i), 
				in18(i), in19(i), in20(i), in21(i), in22(i),in23(i), in24(i), in25(i), in26(i),
				in27(i), in28(i), in29(i), in30(i), in31(i),
				sel,
				MuxOut(i));
		end generate;
end struct;
