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

entity Stb_Former is
	port(
		Clk 		: in 	std_logic;
		StbOut		: out 	std_logic
	);
end Stb_Former;

architecture Behavioral of Stb_Former is

	signal Cntr			:	std_logic_vector(1 downto 0)	:= "00";
	signal Ena, Ena_w	:	std_logic	:= '0';
	
begin

	process(Clk) begin
		if rising_edge(Clk) then
			Cntr	<= unsigned(Cntr) + 1;
		end if;
	end process;
	
	process(Clk) begin
		if rising_edge(Clk) then
			if unsigned(Cntr) = 3 then
				Ena <= '1';
			else
				Ena <= '0';
			end if;
		end if;
	end process;
	
	process(Clk) begin
		if rising_edge(Clk) then
			Ena_w <= Ena;
		end if;
	end process;
	
	StbOut	<= Ena and (not Ena_w);
	
end Behavioral;
