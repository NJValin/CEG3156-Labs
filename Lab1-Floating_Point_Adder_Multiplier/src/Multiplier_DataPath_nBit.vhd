library ieee;
use ieee.std_logic_1164.all;

entity Multiplier_DataPath_nBit is
	generic (
		n : integer := 8);
	port (
		A, B : in STD_LOGIC_VECTOR(n-1 downto 0);
		clk : in STD_LOGIC;
		startOperation : in STD_LOGIC;
		multiplicandShift, multiplicandLoad : in STD_LOGIC;
		multiplierShift, multiplierLoad : in STD_LOGIC;
		productLoad, productIntLoad : in STD_LOGIC;
		product : out STD_LOGIC_VECTOR(2*n-1 downto 0);
		multiplicandZero : out STD_LOGIC;
		multiplicandLSB : out STD_LOGIC;
		int_multiplicandOut : out STD_LOGIC_VECTOR(n-1 downto 0);
		int_multiplierOut,productTemp : out STD_LOGIC_VECTOR(2*n-1 downto 0));
end Multiplier_DataPath_nBit;

architecture struct of Multiplier_DataPath_nBit is

	signal multiplicandOut, tempZero : STD_LOGIC_VECTOR(n-1 downto 0);
	signal multiplierIn, multiplierOut, productOut, productRegIn : STD_LOGIC_VECTOR(2*n-1 downto 0);
	signal productIn : STD_LOGIC_VECTOR(2*n downto 0);
	
	begin
		multiplicand : entity work.GeneralPurposeRegister(struct)
			generic map (
				n=>n)
			port map (
				regIn=>A,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>multiplicandShift,
				load=>multiplicandLoad, serialIn=>'0',
				asyncClr=>startOperation, asyncSet=>'0',
				regOut=>multiplicandOut);
		int_multiplicandOut<=multiplicandOut;
		multiplicandLSB <= multiplicandOut(0);
		tempZero <=(others=>'0') ;
		
		comp : entity work.Comparator_nBit(struct)
			generic map (n=>n)
			port map (
				A=>tempZero, B=>multiplicandOut,
				AEB=>multiplicandZero);

		-- multiplicandZero <= nor(multiplicandOut); -- Quartus prime lite doesn't support VHDL 2008, which supports unary operators :(
		
		multiplierIn(2*n-1 downto n) <= (others=>'0');
		multiplierIn(n-1 downto 0) <= B;
		multiplier : entity work.GeneralPurposeRegister(struct)
			generic map (
				n=>2*n)
			port map (
				regIn=>multiplierIn,
				clk=>clk,
				shiftLeft=>multiplierShift, shiftRight=>'0',
				load=>multiplierLoad, serialIn=>'0',
				asyncClr=>startOperation, asyncSet=>'0',
				regOut=>multiplierOut);
		int_multiplierOut<=multiplierOut;

		Adder : entity work.RippleAdder_nBit(struct)
			generic map (
				n=>2*n+1)
			port map (
				A=>'0'& productOut, B=>'0' & multiplierOut,
				sub=>'0',
				result=>productIn);	
		
		productIntReg : entity work.GeneralPurposeRegister(struct)
			generic map (
				n=>2*n)
			port map (
				regIn=>productIn(2*n-1 downto 0),
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>productIntLoad, serialIn=>'0',
				asyncClr=>startOperation, asyncSet=>'0',
				regOut=>productOut);
		productTemp<=productOut;
		productRegIn<=productOut;
		productReg : entity work.GeneralPurposeRegister(struct)
			generic map (
				n=>2*n)
			port map (
				regIn=>productRegIn,
				clk=>clk,
				shiftLeft=>'0', shiftRight=>'0',
				load=>productLoad, serialIn=>'0',
				asyncClr=>startOperation, asyncSet=>'0',
				regOut=>product);
	
end struct;