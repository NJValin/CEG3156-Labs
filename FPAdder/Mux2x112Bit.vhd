library ieee;
USE ieee.std_logic_1164.ALL;

Entity Mux2x112Bit is
	port(S : in std_logic;
		  A, B : in std_logic_vector(11 downto 0);
		  O : out std_logic_vector(11 downto 0)
	);
	
End Mux2x112Bit;

Architecture str of Mux2x112Bit is

Signal V : std_logic_vector(11 downto 0);

Begin

V(0) <= (A(0) and (not S)) or (B(0) and S);
V(1) <= (A(1) and (not S)) or (B(1) and S);
V(2) <= (A(2) and (not S)) or (B(2) and S);
V(3) <= (A(3) and (not S)) or (B(3) and S);
V(4) <= (A(4) and (not S)) or (B(4) and S);
V(5) <= (A(5) and (not S)) or (B(5) and S);
V(6) <= (A(6) and (not S)) or (B(6) and S);
V(7) <= (A(7) and (not S)) or (B(7) and S);
V(8) <= (A(8) and (not S)) or (B(8) and S);
V(9) <= (A(9) and (not S)) or (B(9) and S);
V(10) <= (A(10) and (not S)) or (B(10) and S);
V(11) <= (A(11) and (not S)) or (B(11) and S);

O(0) <= V(0);
O(1) <= V(1);
O(2) <= V(2);
O(3) <= V(3);
O(4) <= V(4);
O(5) <= V(5);
O(6) <= V(6);
O(7) <= V(7);
O(8) <= V(8);
O(9) <= V(9);
O(10) <= V(10);
O(11) <= V(11);

End str;
