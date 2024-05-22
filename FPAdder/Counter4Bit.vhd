LIBRARY ieee;
USE ieee.std_logic_1164.all;

Entity Counter4Bit is
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(3 downto 0));
END Counter4Bit;

Architecture str of Counter4Bit is

Signal outpt : std_logic_vector(1 downto 0);
Signal tot : std_logic_vector(1 downto 0);

Component counter is
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(1 downto 0));
		
End Component;

Begin

c1 : counter
	port map(
		i_resetBar => i_resetBar,
		i_clock => i_clock,
		i_load => i_load,
		o_value => tot
	);

c2 : counter
	port map(
		i_resetBar => i_resetBar,
		i_clock => i_clock,
		i_load => (tot(0) and tot(1) and i_load),
		o_value => outpt
	);

o_Value(0) <= tot(0);
o_Value(1) <= tot(1);
o_Value(2) <= outpt(0);
o_Value(3) <= outpt(1);
	
End str;