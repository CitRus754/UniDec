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

library work;
use work.UniDec_Package.all;

entity Mixer_1_TB is
--  Port ( );
end Mixer_1_TB;

architecture Behavioral of Mixer_1_TB is

    component ReadFile is
		generic(
			NumOfBits	: integer;
			Data_i_File	: string;
			Data_q_File	: string
		);
		port (
			data_i	: out std_logic_vector ((NumOfBits - 1) downto 0);
			data_q	: out std_logic_vector ((NumOfBits - 1) downto 0);
			
			dv		: out std_logic;
			rst		: in std_logic;
			rfd		: in std_logic;
			clk		: in std_logic
		);
	end component;
	
	component Mixer_1 is
		port(
			Clk 		: in std_logic;
			
			Input_I		: in std_logic_vector(15 downto 0);		-- a
			Input_Q		: in std_logic_vector(15 downto 0);		-- b
			
			DDS_TVALID	: in std_logic;
			DDS_I		: in std_logic_vector(11 downto 0);		-- c
			DDS_Q		: in std_logic_vector(11 downto 0);		-- d
			
			Mix_TVALID	: out std_logic;
			Output_I	: out std_logic_vector(15 downto 0);	-- R
			Output_Q	: out std_logic_vector(15 downto 0)		-- I
		);
	end component;
	
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
	
	
	
	-- Clk
	constant PERIOD			: time := 11.363636364 ns;	-- 88 MHz
	signal Clk				: std_logic := '0';
	
	-- DDS signals
	signal In_TVALID		: std_logic := '1';
	signal FCW				: std_logic_vector(23 downto 0) := (others => '0');	
	signal Out_TVALID		: std_logic := '0';
	signal DDS_Out			: std_logic_vector(31 downto 0) := (others => '0');
	
	-- Reader signals
	signal ReadReset		: std_logic := '0';
	signal ReadEn			: std_logic := '1';
	-- signal ReadContinue		: std_logic := '1';
	signal Din_I, Din_Q 	: std_logic_vector(15 downto 0) := (others => '0');
	
	-- Mixer signals
	signal Mix_tv 			: std_logic := '0';
	signal Mix_I			: std_logic_vector(15 downto 0) := (others => '0');
	signal Mix_Q			: std_logic_vector(15 downto 0) := (others => '0');
	
	-- Writer signals
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
	
	dds_input: process begin
		FCW <= x"0e8ba3";		-- 5 MHz
		wait;
	end process;
	
	
	
	----------------- Instantiations ---------------------
	
	Reader: ReadFile
	generic map (	NumOfBits	=> 16,
					Data_i_File => "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\Input_I.txt",
					Data_q_File	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\Input_Q.txt"
			)
	port map (	clk 	=> Clk,
				rst 	=> ReadReset,
				rfd 	=> Out_TVALID,
				dv 		=> ReadEn,
				data_i 	=> Din_I,
				data_q 	=> Din_Q
			);
	
	DDS: dds_compiler_0
	port map (	aclk 				=> Clk,
				s_axis_phase_tvalid => In_TVALID,
				s_axis_phase_tdata 	=> FCW,
				m_axis_data_tvalid 	=> Out_TVALID,
				m_axis_data_tdata 	=> DDS_Out
			);
	
	Mixer: Mixer_1
	port map (
				Clk			=> Clk,
				Input_I		=> Din_I,
				Input_Q		=> Din_Q,
				DDS_TVALID	=> Out_TVALID,
				DDS_I		=> DDS_Out(11 downto 0),
				DDS_Q		=> DDS_Out(27 downto 16),
				Mix_TVALID	=> Mix_tv,
				Output_I	=> Mix_I,
				Output_Q	=> Mix_Q
			);
	
	Writer: WriteFile
	generic map (	NumOfBits	=> 16,
					File_name1	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\Mixer_I.txt",
					File_name2	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\Mixer_Q.txt"
			)
	port map (	clk			=> Clk,
				dv			=> Out_TVALID,
				sign		=> WrSign,
				DataIn_i	=> Mix_I,
				DataIn_q	=> Mix_Q
			);
	
end Behavioral;
