
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
LIBRARY std;
USE std.textio.all;

entity FIR_Writer_1 is
	generic(
		NumOfBits 	: integer;
		File_name1	: string;
		File_name2	: string;
		File_name3	: string;
		File_name4	: string
		);
	port(
		clk			: in std_logic;
		dv			: in std_logic;
		sign		: in std_logic;
		
		DataIn_i_1 	: in std_logic_vector ((numOfBits-1) downto 0);
		DataIn_q_1 	: in std_logic_vector ((numOfBits-1) downto 0);
		DataIn_i_2 	: in std_logic_vector ((numOfBits-1) downto 0);
		DataIn_q_2 	: in std_logic_vector ((numOfBits-1) downto 0)
		);
	end FIR_Writer_1;

architecture Behavioral of FIR_Writer_1 is

	constant log_file1 : string := File_name1;
	constant log_file2 : string := File_name2;
	constant log_file3 : string := File_name3;
	constant log_file4 : string := File_name4;
	
	file file_wr1: TEXT open write_mode is log_file1;
	file file_wr2: TEXT open write_mode is log_file2;
	file file_wr3: TEXT open write_mode is log_file3;
	file file_wr4: TEXT open write_mode is log_file4;

begin

	write_data : process(clk)
	variable row1 : line;
	variable row2 : line;
	variable row3 : line;
	variable row4 : line;
	
	begin
		if(rising_edge(clk)) then
			if dv = '1' then
				if sign='0' then
					write (row1, CONV_INTEGER(UNSIGNED(DataIn_i_1)));
					write (row2, CONV_INTEGER(UNSIGNED(DataIn_i_2)));
					write (row3, CONV_INTEGER(UNSIGNED(DataIn_q_1)));
					write (row4, CONV_INTEGER(UNSIGNED(DataIn_q_2)));
					
					writeline(file_wr1, row1);
					writeline(file_wr2, row2);
					writeline(file_wr3, row3);
					writeline(file_wr4, row4);
				else
					write (row1, CONV_INTEGER(SIGNED(DataIn_i_1)));
					write (row2, CONV_INTEGER(SIGNED(DataIn_i_2)));
					write (row3, CONV_INTEGER(SIGNED(DataIn_q_1)));
					write (row4, CONV_INTEGER(SIGNED(DataIn_q_2)));
					
					writeline(file_wr1, row1);
					writeline(file_wr2, row2);
					writeline(file_wr3, row3);
					writeline(file_wr4, row4);
				end if;
			end if;
		end if;
	end process;
	 
end Behavioral;
