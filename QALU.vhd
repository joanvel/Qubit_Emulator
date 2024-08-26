library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity QALU is
	generic(g_bits:integer:=32
				;g_LUT:integer:=8);
	port
		(i_U:	in std_logic_vector(1 downto 0)
		;i_angle:	in std_logic_vector(g_LUT-1 downto 0)
		;i_ReS0:	in std_logic_vector(g_bits-1 downto 0)
		;i_ImS0:	in std_logic_vector(g_bits-1 downto 0)
		;i_ReS1:	in std_logic_vector(g_bits-1 downto 0)
		;i_ImS1:	in std_logic_vector(g_bits-1 downto 0)
		;o_ReS0:	out std_logic_vector(g_bits-1 downto 0)
		;o_ImS0:	out std_logic_vector(g_bits-1 downto 0)
		;o_ReS1:	out std_logic_vector(g_bits-1 downto 0)
		;o_ImS1:	out std_logic_vector(g_bits-1 downto 0)
		);
end entity;

architecture rtl of QALU is

	component Cos_LUT is
		generic(g_LUT:integer:=g_LUT
					;g_bits:integer:=g_bits);
		port(i_angle	:	in		std_logic_vector(g_LUT-1 downto 0)
				;o_Cos	:	out	std_logic_vector(g_bits-1 downto 0)
				);
	end component;
	
	component Sin_LUT is
		generic(g_LUT:integer:=g_LUT
					;g_bits:integer:=g_bits);
		port(i_angle	:	in		std_logic_vector(g_LUT-1 downto 0)
				;o_Sin	:	out	std_logic_vector(g_bits-1 downto 0)
				);
	end component;
	
	component MultC is
		generic(g_bits:integer:=g_bits);
		port
			(i_ReA:	in std_logic_vector(g_bits-1 downto 0)--Parte real de la entrada A
			;i_ImA:	in std_logic_vector(g_bits-1 downto 0)--Parte imaginaria de la entrada A
			;i_ReB:	in std_logic_vector(g_bits-1 downto 0)--Parte real de la entrada B
			;i_ImB:	in	std_logic_vector(g_bits-1 downto 0)--Parte imaginaria de la entrada B
			;o_Re:	out	std_logic_vector(g_bits-1 downto 0)--Parte real de la salida
			;o_Im:	out	std_logic_vector(g_bits-1 downto 0)--Parte imaginaria de la salida
			);
	end component;
	
	component Inv is
		generic(g_bits:integer:=32);
		port
			(i_Data:	in std_logic_vector(g_bits-1 downto 0)
			;o_Data:	out std_logic_vector(g_bits-1 downto 0)
			);
	end component;
	
	signal s_Cos,s_Sin,s_NSin:std_logic_vector(g_bits-1 downto 0);
	
	signal s_m1,s_m2,s_m3:std_logic_vector(g_bits-1 downto 0);
	
	signal s_ImA00,s_ReA01,s_ImA01,s_ReA10,s_ImA10,s_ImA11:std_logic_vector(g_bits-1 downto 0);
	
	signal s_Re00,s_Im00,s_Re01,s_Im01,s_Re10,s_Im10,s_Re11,s_Im11:std_logic_vector(g_bits-1 downto 0);

begin

	Cos:	Cos_LUT	port map (i_angle,s_Cos);
	Sin:	Sin_LUT	port map (i_angle,s_Sin);
	
	NSin:	Inv	port map (s_Sin,S_NSin);
	
	s_m1	<=	(others=>(not(i_U(1)) and i_U(0)));
	s_m2	<=	(others=>(i_U(1) and not(i_U(0))));
	s_m3	<=	(others=>(i_U(1) and i_U(0)));
	
	s_ImA00	<=	s_m3 and s_NSin;
	s_ReA01	<=	s_m2 and s_NSin;
	s_ImA01	<=	s_m1 and s_NSin;
	s_ReA10	<=	s_m2 and s_Sin;
	s_ImA10	<= s_ImA01;
	s_ImA11	<=	s_m3 and s_Sin;
	
	Mult00:	MultC	port map (s_Cos	,s_ImA00	,i_ReS0	,i_ImS0	,s_Re00	,s_Im00);
	Mult01:	MultC	port map (s_ReA01	,s_ImA01	,i_ReS1	,i_ImS1	,s_Re01	,s_Im01);
	Mult10:	MultC	port map (s_ReA10	,s_ImA10	,i_ReS0	,i_ImS0	,s_Re10	,s_Im10);
	Mult11:	MultC	port map (s_Cos	,s_ImA11	,i_ReS1	,i_ImS1	,s_Re11	,s_Im11);
	
	o_ReS0	<=	std_logic_vector(signed(s_Re00) + signed(s_Re01));
	o_ImS0	<=	std_logic_vector(signed(s_Im00) + signed(s_Im01));
	o_ReS1	<=	std_logic_vector(signed(s_Re10) + signed(s_Re11));
	o_ImS1	<=	std_logic_vector(signed(s_Im10) + signed(s_Im11));

end rtl;