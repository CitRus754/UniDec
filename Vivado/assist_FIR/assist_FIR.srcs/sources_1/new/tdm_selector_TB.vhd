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

entity tdm_selector_TB is
--  Port ( );
end tdm_selector_TB;

architecture Behavioral of tdm_selector_TB is

    component tdm_selector is
		port(
			Clk 		: in 	std_logic;
			
			Start		: in	std_logic;
			Din			: in 	std_logic_vector(15 downto 0);
			
			Dout0		: out 	std_logic_vector(15 downto 0);
			Dout1		: out 	std_logic_vector(15 downto 0);
			Dout2		: out 	std_logic_vector(15 downto 0);
			Dout3		: out 	std_logic_vector(15 downto 0)
			);
	end component;
	
	constant PERIOD	: time := 11.36363636 ns;	
	signal Clk		: std_logic	:= '0';
	
	signal tbStart	: std_logic	:= '0';
	
	signal tbDin	: std_logic_vector(15 downto 0)	:= (others => '0');
	
	signal tbDout0	: std_logic_vector(15 downto 0)	:= (others => '0');
	signal tbDout1	: std_logic_vector(15 downto 0)	:= (others => '0');
	signal tbDout2	: std_logic_vector(15 downto 0)	:= (others => '0');
	signal tbDout3	: std_logic_vector(15 downto 0)	:= (others => '0');	

begin
	
	Clk 	<= not Clk after PERIOD/2;
	
	gen_start: process begin
		wait for PERIOD;
		wait for 2 ns;
		tbStart	<= '1';
		wait for 2 us;
		tbStart	<= '0';
	end process;
	
	gen_data: process(Clk) begin
		if falling_edge(Clk) then
			tbDin	<= unsigned(tbDin) + 12345;
		end if;
	end process;
	
	uut: tdm_selector
	port map (
		Clk		=> Clk,
		Start	=> tbStart,
		Din		=> tbDin,
		Dout0	=> tbDout0,
		Dout1	=> tbDout1,
		Dout2	=> tbDout2,
		Dout3	=> tbDout3
	);
		
end Behavioral;
