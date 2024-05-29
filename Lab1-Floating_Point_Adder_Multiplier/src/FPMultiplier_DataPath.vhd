library ieee;
use ieee.std_logic_1164.all;
-----------------------------------------
--	Author : Neil Valin - 300236063
--			 Email : nvali069@uottawa.ca
--
-----------------------------------------
entity FPMultiplier_DataPath is
	port (
		SignA, SignB : in STD_LOGIC;
		MantissaA, MantissaB : in STD_LOGIC_VECTOR(7 downto 0);
		ExponentA, ExponentB : in STD_LOGIC_VECTOR(6 downto 0);
		GClock, GReset : in STD_LOGIC;
		-- Input control signals
		loadEA, loadEB, loadMA, loadMB, loadEP, loadpreMP, loadMP : in STD_LOGIC;
		incrementEP, enableMult, rounding, preMPShift : in STD_LOGIC;
		
		SignOut : out STD_LOGIC;
		MantissaOut : out STD_LOGIC_VECTOR(7 downto 0);
		ExponentOut : out STD_LOGIC_VECTOR(6 downto 0);
		Overflow : out STD_LOGIC :='0';
		-- Output control signals
		preMP_G, preMP_8, preMP_RS, normalized, multDone : out STD_LOGIC := '0');
end FPMultiplier_DataPath;

architecture struct of FPMultiplier_DataPath is
	signal expAout, expBout, EPin, int_ExponentOut, expAval, expBval, preBiasExp, finalExp, incrementedExp : STD_LOGIC_VECTOR(6 downto 0);
	signal multiplicandIn, multiplicandOut, multiplierOut, multiplierIn : STD_LOGIC_VECTOR(8 downto 0);
	signal preBiasV, incrementV : STD_LOGIC;
	signal multResult, preMPIn, preMPout, roundedUpProd : STD_LOGIC_VECTOR(17 downto 0);
	begin
		expA : entity work.GeneralPurposeRegister(struct)
			generic map (n=>7)
			port map (
				regIn=>ExponentA,
				clk=>GClock,
				shiftLeft=>'0', shiftRight=>'0',
				load=>loadEA, serialIn=>'0',
				asyncClr=>GReset, asyncSet=>'0',
				regOut=>expAout);
		
		expB : entity work.GeneralPurposeRegister(struct)
			generic map (n=>7)
			port map (
				regIn=>ExponentB,
				clk=>GClock,
				shiftLeft=>'0', shiftRight=>'0',
				load=>loadEB, serialIn=>'0',
				asyncClr=>GReset, asyncSet=>'0',
				regOut=>expBout);
		
		--Combinational logic for the Exponent calculation
		EAval : entity work.RippleAdder_nBit(struct) -- EA-63 to determine exponent value
			generic map (n=>7)
			port map (
				A=>expAout, B=>"0111111",
				sub=>'1',
				result=>expAval);
		
		EBval : entity work.RippleAdder_nBit(struct) -- EB-63 to determine exponent value
			generic map (n=>7)
			port map (
				A=>expBout, B=>"0111111",
				sub=>'1',
				result=>expBval);
		
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
				result=>finalExp);
		
		incrementAdder : entity work.RippleAdder_nBit(struct) -- Used to increment the exponent in re-normalization
			generic map (n=>7)
			port map (
				A=>"0000001", B=>int_ExponentOut,
				sub=>'0',
				result=>incrementedExp,
				V=>incrementV);
				
		expMux : entity work.nBit_2x1_Mux(struct)
			generic map (n=>7)
			port map (
				in0=>finalExp, in1=>incrementedExp,
				sel=>incrementEP,
				muxOut=>EPin);
		
		-- product Exponent
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
		
		-- Multiplicand (mantissa of A appended with a leading 1)
		multiplicandIn(8)<='1';
		multiplicandIn(7 downto 0) <= mantissaA;
		multiplicand : entity work.GeneralPurposeRegister(struct)
			generic map (n=>9)
			port map (
				regIn=>multiplicandIn,
				clk=>GClock,
				shiftLeft=>'0', shiftRight=>'0',
				load=>loadMA, serialIn=>'0',
				asyncClr=>GReset, asyncSet=>'0',
				regOut=>multiplicandOut);
		
		--Multiplier (mantissa of B appended with a leading 1)
		multiplierIn(8)<='1';
		multiplierIn(7 downto 0) <= mantissaB;
		multiplier : entity work.GeneralPurposeRegister(struct)
			generic map (n=>9)
			port map (
				regIn=>multiplierIn,
				clk=>GClock,
				shiftLeft=>'0', shiftRight=>'0',
				load=>loadMB, serialIn=>'0',
				asyncClr=>GReset, asyncSet=>'0',
				regOut=>multiplierOut);
		
		-- the 9 bit multiplier
		mult : entity work.Multiplier_nBit(struct)
			generic map (n=>9)
			port map (
				A=>multiplicandOut, B=>multiplierOut,
				clk=>GClock,
				startOperation=>enableMult,
				operationDone=>multDone,
				product=>multResult);
			
		roundUp : entity work.RippleAdder_nBit(struct)
			generic map (n=>18)
			port map (
				A=>"000000000100000000", B=>preMPout,
				sub=>'0',
				result=>roundedUpProd);
		
		mantissaMux : entity work.nBit_2x1_Mux(struct)
			generic map (n=>18)
			port map (
				in0=>multResult, in1=>roundedUpProd,
				sel=>rounding,
				muxOut=>preMPIn);
		
		preMP : entity work.GeneralPurposeRegister(struct)
			generic map (n=>18)
			port map (
				regIn=>preMPIn,
				clk=>GClock,
				shiftLeft=>'0', shiftRight=>preMPShift,
				load=>loadpreMP, serialIn=>'0',
				asyncClr=>GReset, asyncSet=>'0',
				regOut=>preMPout);
		
		-- Output control signals drivers
		preMP_G <= preMPout(7); -- Guard bit for rounding
		preMP_RS <= preMPout(6) or preMPout(5) or preMPout(4) or preMPout(3) or preMPout(2) or preMPout(1) or preMPout(0); -- the round bit preMP(6) and the the sticky bits 
		preMP_8 <= preMPout(8); -- lsb of the product's pre-rounding mantissa. Used for determining rounding action in a tie (G=1 R=0 S=0)
		
		comp : entity work.Comparator_nBit(struct) -- Determines if there is only a single leading 1 directly in front of the decimal point.
			generic map (n=>2)
			port map (
				A=>preMPout(17 downto 16), B=>"01",
				AEB=>normalized);
		
		productMantissa : entity work.GeneralPurposeRegister(struct)
			generic map (n=>8)
			port map (
				regIn=>preMPout(15 downto 8),
				clk=>GClock,
				shiftLeft=>'0', shiftRight=>preMPShift,
				load=>loadMP, serialIn=>'0',
				asyncClr=>GReset, asyncSet=>'0',
				regOut=>MantissaOut);
		-- Driving the SignOut output
		SignOut <= SignA xor SignB;
		-- Overflow detection
		Overflow<=preBiasV or incrementV;
end struct;