library ieee;
use ieee.std_logic_1164.all;

entity FSM is
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
		;o_DReady		:	out	std_logic
		);
end entity;


Architecture rtl of FSM is

	type t_state is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11);
	
	signal s_state	:	t_state;

begin

	process(i_Clk, i_Reset)
	begin
		if i_Reset	=	'1' then
			s_state	<=	S0;
		elsif(rising_edge(i_Clk)) then
			case s_state is
				when	S0	=>
					if (i_OP	=	"00") then
						s_state	<=	S0;
					elsif (i_OP	=	"01") then
						s_state	<=	S1;
					elsif (i_OP	=	"10") then
						s_state	<=	S2;
					else
						s_state	<=	S9;
					end if;
				when	S1	=>
					s_state	<=	S0;
				when	S2	=>
					s_state	<=	S3;
				when	S3	=>
					s_state	<=	S4;
				when	S4	=>
					s_state	<=	S5;
				when	S5	=>
					s_state	<=	S6;
				when	S6	=>
					s_state	<=	S7;
				when	s7	=>
					if(i_Finish	=	'1') then
						s_state	<=	S0;
					else
						s_state	<=	S8;
					end if;
				when	S8	=>
					s_state	<=	S3;
				when	S9	=>
					s_state	<=	S10;
				when	S10	=>
					if(i_Finish	=	'1') then
						s_state	<=	S0;
					else
						if(i_NextState	=	'0') then
							s_state	<=	S10;
						else
							s_state	<=	S11;
						end if;
					end if;
				when	S11	=>
					s_state	<=	S9;
				when others =>
					NULL;
			end case;
		end if;
	end process;
	
	process(s_state)
	begin
		case s_state is
			when	S0	=>
				o_WriteInst	<=	'1';
				o_WriteAddr	<=	'0';
				o_WState		<=	'0';
				o_WriteInA	<=	'0';
				o_WriteInB	<=	'0';
				o_cMUX		<=	'0';
				o_WriteMem	<=	'0';
				o_NextState	<=	'0';
				o_WriteOut	<=	'0';
				o_Busy		<=	'0';
				o_Reset		<=	'1';
				o_DReady		<=	'0';
			when	S1	=>
				o_WriteInst	<=	'0';
				o_WriteAddr	<=	'1';
				o_WState		<=	'0';
				o_WriteInA	<=	'0';
				o_WriteInB	<=	'0';
				o_cMUX		<=	'0';
				o_WriteMem	<=	'0';
				o_NextState	<=	'0';
				o_WriteOut	<=	'0';
				o_Busy		<=	'1';
				o_Reset		<=	'0';
				o_DReady		<=	'0';
			when	S2	=>
				o_WriteInst	<=	'0';
				o_WriteAddr	<=	'0';
				o_WState		<=	'0';
				o_WriteInA	<=	'0';
				o_WriteInB	<=	'0';
				o_cMUX		<=	'0';
				o_WriteMem	<=	'0';
				o_NextState	<=	'0';
				o_WriteOut	<=	'0';
				o_Busy		<=	'1';
				o_Reset		<=	'0';
				o_DReady		<=	'0';
			when	S3	=>
				o_WriteInst	<=	'0';
				o_WriteAddr	<=	'0';
				o_WState		<=	'0';
				o_WriteInA	<=	'1';
				o_WriteInB	<=	'0';
				o_cMUX		<=	'0';
				o_WriteMem	<=	'0';
				o_NextState	<=	'0';
				o_WriteOut	<=	'0';
				o_Busy		<=	'1';
				o_Reset		<=	'0';
				o_DReady		<=	'0';
			when	S4	=>
				o_WriteInst	<=	'0';
				o_WriteAddr	<=	'0';
				o_WState		<=	'0';
				o_WriteInA	<=	'0';
				o_WriteInB	<=	'0';
				o_cMUX		<=	'0';
				o_WriteMem	<=	'0';
				o_NextState	<=	'1';
				o_WriteOut	<=	'0';
				o_Busy		<=	'1';
				o_Reset		<=	'0';
				o_DReady		<=	'0';
			when	S5	=>
				o_WriteInst	<=	'0';
				o_WriteAddr	<=	'0';
				o_WState		<=	'0';
				o_WriteInA	<=	'0';
				o_WriteInB	<=	'1';
				o_cMUX		<=	'0';
				o_WriteMem	<=	'0';
				o_NextState	<=	'1';
				o_WriteOut	<=	'0';
				o_Busy		<=	'1';
				o_Reset		<=	'0';
				o_DReady		<=	'0';
			when	S6	=>
				o_WriteInst	<=	'0';
				o_WriteAddr	<=	'0';
				o_WState		<=	'0';
				o_WriteInA	<=	'0';
				o_WriteInB	<=	'0';
				o_cMUX		<=	'0';
				o_WriteMem	<=	'1';
				o_NextState	<=	'0';
				o_WriteOut	<=	'0';
				o_Busy		<=	'1';
				o_Reset		<=	'0';
				o_DReady		<=	'0';
			when	S7	=>
				o_WriteInst	<=	'0';
				o_WriteAddr	<=	'0';
				o_WState		<=	'0';
				o_WriteInA	<=	'0';
				o_WriteInB	<=	'0';
				o_cMUX		<=	'1';
				o_WriteMem	<=	'1';
				o_NextState	<=	'1';
				o_WriteOut	<=	'0';
				o_Busy		<=	'1';
				o_Reset		<=	'0';
				o_DReady		<=	'0';
			when	S8	=>
				o_WriteInst	<=	'0';
				o_WriteAddr	<=	'0';
				o_WState		<=	'1';
				o_WriteInA	<=	'0';
				o_WriteInB	<=	'0';
				o_cMUX		<=	'0';
				o_WriteMem	<=	'0';
				o_NextState	<=	'0';
				o_WriteOut	<=	'0';
				o_Busy		<=	'1';
				o_Reset		<=	'0';
				o_DReady		<=	'0';
			when	S9	=>
				o_WriteInst	<=	'0';
				o_WriteAddr	<=	'0';
				o_WState		<=	'0';
				o_WriteInA	<=	'0';
				o_WriteInB	<=	'0';
				o_cMUX		<=	'0';
				o_WriteMem	<=	'0';
				o_NextState	<=	'0';
				o_WriteOut	<=	'0';
				o_Busy		<=	'1';
				o_Reset		<=	'0';
				o_DReady		<=	'0';
			when	S10	=>
				o_WriteInst	<=	'0';
				o_WriteAddr	<=	'0';
				o_WState		<=	'0';
				o_WriteInA	<=	'0';
				o_WriteInB	<=	'0';
				o_cMUX		<=	'0';
				o_WriteMem	<=	'0';
				o_NextState	<=	'0';
				o_WriteOut	<=	'1';
				o_Busy		<=	'1';
				o_Reset		<=	'0';
				o_DReady		<=	'1';
			when	S11	=>
				o_WriteInst	<=	'0';
				o_WriteAddr	<=	'0';
				o_WState		<=	'1';
				o_WriteInA	<=	'0';
				o_WriteInB	<=	'0';
				o_cMUX		<=	'0';
				o_WriteMem	<=	'0';
				o_NextState	<=	'1';
				o_WriteOut	<=	'0';
				o_Busy		<=	'1';
				o_Reset		<=	'0';
				o_DReady		<=	'0';
			when others	=>
				NULL;
		end case;
	end process;

end rtl;