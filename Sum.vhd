library ieee;
use ieee.std_logic_1164.all;

entity Sum is
	generic(g_bits:integer:=4);
	port
		(i_Data	:	in std_logic_vector(g_bits-1 downto 0)
		;o_Data	:	out std_logic_vector(g_bits-1 downto 0)
		);
end entity;

Architecture rtl of Sum is
	signal s_Temp	: std_logic_vector(g_bits-1 downto 0);
begin
	o_Data(0)	<=	not(i_Data(0));
	s_Temp(0)	<=	i_Data(0);
	
	A:	for i in 1 to g_bits-1 generate
			s_Temp(i)	<= i_Data(i) and s_Temp(i-1);
			o_Data(i)	<=	i_Data(i) xor s_Temp(i-1);
		end generate;
end rtl;