library IEEE;
use ieee.std_logic_1164.ALL;

Entity CLA4Bit is
	port(a : in std_logic_vector(3 downto 0);
        b : in std_logic_vector(3 downto 0);
        cin : in std_logic;
        s : out std_logic_vector(3 downto 0);
        cout : out std_logic
	);
End CLA4Bit;

Architecture str of CLA4Bit is

Signal p,g,c : std_logic_vector(3 downto 0);

Begin

p(0) <= a(0) xor b(0);
g(0) <= a(0) and b(0);
p(1) <= a(1) xor b(1);
g(1) <= a(1) and b(1);
p(2) <= a(2) xor b(2);
g(2) <= a(2) and b(2);
p(3) <= a(3) xor b(3);
g(3) <= a(3) and b(3);

c(0) <= g(0) or (p(0) and cin);
c(1) <= g(1) or (g(0) and p(1)) or (p(0) and p(1) and cin);
c(2) <= g(2) or (g(1) and p(2)) or (g(0) and p(1) and p(2)) or (p(0) and p(1) and p(2) and cin);
c(3) <= g(3) or (g(2) and p(3)) or (g(1) and p(2) and p(3)) or (g(0) and p(1) and p(2) and p(3)) or (p(0) and p(1) and p(2) and p(3) and cin);

s(0) <= cin xor p(0);
s(1) <= c(0) xor p(1);
s(2) <= c(1) xor p(2);
s(3) <= c(2) xor p(3);

cout <= c(3);

End str;