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
use IEEE.numeric_std.all;

library work;
use work.UniDec_Package.all;

entity CORE_2 is								-- latency is 22
	port(
		Clk 			: in std_logic;							-- 88 MHz
		
		Input_I			: in std_logic_vector(15 downto 0);		-- Input Signal
		Input_Q			: in std_logic_vector(15 downto 0);
		
		DDS_Ena			: in std_logic;
		DDS_I			: in std_logic_vector(11 downto 0);
		DDS_Q			: in std_logic_vector(11 downto 0);		
		
		FIR_TVALID		: out std_logic;
		FIR_Output		: out std_logic_vector(31 downto 0)		-- Output Signal
		);
end CORE_2;

architecture Behavioral of CORE_2 is
	
	component Mixer_1 is						-- latency is 4
		port(
			Clk 		: in std_logic;							-- 88 MHz
			
			Input_I		: in std_logic_vector(15 downto 0);		-- a	Fs = 11 MHz
			Input_Q		: in std_logic_vector(15 downto 0);		-- b
			
			DDS_TVALID	: in std_logic;
			DDS_I		: in std_logic_vector(11 downto 0);		-- c	Fs = 88 MHz
			DDS_Q		: in std_logic_vector(11 downto 0);		-- d
			
			Mix_TVALID	: out std_logic;
			Output_I	: out std_logic_vector(15 downto 0);	-- R	Fs = 11 MHz, TDM
			Output_Q	: out std_logic_vector(15 downto 0)		-- I
		);
	end component;
	
	component fir_compiler_2 IS					-- latency is 27
		PORT (
			aclk : IN STD_LOGIC;
			s_axis_data_tvalid : IN STD_LOGIC;
			s_axis_data_tready : OUT STD_LOGIC;
			s_axis_data_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			m_axis_data_tvalid : OUT STD_LOGIC;
			m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	END component;
	
	-- Mixer signals
	signal Mix_TV		: std_logic := '0';
	signal Mix_TV_w1	: std_logic := '0';
	signal Mix_Out_I	: std_logic_vector(15 downto 0) := (others => '0');
	signal Mix_Out_Q	: std_logic_vector(15 downto 0) := (others => '0');
	
	-- FIR signals
	signal FIR_tr		: std_logic := '0';
	signal FIR_Input 	: std_logic_vector(31 downto 0) := (others => '0');
	
begin

	-- Mixer instantiation
	Mix_Inst: Mixer_1
		port map(
			Clk 		=> Clk,
			Input_I		=> Input_I,
			Input_Q		=> Input_Q,
			DDS_TVALID	=> DDS_Ena,
			DDS_I		=> DDS_I,
			DDS_Q		=> DDS_Q,
			Mix_TVALID	=> Mix_TV,
			Output_I	=> Mix_Out_I,
			Output_Q	=> Mix_Out_Q
		);
	
	-- TVALID signal for FIR
	process(Clk) begin
		if rising_edge(Clk) then
			Mix_TV_w1 	<= Mix_TV;
		end if;
	end process;



	-- FIR input forming
	-- bit		|31-----16|15------0|	
	-- content	|----Q----|----I----|	
	process(Clk) begin
		if rising_edge(Clk) then
			FIR_Input 	<= Mix_Out_Q & Mix_Out_I;
		end if;
	end process;
	
	
	-- Clk is 88 MHz, samples (Sk) are fed with Fs = 11 MHz
	-- Designations: Sk(i) - k-th number of sample of i-th channel
	-- FIR input is 16 channels: 2 parallel (Q-I) and 8 interleaved (mix_0-mix_1-...-mix_7)
	-- Clk Period	|	1	|	2	|	3	|	4	|	5	|	6	|	7	|	8	|	9	|	10	|	11	|	12	|	13	|	14	|
	---------------------------------------------------------------------------------------------------------------------------------
	-- FIR_Input	| S1(0) | S1(1) | S1(2) | S1(3) | S1(4) | S1(5) | S1(6) | S1(7) | S2(0) | S2(1) | S2(2) | S2(3) | S2(4) | S2(5) |
	---------------------------------------------------------------------------------------------------------------------------------
	-- FIR_Output	|	  S1(0)  	|	  S1(1)  	|	  S1(2)  	|	 S1(3)		|	  S1(4)  	|	  S1(5)  	|	  S1(6)  	|
	-- Output Fs = 5.5 MHz
	
	
	-- FIR instantiation
	FIR_Inst: fir_compiler_2
	port map(
		aclk 				=> Clk,
		s_axis_data_tvalid 	=> Mix_TV_w1,
		s_axis_data_tready 	=> FIR_tr,			-- not connected
		s_axis_data_tdata 	=> FIR_Input,
		m_axis_data_tvalid 	=> FIR_TVALID,
		m_axis_data_tdata 	=> FIR_Output
	);
	
end Behavioral;
