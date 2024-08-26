library ieee;
use ieee.std_logic_1164.all;

entity Inv is
	generic(g_bits:integer:=4);
	port
		(i_Data:	in std_logic_vector(g_bits-1 downto 0)
		;o_Data:	out std_logic_vector(g_bits-1 downto 0)
		);
end entity;

architecture rtl of Inv is

	signal s_Temp:std_logic_vector(g_bits-1 downto 0);

begin

	s_Temp(0)	<=	not(i_Data(0));
	o_Data(0)	<=	i_Data(0);
	
	A:	for i in 1 to g_bits-1 generate
			o_Data(i)	<=	not(i_Data(i)) xor s_Temp(i-1);
			s_Temp(i)	<=	not(i_data(i)) and s_Temp(i-1);
		end generate;
	
end rtl;