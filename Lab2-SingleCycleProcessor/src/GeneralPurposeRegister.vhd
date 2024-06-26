library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- n-bit general purpose register
entity GeneralPurposeRegister is
	generic (
		n : integer := 8);
	port (
		regIn : in STD_LOGIC_VECTOR(n-1 downto 0);
		clk : in STD_LOGIC;
		shiftLeft, shiftRight : in STD_LOGIC := '0';
		load, serialIn : in STD_LOGIC := '0';
		asyncClr, asyncSet : in STD_LOGIC := '0';
		shiftOut : out STD_LOGIC;
		regOut : out STD_LOGIC_VECTOR(n-1 downto 0));
end GeneralPurposeRegister;

architecture struct of GeneralPurposeRegister is
	component D_ff
		port (
		i_d, i_clk, i_clr, i_set : in STD_LOGIC;
		o_Q, o_Qbar : out STD_LOGIC);
	end component D_ff;
	component FourOneMultiplex
		port (
			in3, in2, in1, in0 : in std_logic;
			sel1, sel0 : in std_logic;
			muxOut : out std_logic);
	end component FourOneMultiplex;
	
		signal select1, select0 : STD_LOGIC;
		signal dInIntVector, dOutIntVector : STD_LOGIC_VECTOR(n-1 downto 0);
	begin
		-- Operation selection encoder
		opEncode : entity work.encoder(struct)
			port map (
			in3=>shiftLeft, in2=>shiftRight, in1=>load, in0=>'0',
			out1=>select1, out0=>select0);
			
		-- flip flop for the least significant bit
		lsbMux : entity work.FourOneMultiplex(struct)
			port map (
				in3=>serialIn , in2=>dOutIntVector(1) ,in1=>regIn(0), in0=>dOutIntVector(0),
				sel1=>select1, sel0=>select0,
				muxOut=>dInIntVector(0));
				
		DffLSB : D_ff	
			port map (
				i_d=>dInIntVector(0), i_clk=>clk, i_clr=>asyncClr, i_set=>asyncSet,
				o_Q=>dOutIntVector(0));
		
		--For loop the n-2 1 bit registers to
		
			loop1 : for i in 1 to n-2 generate
				ithMux : FourOneMultiplex
					port map (
						in3=>dOutIntVector(i-1), in2=>dOutIntVector(i+1),in1=>regIn(i), in0=>dOutIntVector(i),
						sel1=>select1, sel0=>select0,
						muxOut=>dInIntVector(i));
				Dffi : D_ff 
					port map (
						i_d=>dInIntVector(i), i_clk=>clk, i_clr=>asyncClr, i_set=>asyncSet,
						o_Q=>dOutIntVector(i));
			end generate loop1;
		--flip flop for most significant bit
		msbMux : entity work.FourOneMultiplex(struct)
			port map (
				in3=>dOutIntVector(n-2), in2=>serialIn, in1=>regIn(n-1), in0=>dOutIntVector(n-1),
				sel1=>select1, sel0=>select0,
				muxOut=>dInIntVector(n-1));
				
		DffMSB : D_ff
			port map (
				dInIntVector(n-1), i_clk=>clk, i_clr=>asyncClr, i_set=>asyncSet,
				o_Q=>dOutIntVector(n-1));
		
		--Serial Out
		serialOutMux : entity work.FourOneMultiplex(struct)
			port map (
				in3=>'0', in2=>dOutIntVector(n-1), in1=>dOutIntVector(0), in0=>'0',
				sel1=>shiftLeft, sel0=>shiftRight,
				muxOut=>shiftOut);
		
		--output driver
		regOut<=dOutIntVector;
end architecture struct;