library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_wallace_tree is
--  Port ( );
end tb_wallace_tree;

architecture Behavioral of tb_wallace_tree is
component wallace_tree is
	port(
	A_in:in std_logic_vector(3 downto 0);
	B_in:in std_logic_vector(3 downto 0);
	--Outputs
	result:out std_logic_vector(7 downto 0)
	);
end component;

signal A_in:std_logic_vector(3 downto 0);
signal B_in: std_logic_vector(3 downto 0);
signal result: std_logic_vector(7 downto 0);

begin
uut: wallace_tree port map(
        A_in=>A_in,
        B_in=>B_in,
        result=>result
);
 
--Test Case:
stim_procc:process
begin
A_in<="0000";
B_in<="0100";
wait for 20ns;

A_in<="0110";
B_in<="0100";
wait for 20ns;

A_in<="1111";
B_in<="0100";
wait for 20ns;

A_in<="1000";
B_in<="0111";
wait for 20ns;

A_in<="1111";
B_in<="1111";
wait for 20ns;

end process;
end Behavioral;