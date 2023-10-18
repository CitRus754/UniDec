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

entity FIR_TB is
--  Port ( );
end FIR_TB;

architecture Behavioral of FIR_TB is

    component Clk_Divider is
		generic(
		Num_Freqs	: integer := 8
	);
	port(
		Clk 		: in std_logic;									-- System Clock 88 MHz
		
		Clk_Out		: out std_logic_vector(Num_Freqs-1 downto 0)
	);
	end component;
	
	component fir_compiler_0 is
		PORT (
			aclk : IN STD_LOGIC;
			s_axis_data_tvalid : IN STD_LOGIC;
			s_axis_data_tready : OUT STD_LOGIC;
			s_axis_data_tdata : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			m_axis_data_tvalid : OUT STD_LOGIC;
			m_axis_data_tdata : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	end component;
	
	constant PERIOD			: time := 11.36363636 ns;
	
	signal Clk				: std_logic;
	signal Clk_Divided		: std_logic_vector(7 downto 0);
	signal Input_DV			: std_logic := '1';
	signal TREADY			: std_logic := '0';
	
	signal Cntr1, Cntr2		: std_logic_vector(3 downto 0) := (others => '0');
	signal Din 				: std_logic_vector(7 downto 0) := (others => '0');
	
	signal Output_DV		: std_logic := '0';
	signal FIR_Output		: std_logic_vector(7 downto 0) := (others => '0');
	signal Dout				: std_logic_vector(5 downto 0) := (others => '0');
	signal Ch1, Ch2			: std_logic_vector(5 downto 0) := (others => '0');

begin

	clk_div_inst: Clk_Divider
	port map (
		Clk		=> Clk,
		Clk_Out	=> Clk_Divided
	);

	gen_clk: process begin
		loop
			Clk <= '0';
			wait for PERIOD/2;
			Clk <= '1';
			wait for PERIOD/2;
		end loop;
	end process;
	
    gen_data: process begin
        Cntr1 <= "0001";
		Cntr2 <= "0010";
        wait;
    end process;
	
	process(Clk) begin
		if rising_edge(Clk) then
			if Clk_Divided(0) = '0' then
				Din <= "0000" & Cntr1;
			else
				Din <= "0000" & Cntr2;
			end if;
		end if;
	end process;
	
	process(Clk) begin
		if rising_edge(Clk) then
			if Clk_Divided(1) = '0' then
				Ch1 <= Dout;
			else
				Ch2 <= Dout;
			end if;
		end if;
	end process;
	
	FIR: fir_compiler_0
	port map (	aclk 				=> Clk,
				s_axis_data_tvalid 	=> Input_DV,
				s_axis_data_tready 	=> TREADY,
				s_axis_data_tdata 	=> Din,
				m_axis_data_tvalid 	=> Output_DV,
				m_axis_data_tdata 	=> FIR_Output
			);
	
	Dout <= FIR_Output(5 downto 0);
	
end Behavioral;
