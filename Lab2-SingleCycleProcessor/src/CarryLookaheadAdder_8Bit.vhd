library ieee;
use ieee.std_logic_1164.all;

entity CarryLookaheadAdder_8Bit is
	port (
		A, B : in STD_LOGIC_VECTOR(7 downto 0);
		sub : in STD_LOGIC;
		V : out STD_LOGIC;
		Sum : out STD_LOGIC_VECTOR(7 downto 0));
end CarryLookaheadAdder_8Bit;

architecture struct of CarryLookaheadAdder_8Bit is
	signal int_Sub : STD_LOGIC_VECTOR(7 downto 0);
	signal int_B : STD_LOGIC_VECTOR(7 downto 0);
	signal g0, g1, g2, g3, g4, g5, g6, g7: STD_LOGIC;
	signal p0, p1, p2, p3, p4, p5, p6, p7: STD_LOGIC;
	signal c1, c2, c3, c4, c5, c6,c7, c8 : STD_LOGIC;
	begin
		int_Sub <= (0=>sub, others=>sub);
		int_B <= int_Sub xor B;
		--Carry-lookahead logic
		g0 <= A(0) and int_B(0);
		g1 <= A(1) and int_B(1);
		g2 <= A(2) and int_B(2);
		g3 <= A(3) and int_B(3);
		g4 <= A(4) and int_B(4);
		g5 <= A(5) and int_B(5);
		g6 <= A(6) and int_B(6);
		g7 <= A(7) and int_B(7);

		p0 <= A(0) or int_B(0);
		p1 <= A(1) or int_B(1);
		p2 <= A(2) or int_B(2);
		p3 <= A(3) or int_B(3);
		p4 <= A(4) or int_B(4);
		p5 <= A(5) or int_B(5);
		p6 <= A(6) or int_B(6);
		p7 <= A(7) or int_B(7);

		-- Carry out calculation
		c1 <= g0 or (p0 and sub);
		c2 <= g1 or (p1 and g0) or (p1 and p0 and sub);
		c3 <= g2 or (p2 and g1) or (p2 and p1 and g0) or (p2 and p1 and p0 and sub);
		c4 <= g3 or (p3 and g2) or (p3 and p2 and g1) or (p3 and p2 and p1 and g0) or (p3 and p2 and p1 and p0 and sub);
		c5 <= g4 or (p4 and g3) or (p4 and p3 and g2) or (p4 and p3 and p2 and g1) or (p4 and p3 and p2 and p1 and g0) or (p4 and p3 and p2 and p1 and p0 and sub);
		c6 <= g5 or (p5 and g4) or (p5 and p4 and g3) or (p5 and p4 and p3 and g2) or (p5 and p4 and p3 and p2 and g1) or (p5 and p4 and p3 and p2 and p1 and g0) or (p5 and p4 and p3 and p2 and p1 and p0 and sub);
		c7 <= g6 or (p6 and g5) or (p6 and p5 and g4) or (p6 and p5 and p4 and g3) or (p6 and p5 and p4 and p3 and g2) or (p6 and p5 and p4 and p3 and p2 and g1) or (p6 and p5 and p4 and p3 and p2 and p1 and g0) or (p6 and p5 and p4 and p3 and p2 and p1 and p0 and sub);
		c8 <= g7 or (p7 and g6) or (p7 and p6 and g5) or (p7 and p6 and p5 and g4) or (p7 and p6 and p5 and p4 and g3) or (p7 and p6 and p5 and p4 and p3 and g2) or (p7 and p6 and p5 and p4 and p3 and p2 and g1) or (p7 and p6 and p5 and p4 and p3 and p2 and p1 and g0) or (p7 and p6 and p5 and p4 and p3 and p2 and p1 and p0 and sub);

		--Full adder
		add1 : entity work.FullAdder1Bit(str)
			port map (
				A=>A(0), B=>int_B(0),
				cin=>sub,
				S=>Sum(0));

		add2 : entity work.FullAdder1Bit(str)
			port map (
				A=>A(1), B=>int_B(1),
				cin=>c1,
				S=>Sum(1));

		add3 : entity work.FullAdder1Bit(str)
			port map (
				A=>A(2), B=>int_B(2),
				cin=>c2,
				S=>Sum(2));

		add4 : entity work.FullAdder1Bit(str)
			port map (
				A=>A(3), B=>int_B(3),
				cin=>c3,
				S=>Sum(3));

		add5 : entity work.FullAdder1Bit(str)
			port map (
				A=>A(4), B=>int_B(4),
				cin=>c4,
				S=>Sum(4));

		add6 : entity work.FullAdder1Bit(str)
			port map (
				A=>A(5), B=>int_B(5),
				cin=>c5,
				S=>Sum(5));

		add7 : entity work.FullAdder1Bit(str)
			port map (
				A=>A(6), B=>int_B(6),
				cin=>c6,
				S=>Sum(6));

		add8 : entity work.FullAdder1Bit(str)
			port map (
				A=>A(7), B=>int_B(7),
				cin=>c7,
				S=>Sum(7));

		V<=c8 xor c7;
end struct;
