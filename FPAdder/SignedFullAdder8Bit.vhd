LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity SignedFullAdder8Bit is
	port(A, B : in std_logic_vector(7 downto 0);
		  cin : in std_logic;
		  S : out std_logic_vector(7 downto 0);
		  cout : out std_logic
	);
End SignedFullAdder8Bit;

Architecture str of SignedFullAdder8Bit is

Signal con, sel, g, e, ge, sign : std_logic;
Signal x, y, Final: std_logic_vector(7 downto 0);
Signal T, c, trans: std_logic_vector(6 downto 0);


Component Comparator8Bit is
	port(A, B : in std_logic_vector(7 downto 0);
		  Greater, Equal : out std_logic
	);
End Component;

Component Mux2x18Bit is
	port(S : in std_logic;
		  A, B : in std_logic_vector(7 downto 0);
		  O : out std_logic_vector(7 downto 0)
	);
End Component;

Component FullAdder1Bit is
	port(A, B, cin : in std_logic;
		  S, cout: out std_logic
	);
End Component;

Component FullAdder8Bit is
	port(A, B : in std_logic_vector(7 downto 0);
		  cin : in std_logic;
		  S : out std_logic_vector(7 downto 0);
		  cout, ovf : out std_logic
	);
End Component;

Begin

con <= (not cin and not A(7) and B(7)) or (A(7) and not B(7)) or (cin and (A(7) or not B(7)));
sel <= (not cin and A(7) and not B(7)) or (cin and A(7) and B(7));

Comparator: Comparator8Bit
	port map(A => '0' & A(6 downto 0),
				B => '0' & B(6 downto 0),
				Greater => g,
				Equal => e
	);

ge <= g or e;

sel1 : Mux2x18Bit
	port map(S => sel,
				A => A,
				B => B,
				O => x
	);
	
sel2 : Mux2x18Bit
	port map(S => sel,
				A => B,
				B => A,
				O => y
	);
	
Adder0 : FullAdder1Bit
	port map(
		A => x(0),
		B => y(0) xor con,
		cin => con,
		S => T(0),
		cout => c(0)
	);
	
Adder1 : FullAdder1Bit
	port map(
		A => x(1),
		B => y(1) xor con,
		cin => c(0),
		S => T(1),
		cout => c(1)
	);
	
Adder2 : FullAdder1Bit
	port map(
		A => x(2),
		B => y(2) xor con,
		cin => c(1),
		S => T(2),
		cout => c(2)
	);
	
Adder3 : FullAdder1Bit
	port map(
		A => x(3),
		B => y(3) xor con,
		cin => c(2),
		S => T(3),
		cout => c(3)
	);
	
Adder4 : FullAdder1Bit
	port map(
		A => x(4),
		B => y(4) xor con,
		cin => c(3),
		S => T(4),
		cout => c(4)
	);
	
Adder5 : FullAdder1Bit
	port map(
		A => x(5),
		B => y(5) xor con,
		cin => c(4),
		S => T(5),
		cout => c(5)
	);
	
Adder6 : FullAdder1Bit
	port map(
		A => x(6),
		B => y(6) xor con,
		cin => c(5),
		S => T(6),
		cout => c(6)
	);

trans(0) <= (T(0) and (not con or c(6))) or (not T(0) and con and not c(6));
trans(1) <= (T(1) and (not con or c(6))) or (not T(1) and con and not c(6));
trans(2) <= (T(2) and (not con or c(6))) or (not T(2) and con and not c(6));
trans(3) <= (T(3) and (not con or c(6))) or (not T(3) and con and not c(6));
trans(4) <= (T(4) and (not con or c(6))) or (not T(4) and con and not c(6));
trans(5) <= (T(5) and (not con or c(6))) or (not T(5) and con and not c(6));
trans(6) <= (T(6) and (not con or c(6))) or (not T(6) and con and not c(6));

Last: FullAdder8Bit
	port map(A => '0' & trans,
				B => "0000000" & (con and not c(6)),
				cin => '0',
				S => Final
	);

sign <= (not ge and ((not cin and B(7)) or (cin and not B(7)))) or (ge and A(7));

S(7) <= sign;
S(6 downto 0) <= Final(6 downto 0);
cout <=  c(6);

End str;