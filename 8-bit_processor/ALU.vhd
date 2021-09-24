library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ALU is
	port(
		A: in std_logic_vector(7 downto 0);
		B: in std_logic_vector(7 downto 0);
		ALU_Sel: in std_logic_vector(2 downto 0);--Process type
		--Outputs
		NZVC: out std_logic_vector(3 downto 0);
		ALU_result: out std_logic_vector(7 downto 0)
	);
end ALU;

architecture arch of ALU is
signal sum_unsigned: std_logic_vector(8 downto 0); --Carry var mi?
signal alu_signal: std_logic_vector(7 downto 0);
signal add_overflow: std_logic;
signal sub_overflow: std_logic;

begin
process(ALU_Sel,A,B)
begin
	sum_unsigned<=(others =>'0');--reset parameters
	case ALU_Sel is
		when "000"=> --Toplama
			alu_signal<=A+B;
			sum_unsigned<=('0'&A)+('0'+B);
		when "001"=> --Cikarma
			alu_signal<=A-B;
			sum_unsigned<=('0'&A)-('0'+B);
		when "010"=>--AND
			alu_signal<=A and B;
		when "011"=>--OR
			alu_signal<=A or B;
		when "100"=>--Increment+1
			alu_signal<=A + x"01";
		when "101"=>--Decrement-1
			alu_signal<=A - x"01";
		when others=>
			alu_signal<=(others=>'0');
			sum_unsigned<=(others=>'0');
	end case;
end process;

ALU_result<=alu_signal;

--NZVC Flags
--N
NZVC(3)<=alu_signal(7);
--Z
NZVC(2)<='1' when alu_signal=x"00" else '0';
--V
add_overflow <= (not(A(7)) and not(B(7)) and alu_signal(7)) or (A(7) and B(7) and not(alu_signal(7)));
sub_overflow<=(not(A(7)) and B(7) and alu_signal(7)) or (A(7) and not(B(7)) and not(alu_signal(7)));

NZVC(1)<=add_overflow when (ALU_Sel="000") else
		sub_overflow when (ALU_Sel="001") else '0';
--C
NZVC(0)<=sum_unsigned(8) when (ALU_Sel="000")else
		 sum_unsigned(8) when (ALU_Sel="001")else '0';
end architecture;