LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity ALU1Bit is
	port (A, B, Binvert, Cin, Less : in std_logic;
			Op : in std_logic_vector(2 downto 0);
			Cout, F, Set, Ovf : out std_logic
	);
End ALU1Bit;

Architecture str of ALU1Bit is

Signal Adder, Mux, TCout, TCin : std_logic;

Component Mux4x1Bit is
	port (A, B, C, D : in std_logic;
			M : in std_logic_vector(1 downto 0);
			O : out std_logic
	);
End Component;
	
Component Mux2x1Bit is
	port(S : in std_logic;
		  A, B : in std_logic;
		  O : out std_logic
	);
End Component;
	
Component FullAdder1Bit is
	port(A, B, cin : in std_logic;
		  S, cout: out std_logic
	);
End Component;
	
Begin

Bsel: Mux2x1Bit
	Port map(S => Binvert,
				A => B,
				B => not B,
				O => Mux
	);

Ad: FullAdder1Bit
	Port map(A => A,
				B => Mux,
				cin => Cin,
				S => Adder,
				cout => TCout
	);
	
Fsel: Mux4x1Bit
	Port map(A => A and B,
				B => A or B,
				C => Adder,
				D => Less,
				M => Op(1 downto 0),
				O => F
	);

Cout <= TCout;
Set <= Adder;
Ovf <= cin xor TCout;

End str;