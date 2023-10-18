----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.09.2023 15:50:32
-- Design Name: 
-- Module Name: CORE_1 - Behavioral
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
use IEEE.std_logic_arith.ALL;

entity BitReversedCounter_8 is
	port(
		Clk 		: in std_logic;									-- System Clock 88 MHz
		BitRvsCntr	: out std_logic_vector(7 downto 0)
	);
end BitReversedCounter_8;

architecture Behavioral of BitReversedCounter_8 is

	signal CntrDir: std_logic_vector(7 downto 0) := (others => '0');	-- direct counter
	signal CntrRvs: std_logic_vector(7 downto 0) := (others => '0');	-- reversed counter
	
begin

	process(Clk) begin
		if rising_edge(Clk) then
			CntrDir <= unsigned(CntrDir) + 1;
		end if;
	end process;
	
	process(Clk) begin
		if rising_edge(Clk) then
			for i in CntrDir'range loop
				CntrRvs(CntrRvs'left - i) <= CntrDir(i);
			end loop;
		end if;
	end process;
	
	BitRvsCntr	<= CntrRvs;
	
end Behavioral;
