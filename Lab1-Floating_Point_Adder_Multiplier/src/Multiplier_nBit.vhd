library ieee;
use ieee.std_logic_1164.all;

entity Multiplier_nBit is
	generic (
		n : integer := 8);
	port (
		A, B : in STD_LOGIC_VECTOR(n-1 downto 0);
		clk : in STD_LOGIC;
		startOperation : in STD_LOGIC;
		operationDone : out STD_LOGIC := '0';
		product : out STD_LOGIC_VECTOR(2*n-1 downto 0);
		int_multiplicandOut: out STD_LOGIC_VECTOR(n-1 downto 0);
		int_multiplierOut, productTemp : out STD_LOGIC_VECTOR(2*n-1 downto 0);
		intS : out STD_LOGIC_VECTOR(5 downto 0));
end Multiplier_nBit;

architecture struct of Multiplier_nBit is
	signal int_multiplicandShift, int_multiplicandLoad, int_multiplierShift : STD_LOGIC;
	signal int_multiplierLoad, int_productLoad, int_productIntLoad : STD_LOGIC;
	signal int_multiplicandZero, int_multiplicandLSB : STD_LOGIC;

	begin
	
	dataPath : entity work.Multiplier_DataPath_nBit(struct)
		generic map(n)
		port map (
			A=>A, B=>B,
			clk=>clk,
			startOperation=>startOperation,
			multiplicandShift=>int_multiplicandShift, multiplicandLoad=>int_multiplicandLoad,
			multiplierShift=>int_multiplierShift, multiplierLoad=>int_multiplierLoad,
			productLoad=>int_productLoad, productIntLoad=>int_productIntLoad,
			product=>product,
			multiplicandZero=>int_multiplicandZero,
			multiplicandLSB=>int_multiplicandLSB,
			int_multiplicandOut=>int_multiplicandOut, int_multiplierOut=>int_multiplierOut,
			productTemp=>productTemp);
	
	controlPath : entity work.Multiplier_Control_nBit(struct)
		port map (
			clk=>clk,
			startOperation=>startOperation,
			multiplicandZero=>int_multiplicandZero, multiplicandLSB=>int_multiplicandLSB,
			multiplicandLoad=>int_multiplicandLoad, multiplierLoad=>int_multiplierLoad,
			multiplicandShift=>int_multiplicandShift, multiplierShift=>int_multiplierShift,
			productIntLoad=>int_productIntLoad, productLoad=>int_productLoad,
			operationDone=>operationDone,
			intS=>intS);
end struct;