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

    component dds_compiler_0 is
		PORT (
			aclk : IN STD_LOGIC;
			s_axis_phase_tvalid : IN STD_LOGIC;
			s_axis_phase_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
			m_axis_data_tvalid : OUT STD_LOGIC;
			m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	end component;
	
	component WriteFile is
		generic(
		NumOfBits 	: integer;
		File_name1	: string;
		File_name2	: string
		);
	port(
		clk			: in std_logic;
		dv			: in std_logic;
		sign		: in std_logic;
		
		DataIn_i 	: in std_logic_vector ((numOfBits-1) downto 0);
		DataIn_q 	: in std_logic_vector ((numOfBits-1) downto 0)
		);
	end component;
	
	constant PERIOD			: time := 11.363636364 ns;        -- Fclk = 88 MHz
	
	signal Clk				: std_logic;
	
	signal In_TVALID		: std_logic := '1';
--	signal RESYNC           : std_logic := '0';
	signal FCW				: std_logic_vector(23 downto 0) := (others => '0');
--	signal DDS_In			: std_logic_vector(31 downto 0) := (others => '0');
	
	signal Out_TVALID		: std_logic;
	signal DDS_Out			: std_logic_vector(31 downto 0);
	signal Out_Cos			: std_logic_vector(11 downto 0);
	signal Out_Sin			: std_logic_vector(11 downto 0);	

	signal WrSign			: std_logic := '1';

begin

	gen_clk: process begin
		loop
			Clk <= '0';
			wait for PERIOD/2;
			Clk <= '1';
			wait for PERIOD/2;
		end loop;
	end process;
	
	gen_input: process begin
		FCW <= x"0e8ba3";		-- 5 MHz
		wait;
--		In_TVALID	<= '0';
--		wait for 1 us;
--		FCW <= x"02e8ba";		-- 1 MHz
--		wait for 5 us;
--		In_TVALID	<= '1';
--		finish;
	end process;
	
--	DDS_In(24) <= RESYNC;
--	DDS_In(23 downto 0) <= FCW;
	
	DDS: dds_compiler_0
	port map (	aclk 				=> Clk,
				s_axis_phase_tvalid => In_TVALID,
				s_axis_phase_tdata 	=> FCW,
				m_axis_data_tvalid 	=> Out_TVALID,
				m_axis_data_tdata 	=> DDS_Out
			);
	
	Out_Cos <= DDS_Out(11 downto 0);
	Out_Sin <= DDS_Out(27 downto 16);
	
	Writer: WriteFile
	generic map (	NumOfBits	=> 12,
					File_name1	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\DDS_Cosine.txt",
					File_name2	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\DDS_Sine.txt"
			)
	port map (	clk			=> Clk,
				dv			=> Out_TVALID,
				sign		=> WrSign,
				DataIn_i	=> Out_Cos,
				DataIn_q	=> Out_Sin
			);
	
end Behavioral;
