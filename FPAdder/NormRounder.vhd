LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity NormRounder is
	port (clk, en, res, cin : in std_logic;
			E : in std_logic_vector(6 downto 0);
			M : in std_logic_vector(17 downto 0);
			FlagO: out std_logic;
			Eout : out std_logic_vector(6 downto 0);
			Mout : out std_logic_vector(7 downto 0)
	);
End NormRounder;

Architecture str of NormRounder is

	Signal Flag, Z, Equal : std_logic;
	Signal Shift, FinalE : std_logic_vector(7 downto 0);
	Signal Shifted, PreShifted, FinalM : std_logic_vector(17 downto 0);
	
Component Mux2x118Bit is
	port(S : in std_logic;
		  A, B : in std_logic_vector(17 downto 0);
		  O : out std_logic_vector(17 downto 0)
	);
End Component;

Component Shifter18Bit is
	port(clk, res, en, Dir, Inpt : in std_logic;
		  D : in std_logic_vector(17 downto 0);
		  Q : out std_logic;
		  Outpt : out std_logic_vector(17 downto 0)
	);
End Component;

Component Counter8Bit is
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0)
	);
End Component;

Component Comparator8Bit is
	port(A, B : in std_logic_vector(7 downto 0);
		  Greater, Equal : out std_logic
	);
End Component;

Component SignedFullAdder8Bit is
	port(A, B : in std_logic_vector(7 downto 0);
		  cin : in std_logic;
		  S : out std_logic_vector(7 downto 0);
		  cout : out std_logic
	);
End Component;

Begin

Z <= not(cin or M(17) or M(16) or M(15) or M(14) or M(13) or M(12) or M(11) or M(10) or M(9) or M(8)or M(7) or M(6) or M(5) or M(4)or M(3) or M(2) or M(1) or M(0));

Flag <= Z or (Equal and cin) or ((Shifted(17) or M(17)) and not cin);

SelShift: Mux2x118Bit
	port map(S => Equal,
				A => M,
				B => Shifted,
				O => PreShifted
	);
	
Shifter: Shifter18Bit
	port map(clk => clk,
				res => not res,
				en => en and not flag,
				Dir => Cin,
				Inpt => Cin,
				D => PreShifted,
				Outpt => Shifted
	);

ShiftCount : Counter8Bit
	port map(i_load => not Flag and en,
				i_resetBar => not res,
				i_clock => clk,
				o_value => shift
	);
	
CountComparer: Comparator8Bit
	port map(A => shift,
				B => "00000001",
				Equal => Equal
	);
	
Adder: SignedFullAdder8Bit
	port map(A => '0' & E,
				B =>	shift,
				cin => not Cin,
				S => FinalE
	);

SelFinal: Mux2x118Bit
	port map(S => Equal,
				A => M,
				B => Shifted,
				O => FinalM
	);

Eout <= FinalE(6 downto 0);
Mout <= FinalM(16 downto 9);
FlagO <= Flag;

End str;

