library ieee;
use ieee.std_logic_1164.all;

entity PipelinedProcessor is
	port (
		ValueSelect, InstrSelect: in STD_LOGIC_VECTOR (2 downto 0):="000";
		GClock, GReset : in STD_LOGIC := '0';
		MuxOut : out STD_LOGIC_VECTOR(7 downto 0):="00000000";
		InstructionOut : out STD_LOGIC_VECTOR(31 downto 0):="00000000000000000000000000000000";
		BranchOut, EqualOut, MemWriteOut, RegWriteOut : out STD_LOGIC:='0');
end entity;

architecture struct of PipelinedProcessor is
	signal PCLoad, IFIDLoad: STD_LOGIC:='1';
	signal Stall, branch, equal, jump, IFflush, WB_RegWrite, EX_MemToReg, MEM_RegWrite : STD_LOGIC :='0';
	signal nextAddr : STD_LOGIC_VECTOR(7 downto 0) := "00000000";
	signal jumpAddr, BranchTargetAddress, PC_plus1, Address, MEM_Result, MEM_Addr, MEM_Data : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
	signal ID_PCplus1, ID_A, ID_B: STD_LOGIC_VECTOR(7 downto 0):= "00000000";
	signal IF_Instruction, ID_instruction, EX_instruction, MEM_instruction, WB_instruction : STD_LOGIC_VECTOR(31 downto 0);
	signal WB_WriteData : STD_LOGIC_VECTOR(7 downto 0):= "00000000";
	signal ControlSignals, ID_control: STD_LOGIC_VECTOR(5 downto 0);
	signal EX_WBctrl,  MEM_WBctrl, WBctrl : STD_LOGIC_VECTOR(3 downto 0) :="0000";
	signal MEMWrite, EX_MEMWrite : STD_LOGIC;
	signal EXctrl,ALUOp : STD_LOGIC_VECTOR(2 downto 0):="000"; 
	signal MEM_DataOut, ALUinputA,ALUinputB, EX_Result, WB_Result, EX_Addr, EX_A, EX_B, WB_DataOut, OtherControlSignals: STD_LOGIC_VECTOR(7 downto 0);
	signal EX_DestReg, EX_Rt, EX_Rs, EX_Rd, MEM_DestReg, WB_DestReg : STD_LOGIC_VECTOR(4 downto 0);
	signal ForwardA, ForwardB : STD_LOGIC_VECTOR(1 downto 0);
	begin
-- Instruction Fetch Stage ----------------------------------------------------------------------
		PCplus1 : entity work.CarryLookaheadAdder_8bit(struct)
			port map (
				A=>Address, B=>"00000001",
				sub=>'0',
				Sum=>PC_plus1);

		PCMux : entity work.Mux4x1_nBit(struct)
			generic map (8)
			port map (
			in3=>jumpAddr, in2=>jumpAddr, in1=>BranchTargetAddress, in0=>PC_plus1,
			sel=>(0=>(branch and equal),1=>jump),
			output=>nextAddr);

		PC : entity work.GeneralPurposeRegister(struct)
			generic map (8)
			port map(
				regIn=>nextAddr,
				clk=>GClock,
				shiftLeft=>'0', shiftRight=>'0',
				load=>PCLoad, serialIn=>'0',
				asyncClr=>GReset, asyncSet=>'0',
				regOut=>Address);

		InstrMem : entity work.InstructionMemory(SYN)
			port map (
				aclr=>'0',
				address=>Address,
				clken=>'0',
				q=>IF_Instruction);

------------------------- IF/ID Pipeline Buffer--------------------------------------------------
		IFflush <= jump or (equal and branch) or GReset;
		IF_ID_BUF : entity work.IF_ID_Buffer(struct)
			port map (
				i_PCincr=>PC_plus1,
				i_instruction=>IF_Instruction,
				i_load=>IFIDLoad,
				i_clk=>GClock, i_clr=>IFflush,
				o_PCincr=>ID_PCplus1,
				o_instruction=>ID_Instruction);

-- Identification and Register Fetch Stage ------------------------------------------------------
		jumpAddr<=ID_Instruction(7 downto 0);
		RegisterFile : entity work.RegisterFile_32_8bit(struct)
			port map (
				ReadReg1=>ID_Instruction(25 downto 21), ReadReg2=>ID_Instruction(20 downto 16),
				WriteReg=>WB_DestReg,
				WriteData=>WB_WriteData,
				clk=>GClock, async_clr=>GReset,
				RegWrite=>WB_RegWrite,
				ReadData1=>ID_A, ReadData2=>ID_B);

		RegEqual : entity work.Comparator_nBit(struct)
			generic map (8)
			port map (
				A=>ID_A, B=>ID_B,
				AEB=>equal);

		BranchAddrCalc : entity work.CarryLookaheadAdder_8bit(struct)
			port map (
				A=>ID_PCplus1, B=>ID_Instruction(7 downto 0),
				sub=>'0',
				Sum=>BranchTargetAddress);

		CtrlUnit : entity work.ControlUnit(str)
			port map (
				Op=>ID_Instruction(31 downto 26),
				MemtoReg=>ControlSignals(5),
				RegWrite=>ControlSignals(4),
				MemWrite=>ControlSignals(3),
				ALUOp1=>ControlSignals(2),
				ALUOp0=>ControlSignals(1),
				RegDst=>ControlSignals(0),
				Branch=>branch,
				Jump=>jump);
		EX_MemToReg<=ControlSignals(5);
		

		StallMux : entity work.Mux2x1_nBit(struct)
			generic map (6)
			port map (
				in1=>"000000", in0=>ControlSignals,
				sel=>Stall,
				output=>ID_control);

		DecideStall : entity work.HazardDetectUnit(str)
			port map (
				IDEXMemRead=>EX_MemToReg,
				IDEXRegRt=>EX_Rt, IFIDRegRs=>ID_Instruction(25 downto 21),
				IFIDRegRt=>ID_Instruction(20 downto 16),
				PCWrite=>PCLoad, IFIDWrite=>IFIDLoad, CMux=>Stall);
------------------------- ID/EX Pipeline Buffer--------------------------------------------------
		EX_WBControlReg : entity work.GeneralPurposeRegister(struct)
			generic map (4)
			port map (
				regIn=>(0=>ID_control(5), 1=>ID_control(4), others=>'0'),
				clk=>GClock,
				load=>'1',
				asyncClr=>GReset,
				regOut=>EX_WBctrl);

		EX_MEMControlReg : entity work.D_FF(struct)
			port map (
				i_d=>ID_control(3),
				i_clk=>GClock, i_clr=>GReset, i_set=>'0',
				o_Q=>EX_MEMWrite);

		EXControlReg : entity work.GeneralPurposeRegister(struct)
			generic map (3)
			port map (
				regIn=>(0=>ID_control(0), 1=>ID_control(1), 2=>ID_control(2)),
				clk=>GClock,
				load=>'1',
				asyncClr=>GReset,
				regOut=>EXctrl);

		IDEXbuffer : entity work.ID_EX_Buffer(struct)
			port map (
				i_A=>ID_A, i_B=>ID_B, i_Addr=>ID_Instruction(7 downto 0),
				i_Rs=>ID_Instruction(25 downto 21), i_Rt=>ID_Instruction(20 downto 16), i_Rd=>ID_Instruction(15 downto 11),
				i_instruction=>ID_Instruction,
				i_clk=>GClock, i_clr=>GReset,
				o_A=>EX_A, o_B=>EX_B, o_Addr=>EX_Addr,
				o_Rs=>EX_Rs, o_Rt=>EX_Rt, o_Rd=>EX_Rd,
				o_instruction=>EX_Instruction);
-- Execution Stage ------------------------------------------------------
		FrwrdAMux : entity work.Mux4x1_nBit(struct)
			generic map (8)
			port map (
				in3=>WB_Result, in2=>WB_Result, in1=>WB_WriteData, in0=>EX_A,
				sel=>ForwardA,
				output=>ALUinputA);

		FrwrdBMux : entity work.Mux4x1_nBit(struct)
			generic map (8)
			port map (
				in3=>WB_WriteData, in2=>WB_WriteData, in1=>WB_Result, in0=>EX_B,
				sel=>ForwardB,
				output=>ALUinputB);

		ALU : entity work.ALU8Bit(str)
			port map (
				A=>ALUinputA, B=>ALUinputB,
				Operation=>ALUOp,
				ALUResult=>EX_Result);

		ALUCtrl : entity work.ALUControlUnit(str)
			port map (
				F=>EX_Addr(5 downto 0),
				ALUOp=>EXctrl(2 downto 1),
				Operation=>ALUOp);
		DestRegMux : entity work.Mux2x1_nBit(struct)
			generic map (5)
			port map (
				in1=>EX_Rd, in0=>EX_Rt,
				sel=>EXctrl(0),
				output=>EX_DestReg);

		FrwrdUnit : entity work.ForwardingUnit(str)
			port map (
				EXMEMRegWrite=>MEM_RegWrite, MEMWBRegWrite=>WB_RegWrite,
				EXMEMRegRd=>MEM_DestReg, MEMWBRegRd=>WB_DestReg, IDEXRegRs=>EX_Rs, IDEXRegRt=>EX_Rt,
				ForwardA=>ForwardA, ForwardB=>ForwardB);

------------------------- EX/MEM Pipeline Buffer--------------------------------------------------
		MEM_WBControlReg : entity work.GeneralPurposeRegister(struct)
			generic map (4)
			port map (
				regIn=>(0=>EX_WBctrl(0), 1=>EX_WBctrl(1), others=>'0'),
				clk=>GClock,
				load=>'1',
				asyncClr=>GReset,
				regOut=>MEM_WBctrl);
		MEM_RegWrite<=MEM_WBctrl(1);

		MEMControlReg : entity work.D_FF(struct)
			port map (
				i_d=>EX_MEMWrite,
				i_clk=>GClock, i_clr=>GReset, i_set=>'0',
				o_Q=>MEMWrite);

		EXMEMbuffer : entity work.EX_MEM_Buffer(struct)
			port map (
				i_Result=>EX_Result,
				i_DataAddress=>EX_Addr,
				i_Data=>EX_B,
				i_Rd=>EX_DestReg,
				i_instruction=>EX_Instruction,
				i_clk=>GClock, i_clr=>GReset,
				o_Result=>MEM_Result,
				o_DataAddress=>MEM_Addr,
				o_Data=>MEM_Data,
				o_Rd=>MEM_DestReg,
				o_instruction=>MEM_Instruction);
-- Memory Write Stage ------------------------------------------------------
		
		DataMem : entity work.DataMemory(SYN)
			port map (
				aclr=>'0',
				address=>MEM_Addr,
				clken=>'0',
				data=>MEM_Data,
				wren=>MEMWrite,
				q=>MEM_DataOut);

------------------------- MEM/WB Pipeline Buffer--------------------------------------------------
		WBControlReg : entity work.GeneralPurposeRegister(struct)
			generic map (4)
			port map (
				regIn=>(0=>MEM_WBctrl(0), 1=>MEM_WBctrl(1), others=>'0'),
				clk=>GClock,
				load=>'1',
				asyncClr=>GReset,
				regOut=>WBctrl);
		WB_RegWrite<=WBctrl(1);

		MEMWBBuffer : entity work.MEM_WB_Buffer(struct)
			port map (
				i_Result=>MEM_Result,
				i_Data=>MEM_DataOut,
				i_Rd=>MEM_DestReg,
				i_instruction=>MEM_Instruction,
				i_clk=>GClock, i_clr=>GReset,
				o_Result=>WB_Result,
				o_Data=>WB_DataOut,
				o_Rd=>WB_DestReg,
				o_instruction=>WB_Instruction);
-- Write Back Stage ------------------------------------------------------

		WBMux : entity work.Mux2x1_nBit(struct)
			generic map (8)
			port map (
				in1=>WB_DataOut, in0=>WB_Result,
				sel=>WBctrl(0),
				output=>WB_WriteData);

-- Output Drivers --------------------------------------------------------
		OtherControlSignals <= (7=>'0', 6=>ControlSignals(0),5=>jump, 4=>'0', 3=>ControlSignals(5), 2=>ControlSignals(2), 1=>ControlSignals(1), 0=>'0');
		ControlSignalMux : entity work.Mux8x1_nBit(struct)
			generic map (8)
			port map (
				in0=>Address, in1=>EX_Result, in2=>ID_A, in3=>ID_B, in4=>WB_WriteData, in5=>OtherControlSignals, in6=>OtherControlSignals, in7=>OtherControlSignals,
				sel=>ValueSelect,
				MuxOut=>MuxOut);

		InstructionMux : entity work.Mux8x1_nBit(struct)
			generic map (32)
			port map (
				in0=>IF_Instruction, in1=>ID_Instruction, in2=>EX_Instruction, in3=>MEM_Instruction, in4=>WB_Instruction,
				sel=>InstrSelect,
				MuxOut=>InstructionOut);


		BranchOut<=branch;
		EqualOut <= equal;
		MemWriteOut<=ControlSignals(3);
		RegWriteOut<=ControlSignals(4);
end struct;
