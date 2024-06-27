library ieee;
use ieee.std_logic_1164.all;

entity SingleCycleProcessor is
	port (
		ValueSelect : in STD_LOGIC_VECTOR (2 downto 0):="000";
		GClock, GReset : in STD_LOGIC := '0';
		MuxOut : out STD_LOGIC_VECTOR(7 downto 0);
		InstructionOut : out STD_LOGIC_VECTOR(31 downto 0);
		BranchOut, ZeroOut, MemWriteOut, RegWriteOut : out STD_LOGIC);
end entity;

architecture struct of SingleCycleProcessor is
	signal nextAddr, Address, WriteData, Rs, Rt, ALUResult, Data, int_PullDown: STD_LOGIC_VECTOR(7 downto 0) := "00000000";
	signal PC_Plus_4, BranchAddress, BrnchOrSeq: STD_LOGIC_VECTOR(7 downto 0);
	signal CurrentInstruction : STD_LOGIC_VECTOR(31 downto 0);--:= "00000000000000000000000000000000";
	signal WriteReg : STD_LOGIC_VECTOR(4 downto 0):="00000";
	signal RegDst, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0, Jump, Zero, V : std_logic :='0';
	signal ALUOp : STD_LOGIC_VECTOR(2 downto 0) :="000";
	begin

		-- Control Unit
		control : entity work.ControlUnit(str)
			port map (
				CurrentInstruction(31 downto 26),
				RegDst, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0, Jump);

		-- PC+1 adder
		PCIncrementer : entity work.CarryLookaheadAdder_8Bit(struct)
			port map (
				A=>Address, B=>"00000001",
				sub=>'0',
				Sum=>PC_Plus_4);

		-- Program Counter
		PC : entity work.GeneralPurposeRegister(struct)
			generic map (8)
			port map(
				regIn=>nextAddr,
				clk=>GClock,
				shiftLeft=>'0', shiftRight=>'0',
				load=>'1', serialIn=>'0',
				asyncClr=>GReset, asyncSet=>'0',
				regOut=>Address);
		
		-- Instruction ROM
		InstrMem : entity work.InstructionMemory(SYN)
			port map (
				address=>Address,
				rden=>'1',
				q=>CurrentInstruction);

		-- Register File
		WRmux : entity work.Mux2x1_nBit(struct)
			generic map (5)
			port map (
				CurrentInstruction(15 downto 11), CurrentInstruction(20 downto 16),
				RegDst,
				WriteReg);
		RegisterFile : entity work.RegisterFile_32_8bit(struct)
			port map (
				CurrentInstruction(25 downto 21), CurrentInstruction(20 downto 16),
				WriteReg,
				WriteData,
				GClock, GReset,
				RegWrite,
				Rs, Rt);

		-- Arithmetic Logic Unit
		ALUControl : entity work.ALUControlUnit(str)
			port map (
				F=>CurrentInstruction(5 downto 0),
				ALUOp=>(0=>ALUOp0, 1=>ALUOp1),
				Operation=>ALUOp);

		ALU : entity work.ALU8Bit(str)
			port map (
				A=>Rs, B=>Rt,
				Operation=>AlUOp,
				ALUResult=>ALUResult,
				Zero=>Zero, Overflow=>V);
		
		-- Either write the ALU result or the Data memory to the Register File
		WriteBackMux : entity work.Mux2x1_nBit(struct)
			port map (
				ALUResult, Data,
				MemToReg,
				WriteData);

		-- Data RAM
		DataRAM : entity work.DataMemory(SYN) 
			port map (
				aclr=>GReset,
				address=>CurrentInstruction(7 downto 0),
				clock=>GClock,
				data=>Rt,
				wren=>MemWrite,
				q=>Data);

		-- Calculate the Branch target address
		BranchAddrCalc : entity work.CarryLookaheadAdder_8Bit(struct)
			port map (
				A=>PC_Plus_4, B=>CurrentInstruction(7 downto 0),
				sub=>'0',
				Sum=>BranchAddress);

		-- Branch or PC+4
		BranchOrSequential : entity work.Mux2x1_nBit(struct)
			generic map (8)
			port map (
				BranchAddress, PC_Plus_4,
				(Branch and Zero),
				BrnchOrSeq);
		-- Jump?
		JumpOr : entity work.Mux2x1_nBit(struct)
			generic map (8)
			port map (
				CurrentInstruction(7 downto 0) , BrnchOrSeq,
				Jump,
				NextAddr);
		
		InstructionOut<=CurrentInstruction;

		int_PullDown <= "00000000";
		ControlSignalMux : entity work.Mux_32x1_nBit(struct)
			generic map (8)
			port map (
				in0=>Address, in1=>ALUResult, in2=>Rs, in3=>Rt, in4=>WriteData,
				in5=>(0=>'0', 1=>ALUOp0, 2=>ALUOp1, 3=>MemToReg, 4=>'0', 5=>Jump, 6=>RegDst, 7=>'0'),
				in6=>int_PullDown, in7=>int_PullDown, in8=>int_PullDown, in9=>int_PullDown, in10=>int_PullDown, in11=>int_PullDown,
				in12=>int_PullDown, in13=>int_PullDown, in14=>int_PullDown, in15=>int_PullDown, in16=>int_PullDown, in17=>int_PullDown,
				in18=>int_PullDown, in19=>int_PullDown, in20=>int_PullDown, in21=>int_PullDown, in22=>int_PullDown, in23=>int_PullDown,
				in24=>int_PullDown, in25=>int_PullDown, in26=>int_PullDown, in27=>int_PullDown, in28=>int_PullDown, in29=>int_PullDown,
				in30=>int_PullDown, in31=>int_PullDown,
				sel=>(0=>ValueSelect(0), 1=>ValueSelect(1), 2=>ValueSelect(2), others=>'0'),
				MuxOut=>MuxOut);
		BranchOut<=Branch;
		ZeroOut<=Zero;
		MemWriteOut<=MemWrite;
		RegWriteOut<=RegWrite;
end struct;
