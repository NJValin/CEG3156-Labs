LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity BigALU is
	port (SignA, SignB, SignSel : in std_logic;
			Greater, Lesser : in std_logic_vector(8 downto 0);
			SignO, Cout: out std_logic;
			Outpt : out std_logic_vector(8 downto 0)
	);
End BigALU;

Architecture str of BigALU is

Signal SignLesser, SignGreater: std_logic;
Signal NLesser, NGreater, Nout, Final : std_logic_vector(11 downto 0);

Component Mux2x11Bit is
	port(S : in std_logic;
		  A, B : in std_logic;
		  O : out std_logic
	);
End Component;

Component Complementer12Bit is
	Port(Comp : in std_logic;
		  Inpt : in std_logic_vector(11 downto 0);
		  Outpt : out std_logic_vector(11 downto 0)
	);
End Component;

Component CLA12Bit is
	port(a : in std_logic_vector(11 downto 0);
        b : in std_logic_vector(11 downto 0);
        cin : in std_logic;
        s : out std_logic_vector(11 downto 0);
        cout : out std_logic
	);
End Component;

Begin

SignLess: mux2x11Bit
	port map(S => not SignSel,
				A => SignA,
				B => SignB,
				O => SignLesser
	);
	
SignGreat: mux2x11Bit
	port map(S => SignSel,
				A => SignA,
				B => SignB,
				O => SignGreater
	);
	
NotLess: Complementer12Bit
	port map(Comp => SignLesser and (SignA xor SignB),
				Inpt => "000" & Lesser,
				Outpt => NLesser
	);
	
NotGreat: Complementer12Bit
	port map(Comp => SignGreater and (SignA xor SignB),
				Inpt => "000" & Greater,
				Outpt => NGreater
	);
	
Adder : CLA12Bit
	port map(a => NGreater,
				b => NLesser,
				cin => '0',
				s => Nout
	);
	
NotNotAns: Complementer12Bit
	port map(Comp => Nout(9) and (SignA xor SignB),
				Inpt => Nout,
				Outpt => Final
	);
	
Cout <= Final(9);
SignO <= (Final(9) and (SignA xor SignB)) or (SignA and not (SignA xor SignB));
Outpt <= Final(8 downto 0);

End str;