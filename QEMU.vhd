library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity QEMU is
	generic
		(g_bits			:integer	:= 32
		;g_LUT			:integer	:= 8
		;g_Log2Qubits	:integer	:= 4
		);
	port
		(i_Clk		:	in std_logic
		;i_Inst0		:	in std_logic_vector(1 downto 0)
		;i_Inst1		:	in std_logic_vector(1 downto 0)
		;i_Inst2		:	in	std_logic_vector(2**g_Log2Qubits-1 downto 0)
		;i_Reset		:	in	std_logic
		;i_ResetMem	:	in	std_logic
		;o_Busy		:	out	std_logic
		;o_ReState	:	out	std_logic_vector(g_bits-1 downto 0)
		;o_ImState	:	out	std_logic_vector(g_bits-1 downto 0)
		;o_DReady	:	out	std_logic
		);
end entity;

Architecture rtl of QEMU is

	component QALU is
		generic
			(g_bits	:integer	:= g_bits
			;g_LUT	:integer	:= g_LUT
			);
		port
			(i_U		:	in std_logic_vector(1 downto 0)
			;i_angle	:	in std_logic_vector(g_LUT-1 downto 0)
			;i_ReS0	:	in std_logic_vector(g_bits-1 downto 0)
			;i_ImS0	:	in std_logic_vector(g_bits-1 downto 0)
			;i_ReS1	:	in std_logic_vector(g_bits-1 downto 0)
			;i_ImS1	:	in std_logic_vector(g_bits-1 downto 0)
			;o_ReS0	:	out std_logic_vector(g_bits-1 downto 0)
			;o_ImS0	:	out std_logic_vector(g_bits-1 downto 0)
			;o_ReS1	:	out std_logic_vector(g_bits-1 downto 0)
			;o_ImS1	:	out std_logic_vector(g_bits-1 downto 0)
			);
	end component;
	
	component AddrGen	is
		generic
			(g_Log2Qubits	:integer	:= g_Log2Qubits
			);
		port
			(i_Clk		:	in std_logic													--Senal de reloj
			;i_Data1																				--Entrada de Qubits de control
			,i_Data2		:	in std_logic_vector(2**g_Log2Qubits-1 downto 0)		--Entrada de Qubits de control inversos
			;i_Qubit		:	in std_logic_vector(g_Log2Qubits-1 downto 0)			--Entrada de Qubit Objetivo
			;i_W			:	in std_logic													--Entrada para habilitar la escritura en el registro
			;i_Reset		:	in std_logic													--Entrada de reinicio del registro
			;i_Q			:	in std_logic													--Entrada de seleccion de cual de los dos estados base leer
			;i_nQubits	:	in std_logic_vector(g_Log2Qubits downto 0)			--Entrada que inidica la cantidad de Qubits
			;o_Finish	:	out	std_logic												--Salida que inidica el fin de todos los estados a procesar
			;o_Data		:	out	std_logic_vector(2**g_Log2Qubits-1 downto 0)	--Salida del estado base a leer
			);
	end component;
	
	component FSM is
		port
			(i_Clk			:	in	std_logic
			;i_Reset			:	in	std_logic
			;i_OP				:	in	std_logic_vector(1 downto 0)
			;i_Finish		:	in std_logic
			;i_NextState	:	in	std_logic
			;o_WriteInst	:	out	std_logic
			;o_WriteAddr	:	out	std_logic
			;o_WState		:	out	std_logic
			;o_WriteInA		:	out	std_logic
			;o_WriteInB		:	out	std_logic
			;o_cMUX			:	out	std_logic
			;o_WriteMem		:	out	std_logic
			;o_NextState	:	out	std_logic
			;o_WriteOut		:	out	std_logic
			;o_Busy			:	out	std_logic
			;o_Reset			:	out	std_logic
			;o_DReady			:	out	std_logic
			);
	end component;
	
	component RAMMem
		PORT
			(
				address		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
				clock		: IN STD_LOGIC  := '1';
				data		: IN STD_LOGIC_VECTOR (63 DOWNTO 0);
				wren		: IN STD_LOGIC ;
				q		: OUT STD_LOGIC_VECTOR (63 DOWNTO 0)
			);
	end component;
	
	--Senales para la QALU
	signal	s_U		:std_logic_vector(1 downto 0);
	signal	s_angle	:std_logic_vector(g_LUT-1 downto 0);
	signal	s_iReS0	:std_logic_vector(g_bits-1 downto 0);
	signal	s_iImS0	:std_logic_vector(g_bits-1 downto 0);
	signal	s_iReS1	:std_logic_vector(g_bits-1 downto 0);
	signal	s_iImS1	:std_logic_vector(g_bits-1 downto 0);
	signal	s_oReS0	:std_logic_vector(g_bits-1 downto 0);
	signal	s_oImS0	:std_logic_vector(g_bits-1 downto 0);
	signal	s_oReS1	:std_logic_vector(g_bits-1 downto 0);
	signal	s_oImS1	:std_logic_vector(g_bits-1 downto 0);
	
	--Senales para AddrGen
	signal	s_NClk		:std_logic;
	signal	s_Data1		:std_logic_vector(2**g_Log2Qubits-1 downto 0);
	signal	s_Data2		:std_logic_vector(2**g_Log2Qubits-1 downto 0);
	signal	s_Qubit		:std_logic_vector(g_Log2Qubits-1 downto 0);
	signal	s_W			:std_logic;
	signal	s_Reset		:std_logic;
	signal	s_Q			:std_logic;
	signal	s_nQubits	:std_logic_vector(g_Log2Qubits downto 0);
	signal	s_Finish		:std_logic;
	signal	s_Data		:std_logic_vector(2**g_Log2Qubits-1 downto 0);
	
	--Senales para FSM
	signal	s_Clk				:std_logic;
	signal	s_OP				:std_logic_vector(1 downto 0);
	--signal	s_Finish			:std_logic;
	signal	s_iNextState	:std_logic;
	signal	s_WriteInst		:std_logic;
	signal	s_WriteAddr		:std_logic;
	signal	s_WState			:std_logic;
	signal	s_WriteInA		:std_logic;
	signal	s_WriteInB		:std_logic;
	signal	s_cMUX			:std_logic;
	signal	s_WriteMem		:std_logic;
	signal	s_oNextState	:std_logic;
	signal	s_WriteOut		:std_logic;
	signal	s_Busy			:std_logic;
	
	--Senales RAMMemory
	signal	s_address		:std_logic_vector(15 downto 0);
	--signal	s_NClk			:std_logic;
	signal	s_idata			:std_logic_vector(63	downto 0);
	signal	s_wren			:std_logic;
	signal	s_odata				:std_logic_vector(63 downto 0);
	
	--Otras senales
	signal	s_DeMUX			:std_logic_vector(3 downto 0);
	signal	s_WData1			:std_logic;
	signal	s_WData2			:std_logic;
	signal	s_WnQubits		:std_logic;
	signal	s_Inst0			:std_logic_vector(1 downto 0);
	signal	s_Inst1			:std_logic_vector(1 downto 0);
	signal	s_Inst2			:std_logic_vector(2**g_Log2Qubits-1 downto 0);
	

begin
	A:	QALU			port map	(i_U		=>	s_U
									,i_angle	=>	s_angle
									,i_ReS0	=>	s_iReS0
									,i_ImS0	=>	s_iImS0
									,i_ReS1	=>	s_iReS1
									,i_ImS1	=>	s_iImS1
									,o_ReS0	=>	s_oReS0
									,o_ImS0	=>	s_oImS0
									,o_ReS1	=>	s_oReS1
									,o_ImS1	=>	s_oImS1
									);
	B:	AddrGen		port map	(i_Clk		=>	s_NClk
									,i_Data1		=>	s_Data1
									,i_Data2		=>	s_Data2
									,i_Qubit		=>	s_Qubit
									,i_W			=>	s_W
									,i_Reset		=>	s_Reset
									,i_Q			=>	s_Q
									,i_nQubits	=>	s_nQubits
									,o_Finish	=>	s_Finish
									,o_Data		=>	s_Data
									);
								
	C:	FSM			port map	(i_Clk			=>	s_Clk
									,i_Reset			=>	i_Reset
									,i_OP				=>	s_OP
									,i_Finish		=>	s_Finish
									,i_NextState	=>	s_iNextState
									,o_WriteInst	=>	s_WriteInst
									,o_WriteAddr	=>	s_WriteAddr
									,o_WState		=>	s_WState
									,o_WriteInA		=>	s_WriteInA
									,o_WriteInB		=>	s_WriteInB
									,o_cMUX			=>	s_cMUX
									,o_WriteMem		=>	s_WriteMem
									,o_NextState	=>	s_oNextState
									,o_WriteOut		=>	s_WriteOut
									,o_Busy			=>	o_Busy
									,o_Reset			=>	s_Reset
									,o_DReady		=>	o_DReady
									);
	
	D:	RAMMem		port map (address	=>	s_address
									,clock	=>	s_NClk
									,data		=>	s_idata
									,wren		=>	s_wren
									,q			=>	s_odata
									);
	
	s_Clk		<=	i_Clk;
	s_NClk	<=	not(i_Clk);
	
	--Registro del estado X0 a operar con el estado X1
	process(s_NClk)
		variable	v_Data	:	std_logic_vector(2*g_bits-1 downto 0);
	begin
		if rising_edge(s_Clk) then
			if	(s_WriteInA	=	'1')	then
				v_Data	:=	s_odata;
			end if;
		end if;
		s_iReS0	<=	v_Data(2*g_bits-1 downto g_bits);
		s_iImS0	<=	v_Data(g_bits-1 downto 0);
	end process;
	
	--Registro del estado X1 a operar con el estado X0
	process(s_NClk)
		variable	v_Data	:	std_logic_vector(2*g_bits-1 downto 0);
	begin
		if rising_edge(s_NClk) then
			if	(s_WriteInB	=	'1')	then
				v_Data	:=	s_odata;
			end if;
		end if;
		s_iReS1	<=	v_Data(2*g_bits-1 downto g_bits);
		s_iImS1	<=	v_Data(g_bits-1 downto 0);
	end process;
	
	--Multiplexor entre los estados de salida
	process(s_cMUX,s_oReS0,s_oImS0,s_oReS1,s_oImS1)
	begin
		case s_cMUX is
			when	'0'	=>
				s_idata(2*g_bits-1 downto g_bits)	<=	s_oReS0;
				s_idata(g_bits-1 downto 0)				<=	s_oImS0;
			when	'1'	=>
				s_idata(2*g_bits-1 downto g_bits)	<=	s_oReS1;
				s_idata(g_bits-1 downto 0)				<=	s_oImS1;
			when	others	=>
				NULL;
		end case;
	end process;
	
	--Conexiones entre senales
	s_wren			<=	s_WriteMem;
	s_address		<=	s_Data;
	s_OP				<=	s_Inst0;
	s_iNextState	<=	i_Inst2(0);
	s_Qubit			<=	s_Inst2(g_Log2Qubits-1 downto 0);
	s_Q				<=	s_oNextState;
	s_W				<=	s_WState;
	s_U				<=	s_Inst1;
	s_angle			<=	s_Inst2(g_LUT+g_Log2Qubits-1 downto g_Log2Qubits);
	
	--Registro de configuracion de Qubits de control
	process(s_NClk,i_Reset)
		variable	v_Temp	:	std_logic_vector(2**g_Log2Qubits-1 downto 0);
	begin
		if	(i_Reset	=	'1') then
			v_Temp	:=	(others	=>	'0');
		elsif rising_edge(s_NClk) then
			if (s_WData1	=	'1') then
				v_Temp	:=	s_Inst2;
			end if;
		end if;
		s_Data1	<=	v_Temp;
	end process;
	
	
	--Registro de invertir los Qubits de control
	process(s_NClk,i_Reset)
		variable	v_Temp	:	std_logic_vector(2**g_Log2Qubits-1 downto 0);
	begin
		if	(i_Reset	=	'1') then
			v_Temp	:=	(others	=>	'0');
		elsif rising_edge(s_NClk) then
			if (s_WData2	=	'1') then
				v_Temp	:=	s_Inst2;
			end if;
		end if;
		s_Data2	<=	v_Temp;
	end process;
	
	--Registro del numero de Qubits
	process(s_NClk,i_Reset)
		variable	v_Temp	:	std_logic_vector(g_Log2Qubits downto 0);
	begin
		if	(i_Reset	=	'1') then
			v_Temp	:=	(others	=>	'0');
		elsif rising_edge(s_NClk) then
			if (s_WnQubits	=	'1') then
				v_Temp	:=	s_Inst2(g_Log2Qubits downto 0);
			end if;
		end if;
		s_nQubits	<=	v_Temp;
	end process;
	
	--Demultiplexor
	process(s_Inst1)
		variable	v_Temp	:	std_logic_vector(3 downto 0);
	begin
		v_Temp	:=	(others	=>	'0');
		v_Temp(to_integer(unsigned(s_Inst1)))	:=	'1';
		s_DeMUX	<=	v_Temp;
	end process;
	
	--Registro de Instrucciones
	process(s_NClk,i_Reset)
		variable	v_Inst0	:	std_logic_vector(1 downto 0);
		variable	v_Inst1	:	std_logic_vector(1 downto 0);
		variable	v_Inst2	:	std_logic_vector(2**g_Log2Qubits-1 downto 0);
	begin
		if	(i_Reset	=	'1') then
			v_Inst0	:=	(others	=>	'0');
			v_Inst1	:=	(others	=>	'0');
			v_Inst2	:=	(others	=>	'0');
		elsif rising_edge(s_NClk) then
			if (s_WriteInst	=	'1') then
				v_Inst0	:=	i_Inst0;
				v_Inst1	:=	i_Inst1;
				v_Inst2	:=	i_Inst2;
			end if;
			
		end if;
		s_Inst0	<=	v_Inst0;
		s_Inst1	<=	v_Inst1;
		s_Inst2	<=	v_Inst2;
	end process;
	
	--Senales de escritura de los registros
	s_WData1		<=	s_DeMUX(0) and s_WriteAddr;
	s_WData2		<=	s_DeMUX(1) and s_WriteAddr;
	s_WnQubits	<=	s_DeMUX(2) and s_WriteAddr;
	
	--Registro de salida
	process(s_NClk,i_Reset)
		variable	v_Re	:	std_logic_vector(g_bits-1 downto 0);
		variable	v_Im	:	std_logic_vector(g_bits-1 downto 0);
	begin
		if(i_Reset	=	'1') then
			v_Re	:=	(others	=>	'0');
			v_Im	:=	(others	=>	'0');
		elsif(rising_edge(s_NClk)) then
			if(s_WriteOut	=	'1') then
				v_Re	:=	s_odata(2*g_bits-1 downto g_bits);
				v_Im	:=	s_odata(g_bits-1 downto 0);
			end if;
		end if;
		o_ReState	<=	v_Re;
		o_ImState	<=	v_Im;
	end process;
	
end rtl;