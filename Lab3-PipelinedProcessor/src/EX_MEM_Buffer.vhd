library ieee;
use ieee.std_logic_1164.all;

entity EX_MEM_Buffer is
	port (
		i_Result : in STD_LOGIC_VECTOR(7 downto 0);
		i_DataAddress : in STD_LOGIC_VECTOR(7 downto 0);
		i_Data : in STD_LOGIC_VECTOR(7 downto 0);
		i_Rd : in STD_LOGIC_VECTOR(4 downto 0);
		i_instruction : in STD_LOGIC_VECTOR(31 downto 0);
		i_clk, i_clr : in STD_LOGIC;
		o_Result : out STD_LOGIC_VECTOR(7 downto 0);
		o_DataAddress : out STD_LOGIC_VECTOR(7 downto 0);
		o_Data : out STD_LOGIC_VECTOR(7 downto 0);
		o_Rd : out STD_LOGIC_VECTOR(4 downto 0);
		o_instruction : out STD_LOGIC_VECTOR(31 downto 0));
end EX_MEM_Buffer;

architecture struct of EX_MEM_Buffer is 
	begin
		Result :  entity work.GeneralPurposeRegister(struct)
			generic map (8)
			port map (
				regIn=>i_Result,
				clk=>i_clk,
				load=>'1',
				asyncClr=>i_clr,
				regOut=>o_Result);

		DataAddress : entity work.GeneralPurposeRegister(struct)
			generic map (8)
			port map (
				regIn=>i_DataAddress,
				clk=>i_clk,
				load=>'1',
				asyncClr=>i_clr,
				regOut=>o_DataAddress);


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
