LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity FullAdder8Bit is
	port(A, B : in std_logic_vector(7 downto 0);
		  cin : in std_logic;
		  S : out std_logic_vector(7 downto 0);
		  cout, ovf : out std_logic
	);
End FullAdder8Bit;

Architecture str of FullAdder8Bit is

Signal R,c : std_logic_vector(7 downto 0);

Component FullAdder1Bit is
	port(A, B, cin : in std_logic;
		  S, cout: out std_logic
	);
End Component;

Begin

Adder0 : FullAdder1Bit
	port map(
		A => A(0),
		B => B(0) xor cin,
		cin => cin,
		S => R(0),
		cout => c(0));
		
Adder1 : FullAdder1Bit
	port map(
		A => A(1),
		B => B(1) xor cin,
		cin => c(0),
		S => R(1),
		cout => c(1));
		
Adder2 : FullAdder1Bit
	port map(
		A => A(2),
		B => B(2) xor cin,
		cin => c(1),
		S => R(2),
		cout => c(2));
		
Adder3 : FullAdder1Bit
	port map(
		A => A(3),
		B => B(3) xor cin,
		cin => c(2),
		S => R(3),
		cout => c(3));
		
Adder4 : FullAdder1Bit
	port map(
		A => A(4),
		B => B(4) xor cin,
		cin => c(3),
		S => R(4),
		cout => c(4));
		
Adder5 : FullAdder1Bit
	port map(
		A => A(5),
		B => B(5) xor cin,
		cin => c(4),
		S => R(5),
		cout => c(5));
		
Adder6 : FullAdder1Bit
	port map(
		A => A(6),
		B => B(6) xor cin,
		cin => c(5),
		S => R(6),
		cout => c(6));
		
Adder7 : FullAdder1Bit
	port map(
		A => A(7),
		B => B(7) xor cin,
		cin => c(6),
		S => R(7),
		cout => c(7));
		
S <= R;
cout <= c(7);
ovf <= cin xor c(7);

End str;