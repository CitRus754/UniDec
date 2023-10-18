---------------------------------------
-- Engineer:	CitRus
-- Data:		12.10.2023
-- Project:		UniDec
---------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.UniDec_Package.all;


entity TDM_Matcher_2 is
	port(
		Clk			: in std_logic;
		
		Sel			: in std_logic;
		
		InTV		: in DV_Bus(1 to 2);
		InSignal	: in DDS_Array(1 to 2);
		
		OutTV		: out std_logic;
		OutSignal	: out std_logic_vector(31 downto 0)
	);
end TDM_Matcher_2;

architecture Behavioral of TDM_Matcher_2 is

	signal InTV_w1		: std_logic	:= '0';
	signal InXor		: std_logic	:= '0';
	
	signal InSignal_w1	: std_logic_vector(31 downto 0)	:= (others => '0');
	signal InSignal_d	: std_logic_vector(31 downto 0)	:= (others => '0');

begin

	-- delay for even channels
	process(Clk) begin
		if rising_edge(Clk) then
			InTV_w1		<= InTV(2);
			InSignal_w1 <= InSignal(2);
		end if;
	end process;
	
	
	-- or for TV
	process(Clk) begin
		if rising_edge(Clk) then
			OutTV <= InTV(1) or InTV( 2) or InTV_w1;
		end if;
	end process;
	
	InXor	<= InTV(1) xor InTV(2);
	
	
	-- mux for InXor
	process(InSignal, InSignal_w1, InXor) begin
		if InXor = '1' then
			InSignal_d	<= InSignal(2);
		else
			InSignal_d	<= InSignal_w1;
		end if;
	end process;
	
	-- mux for OutSignal
	process(Clk) begin
		if rising_edge(Clk) then
			if 		Sel = '0' then
				OutSignal <= InSignal(1);
			else
				OutSignal <= InSignal_d;
			end if;
		end if;
	end process;	

end Behavioral;
