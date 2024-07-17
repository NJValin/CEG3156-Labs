LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity ALU8Bit is
	Port (A, B : in std_logic_vector(7 downto 0);
			Operation : in std_logic_vector(2 downto 0);
			ALUResult : out std_logic_vector(7 downto 0);
			Zero, Overflow : out std_logic
	);
End ALU8Bit;

Architecture str of ALU8Bit is

Signal Result, ResN, subl, preres : std_logic_vector(7 downto 0);
Signal Carry : std_logic_vector(3 downto 0);
Signal stl, tempovf, sub : std_logic;

Component ALU1Bit is
	port (A, B, Binvert, Cin, Less : in std_logic;
			Op : in std_logic_vector(2 downto 0);
			Cout, F, Set, Ovf : out std_logic
	);
End Component;

Component ALU4Bit is
	port (Binvert, Cin, Less : in std_logic;
			A, B : in std_logic_vector(3 downto 0);
			Op : in std_logic_vector(2 downto 0);
			F : out std_logic_vector(3 downto 0);
			Cout, Set, Ovf : out std_logic
	);
End Component;

Begin

A0: ALU1Bit
	Port Map(A => A(0),
				B => B(0),
				Cin => '0',
				Binvert => Operation(2),
				Less => stl,
				Op => Operation,
				F => Result(0),
				Cout => Carry(0)
	);
	
A1: ALU1Bit
	Port Map(A => A(1),
				B => B(1),
				Cin => Carry(0),
				Binvert => Operation(2),
				Less => '0',
				Op => Operation,
				F => Result(1),
				Cout => Carry(1)
	);
	
A5: ALU4Bit
	Port Map(A => A(5 downto 2),
				B => B(5 downto 2),
				Cin => Carry(1),
				Binvert => Operation(2),
				Less => '0',
				Op => Operation,
				F => Result(5 downto 2),
				Cout => Carry(2)
	);
	
A6: ALU1Bit
	Port Map(A => A(6),
				B => B(6),
				Cin => Carry(2),
				Binvert => Operation(2),
				Less => '0',
				Op => Operation,
				F => Result(6),
				Cout => Carry(3)
	);
	
A31: ALU1Bit
	Port Map(A => A(7),
				B => B(7),
				Cin => Carry(3),
				Binvert => Operation(2),
				Less => '0',
				Op => Operation,
				F => Result(7),
				Set => stl,
				Ovf => tempovf
	);
	

ResN <= not Result;
sub <= Operation(2) and Operation(1) and not Operation(0);

subl(0) <= sub;
subl(1) <= sub;
subl(2) <= sub;
subl(3) <= sub;
subl(4) <= sub;
subl(5) <= sub;
subl(6) <= sub;
subl(7) <= sub;

Overflow <= tempovf and Operation(1);
preres <= (ResN and subl) or (Result and not subl);
Zero <= not(preres(0) or preres(1) or preres(2) or preres(3) or preres(4) or preres(5) or preres(6) or preres(7));
ALUResult <= preres;

End str;
	