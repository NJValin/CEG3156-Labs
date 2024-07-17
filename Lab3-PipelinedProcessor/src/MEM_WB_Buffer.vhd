library ieee;
use ieee.std_logic_1164.all;

entity MEM_WB_Buffer is
	port (
		i_Result : in STD_LOGIC_VECTOR(7 downto 0);
		i_Data : in STD_LOGIC_VECTOR(7 downto 0);
		i_Rd : in STD_LOGIC_VECTOR(4 downto 0);
		i_instruction : in STD_LOGIC_VECTOR(31 downto 0);
		i_clk, i_clr : in STD_LOGIC;
		o_Result : out STD_LOGIC_VECTOR(7 downto 0);
		o_Data : out STD_LOGIC_VECTOR(7 downto 0);
		o_Rd : out STD_LOGIC_VECTOR(4 downto 0);
		o_instruction : out STD_LOGIC_VECTOR(31 downto 0));
end MEM_WB_Buffer;

architecture struct of MEM_WB_Buffer is 
	begin
		Result :  entity work.GeneralPurposeRegister(struct)
			generic map (8)
			port map (
				regIn=>i_Result,
				clk=>i_clk,
				load=>'1',
				asyncClr=>i_clr,
				regOut=>o_Result);


		Data : entity work.GeneralPurposeRegister(struct)
			generic map (8)
			port map (
				regIn=>i_Data,
				clk=>i_clk,
				load=>'1',
				asyncClr=>i_clr,
				regOut=>o_Data);

		Rd : entity work.GeneralPurposeRegister(struct)
			generic map (5)
			port map (
				regIn=>i_Rd,
				clk=>i_clk,
				load=>'1',
				asyncClr=>i_clr,
				regOut=>o_Rd);

		instruction : entity work.GeneralPurposeRegister(struct)
			generic map (32)
			port map (
				regIn=>i_instruction,
				clk=>i_clk,
				load=>'1',
				asyncClr=>i_clr,
				regOut=>o_instruction);

end struct;
