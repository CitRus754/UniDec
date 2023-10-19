----------------------------------------------------------------------------------
-- Company: 		NTT
-- Engineer: 		Citaishvili R.A.
-- 
-- Create Date: 	26.09.2023 12:43:27
-- Design Name: 	UniDec
-- Module Name: 	testbench - Behavioral
-- Project Name: 	UniDec
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
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.ALL;
library STD;
use STD.textio.all;
use STD.env.finish;

entity Cntr_TB is
--  Port ( );
end Cntr_TB;

architecture Behavioral of Cntr_TB is

    component BitReversedCounter_8 is
		port(
			Clk 		: in std_logic;									-- System Clock 88 MHz
			BitRvsCntr	: out std_logic_vector(7 downto 0)
		);
	end component;
	
	constant PERIOD			: time := 11.363636364 ns;        -- Fclk = 88 MHz	
	signal Clk				: std_logic	:= '0';
	signal Cntr				: std_logic_vector(7 downto 0)	:= x"00";

begin

	gen_clk: process begin
		loop
			Clk <= '0';
			wait for PERIOD/2;
			Clk <= '1';
			wait for PERIOD/2;
		end loop;
	end process;
	
	uut: BitReversedCounter_8
	port map (	Clk 		=> Clk,
				BitRvsCntr 	=> Cntr
			);
		
	stopper: process begin
	   wait for 1 us;
	   finish;
	end process;
		
end Behavioral;
