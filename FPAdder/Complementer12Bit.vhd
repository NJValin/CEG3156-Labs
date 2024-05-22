LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity Complementer12Bit is
	Port(Comp : in std_logic;
		  Inpt : in std_logic_vector(11 downto 0);
		  Outpt : out std_logic_vector(11 downto 0)
	);
End Complementer12Bit;

Architecture str of Complementer12Bit is

Signal x, y : std_logic_vector(11 downto 0);

Component CLA12Bit is
	port(a : in std_logic_vector(11 downto 0);
        b : in std_logic_vector(11 downto 0);
        cin : in std_logic;
        s : out std_logic_vector(11 downto 0);
        cout : out std_logic
	);
End Component;

Component Mux2x112Bit is
	port(S : in std_logic;
		  A, B : in std_logic_vector(11 downto 0);
		  O : out std_logic_vector(11 downto 0)
	);
End Component;

Begin

Adder : CLA12Bit
	port map(
		a => not Inpt,
		b => "000000000001",
		cin => '0',
		s => x,
		cout => open);

Mux : Mux2x112Bit
	port map(
		S => Comp,
		A => Inpt,
		B => x,
		O => y);
		
Outpt <= y;

End;
	