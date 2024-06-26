library ieee;
use ieee.std_logic_1164.all;

entity Mux_32x1 is
	port (
		in0, in1, in2, in3, in4,in5, in6, in7, in8 : in STD_LOGIC;
		in9, in10, in11, in12, in13,in14, in15, in16, in17 : in STD_LOGIC;
		in18, in19, in20, in21, in22,in23, in24, in25, in26 : in STD_LOGIC;
		in27, in28, in29, in30, in31 : in STD_LOGIC;
		sel : in STD_LOGIC_VECTOR(4 downto 0);
		MuxOut : out STD_LOGIC);
end entity;

architecture struct of Mux_32x1 is
	signal int_products : STD_LOGIC_VECTOR(31 downto 0);
	begin
		int_products(31)<=in31 and sel(4) and sel(3) and sel(2) and sel(1) and sel(0);
		int_products(30)<=in30 and sel(4) and sel(3) and sel(2) and sel(1) and not sel(0);
		int_products(29)<=in29 and sel(4) and sel(3) and sel(2) and not sel(1) and sel(0);
		int_products(28)<=in28 and sel(4) and sel(3) and sel(2) and not sel(1) and not sel(0);
		int_products(27)<=in27 and sel(4) and sel(3) and not sel(2) and sel(1) and sel(0);
		int_products(26)<=in26 and sel(4) and sel(3) and not sel(2) and sel(1) and not sel(0);
		int_products(25)<=in25 and sel(4) and sel(3) and not sel(2) and not sel(1) and sel(0);
		int_products(24)<=in24 and sel(4) and sel(3) and not sel(2) and not sel(1) and not sel(0);
		int_products(23)<=in23 and sel(4) and not sel(3) and sel(2) and sel(1) and sel(0);
		int_products(22)<=in22 and sel(4) and not sel(3) and sel(2) and sel(1) and not sel(0);
		int_products(21)<=in21 and sel(4) and not sel(3) and sel(2) and not sel(1) and sel(0);
		int_products(20)<=in20 and sel(4) and not sel(3) and sel(2) and not sel(1) and not sel(0);
		int_products(19)<=in19 and sel(4) and not sel(3) and not sel(2) and sel(1) and sel(0);
		int_products(18)<=in18 and sel(4) and not sel(3) and not sel(2) and sel(1) and not sel(0);
		int_products(17)<=in17 and sel(4) and not sel(3) and not sel(2) and not sel(1) and sel(0);
		int_products(16)<=in16 and sel(4) and not sel(3) and not sel(2) and not sel(1) and not sel(0);
		int_products(15)<=in15 and not sel(4) and sel(3) and sel(2) and sel(1) and sel(0);
		int_products(14)<=in14 and not sel(4) and sel(3) and sel(2) and sel(1) and not sel(0);
		int_products(13)<=in13 and not sel(4) and sel(3) and sel(2) and not sel(1) and sel(0);
		int_products(12)<=in12 and not sel(4) and sel(3) and sel(2) and not sel(1) and not sel(0);
		int_products(11)<=in11 and not sel(4) and sel(3) and not sel(2) and sel(1) and sel(0);
		int_products(10)<=in10 and not sel(4) and sel(3) and not sel(2) and sel(1) and not sel(0);
		int_products(9) <=in9 and not sel(4) and sel(3) and not sel(2) and not sel(1) and sel(0);
		int_products(8) <=in8 and not sel(4) and sel(3) and not sel(2) and not sel(1) and not sel(0);
		int_products(7) <=in7 and not sel(4) and not sel(3) and sel(2) and sel(1) and sel(0);
		int_products(6) <=in6 and not sel(4) and not sel(3) and sel(2) and sel(1) and not sel(0);
		int_products(5) <=in5 and not sel(4) and not sel(3) and sel(2) and not sel(1) and sel(0);
		int_products(4) <=in4 and not sel(4) and not sel(3) and sel(2) and not sel(1) and not sel(0);
		int_products(3) <=in3 and not sel(4) and not sel(3) and not sel(2) and sel(1) and sel(0);
		int_products(2) <=in2 and not sel(4) and not sel(3) and not sel(2) and sel(1) and not sel(0);
		int_products(1) <=in1 and not sel(4) and not sel(3) and not sel(2) and not sel(1) and sel(0);
		int_products(0) <=in0 and not sel(4) and not sel(3) and not sel(2) and not sel(1) and not sel(0);
		
		MuxOut<= int_products(31) or int_products(30) or int_products(29) or int_products(28) or int_products(27) or int_products(26) or int_products(25) or int_products(24) or int_products(23) or int_products(22) or int_products(21) or int_products(20) or int_products(19) or int_products(18) or int_products(17) or int_products(16) or int_products(15) or int_products(14) or int_products(13) or int_products(12) or int_products(11) or int_products(10) or int_products(9) or int_products(8) or int_products(7) or int_products(6) or int_products(5) or int_products(4) or int_products(3) or int_products(2) or int_products(1) or int_products(0); 
end struct;
