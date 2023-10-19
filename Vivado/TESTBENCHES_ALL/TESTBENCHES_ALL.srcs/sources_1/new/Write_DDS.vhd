
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
LIBRARY std;
USE std.textio.all;

entity WriteFile is
	generic(
		NumOfBits 	: integer;
		File_name1	: string;
		File_name2	: string
		);
	port(
		clk			: in std_logic;
		dv			: in std_logic;
		sign		: in std_logic;
		
		DataIn_i 	: in std_logic_vector ((numOfBits-1) downto 0);
		DataIn_q 	: in std_logic_vector ((numOfBits-1) downto 0)
		);
	end WriteFile;

architecture Behavioral of WriteFile is

	constant log_file1 : string := File_name1;
	constant log_file2 : string := File_name2;
	
	file file_wr1: TEXT open write_mode is log_file1;
	file file_wr2: TEXT open write_mode is log_file2;

begin

	write_data : process(clk)
	variable row1 : line;
	variable row2 : line;
	
	begin
		if(rising_edge(clk)) then
			if dv = '1' then
				if sign='0' then
					write (row1, CONV_INTEGER(UNSIGNED(DataIn_i)));
					write (row2, CONV_INTEGER(UNSIGNED(DataIn_q)));
					 
					writeline(file_wr1, row1);
					writeline(file_wr2, row2);
				else
					write (row1, conv_integer(signed(DataIn_i)));
					write (row2, conv_integer(signed(DataIn_q)));
					 
					writeline(file_wr1, row1);
					writeline(file_wr2, row2);
				end if;
			end if;
		end if;
	end process;
	 
end Behavioral;
