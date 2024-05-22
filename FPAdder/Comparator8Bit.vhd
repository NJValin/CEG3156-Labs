LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity Comparator8Bit is
	port(A, B : in std_logic_vector(7 downto 0);
		  Greater, Equal : out std_logic
	);
End Comparator8Bit;

Architecture str of Comparator8Bit is

	Signal G, E : std_logic_vector(7 downto 0);
	
Begin

E(0) <= not(A(0) xor B(0));
E(1) <= not(A(1) xor B(1));
E(2) <= not(A(2) xor B(2));
E(3) <= not(A(3) xor B(3));
E(4) <= not(A(4) xor B(4));
E(5) <= not(A(5) xor B(5));
E(6) <= not(A(6) xor B(6));
E(7) <= not(A(7) xor B(7));

G(7) <= A(7) and (not B(7));
G(6) <= E(7) and A(6) and (not B(6));
G(5) <= E(7) and E(6) and A(5) and (not B(5));
G(4) <= E(7) and E(6) and E(5) and A(4) and (not B(4));
G(3) <= E(7) and E(6) and E(5) and E(4) and A(3) and (not B(3));
G(2) <= E(7) and E(6) and E(5) and E(4) and E(3) and A(2) and (not B(2));
G(1) <= E(7) and E(6) and E(5) and E(4) and E(3) and E(2) and A(1) and (not B(1));
G(0) <= E(7) and E(6) and E(5) and E(4) and E(3) and E(2) and E(1) and A(0) and (not B(0));

Greater <= G(0) or G(1) or G(2) or G(3) or G(4) or G(5) or G(6) or G(7);
Equal <= (G(0) or G(1) or G(2) or G(3) or G(4) or G(5) or G(6) or G(7)) or (E(7) and E(6) and E(5) and E(4) and E(3) and E(2) and E(1) and E(0));

End str;