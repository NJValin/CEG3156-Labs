library ieee;
use ieee.std_logic_1164.all;

entity FPMultiplier_ControlPath is
	port (
		clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		-- Input control signals
		multDone, normalized, preMP_G, preMP_RS, preMP_8 : in STD_LOGIC;
		-- Output control
		loadEA, loadEB, loadMA, loadMB, loadEP, loadPreMP, loadMP : out STD_LOGIC :='0';
		preMPShift, startMult : out STD_LOGIC := '0';
		incrementEP, rounding : out STD_LOGIC :='0');
end FPMultiplier_ControlPath;

architecture struct of FPMultiplier_ControlPath is
	signal s0, s1, s2, s3, s4, s5, s6, sTemp, sTemp2 : STD_LOGIC :='0';
	signal inS0, inS1, inS2, inS3, inS4, inS5, inS6, inStemp, inSTemp2 : STD_LOGIC :='0';
	signal intInS6, intInS4 : STD_LOGIC;
	begin
	
	inS0<='0';
	S0_ff : entity work.D_ff(struct)
		port map (
			i_d=>inS0,
			i_clk=>clk, i_clr=>'0', i_set=>reset,
			o_Q=>s0);
	
	inS1<=s0;
	S1_ff : entity work.D_ff(struct)
		port map (
			i_d=>inS1,
			i_clk=>clk, i_clr=>reset, i_set=>'0',
			o_Q=>s1);
	
	inStemp<=s1 or (inStemp and (not multDone));
	STemp_ff : entity work.D_ff(struct)
		port map (
			i_d=>inStemp,
			i_clk=>clk, i_clr=>reset, i_set=>'0',
			o_Q=>sTemp);
	
	inS2<=sTemp and multDone;
	S2_ff : entity work.D_ff(struct)
		port map (
			i_d=>inS2,
			i_clk=>clk, i_clr=>reset, i_set=>'0',
			o_Q=>s2);
	inSTemp2<=s2 or s3;
	STemp2_ff : entity work.D_ff(struct)
		port map (
			i_d=>inSTemp2,
			i_clk=>clk, i_clr=>reset, i_set=>'0',
			o_Q=>sTemp2);
	
	inS3<=(not normalized) and sTemp2;
	S3_ff : entity work.D_ff(struct)
		port map (
			i_d=>inS3,
			i_clk=>clk, i_clr=>reset, i_set=>'0',
			o_Q=>s3);
			
	intInS4<= (s3 and normalized and preMP_G and preMP_RS) or (s3 and normalized and preMP_G and (not preMP_RS) and preMP_8); 
	inS4<= (sTemp2 and normalized and preMP_G and preMP_RS) or (sTemp2 and normalized and preMP_G and (not preMP_RS) and preMP_8) or intInS4;
	S4_ff : entity work.D_ff(struct)
		port map (
			i_d=>inS4,
			i_clk=>clk, i_clr=>reset, i_set=>'0',
			o_Q=>s4);
	
	inS5<= s4 and (not normalized);
	S5_ff : entity work.D_ff(struct)
		port map (
			i_d=>inS5,
			i_clk=>clk, i_clr=>reset, i_set=>'0',
			o_Q=>s5);
			
	intInS6 <= (sTemp2 and normalized and preMP_G and (not preMP_RS) and (not preMP_8)) or (s3 and normalized and preMP_G and (not preMP_RS) and (not preMP_8));
	inS6<= (sTemp2 and normalized and (not preMP_G)) or (s3 and normalized and (not preMP_G)) or intInS6 or (s4 and normalized) or (s5 and normalized);  
	S6_ff : entity work.D_ff(struct)
		port map (
		i_d=>inS6,
		i_clk=>clk, i_clr=>reset, i_set=>'0',
		o_Q=>s6);
	
	
	loadEA <= s0;
	loadEB <= s0;
	
	loadMA<= s0;
	loadMB<= s0;
	loadEP<= s1 or s3 or s5;
	startMult<= s1;
	
	loadPreMP<= s2 or s4;
	
	preMPShift<= s3 or s5;
	incrementEP<=s3 or s5;
	
	rounding<= s4;
	
	loadMP<= s6;
end struct;