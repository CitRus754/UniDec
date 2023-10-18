----------------------------------------------------------------------------------
-- Company: 		NTT
-- Engineer: 		Citaishvili R.A.
-- 
-- Create Date: 	19.07.2023 12:43:27
-- Design Name: 	PlOb
-- Module Name: 	testbench - Behavioral
-- Project Name: 	PlOb
-- Target Devices:	
-- Tool Versions: 	
-- Description: 	Testbench for Channel_One Module
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.ALL;
library STD;
use STD.textio.all;
use STD.env.finish;

entity Stb_Former_TB is
--  Port ( );
end Stb_Former_TB;

architecture Behavioral of Stb_Former_TB is

    component Stb_Former is
		port(
			Clk 		: in 	std_logic;
			StbOut		: out 	std_logic
		);
	end component;
	
	constant PERIOD			: time := 11.36363636 ns;	
	signal Clk				: std_logic	:= '0';
	signal Stb_TB			: std_logic	:= '0';

begin
	
	stbf_inst: Stb_Former
	port map (
		Clk		=> Clk,
		StbOut	=> Stb_TB
	);
	
	Clk 	<= not Clk after PERIOD/2;
	
end Behavioral;
