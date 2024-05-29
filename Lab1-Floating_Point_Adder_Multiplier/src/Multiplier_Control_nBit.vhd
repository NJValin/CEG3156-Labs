library ieee;
use ieee.std_logic_1164.all;

entity Multiplier_Control_nBit is
	port (
		clk : in STD_LOGIC;
		startOperation : in STD_LOGIC;
		multiplicandZero, multiplicandLSB : in STD_LOGIC;
		multiplicandLoad, multiplierLoad : out STD_LOGIC :='0';
		multiplierShift, multiplicandShift : out STD_LOGIC:='0';
		productIntLoad, productLoad : out STD_LOGIC := '0';
		operationDone : out STD_LOGIC:='0';
		intS : out STD_LOGIC_VECTOR(5 downto 0));
end Multiplier_Control_nBit;

architecture struct of Multiplier_Control_nBit is
	
	signal s0, s1, s2, s3, s4, s5, sTemp  : STD_LOGIC;
	signal s1In, s2In, s3In, s4In, s5In, sTempIn : STD_LOGIC;
	
	begin
		S0_ff : entity work.D_ff(struct)
			port map (
				i_d=>'0',
				i_clk=>clk,
				i_clr=>'0', i_set=>startOperation,
				o_Q=>s0);
		
		sTempIn<=s0;
		STemp_ff : entity work.D_ff(struct)
			port map (
				i_d=>sTempIn,
				i_clk=>clk,
				i_clr=>startOperation, i_set=>'0',
				o_Q=>sTemp);
		
		s1In <= (sTemp and multiplicandLSB) or (s3 and (not multiplicandZero) and multiplicandLSB);
		S1_ff : entity work.D_ff(struct)
			port map (
				i_d=>s1In,
				i_clk=>clk,
				i_clr=>startOperation, i_set=>'0',
				o_Q=>s1);
		
		
		s2In <= (sTemp and (not multiplicandLSB)) or (s3 and (not multiplicandZero) and (not multiplicandLSB)) or s1;
		S2_ff : entity work.D_ff(struct)
			port map (
				i_d=>s2In,
				i_clk=>clk,
				i_clr=>startOperation, i_set=>'0',
				o_Q=>s2);
		s3In <=s2;
		s3_ff : entity work.D_ff(struct)
			port map (
				i_d=>s3In,
				i_clk=>clk,
				i_clr=>startOperation, i_set=>'0',
				o_Q=>s3);
				
		s4In <= s3 and multiplicandZero;
		s4_ff : entity work.D_ff(struct)
			port map (
				i_d=>s4In,
				i_clk=>clk,
				i_clr=>startOperation, i_set=>'0',
				o_Q=>s4);
		
		s5In <= s5 or s4;
		s5_ff : entity work.D_ff(struct)
			port map (
				i_d=>s5In,
				i_clk=>clk,
				i_clr=>startOperation, i_set=>'0',
				o_Q=>s5);
		
		multiplicandLoad <=s0;
		multiplierLoad <= s0;
		
		productIntLoad <= s1;
		
		multiplierShift <= s3;
		multiplicandShift <= s2;
		
		productLoad<= s4;
		operationDone <= s5;
		
		intS<= (0=>s0, 1=>s1,2=>s2, 3=>s3, 4=>s4, 5=>s5);
end struct;