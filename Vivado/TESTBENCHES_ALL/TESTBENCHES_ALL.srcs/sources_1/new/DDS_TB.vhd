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

entity DDS_TB is
--  Port ( );
end DDS_TB;

architecture Behavioral of DDS_TB is

    component dds_compiler_1 is
		PORT (
			aclk : IN STD_LOGIC;
			s_axis_phase_tvalid : IN STD_LOGIC;
			s_axis_phase_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
			s_axis_phase_tlast : IN STD_LOGIC;
			m_axis_data_tvalid : OUT STD_LOGIC;
			m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			event_s_phase_tlast_missing : OUT STD_LOGIC;
			event_s_phase_tlast_unexpected : OUT STD_LOGIC
		);
	end component;
	
	constant PERIOD			: time := 11.363636364 ns;        -- Fclk = 88 MHz	
	signal Clk				: std_logic	:= '0';
	signal Sel              : std_logic := '0';
	
	signal In_TVALID		: std_logic := '1';
	signal FCW				: std_logic_vector(23 downto 0) := (others => '0');
	signal In_TLAST			: std_logic := '0';	
	signal Out_TVALID		: std_logic := '0';
	signal Missing			: std_logic := '0';
	signal Unexp			: std_logic := '0';
	
	signal DDS_Out			: std_logic_vector(31 downto 0);
	signal Out_Cos			: std_logic_vector(11 downto 0);
	signal Out_Sin			: std_logic_vector(11 downto 0);
	
	signal Cos_1, Cos_2     : std_logic_vector(11 downto 0);
	signal Sin_1, Sin_2     : std_logic_vector(11 downto 0);

begin

	Clk 	<= not Clk after PERIOD/2;
	
	gen_sel: process(Clk) begin
	   if rising_edge(Clk) then
			Sel <= not Sel;
		end if;
	end process;
		
	gen_input: process(Clk) begin
	   if rising_edge(Clk) then
	       if Sel = '0' then
	           FCW <= x"1d1746";		-- 5 MHz
			--    In_TVALID	<= '1';
	       else
	           FCW <= x"02e8ba";   
			--    In_TVALID	<= '0';
	       end if;    
		end if;
	end process;
	
	gen_tlast: process(Clk) begin
		if rising_edge(Clk) then
			In_TLAST <= not In_TLAST;
		end if;
	end process;
	
	DDS: dds_compiler_1
	port map (	aclk 							=> Clk,
				s_axis_phase_tvalid 			=> In_TVALID,
				s_axis_phase_tdata 				=> FCW,
				s_axis_phase_tlast				=> In_TLAST,
				m_axis_data_tvalid 				=> Out_TVALID,
				m_axis_data_tdata 				=> DDS_Out,
				event_s_phase_tlast_missing		=> Missing,
				event_s_phase_tlast_unexpected	=> Unexp
			);
	
	Out_Cos <= DDS_Out(11 downto 0);
	Out_Sin <= DDS_Out(27 downto 16);
	
	select_chan: process(Clk) begin
	   if rising_edge(Clk) then
			if Sel = '0' then
	           Cos_1 <= Out_Cos;
	           Sin_1 <= Out_Sin;
	       else
	           Cos_2 <= Out_Cos;
	           Sin_2 <= Out_Sin;
	       end if; 
		end if;
	end process;
	
	
	
	stopper: process begin
	   wait for 10 us;
	   finish;
	end process;
		
end Behavioral;
