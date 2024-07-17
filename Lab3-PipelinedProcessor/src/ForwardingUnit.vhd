LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity ForwardingUnit is
	Port( EXMEMRegWrite, MEMWBRegWrite: in std_logic;
			EXMEMRegRd, MEMWBRegRd, IDEXRegRs, IDEXRegRt: in std_logic_vector(4 downto 0);
			ForwardA, ForwardB : out std_logic_vector(1 downto 0)
	);
End ForwardingUnit;

Architecture str of ForwardingUnit is

Signal EXMEMZero, MEMWBZero, Aequi, Bequi, Cequi, Dequi : std_logic;

Begin

EXMEMZero <= (EXMEMRegRd(4) or EXMEMRegRd(3) or EXMEMRegRd(2) or EXMEMRegRd(1) or EXMEMRegRd(0));
MEMWBZero <= (MEMWBRegRd(4) or MEMWBRegRd(3) or MEMWBRegRd(2) or MEMWBRegRd(1) or MEMWBRegRd(0));

Aequi <= (not (EXMEMRegRd(4) xor IDEXRegRs(4))) and (not (EXMEMRegRd(3) xor IDEXRegRs(3))) and (not (EXMEMRegRd(2) xor IDEXRegRs(2))) and (not (EXMEMRegRd(1) xor IDEXRegRs(1))) and (not (EXMEMRegRd(0) xor IDEXRegRs(0)));
Bequi <= (not (EXMEMRegRd(4) xor IDEXRegRt(4))) and (not (EXMEMRegRd(3) xor IDEXRegRt(3))) and (not (EXMEMRegRd(2) xor IDEXRegRt(2))) and (not (EXMEMRegRd(1) xor IDEXRegRt(1))) and (not (EXMEMRegRd(0) xor IDEXRegRt(0)));
Cequi <= (not (MEMWBRegRd(4) xor IDEXRegRs(4))) and (not (MEMWBRegRd(3) xor IDEXRegRs(3))) and (not (MEMWBRegRd(2) xor IDEXRegRs(2))) and (not (MEMWBRegRd(1) xor IDEXRegRs(1))) and (not (MEMWBRegRd(0) xor IDEXRegRs(0)));
Dequi <= (not (MEMWBRegRd(4) xor IDEXRegRt(4))) and (not (MEMWBRegRd(3) xor IDEXRegRt(3))) and (not (MEMWBRegRd(2) xor IDEXRegRt(2))) and (not (MEMWBRegRd(1) xor IDEXRegRt(1))) and (not (MEMWBRegRd(0) xor IDEXRegRt(0)));

ForwardA(1) <= EXMEMRegWrite and EXMEMZero and Aequi;
ForwardB(1) <= EXMEMRegWrite and EXMEMZero and Bequi;
ForwardA(0) <= MEMWBRegWrite and MEMWBZero and Cequi;
ForwardB(0) <= MEMWBRegWrite and MEMWBZero and Dequi;

End str;
