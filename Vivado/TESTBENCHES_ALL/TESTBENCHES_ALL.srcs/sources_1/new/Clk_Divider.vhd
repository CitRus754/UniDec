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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Clk_Divider is
	generic(
		Num_Freqs	: integer
	);
	port(
		Clk 		: in std_logic;									-- System Clock 88 MHz
		
		Clk_Out		: out std_logic_vector(Num_Freqs-1 downto 0)
	);
end Clk_Divider;

architecture Behavioral of Clk_Divider is

	signal Cntr: std_logic_vector(Num_Freqs-1 downto 0) := (others => '0');
	
begin

	process(Clk) begin
		if rising_edge(Clk) then
			Cntr <= unsigned(Cntr) + 1;
		end if;
	end process;
	
	Clk_Out <= Cntr;
	
end Behavioral;
