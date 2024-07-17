library ieee;
use ieee.std_logic_1164.all;

entity Mux8x1 is 
	port (
		in7, in6, in5, in4, in3, in2, in1, in0 : in STD_LOGIC;
		sel : in STD_LOGIC_VECTOR(2 downto 0);
		MuxOut : out STD_LOGIC);
end entity;

architecture struct of Mux8x1 is
	signal int_i : STD_LOGIC_VECTOR(7 downto 0);
	begin
		int_i(0)<= in0 and (not sel(2)) and (not sel(1)) and (not sel(0));
		int_i(1)<= in1 and (not sel(2)) and (not sel(1)) and (sel(0));
		int_i(2)<= in2 and (not sel(2)) and (sel(1)) and (not sel(0));
		int_i(3)<= in3 and (not sel(2)) and (sel(1)) and (sel(0));
		int_i(4)<= in4 and (sel(2)) and (not sel(1)) and (not sel(0));
		int_i(5)<= in5 and (sel(2)) and (not sel(1)) and (sel(0));
		int_i(6)<= in6 and (sel(2)) and (sel(1)) and (not sel(0));
		int_i(7)<= in7 and (sel(2)) and (sel(1)) and (sel(0));
		
		MuxOut <= int_i(0) or int_i(1) or int_i(2) or int_i(3) or int_i(4) or int_i(5) or int_i(6) or int_i(7);
	
end struct;
