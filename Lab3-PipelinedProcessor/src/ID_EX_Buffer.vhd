library ieee;
use ieee.std_logic_1164.all;

entity ID_EX_Buffer is
	port (
		i_A, i_B, i_Addr : in STD_LOGIC_VECTOR(7 downto 0);
		i_Rs, i_Rt, i_Rd : in STD_LOGIC_VECTOR(4 downto 0);
		i_instruction : in STD_LOGIC_VECTOR(31 downto 0);
		i_clk, i_clr : in STD_LOGIC;
		o_A, o_B, o_Addr: out STD_LOGIC_VECTOR(7 downto 0);
		o_Rs, o_Rt, o_Rd : out STD_LOGIC_VECTOR(4 downto 0);
		o_instruction : out STD_LOGIC_VECTOR(31 downto 0));
end ID_EX_Buffer;

architecture struct of ID_EX_Buffer is 
	begin
		A : entity work.GeneralPurposeRegister(struct)
			generic map (8)
			port map (
				regIn=>i_A,
				clk=>i_clk,
				load=>'1',
				asyncClr=>i_clr,
				regOut=>o_A);

		B : entity work.GeneralPurposeRegister(struct)
			generic map (8)
			port map (
				regIn=>i_B,
				clk=>i_clk,
				load=>'1',
				asyncClr=>i_clr,
				regOut=>o_B);


		Addr : entity work.GeneralPurposeRegister(struct)
			generic map (8)
			port map (
				regIn=>i_Addr,
				clk=>i_clk,
				load=>'1',
				asyncClr=>i_clr,
				regOut=>o_Addr);

		Rs : entity work.GeneralPurposeRegister(struct)
			generic map (5)
			port map (
				regIn=>i_Rs,
				clk=>i_clk,
				load=>'1',
				asyncClr=>i_clr,
				regOut=>o_Rs);

		Rt : entity work.GeneralPurposeRegister(struct)
			generic map (5)
			port map (
				regIn=>i_Rt,
				clk=>i_clk,
				load=>'1',
				asyncClr=>i_clr,
				regOut=>o_Rt);

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
