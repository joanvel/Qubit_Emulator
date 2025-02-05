library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all; -- Para funciones matemáticas como sin


entity Sin_LUT is
	generic(g_LUT:integer:=8
				;g_bits:integer:=32);
	port(i_angle	:	in		std_logic_vector(g_LUT-1 downto 0)
			;o_Sin	:	out	std_logic_vector(g_bits-1 downto 0)
			);
end Sin_LUT;

Architecture rtl of Sin_LUT is

	constant PI : real :=3.14159265358979323846;
	
	type t_LUT is array (0 to 2**g_LUT-1) of std_logic_vector(g_bits-1 downto 0);
	
	constant sine_lut : t_LUT := (std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(0)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(1)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(2)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(3)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(4)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(5)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(6)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(7)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(8)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(9)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(10)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(11)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(12)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(13)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(14)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(15)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(16)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(17)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(18)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(19)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(20)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(21)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(22)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(23)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(24)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(25)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(26)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(27)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(28)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(29)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(30)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(31)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(32)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(33)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(34)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(35)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(36)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(37)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(38)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(39)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(40)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(41)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(42)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(43)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(44)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(45)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(46)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(47)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(48)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(49)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(50)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(51)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(52)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(53)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(54)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(55)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(56)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(57)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(58)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(59)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(60)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(61)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(62)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(63)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(64)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(65)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(66)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(67)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(68)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(69)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(70)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(71)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(72)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(73)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(74)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(75)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(76)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(77)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(78)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(79)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(80)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(81)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(82)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(83)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(84)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(85)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(86)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(87)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(88)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(89)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(90)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(91)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(92)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(93)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(94)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(95)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(96)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(97)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(98)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(99)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(100)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(101)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(102)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(103)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(104)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(105)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(106)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(107)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(108)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(109)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(110)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(111)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(112)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(113)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(114)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(115)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(116)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(117)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(118)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(119)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(120)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(121)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(122)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(123)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(124)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(125)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(126)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(127)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(128)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(129)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(130)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(131)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(132)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(133)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(134)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(135)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(136)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(137)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(138)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(139)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(140)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(141)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(142)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(143)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(144)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(145)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(146)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(147)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(148)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(149)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(150)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(151)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(152)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(153)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(154)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(155)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(156)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(157)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(158)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(159)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(160)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(161)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(162)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(163)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(164)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(165)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(166)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(167)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(168)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(169)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(170)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(171)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(172)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(173)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(174)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(175)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(176)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(177)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(178)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(179)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(180)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(181)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(182)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(183)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(184)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(185)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(186)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(187)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(188)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(189)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(190)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(191)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(192)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(193)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(194)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(195)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(196)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(197)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(198)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(199)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(200)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(201)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(202)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(203)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(204)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(205)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(206)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(207)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(208)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(209)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(210)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(211)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(212)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(213)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(214)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(215)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(216)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(217)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(218)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(219)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(220)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(221)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(222)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(223)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(224)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(225)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(226)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(227)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(228)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(229)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(230)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(231)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(232)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(233)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(234)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(235)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(236)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(237)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(238)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(239)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(240)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(241)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(242)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(243)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(244)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(245)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(246)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(247)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(248)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(249)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(250)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(251)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(252)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(253)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(254)/real(2**g_LUT))*PI))),g_bits)),
											std_logic_vector(to_signed(integer(floor(real(2**(g_bits-1)-1)*sin((real(255)/real(2**g_LUT))*PI))),g_bits))
	
	);

begin
	o_Sin <= sine_LUT(to_integer(unsigned(i_angle)));
end rtl;