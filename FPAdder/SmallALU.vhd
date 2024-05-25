LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity SmallALU is
	port(clk, en, res : in std_logic;
		  A, B, Exponent : in std_logic_vector(7 downto 0);
		  ctrl: out std_logic;
		  Lesser, Greater : out std_logic_vector(8 downto 0)
	);
End SmallALU;

Architecture str of SmallALU is

Signal Z, Shift, Sel : std_logic;
Signal Less, Great, Shiftnum, ShiftedLess, PreShiftedLess, NextBit, Final : std_logic_vector(7 downto 0);


Component Mux2x18Bit is
	port(S : in std_logic;
		  A, B : in std_logic_vector(7 downto 0);
		  O : out std_logic_vector(7 downto 0)
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

Component Shifter8Bit is
	port(clk, res, en, Dir, Inpt : in std_logic;
		  D : in std_logic_vector(7 downto 0);
		  Q : out std_logic;
		  Outpt : out std_logic_vector(7 downto 0)
	);
End Component;

Begin

GreaterMantissa : mux2x18Bit
	port map (S => Exponent(7),
				A => A,
				B => B,
				O => Great
	);
				
LesserMantissa : mux2x18Bit
	port map (S => not Exponent(7),
				A => A,
				B => B,
				O => Less
	);

ShiftCounter: Counter8Bit
	port map (i_load => not Shift and en,
				i_resetBar => not res,
				i_clock => clk,
				o_Value => shiftnum
	);

Selecter: Comparator8Bit
	port map (A => shiftnum,
				B => "00000001",
				Equal => Sel
	);

SelectShifter: mux2x18Bit
	port map (S => Sel,
				A => Less,
				B => ShiftedLess,
				O => PreShiftedLess
	);
	
FullyShifted: Comparator8Bit
	port map (A => shiftnum,
				B => '0' & exponent(6 downto 0),
				Equal => Shift
	);
	
Ctrl <= Shift;

Shifter : Shifter8Bit
	port map (clk => clk,
				res => not res,
				en => not shift and en,
				D => PreShiftedLess,
				Inpt => not Sel,
				Dir => '1',
				Outpt => ShiftedLess
	);

Z <= not(Exponent(7) or Exponent(6) or Exponent(5) or Exponent(4) or Exponent(3) or Exponent(2) or Exponent(1) or Exponent(0));

ResultSelect: mux2x18Bit
	port map(S => Z,
				A => ShiftedLess,
				B => Less,
				O => Final
	);

Lesser <=  (Z and '1') & Final;
Greater <= '1' & Great;

End str;