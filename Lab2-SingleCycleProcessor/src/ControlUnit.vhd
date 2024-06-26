LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity ControlUnit is
	Port (Op : in std_logic_vector(5 downto 0);
			RegDst, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp0, Jump : out std_logic :='0'
	);
End ControlUnit;

Architecture str of ControlUnit is

Signal RFormat, lw, sw, beq, jmp : std_logic;

Begin

RFormat <= (not Op(5)) and (not Op(4)) and (not Op(3)) and (not Op(2)) and (not Op(1)) and (not Op(0));
lw <= (Op(5)) and (not Op(4)) and (not Op(3)) and (not Op(2)) and (Op(1)) and (Op(0));
sw <= (Op(5)) and (not Op(4)) and (Op(3)) and (not Op(2)) and ( Op(1)) and (Op(0));
beq <= (not Op(5)) and (not Op(4)) and (not Op(3)) and (Op(2)) and (not Op(1)) and (not Op(0));
jmp <= (not Op(5)) and (not Op(4)) and (not Op(4)) and (not Op(1)) and Op(1) and (not Op(0));

RegDst <= RFormat;
MemtoReg <= lw;
RegWrite <= RFormat or lw;
MemWrite <= sw;
Branch <= beq;
AluOp1 <= RFormat;
AluOp0 <= beq;
Jump <= jmp;

End str;