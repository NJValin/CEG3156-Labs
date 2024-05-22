LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity Shifter18Bit is
	port(clk, res, en, Dir, Inpt : in std_logic;
		  D : in std_logic_vector(17 downto 0);
		  Q : out std_logic;
		  Outpt : out std_logic_vector(17 downto 0)
	);
End Shifter18Bit;

Architecture str of Shifter18Bit is

Component enardFF_2
	port(
		i_resetBar	: IN	STD_LOGIC;
		i_d		: IN	STD_LOGIC;
		i_enable	: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		o_q, o_qBar	: OUT	STD_LOGIC
	);
End Component;

Begin

D0 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (Inpt and (not Dir)) or (D(1) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(0));
		
D1 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(0) and (not Dir)) or (D(2) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(1));
		
D2 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(1) and (not Dir)) or (D(3) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(2));
		
D3 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(2) and (not Dir)) or (D(4) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(3));
		
D4 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(3) and (not Dir)) or (D(5) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(4));
		
D5 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(4) and (not Dir)) or (D(6) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(5));
		
D6 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(5) and (not Dir)) or (D(7) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(6));
		
D7 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(6) and (not Dir)) or (D(8) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(7));
		
D8 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(7) and (not Dir)) or (D(9) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(8));
		
D9 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(8) and (not Dir)) or (D(10) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(9));
		
D10 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(9) and (not Dir)) or (D(11) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(10));
		
D11 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(10) and (not Dir)) or (D(12) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(11));
		
D12 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(11) and (not Dir)) or (D(13) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(12));
		
D13 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(12) and (not Dir)) or (D(14) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(13));
		
D14 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(13) and (not Dir)) or (D(15) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(14));
		
D15 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(14) and (not Dir)) or (D(16) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(15));
		
D16 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(15) and (not Dir)) or (D(17) and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(16));
		
D17 : enardFF_2
	port map(
		i_resetBar => res,
		i_d => (D(16) and (not Dir)) or (Inpt and Dir),
		i_enable => en,
		i_clock => clk,
		o_q => Outpt(17));

Q <= (D(17) and (not Dir)) or (D(0) and Dir);

End str;
		
		