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

entity tdm_selector is
	port(
		Clk 		: in 	std_logic;
		
		Start		: in	std_logic;
		Din			: in 	std_logic_vector(15 downto 0);
		
		Dout0		: out 	std_logic_vector(15 downto 0);
		Dout1		: out 	std_logic_vector(15 downto 0);
		Dout2		: out 	std_logic_vector(15 downto 0);
		Dout3		: out 	std_logic_vector(15 downto 0)
		);
end tdm_selector;

architecture Behavioral of tdm_selector is
	
	-- strob signals
	signal Start_data		: std_logic	:= '0';
	-- signal start_data_d		: std_logic	:= '0';
	-- signal stb				: std_logic	:= '0';
	
	-- TDM signals
	signal TDM_Channels		: std_logic_vector(15 downto 0)	:= (others => '0');
	signal Cntr				: std_logic_vector(1 downto 0)	:= "00";
	signal Cntr_d			: std_logic_vector(1 downto 0)	:= "00";
	
	-- Out channels
	signal ToOut0			: std_logic_vector(15 downto 0)	:= (others => '0');
	signal ToOut1			: std_logic_vector(15 downto 0)	:= (others => '0');
	signal ToOut2			: std_logic_vector(15 downto 0)	:= (others => '0');
	signal ToOut3			: std_logic_vector(15 downto 0)	:= (others => '0');
	
	-- component BitReversedCounter_8 is
		-- port(
			-- Clk 		: in std_logic;									-- System Clock 88 MHz
			-- BitRvsCntr	: out std_logic_vector(7 downto 0)
		-- );
	-- end component;
	
	-- signal BitRvsCntr	: 	std_logic_vector(7 downto 0)	:= (others => '0');
	
	-- signal RvsCntr		:	std_logic_vector(1 downto 0)	:= "00";
	
begin
	
	-- strob forming
	process(Clk) begin
		if rising_edge(Clk) then
			Start_data		<= Start;
			-- start_data_d	<= start_data;
		end if;
	end process;
	
	-- stb	<= start_data and (not start_data_d);
	
	
	
	-- TDM data forming
	process(Clk) begin
		if rising_edge(Clk) then
			if Start_data = '1' then
				TDM_Channels	<= Din;
			else
				TDM_Channels	<= (others => '0');
			end if;
		end if;
	end process;	
	
	-- counter for data selection
	process(Clk) begin
		if rising_edge(Clk) then
			if Start_data	= '0' then
				Cntr	<= "00";
			else
				Cntr	<= unsigned(Cntr) + 1;
			end if;
			Cntr_d	<= Cntr;
		end if;
	end process;
	
	
	-- output selection
	process(Clk) begin
		if rising_edge(Clk) then
			if 		Cntr_d = "00" then
				ToOut0	<= TDM_Channels;
			elsif	Cntr_d = "01" then
				ToOut1	<= TDM_Channels;
			elsif	Cntr_d = "10" then
				ToOut2	<= TDM_Channels;
			else
				ToOut3	<= TDM_Channels;
			end if;
		end if;
	end process;
	
	Dout0	<= ToOut0;
	Dout1	<= ToOut1;
	Dout2	<= ToOut2;
	Dout3	<= ToOut3;
	
	
	-- RvsCnt_inst: BitReversedCounter_8
	-- port map(
			-- Clk			=> Clk,
			-- BitRvsCntr	=> BitRvsCntr
	-- );
	
	
	-- RvsCntr	<= BitRvsCntr(7 downto 6);
	
	
	
end Behavioral;
