LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

Entity ALUControlUnit is
	port (F : in std_logic_vector(5 downto 0);
			ALUOp : in std_logic_vector(1 downto 0);
			Operation : out std_logic_vector(2 downto 0)
	);
End ALUControlUnit;

Architecture str of ALUControlUnit is

Begin

Operation(2) <= ALUOp(0) or (F(1) and ALUOp(1));
Operation(1) <= (not ALUOp(1) or not F(2));
Operation(0) <= ALUOp(1) and (F(3) or F(0));

End str;