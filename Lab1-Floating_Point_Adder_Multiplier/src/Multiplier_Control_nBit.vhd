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
		operationDone : out STD_LOGIC:='0');
end Multiplier_Control_nBit;

architecture struct of Multiplier_Control_nBit is
	
	signal s0, s1, s2, s3, s4 : STD_LOGIC;
	signal s1In, s2In, s3In, s4In : STD_LOGIC;
	
	begin
		S0_ff : entity work.D_ff(struct)
			port map (
				i_d=>'0',
				i_clk=>clk,
				i_clr=>'0', i_set=>startOperation,
				o_Q=>s0);
		
		s1In <= (s0 and multiplicandLSB) or (s2 and (not multiplicandZero) and multiplicandLSB);
		S1_ff : entity work.D_ff(struct)
			port map (
				i_d=>s1In,
				i_clk=>clk,
				i_clr=>startOperation, i_set=>'0',
				o_Q=>s1);
		
		s2In <= (s0 and (not multiplicandLSB)) or (s2 and (not multiplicandZero) and (not multiplicandLSB)) or s1;
		S2_ff : entity work.D_ff(struct)
			port map (
				i_d=>s2In,
				i_clk=>clk,
				i_clr=>startOperation, i_set=>'0',
				o_Q=>s2);
		
		s3In <= s2 and multiplicandZero;
		S3_ff : entity work.D_ff(struct)
			port map (
				i_d=>s3In,
				i_clk=>clk,
				i_clr=>startOperation, i_set=>'0',
				o_Q=>s3);
		
		s4In <= s4 or s3;
		S4_ff : entity work.D_ff(struct)
			port map (
				i_d=>s4In,
				i_clk=>clk,
				i_clr=>startOperation, i_set=>'0',
				o_Q=>s4);
		
		multiplicandLoad <=s0;
		multiplierLoad <= s0;
		
		productIntLoad <= s1;
		
		multiplierShift <= s2;
		multiplicandShift <= s2;
		
		productLoad<= s3;
		operationDone <= s4;
end struct;