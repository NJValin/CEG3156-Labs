library IEEE;
use ieee.std_logic_1164.ALL;

entity CLA12Bit is
	port(a : in std_logic_vector(11 downto 0);
        b : in std_logic_vector(11 downto 0);
        cin : in std_logic;
        s : out std_logic_vector(11 downto 0);
        cout : out std_logic
	);
End CLA12Bit;

Architecture str of CLA12Bit is

Component CLA4Bit
	port(a : in std_logic_vector(3 downto 0);
        b : in std_logic_vector(3 downto 0);
        cin : in std_logic;
        s : out std_logic_vector(3 downto 0);
        cout : out std_logic
	);
End Component;

Signal a0,a1,a2,b0,b1,b2,o0,o1,o2 : std_logic_vector(3 downto 0);
Signal c4,c8 : std_logic;

Begin

a0(0) <= a(0);
a0(1) <= a(1);
a0(2) <= a(2);
a0(3) <= a(3);

b0(0) <= b(0);
b0(1) <= b(1);
b0(2) <= b(2);
b0(3) <= b(3);

CLA1 : CLA4Bit
	port map(
		a => a0,
		b => b0,
		cin => cin,
		s => o0,
		cout => c4
	);

a1(0) <= a(4);
a1(1) <= a(5);
a1(2) <= a(6);
a1(3) <= a(7);

b1(0) <= b(4);
b1(1) <= b(5);
b1(2) <= b(6);
b1(3) <= b(7);

CLA2 : CLA4Bit
	port map(
		a => a1,
		b => b1,
		cin => c4,
		s => o1,
		cout => c8
	);

a2(0) <= a(8);
a2(1) <= a(9);
a2(2) <= a(10);
a2(3) <= a(11);

b2(0) <= b(8);
b2(1) <= b(9);
b2(2) <= b(10);
b2(3) <= b(11);

CLA3 : CLA4Bit
	port map(
		a => a2,
		b => b2,
		cin => c8,
		s => o2,
		cout => cout
	);

s(0) <= o0(0);
s(1) <= o0(1);
s(2) <= o0(2);
s(3) <= o0(3);
s(4) <= o1(0);
s(5) <= o1(1);
s(6) <= o1(2);
s(7) <= o1(3);
s(8) <= o2(0);
s(9) <= o2(1);
s(10) <= o2(2);
s(11) <= o2(3);

End str;
