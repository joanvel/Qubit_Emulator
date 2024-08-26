library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity AddrGen is
	generic(g_Log2Qubits:integer:=4);
	port
		(i_Clk		:	in std_logic													--Senal de reloj
		;i_Data1																				--Entrada de Qubits de control
		,i_Data2		:	in std_logic_vector(2**g_Log2Qubits-1 downto 0)		--Entrada de Qubits de control inversos
		;i_Qubit		:	in std_logic_vector(g_Log2Qubits-1 downto 0)			--Entrada de Qubit Objetivo
		;i_W			:	in std_logic													--Entrada para habilitar la escritura en el registro
		;i_Reset		:	in std_logic													--Entrada de reinicio del registro
		;i_Q			:	in std_logic													--Entrada de seleccion de cual de los dos estados base leer
		;i_nQubits	:	in std_logic_vector(g_Log2Qubits downto 0)			--Entrada que inidica la cantidad de Qubits
		;o_Finish	:	out std_logic													--Salida que inidica el fin de todos los estados a procesar
		;o_Data		:	out std_logic_vector(2**g_Log2Qubits-1 downto 0)	--Salida del estado base a leer
		);
end entity;

Architecture rtl of AddrGen is

	component Sum is
		generic(g_bits:integer:=2**g_Log2Qubits);
		port
			(i_Data	:	in std_logic_vector(g_bits-1 downto 0)
			;o_Data	:	out std_logic_vector(g_bits-1 downto 0)
			);
	end component;
	
	component MaskGen is
		generic(g_bits:integer:=g_Log2Qubits+1);
		port
			(i_Data	:	in std_logic_vector(g_bits-1 downto 0)
			;o_Data	:	out std_logic_vector(2**g_bits-1 downto 0)
			);
	end component;
	
	signal s_Mux	:	std_logic_vector(2**g_Log2Qubits-1 downto 0);	--Se;al que conecta la salida del multiplexor con la entrada del registro
	signal s_add	:	std_logic_vector(2**g_Log2Qubits-1 downto 0);	--Senal que conecta la salida del sumador con la entrada del multiplexor
	signal s_Reg	:	std_logic_vector(2**g_Log2Qubits-1 downto 0);	--Senal que conecta la salida del registro con la entrada de la compuerta or
	signal s_Or		:	std_logic_vector(2**g_Log2Qubits-1 downto 0);	--Senal que conecta la salida del or con la entrada del sumador y la entrada de la xor
	signal s_DeMux	:	std_logic_vector(2**g_Log2Qubits-1 downto 0);	--Senal que conecta la salida del demultiplexor con la entrada de la and
	signal s_and	:	std_logic_vector(2**g_Log2Qubits-1 downto 0);	--Senal que conecta la salida de la and con la entrada de la xor
	signal s_xor	:	std_logic_vector(2**g_Log2Qubits-1 downto 0);	--Senal que conecta la salida de una xor con la otra xor
	
	signal s_Mask	:	std_logic_vector(2**(g_Log2Qubits+1)-1 downto 0);	--Senal que conecta el generador de mascaras con la or
	signal s_or1	:	std_logic_vector(2**g_Log2Qubits-1 downto 0);		--Senal que conecta la or con la and

begin
	
	--Registro
	process(i_Clk,i_Reset)
		variable v_Temp	:	std_logic_vector(2**g_Log2Qubits-1 downto 0);
	begin
		if(i_Reset	=	'1') then
			v_Temp	:=	(others=>'0');
		else
			if (rising_edge(i_Clk)) then
				if(i_W	= '1') then
					v_Temp	:=	s_add;
				end if;
			end if;
		end if;
		s_Reg	<=	v_Temp;
	end process;
	
	--Sumador
	Add	:	Sum	port map (s_Or,s_add);
	
	--Or
	s_Or	<=	s_Reg or s_DeMux or i_Data1;
	
	--Demux
	process(i_Qubit)
		variable	v_Temp	:	std_logic_vector(2**g_Log2Qubits-1 downto 0);
	begin
		v_Temp	:= (others=>'0');
		v_Temp(to_integer(unsigned(i_Qubit)))	:=	'1';
		s_DeMux	<=	v_Temp;
	end process;
	
	--and
	A:	for i in 0 to 2**g_Log2Qubits-1 generate
			s_and(i)	<=	not(i_Q) and s_DeMux(i);
		end generate;
	
	--Xor0
	s_xor	<=	s_Or xor i_Data2;
	
	--Xor1
	o_Data	<=	s_and xor s_xor;
	
	--Generador de mascara
	MG:	MaskGen	port map (i_nQubits, s_Mask);
	
	--Or
	s_or1	<=	s_Or or s_Mask(2**g_Log2Qubits-1 downto 0);
	
	--and
	process(s_or1)
		variable v_Temp	:	std_logic;
	begin
		v_Temp	:=	'1';
		for i in 0 to 2**g_Log2Qubits-1 loop
			v_Temp	:=	s_or1(i) and v_Temp;
		end loop;
		o_Finish	<=	v_Temp;
	end process;

end rtl;