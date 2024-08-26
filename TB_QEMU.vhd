library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use std.textio.all;

entity TB_QEMU is
	generic
		(g_bits			:	integer	:=	32
		;g_LUT			:	integer	:=	8
		;g_Log2Qubits	:	integer	:=	4
		);
end entity;

Architecture rtl of TB_QEMU is

	component QEMU is
		generic
			(g_bits			:integer	:= g_bits
			;g_LUT			:integer	:= g_LUT
			;g_Log2Qubits	:integer	:= g_Log2Qubits
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
	end component;
	
	type	t_Inst01 is array (0 to 102) of std_logic_vector(1 downto 0);
	type	t_Inst2 is array (0 to 102) of std_logic_vector(2**g_Log2Qubits-1 downto 0);
	
	--Constantes
	constant	c_Inst0	:	t_Inst01	:=	("01",																			--Acomodar la cantidad de Qubits a 1
													"10","10","10",															--H(Q0)
													"01",																			--Acomodar la cantidad de Qubits a 2
													"10","10","10",															--H(Q1)
													"01",																			--Acomodar la cantidad de Qubits a 4
													"01","10",																	--CCX(Q0,Q1,Q3)
													"01","10",																	--CX(Q0,Q1)
													"01","10",																	--CCX(Q1,Q2,Q3)
													"01","10",																	--CX(Q1,Q2)
													"01","10",																	--CX(Q0,Q1)
													"01","01",																	--Acomodar la cantidad de Qubits a 5 y reconfigurar los Qubits de control
													--Barrier
													"10","10","10",															--H(Q4)
													"01",																			--Acomodar la cantidad de Qubits a 6
													"10","10","10",															--H(Q5)
													"01",																			--Acomodar la cantidad de Qubits a 7
													"01","10",																	--CCX(Q4,Q5,Q6)
													"01","10",																	--CX(Q4,Q5)
													"01","10",																	--CCX(Q3,Q5,Q6)
													"01","10",																	--CX(Q5,Q3)
													"01","10",																	--CX(Q4,Q5)
													"01","01",																	--Acomodar la cantidad de Qubits a 8 y reconfigurar los Qubits de control
													--Barrier
													"10","10","10",															--H(Q7)
													"01",																			--Acomodar la cantidad de Qubits a 9
													"10","10","10",															--H(Q8)
													"01",																			--Acomodar la cantidad de Qubits a 10
													"01","10",																	--CCX(Q7,Q8,Q9)
													"01","10",																	--CX(Q7,Q8)
													"01","10",																	--CCX(Q6,Q8,Q9)
													"01","10",																	--CX(Q8,Q6)
													"01","10",																	--CX(Q7,Q8)
													"01","01",																	--Acomodar la cantidad de Qubits a 11 y reconfigurar los Qubits de control
													--Barrier
													"10","10","10",															--H(Q10)
													"01",																			--Acomodar la cantidad de Qubits a 12
													"10","10","10",															--H(Q11)
													"01",																			--Acomodar la cantidad de Qubits a 13
													"01","10",																	--CCX(Q10,Q11,Q12)
													"01","10",																	--CX(Q10,Q11)
													"01","10",																	--CCX(Q9,Q11,Q12)
													"01","10",																	--CX(Q11,Q9)
													"01","10",																	--CX(Q10,Q11)
													"01","01",																	--Acomodar la cantidad de Qubits a 14 y reconfigurar los Qubits de control
													--Barrier
													"10","10","10",															--H(Q13)
													"01",																			--Acomodar la cantidad de Qubits a 15
													"10","10","10",															--H(Q14)
													"01",																			--Acomodar la cantidad de Qubits a 16
													"01","10",																	--CCX(Q13,Q14,Q15)
													"01","10",																	--CX(Q13,Q14)
													"01","10",																	--CCX(Q12,Q14,Q15)
													"01","10",																	--CX(Q14,Q12)
													"01","10",																	--CX(Q13,Q14)
													"01",																			--reconfigurar los Qubits de control
													"01","01","11"																	--Medir(Q2,Q3,Q6,Q9,Q12,Q15)
													);
													
													
	constant c_Inst1	:	t_Inst01	:=	("10",																			--Acomodar la cantidad de Qubits a 1
													"10","11","10",															--H(Q0)
													"10",																			--Acomodar la cantidad de Qubits a 2
													"10","11","10",															--H(Q1)
													"10",																			--Acomodar la cantidad de Qubits a 4
													"00","01",																	--CCX(Q0,Q1,Q3)
													"00","01",																	--CX(Q0,Q1)
													"00","01",																	--CCX(Q1,Q2,Q3)
													"00","01",																	--CX(Q1,Q2)
													"00","01",																	--CX(Q0,Q1)
													"10","00",																	--Acomodar la cantidad de Qubits a 5 y re configurar los Qubits de control
													--Barrier
													"10","11","10",															--H(Q4)
													"10",																			--Acomodar la cantidad de Qubits a 6
													"10","11","10",															--H(Q5)
													"10",																			--Acomodar la cantidad de Qubits a 7
													"00","01",																	--CCX(Q4,Q5,Q6)
													"00","01",																	--CX(Q4,Q5)
													"00","01",																	--CCX(Q3,Q5,Q6)
													"00","01",																	--CX(Q5,Q3)
													"00","01",																	--CX(Q4,Q5)
													"10","00",																	--Acomodar la cantidad de Qubits a 8 y re configurar los Qubits de control
													--Barrier
													"10","11","10",															--H(Q7)
													"10",																			--Acomodar la cantidad de Qubits a 9
													"10","11","10",															--H(Q8)
													"10",																			--Acomodar la cantidad de Qubits a 10
													"00","01",																	--CCX(Q7,Q8,Q9)
													"00","01",																	--CX(Q7,Q8)
													"00","01",																	--CCX(Q6,Q8,Q9)
													"00","01",																	--CX(Q8,Q6)
													"00","01",																	--CX(Q7,Q8)
													"10","00",																	--Acomodar la cantidad de Qubits a 11 y re configurar los Qubits de control
													--Barrier
													"10","11","10",															--H(Q10)
													"10",																			--Acomodar la cantidad de Qubits a 12
													"10","11","10",															--H(Q11)
													"10",																			--Acomodar la cantidad de Qubits a 13
													"00","01",																	--CCX(Q10,Q11,Q12)
													"00","01",																	--CX(Q10,Q11)
													"00","01",																	--CCX(Q9,Q11,Q12)
													"00","01",																	--CX(Q11,Q9)
													"00","01",																	--CX(Q10,Q11)
													"10","00",																	--Acomodar la cantidad de Qubits a 14 y re configurar los Qubits de control
													--Barrier
													"10","11","10",															--H(Q13)
													"10",																			--Acomodar la cantidad de Qubits a 15
													"10","11","10",															--H(Q14)
													"10",																			--Acomodar la cantidad de Qubits a 16
													"00","01",																	--CCX(Q13,Q14,Q15)
													"00","01",																	--CX(Q13,Q14)
													"00","01",																	--CCX(Q12,Q14,Q15)
													"00","01",																	--CX(Q14,Q12)
													"00","01",																	--CX(Q13,Q14)
													"00",																			--re configurar los Qubits de control
													"00","01","00"																	--Medir(Q2,Q3,Q6,Q9,Q12,Q15)
													);
													
													
	constant	c_Inst2	:	t_Inst2	:=	("0000000000000001",															--Acomodar la cantidad de Qubits a 1
													"0000111000000000","0000100000000000","0000001000000000",	--H(Q0)
													"0000000000000010",														--Acomodar la cantidad de Qubits a 2
													"0000111000000001","0000100000000001","0000001000000001",	--H(Q1)
													"0000000000000100",														--Acomodar la cantidad de Qubits a 4
													"0000000000000011","0000100000000011",								--CCX(Q0,Q1,Q3)
													"0000000000000001","0000100000000001",								--CX(Q0,Q1)
													"0000000000000110","0000100000000011",								--CCX(Q1,Q2,Q3)
													"0000000000000010","0000100000000010",								--CX(Q1,Q2)
													"0000000000000001","0000100000000001",								--CX(Q0,Q1)
													"0000000000000101","0000000000000000",								--Acomodar la cantidad de Qubits a 5 y re confiugurar los Qubits de control
													--Barrier
													"0000111000000100","0000100000000100","0000001000000100",	--H(Q4)
													"0000000000000110",														--Acomodar la cantidad de Qubits a 6
													"0000111000000101","0000100000000101","0000001000000101",	--H(Q5)
													"0000000000000111",														--Acomodar la cantidad de Qubits a 7
													"0000000000110000","0000100000000110",								--CCX(Q4,Q5,Q6)
													"0000000000010000","0000100000000101",								--CX(Q4,Q5)
													"0000000000101000","0000100000000110",								--CCX(Q3,Q5,Q6)
													"0000000000100000","0000100000000011",								--CX(Q5,Q3)
													"0000000000010000","0000100000000101",								--CX(Q4,Q5)
													"0000000000001000","0000000000000000",								--Acomodar la cantidad de Qubits a 8 y re confiugurar los Qubits de control
													--Barrier
													"0000111000000111","0000100000000111","0000001000000111",	--H(Q7)
													"0000000000001001",														--Acomodar la cantidad de Qubits a 9
													"0000111000001000","0000100000001000","0000001000001000",	--H(Q8)
													"0000000000001010",														--Acomodar la cantidad de Qubits a 10
													"0000000110000000","0000100000001001",								--CCX(Q7,Q8,Q9)
													"0000000010000000","0000100000001000",								--CX(Q7,Q8)
													"0000000101000000","0000100000001001",								--CCX(Q6,Q8,Q9)
													"0000000100000000","0000100000000110",								--CX(Q8,Q6)
													"0000000010000000","0000100000001000",								--CX(Q7,Q8)
													"0000000000001011","0000000000000000",								--Acomodar la cantidad de Qubits a 11 y re confiugurar los Qubits de control
													--Barrier
													"0000111000001010","0000100000001010","0000001000001010",	--H(Q10)
													"0000000000001100",														--Acomodar la cantidad de Qubits a 12
													"0000111000001011","0000100000001011","0000001000001011",	--H(Q11)
													"0000000000001101",														--Acomodar la cantidad de Qubits a 13
													"0000110000000000","0000100000001100",								--CCX(Q10,Q11,Q12)
													"0000010000000000","0000100000001011",								--CX(Q10,Q11)
													"0000101000000000","0000100000001100",								--CCX(Q9,Q11,Q12)
													"0000100000000000","0000100000001001",								--CX(Q11,Q9)
													"0000010000000000","0000100000001011",								--CX(Q10,Q11)
													"0000000000001110","0000000000000000",								--Acomodar la cantidad de Qubits a 14 y re confiugurar los Qubits de control
													--Barrier
													"0000111000001101","0000100000001101","0000001000001101",	--H(Q13)
													"0000000000001111",														--Acomodar la cantidad de Qubits a 15
													"0000111000001110","0000100000001110","0000001000001110",	--H(Q14)
													"0000000000010000",														--Acomodar la cantidad de Qubits a 16
													"0110000000000000","0000100000001111",								--CCX(Q13,Q14,Q15)
													"0010000000000000","0000100000001110",								--CX(Q13,Q14)
													"0101000000000000","0000100000001111",								--CCX(Q12,Q14,Q15)
													"0100000000000000","0000100000001100",								--CX(Q14,Q12)
													"0010000000000000","0000100000001110",								--CX(Q13,Q14)
													"0000000000000000",														--re confiugurar los Qubits de control
													"1001001001001000","0000000000000100","0000000000000010"		--Medir(Q2,Q3,Q6,Q9,Q12,Q15)
													);
	
	--Senales del componente Qemu
	signal	i_Clk			:	std_logic;
	signal	i_Inst0		:	std_logic_vector(1 downto 0);
	signal	i_Inst1		:	std_logic_vector(1 downto 0);
	signal	i_Inst2		:	std_logic_vector(2**g_Log2Qubits-1 downto 0);
	signal	i_Reset		:	std_logic;
	signal	i_ResetMem	:	std_logic;
	signal	o_Busy		:	std_logic;
	signal	o_ReState	:	std_logic_vector(g_bits-1 downto 0);
	signal	o_ImState	:	std_logic_vector(g_bits-1 downto 0);
	signal	o_DReady		:	std_logic;
	
	file	f_Data:text;

begin
	
	A:	QEMU	port map (i_Clk,i_Inst0,i_Inst1,i_Inst2,i_Reset,i_ResetMem,o_Busy,o_ReState,o_ImState,o_DReady);
	
	process
	begin
		i_Clk	<=	'0';
		wait for 10 ns;
		i_Clk	<=	'1';
		wait for 10 ns;
	end process;
	
	--Instrucciones
	process
		variable	i	:	integer	:=	0;
	begin
		i_Inst0	<=	"00";
		i_Inst1	<=	(others	=>	'0');
		i_Inst2	<=	(others	=>	'0');
		wait for 20 ns;
		if (o_Busy	=	'0' and i_Reset	=	'0') then
			i_Inst0	<=	c_Inst0(i);
			i_Inst1	<=	c_Inst1(i);
			i_Inst2	<=	c_Inst2(i);
			i := i + 1;
			wait for 20 ns;
		elsif (o_DReady = '1') then
			wait for 100 ns;
			i_Inst2(0)	<=	'1';
			wait for 20 ns;
		end if;
	end process;
	
	--Senales de reinicio
	process
	begin
		i_Reset	<=	'0';
		wait for 10 ns;
		i_Reset	<=	'1';
		i_ResetMem	<=	'0';
		wait for 20 ns;
		i_Reset	<=	'0';
		wait;
	end process;
	
	--Exportando resultados
	process
		variable l:line;
		variable status:file_open_status;
	begin
		wait until (rising_edge(o_DReady));
		if(o_DReady = '1') then
			wait for 15 ns;
			file_open(status,f_Data,"Tests\Base\ReState63.txt",append_mode);
			assert status=open_ok
				report "No se pudo crear el archivo ReState"
				severity failure;
			write(l,to_integer(signed(o_ReState)));
			writeline(f_Data,l);
			file_close(f_Data);
			
			file_open(status,f_Data,"Tests\Base\ImState63.txt",append_mode);
			assert status=open_ok
				report "No se pudo crear el archivo ImState"
				severity failure;
			write(l,to_integer(signed(o_ImState)));
			writeline(f_Data,l);
			file_close(f_Data);
		end if;
	end process;
end rtl;