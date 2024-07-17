library ieee;
use ieee.std_logic_1164.all;

entity IF_ID_Buffer is
	port (
		i_PCincr : in STD_LOGIC_VECTOR(7 downto 0);
		i_instruction : in STD_LOGIC_VECTOR(31 downto 0);
		i_load : in STD_LOGIC;
		i_clk, i_clr : in STD_LOGIC;
		o_PCincr : out STD_LOGIC_VECTOR(7 downto 0);
		o_instruction : out STD_LOGIC_VECTOR(31 downto 0));
end IF_ID_Buffer;

architecture struct of IF_ID_Buffer is 
	begin
		PCIncr : entity work.GeneralPurposeRegister(struct)
			generic map (8)
			port map (
				regIn=>i_PCincr,
				clk=>i_clk,
				load=>i_load,
				asyncClr=>i_clr,
				regOut=>o_PCincr);

		instruction : entity work.GeneralPurposeRegister(struct)
			generic map (32)
			port map (
				regIn=>i_instruction,
				clk=>i_clk,
				load=>i_load,
				asyncClr=>i_clr,
				regOut=>o_instruction);
end struct;
