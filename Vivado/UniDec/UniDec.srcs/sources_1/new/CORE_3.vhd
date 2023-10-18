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

library work;
use work.UniDec_Package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CORE_3 is
	generic(
		Num_Signals	: integer := 8
	);
	port(
		Clk 		: in 	std_logic;						-- System Clock 44 MHz
		
		Input_I		: in	IQ_Array(1 to Num_Signals);		-- Input Signal
		Input_Q		: in	IQ_Array(1 to Num_Signals);
		
		DDS_DV_IN	: in	DV_Bus(1 to Num_Signals);		-- AXI4 DDS Compiler
		DDS_DV_OUT	: out	DV_Bus(1 to Num_Signals);
		FCW			: in	FCW_Array(1 to Num_Signals);
		
		FIR_DV_IN	: in	std_logic;						-- AXI4 FIR Compiler
		FIR_TREADY	: out	std_logic;
		FIR_DV_OUT	: out	std_logic;
		
		Output_I	: out	IQ_Array(1 to Num_Signals);		-- Output Signal
		Output_Q	: out	IQ_Array(1 to Num_Signals)
	);
end CORE_3;

architecture Behavioral of CORE_1 is

	signal DDS_I			: SinCos_Array(1 to Num_Signals);	
	signal DDS_Q			: SinCos_Array(1 to Num_Signals);
	
	signal DDS_Signal		: DDS_Array(1 to Num_Signals);
	
	signal Mix_Out_I		: IQ_Array(1 to Num_Signals);
	signal Mix_Out_Q		: IQ_Array(1 to Num_Signals);
	
	signal Mix_Signal		: std_logic_vector (Num_Signals*2*16 - 1 downto 0);
	signal FIR_Signal		: std_logic_vector (Num_Signals*2*16 - 1 downto 0);
	
begin

	-- DDS instantiation
	DDS_Inst: for i in 1 to Num_Signals generate DDS: dds_compiler_0
		port map(
			aclk 				=> Clk,
			s_axis_phase_tvalid => DDS_DV_IN(i),
			s_axis_phase_tdata 	=> FCW(i),
			m_axis_data_tvalid 	=> DDS_DV_OUT(i),
			m_axis_data_tdata 	=> DDS_Signal(i)
		);
	end generate DDS_Inst;

	-- Mixers instantiation
	Mix_Inst: for i in 1 to Num_Signals generate Mixers: Mixer_1
		port map(
			Clk 		=> Clk,			
			Input_I		=> Input_I(i),
			Input_Q		=> Input_Q(i),			
			DDS_I		=> DDS_I(i),
			DDS_Q		=> DDS_Q(i),			
			Output_I	=> Mix_Out_I(i),
			Output_Q	=> Mix_Out_Q(i)
		);
	end generate Mix_Inst;
	
	Mix_Signal <= Merge_Signals(Mix_Out_I,Mix_Out_Q);
	
	-- FIR instantiation
	FIR_Inst: fir_compiler_0
	port map(
		aclk 				=> Clk,
		s_axis_data_tvalid 	=> FIR_DV_IN,
		s_axis_data_tready 	=> FIR_TREADY,
		s_axis_data_tdata 	=> Mix_Signal,
		m_axis_data_tvalid 	=> FIR_DV_OUT,
		m_axis_data_tdata 	=> FIR_Signal
	);
	
	Output_I <= Get_I(FIR_Signal);
	Output_Q <= Get_Q(FIR_Signal);
	
end Behavioral;
