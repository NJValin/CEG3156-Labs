LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity FloatingPointAdder is
	Port(SignA, SignB, GClock, GReset : in std_logic;
		  MantissaA, MantissaB : in std_logic_vector(7 downto 0);
		  ExponentA, ExponentB : in std_logic_vector(6 downto 0);
		  SignOut, Overflow : out std_logic;
		  MantissaOut : out std_logic_vector(7 downto 0);
		  ExponentOut : out std_logic_vector(6 downto 0)
	);
End FloatingPointAdder;

Architecture str of FloatingPointAdder is

Signal done, Cout : std_logic;
Signal Difference, PreExp : std_logic_vector(7 downto 0);
Signal Lesser, Greater, PreNorm : std_logic_vector(8 downto 0);


Component SignedFullAdder8Bit is
	port(A, B : in std_logic_vector(7 downto 0);
		  cin : in std_logic;
		  S : out std_logic_vector(7 downto 0);
		  cout : out std_logic
	);
End Component;

Component SmallALU is
	port(clk, en, res : in std_logic;
		  A, B, Exponent : in std_logic_vector(7 downto 0);
		  ctrl: out std_logic;
		  Lesser, Greater : out std_logic_vector(8 downto 0)
	);
End Component;

Component BigALU is
	port (SignA, SignB, SignSel : in std_logic;
			Greater, Lesser : in std_logic_vector(8 downto 0);
			SignO, Cout: out std_logic;
			Outpt : out std_logic_vector(8 downto 0)
	);
End Component;

Component Mux2x18Bit is
	port(S : in std_logic;
		  A, B : in std_logic_vector(7 downto 0);
		  O : out std_logic_vector(7 downto 0)
	);
End Component;

Component NormRounder is
	port (clk, en, res, cin : in std_logic;
			E : in std_logic_vector(6 downto 0);
			M : in std_logic_vector(17 downto 0);
			FlagO: out std_logic;
			Eout : out std_logic_vector(6 downto 0);
			Mout : out std_logic_vector(7 downto 0)
	);
End Component;

Begin

ExponentCalc: SignedFullAdder8Bit
	port map(A => '0' & ExponentA,
				B => '0' & ExponentB,
				cin => '1',
				S => Difference
	);
	
Shifter: SmallALU
	port map(clk => GClock,
				en => '1',
				res => GReset,
				A => MantissaA,
				B => MantissaB,
				Exponent => Difference,
				ctrl => done,
				Lesser => Lesser,
				Greater => Greater
	);

	
Calc: BigALU
	port map(SignA => SignA,
				SignB => SignB,
				SignSel => Difference(7),
				Greater => Greater,
				Lesser => Lesser,
				SignO => SignOut,
				Cout => Cout,
				Outpt => PreNorm
	);
	
Ans: Mux2x18Bit
	port map(S => Difference(7),
				A => '0' & ExponentA,
				B => '0' & ExponentB,
				O => PreExp
	);
	
Normalize: NormRounder
	port map(clk => GClock,
				en => done,
				res => GReset,
				cin => Cout,
				E => PreExp(6 downto 0),
				M => PreNorm & "000000000",
				Eout => ExponentOut,
				Mout => MantissaOut
	);
	
Overflow <= '0';
	
End str;