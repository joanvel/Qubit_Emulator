library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity MaskGen is
	generic(g_bits:integer:=8);
	port
		(i_Data	:	in std_logic_vector(g_bits-1 downto 0)
		;o_Data	:	out std_logic_vector(2**g_bits-1 downto 0)
		);
end entity;

architecture rtl of MaskGen is
	signal s_Temp,s_Temp2	:	std_logic_vector(2**g_bits-1 downto 0);
begin

	process(i_Data)
		variable	v_Temp	:	std_logic_vector(2**g_bits-1 downto 0);
	begin
		v_Temp	:=	(others=>	'0');
		v_Temp(to_integer(unsigned(i_Data)))	:=	'1';
		s_Temp	<=	v_Temp;
	end process;
	
	o_Data(0)	<=	s_Temp(0);
	s_Temp2(0)	<=	s_Temp(0);
	
	A:	for i in 1 to 2**g_bits-1 generate
			s_Temp2(i)	<= s_Temp(i) or s_Temp2(i-1);
		end generate;
	
	o_Data	<=	s_Temp2;

end rtl;