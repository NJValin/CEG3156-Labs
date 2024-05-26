library ieee;
use ieee.std_logic_1164.all;

entity FPMultiplier_DataPath is
	port (
		SignA, SignB : in STD_LOGIC;
		MantissaA, MantissaB : in STD_LOGIC_VECTOR(7 downto 0);
		ExponentA, ExponentB : in STD_LOGIC_VECTOR(6 downto 0),
		GClock, GReset : in STD_LOGIC;
		-- Input control signals
		loadMA, loadMB, loadEP, loadpreMP, loadMP : in STD_LOGIC;
		
		SignOut : out STD_LOGIC;
		MantissaOut : out STD_LOGIC_VECTOR(7 downto 0);
		ExponentOut : out STD_LOGIC_VECTOR(6 downto 0);
		Overflow : out STD_LOGIC;
		-- Output control signals
		preMP_G, preMP_8, normalized : out STD_LOGIC);
end FPMultiplier_DataPath;

architecture struct of FPMultiplier_DataPath is
	signal EPin, int_ExponentOut, expAval, expBval, preBiasExp, finalExp : STD_LOGIC_VECTOR(6 downto 0);
	signal EAvalV, EBvalV,preBiasV, finalExpV : STD_LOGIC;
	begin
		--Combinational logic for the Exponent calculation
		EAval : entity work.RippleAdder_nBit(struct) -- EA-63 to determine exponent value
			generic map (n=>7)
			port map (
				A=>ExponentA, B=>"0111111",
				sub=>'1',
				result=>expAval,
				V=>EAvalV);
		
		EBval : entity work.RippleAdder_nBit(struct) -- EB-63 to determine exponent value
			generic map (n=>7)
			port map (
				A=>ExponentB, B=>"0111111",
				sub=>'1',
				result=>expBval,
				V=>EBvalV);
		preBiasVal : entity work.RippleAdder_nBit(struct) -- (EA-63)+(EB-63)
			generic map (n=>7)
			port map (
				A=>expAval, B=>expBval,
				sub=>'0',
				result=>preBiasExp,
				V=>preBiasV);
		
		finalExpCalc : entity work.RippleAdder_nBit(struct) -- (EA-63)+(EB-63)+63
			generic map (n=>7)
			port map (
				A=>preBiasExp, B=>"0111111",
				sub=>'0',
				result=>finalExp,
				V=>finalExpV);
		
		EP : entity work.GeneralPurposeRegister(struct)
			generic map (n=>7)
			port map (
				regIn=>EPin,
				clk=>GClock,
				shiftLeft=>'0', shiftRight=>'0',
				load=>loadEP, serialIn=>'0',
				asyncClr=>GReset, asyncSet=>'0',
				regOut=>int_ExponentOut);
				ExponentOut<=int_ExponentOut;
	
		
		-- Overflow detection
		Overflow<=EAvalV or EBvalV or preBiasV or finalExpV;
end struct;