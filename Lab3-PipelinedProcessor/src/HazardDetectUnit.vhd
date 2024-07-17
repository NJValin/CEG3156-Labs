LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity HazardDetectUnit is
	Port( IDEXMemRead: in std_logic;
			IDEXRegRt, IFIDRegRs, IFIDRegRt : in std_logic_vector(4 downto 0);
			PCWrite, IFIDWrite, CMux : out std_logic
			);
End HazardDetectUnit;

Architecture str of HazardDetectUnit is

Signal Aequi, Bequi, Result : std_logic;

Begin

Aequi <= (not (IDEXRegRt(4) xor IFIDRegRs(4))) and (not (IDEXRegRt(3) xor IFIDRegRs(3))) and (not (IDEXRegRt(2) xor IFIDRegRs(2))) and (not (IDEXRegRt(1) xor IFIDRegRs(1))) and (not (IDEXRegRt(0) xor IFIDRegRs(0)));
Bequi <= (not (IDEXRegRt(4) xor IFIDRegRt(4))) and (not (IDEXRegRt(3) xor IFIDRegRt(3))) and (not (IDEXRegRt(2) xor IFIDRegRt(2))) and (not (IDEXRegRt(1) xor IFIDRegRt(1))) and (not (IDEXRegRt(0) xor IFIDRegRt(0)));

Result <= IDEXMemRead and (Aequi or Bequi);

PCWrite <= not Result;
IFIDWrite <= not Result;
CMux <= Result;

End str;
