library ieee;
use ieee.std_logic_1164.all;

entity RegisterFile_32_8bit is
	port (
	ReadReg1, ReadReg2 : in STD_LOGIC_VECTOR(4 downto 0);
	WriteReg : in STD_LOGIC_VECTOR(4 downto 0);
	WriteData : in STD_LOGIC_VECTOR(7 downto 0);
	clk, async_clr : in STD_LOGIC;
	RegWrite : in STD_LOGIC; --Control signal to allow writing do regfile
	ReadData1, ReadData2 : out STD_LOGIC_VECTOR(7 downto 0));
end entity;

architecture struct of RegisterFile_32_8bit is
	-- 32 8-bit inputs to multiplexer
	signal muxIn0, muxIn1, muxIn2, muxIn3, muxIn4, muxIn5, muxIn6, muxIn7, muxIn8 : STD_LOGIC_VECTOR(7 downto 0);
	signal muxIn9, muxIn10, muxIn11, muxIn12, muxIn13, muxIn14, muxIn15, muxIn16 : STD_LOGIC_VECTOR(7 downto 0);
	signal muxIn17, muxIn18, muxIn19, muxIn20, muxIn21, muxIn22, muxIn23, muxIn24 : STD_LOGIC_VECTOR(7 downto 0);
	signal muxIn25, muxIn26, muxIn27, muxIn28, muxIn29, muxIn30, muxIn31 : STD_LOGIC_VECTOR(7 downto 0);


	signal enableRegSelect : STD_LOGIC_VECTOR(31 downto 0);
	begin
		Decoder : entity work.decoder_5x32(struct)
			port map (
			input=>WriteReg,
			en=>'1',
			output=>enableRegSelect);

			Reg1 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(0) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn0);
			
			Reg2 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(1) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn1);

			Reg3 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(2) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn2);

			Reg4 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(3) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn3);

			Reg5 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(4) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn4);

			Reg6 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(5) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn5);

			Reg7 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(6) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn6);

			Reg8 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(7) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn7);

			Reg9 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(8) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn8);

			Reg10 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(9) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn9);

			Reg11 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(10) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn10);

			Reg12 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(11) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn11);

			Reg13 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(12) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn12);

			Reg14 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(13) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn13);

			Reg15 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(14) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn14);

			Reg16 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(15) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn15);

			Reg17 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(16) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn16);

			Reg18 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(17) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn17);

			Reg19 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(18) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn18);

			Reg20 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(19) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn19);

			Reg21 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(20) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn20);

			Reg22 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(21) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn21);

			Reg23 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(22) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn22);

			Reg24 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(23) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn23);

			Reg25 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(24) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn24);

			Reg26 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(25) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn25);

			Reg27 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(26) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn26);

			Reg28 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(27) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn27);

			Reg29 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(28) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn28);

			Reg30 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(29) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn29);

			Reg31 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(30) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn30);

			Reg32 : entity work.GeneralPurposeRegister(struct)
				generic map (8)
				port map(
				regIn=>WriteData,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>(enableRegSelect(31) and RegWrite), serialIn=>'0',
				asyncClr=>async_clr, asyncSet=>'0',
				regOut=>muxIn31);

			Mux1 : entity work.Mux_32x1_nBit(struct)
				port map (
					muxIn0, muxIn1, muxIn2, muxIn3, muxIn4, muxIn5, 
					muxIn6, muxIn7, muxIn8, muxIn9, muxIn10, muxIn11, 
					muxIn12, muxIn13, muxIn14, muxIn15, muxIn16, muxIn17, 
					muxIn18, muxIn19, muxIn20, muxIn21, muxIn22, muxIn23, 
					muxIn24, muxIn25, muxIn26, muxIn27, muxIn28, muxIn29, 
					muxIn30, muxIn31, 
					ReadReg1,
					ReadData1);
			
			Mux2 : entity work.Mux_32x1_nBit(struct)
				port map (
					muxIn0, muxIn1, muxIn2, muxIn3, muxIn4, muxIn5, 
					muxIn6, muxIn7, muxIn8, muxIn9, muxIn10, muxIn11, 
					muxIn12, muxIn13, muxIn14, muxIn15, muxIn16, muxIn17, 
					muxIn18, muxIn19, muxIn20, muxIn21, muxIn22, muxIn23, 
					muxIn24, muxIn25, muxIn26, muxIn27, muxIn28, muxIn29, 
					muxIn30, muxIn31, 
					ReadReg2,
					ReadData2);
end struct;
