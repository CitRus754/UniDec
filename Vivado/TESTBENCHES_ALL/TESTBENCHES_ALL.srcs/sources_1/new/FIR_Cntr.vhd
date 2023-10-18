----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.07.2023 16:20:05
-- Design Name: 
-- Module Name: Mixer_1 - Behavioral
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
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity FIR_Cntr is
	generic(
		Num_Bits : integer
	);
	port(
		Clk 		: in std_logic;		
		Dout		: out std_logic_vector(Num_Bits-1 downto 0)
	);
end FIR_Cntr;

architecture Behavioral of FIR_Cntr is
	
	signal cntr	: std_logic_vector(Num_Bits-1 downto 0) := (others => '0');
	
begin

	process(Clk) begin
		if rising_edge(Clk) then
			cntr <= unsigned(cntr) + 1;
		end if;
	end process;

	Dout <= cntr;

end Behavioral;
