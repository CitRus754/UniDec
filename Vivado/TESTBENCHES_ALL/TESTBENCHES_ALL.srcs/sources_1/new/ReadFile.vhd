----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.06.2023 16:05:56
-- Design Name: 
-- Module Name: ReadFile - beh
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
library STD;
use STD.TEXTIO.all;

entity ReadFile is
	generic(
		NumOfBits	: integer;
		Data_i_File	: string;
		Data_q_File	: string
	);
	port (
		data_i	: out std_logic_vector ((NumOfBits - 1) downto 0);
		data_q	: out std_logic_vector ((NumOfBits - 1) downto 0);
		
		dv		: out std_logic;
		rst		: in std_logic;
		rfd		: in std_logic;
		clk		: in std_logic
	);
end ReadFile;

architecture beh of ReadFile is
	
	constant	log_file_rd1 : string := Data_i_File;
	constant	log_file_rd2 : string := Data_q_File;
	
	file file_rd1: TEXT open read_mode is log_file_rd1;
	file file_rd2: TEXT open read_mode is log_file_rd2;
	
	signal to_dv               : std_logic := '1';
	signal to_out_i, to_out_q  : std_logic_vector ((NumOfBits - 1) downto 0) := (others => '0');
		
begin

	read_data: process(clk,rst)
	variable s1 	: integer;
	variable s2 	: integer;
	
	variable line1 	: line;
	variable line2 	: line;
	
	begin
		if (rst = '1') then
			to_out_i 	<= (others => '0');
			to_out_q 	<= (others => '0');
			to_dv 		<= '0';
		elsif(rising_edge(clk)) then
			if rfd='1' then
				readline(file_rd1, line1);
				readline(file_rd2, line2);
				
				read (line1, s1);
				read (line2, s2);
				
				to_out_i 	<= CONV_STD_LOGIC_VECTOR(s1,numOfBits);
				to_out_q 	<= CONV_STD_LOGIC_VECTOR(s2,numOfBits);
				
				to_dv <= '1';
			else
				to_dv <= '0';
			end if;
		end if;
	end process;
    
    dv <= to_dv;
    
    data_i <= to_out_i;
    data_q <= to_out_q;
    
end beh;
