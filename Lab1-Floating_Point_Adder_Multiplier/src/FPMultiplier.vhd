library ieee;
use ieee.std_logic_1164.all;

entity FPMultiplier is
	port (
		GClock, GReset : in STD_LOGIC;
		SignA : in STD_LOGIC;
		MantissaA : in STD_LOGIC_VECTOR(7 downto 0);
		ExponentA : in STD_LOGIC_VECTOR(6 downto 0);
		SignB : in STD_LOGIC;
		MantissaB : in STD_LOGIC_VECTOR(7 downto 0);
		ExponentB : in STD_LOGIC_VECTOR(6 downto 0);
		SignOut : out STD_LOGIC;
		MantissaOut : out STD_LOGIC_VECTOR(7 downto 0);
		ExponentOut : out STD_LOGIC_VECTOR(6 downto 0);
		V : out STD_LOGIC;
		int_loadEA, int_loadEB, int_loadMA, int_loadMB, int_loadEP, int_loadpreMP, int_loadMP : out STD_LOGIC;
		int_incrementEP, int_enableMult, int_rounding, int_preMPShift : out STD_LOGIC;
		int_preMP_G, int_preMP_8, int_preMP_RS, int_normalized, int_multDone : out STD_LOGIC);
end FPMultiplier;

architecture struct of FPMultiplier is
	signal loadEA, loadEB, loadMA, loadMB, loadEP, loadpreMP, loadMP : STD_LOGIC;
	signal incrementEP, enableMult, rounding, preMPShift : STD_LOGIC;
	signal preMP_G, preMP_8, preMP_RS, normalized, multDone : STD_LOGIC;
	begin
	
	dataPath : entity work.FPMultiplier_DataPath(struct)
		port map (
			SignA=>SignA, SignB=>SignB,
			MantissaA=>MantissaA, MantissaB=>MantissaB,
			ExponentA=>ExponentA, ExponentB=>ExponentB,
			GClock=>GClock, GReset=>GReset,
			-- Input control signals
			loadEA=>loadEA, loadEB=>loadEB, loadMA=>loadMA, loadMB=>loadMB, loadEP=>loadEP, loadpreMP=>loadpreMP, loadMP=>loadMP,
			incrementEP=>incrementEP, enableMult=>enableMult, rounding=>rounding, preMPShift=>preMPShift,
			
			SignOut=>SignOut,
			MantissaOut=>MantissaOut,
			ExponentOut=>ExponentOut,
			Overflow=>V,
			-- Output control signals
			preMP_G=>preMP_G, preMP_8=>preMP_8, preMP_RS=>preMP_RS, normalized=>normalized, multDone=>multDone);
	int_loadEA<=loadEA;
	int_loadEB<=loadEB;
	int_loadMA<=loadMA;
	int_loadMB<=loadMB;
	int_loadEP<=loadEP;
	int_loadpreMP<=loadpreMP;
	int_loadMP<=loadMP;
	int_incrementEP<=incrementEP;
	int_enableMult<=enableMult;
	int_rounding<=rounding;
	int_preMPShift<=preMPShift;
	int_preMP_G<=preMP_G;
	int_preMP_8<=preMP_8;
	int_preMP_RS<=preMP_RS;
	int_normalized<=normalized;
	int_multDone<=multDone;
	
	
	controlUnit : entity work.FPMultiplier_ControlPath(struct)
		port map (
			clk=>GClock,
			reset=>GReset,
			-- Input control signals
			multDone=>multDone, normalized=>normalized, preMP_G=>preMP_G, preMP_RS=>preMP_RS, preMP_8=>preMP_8,
			-- Output control
			loadEA=>loadEA, loadEB=>loadEB, loadMA=>loadMA, loadMB=>loadMB, loadEP=>loadEP, loadPreMP=>loadPreMP, loadMP=>loadMP,
			preMPShift=>preMPShift, startMult=>enableMult,
			incrementEP=>incrementEP, rounding=>rounding);
	
	
end struct;