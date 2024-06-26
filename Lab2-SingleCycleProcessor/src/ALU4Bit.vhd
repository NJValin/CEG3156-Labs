LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity ALU4Bit is
	port (Binvert, Cin, Less : in std_logic;
			A, B : in std_logic_vector(3 downto 0);
			Op : in std_logic_vector(2 downto 0);
			F : out std_logic_vector(3 downto 0);
			Cout, Set, Ovf : out std_logic
	);
End ALU4Bit;

Architecture str of ALU4Bit is

Signal Carry : std_logic_vector(3 downto 0);

Component ALU1Bit is
	port (A, B, Binvert, Cin, Less : in std_logic;
			Op : in std_logic_vector(2 downto 0);
			Cout, F, Set, Ovf : out std_logic
	);
End Component;

Begin

A0: ALU1Bit
	Port Map(A => A(0),
				B => B(0),
				Cin => Cin,
				Binvert => Binvert,
				Less => Less,
				Op => Op,
				F => F(0),
				Cout => Carry(0)
	);
	
A1: ALU1Bit
	Port Map(A => A(1),
				B => B(1),
				Cin => Carry(0),
				Binvert => Binvert,
				Less => Less,
				Op => Op,
				F => F(1),
				Cout => Carry(1)
	);
	
A2: ALU1Bit
	Port Map(A => A(2),
				B => B(2),
				Cin => Carry(1),
				Binvert => Binvert,
				Less => Less,
				Op => Op,
				F => F(2),
				Cout => Carry(2)
	);
	
A3: ALU1Bit
	Port Map(A => A(3),
				B => B(3),
				Cin => Carry(2),
				Binvert => Binvert,
				Less => Less,
				Op => Op,
				F => F(3),
				Cout => Cout
	);
	
End str;