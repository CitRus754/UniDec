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

entity FIR_Reader_1 is
	generic(
		NumOfBits	: integer;
		i_1_File	: string;
		i_2_File	: string;
		q_1_File	: string;
		q_2_File	: string
	);
	port (
		inp_I_1	: out std_logic_vector ((NumOfBits - 1) downto 0);
		inp_I_2	: out std_logic_vector ((NumOfBits - 1) downto 0);
		inp_Q_1	: out std_logic_vector ((NumOfBits - 1) downto 0);
		inp_Q_2	: out std_logic_vector ((NumOfBits - 1) downto 0);
		
		dv		: out std_logic;
		rst		: in std_logic;
		rfd		: in std_logic;
		clk		: in std_logic
	);
end FIR_Reader_1;

architecture beh of FIR_Reader_1 is
	
	constant	log_file_rd1 : string := i_1_File;
	constant	log_file_rd2 : string := i_2_File;
	constant	log_file_rd3 : string := q_1_File;
	constant	log_file_rd4 : string := q_2_File;
	
	file file_rd1: TEXT open read_mode is log_file_rd1;
	file file_rd2: TEXT open read_mode is log_file_rd2;
	file file_rd3: TEXT open read_mode is log_file_rd3;
	file file_rd4: TEXT open read_mode is log_file_rd4;
	
	signal to_dv               		: std_logic := '1';
	signal to_out_i_1, to_out_q_1	: std_logic_vector ((NumOfBits - 1) downto 0) := (others => '0');
	signal to_out_i_2, to_out_q_2	: std_logic_vector ((NumOfBits - 1) downto 0) := (others => '0');
		
begin

	read_data: process(clk,rst)
	variable s1 	: integer;
	variable s2 	: integer;
	variable s3 	: integer;
	variable s4 	: integer;
	
	variable line1 	: line;
	variable line2 	: line;
	variable line3 	: line;
	variable line4 	: line;
	
	begin
		if (rst = '1') then
			to_out_i_1 	<= (others => '0');
			to_out_q_1 	<= (others => '0');
			to_out_i_2 	<= (others => '0');
			to_out_q_2 	<= (others => '0');
			to_dv 		<= '0';
		elsif(rising_edge(clk)) then
			if rfd='1' then
				readline(file_rd1, line1);
				readline(file_rd2, line2);
				readline(file_rd3, line3);
				readline(file_rd4, line4);
				
				read (line1, s1);
				read (line2, s2);
				read (line3, s3);
				read (line4, s4);
				
				to_out_i_1 	<= CONV_STD_LOGIC_VECTOR(s1,numOfBits);
				to_out_i_2 	<= CONV_STD_LOGIC_VECTOR(s2,numOfBits);
				to_out_q_1 	<= CONV_STD_LOGIC_VECTOR(s3,numOfBits);
				to_out_q_2 	<= CONV_STD_LOGIC_VECTOR(s4,numOfBits);
				
				to_dv <= '1';
			else
				to_dv <= '0';
			end if;
		end if;
	end process;
    
    dv <= to_dv;
    
    inp_I_1 <= to_out_i_1;
    inp_I_2 <= to_out_i_2;
	inp_Q_1 <= to_out_q_1;
	inp_Q_2 <= to_out_q_2;
    
end beh;
