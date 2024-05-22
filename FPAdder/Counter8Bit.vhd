LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity Counter8Bit is
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0));
END Counter8Bit;

Architecture str of Counter8Bit is

Signal outpt : std_logic_vector(3 downto 0);
Signal tot : std_logic_vector(3 downto 0);

Component Counter4Bit is
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(3 downto 0));
		
End Component;

Begin

c1 : Counter4Bit
	port map(
		i_resetBar => i_resetBar,
		i_clock => i_clock,
		i_load => i_load,
		o_value => tot
	);

c2 : Counter4Bit
	port map(
		i_resetBar => i_resetBar,
		i_clock => i_clock,
		i_load => (tot(0) and tot(1) and tot(2) and tot(3) and i_load),
		o_value => outpt
	);

o_Value(0) <= tot(0);
o_Value(1) <= tot(1);
o_Value(2) <= tot(2);
o_Value(3) <= tot(3);
o_Value(4) <= outpt(0);
o_Value(5) <= outpt(1);
o_Value(6) <= outpt(2);
o_Value(7) <= outpt(3);
	
End str;