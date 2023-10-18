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
use IEEE.STD_LOGIC_1164.all;

package UniDec_Package is

	type DV_Bus			is array(integer range <>) of std_logic;
	type FCW_Array		is array(integer range <>) of std_logic_vector(23 downto 0);
	
	type IQ_Array 		is array(integer range <>) of std_logic_vector(15 downto 0);
	
	type DDS_Array		is array(integer range <>) of std_logic_vector(31 downto 0);
	type SinCos_Array	is array(integer range <>) of std_logic_vector(11 downto 0);
	
	component Mixer_1 is
		port(
			Clk 		: in std_logic;
			
			Input_I		: in std_logic_vector(15 downto 0);		-- a
			Input_Q		: in std_logic_vector(15 downto 0);		-- b
			
			DDS_I		: in std_logic_vector(11 downto 0);		-- c
			DDS_Q		: in std_logic_vector(11 downto 0);		-- d
			
			Output_I	: out std_logic_vector(15 downto 0);	-- R
			Output_Q	: out std_logic_vector(15 downto 0)		-- I
		);
	end component;
	
	component dds_compiler_0 is				-- IP core
		port (
			aclk 				: IN STD_LOGIC;
			s_axis_phase_tvalid : IN STD_LOGIC;
			s_axis_phase_tdata 	: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
			m_axis_data_tvalid 	: OUT STD_LOGIC;
			m_axis_data_tdata 	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
		);
	end component;
	
	component fir_compiler_0 is				-- IP core
		PORT (
			aclk 				: IN STD_LOGIC;
			s_axis_data_tvalid 	: IN STD_LOGIC;
			s_axis_data_tready 	: OUT STD_LOGIC;
			s_axis_data_tdata 	: IN STD_LOGIC_VECTOR(63 DOWNTO 0);
			m_axis_data_tvalid 	: OUT STD_LOGIC;
			m_axis_data_tdata 	: OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
		);
	end component;

	component fir_compiler_1 is				-- IP core
		PORT (
			aclk 				: IN STD_LOGIC;
			s_axis_data_tvalid 	: IN STD_LOGIC;
			s_axis_data_tready 	: OUT STD_LOGIC;
			s_axis_data_tdata 	: IN STD_LOGIC_VECTOR(127 DOWNTO 0);
			m_axis_data_tvalid 	: OUT STD_LOGIC;
			m_axis_data_tdata 	: OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
		);
	end component;

	function Merge_Signals (I_Arr, Q_Arr : IQ_Array) return std_logic_vector;
	function Get_I (InpArr : std_logic_vector) return IQ_Array;
	function Get_Q (InpArr : std_logic_vector) return IQ_Array;
	

end package UniDec_Package;

package body UniDec_Package is
	
	function Merge_Signals (I_Arr, Q_Arr : IQ_Array) return std_logic_vector is
		variable ToOut: std_logic_vector (I_Arr'length*2*16 - 1 downto 0);
		variable FullRange:	integer;
		variable NumOfSignals: integer;
	begin
		ToOut 			:= (others => '0');
		NumOfSignals	:= I_Arr'length;
		FullRange 		:= NumOfSignals*2*16;
		for i in 0 to (NumOfSignals-1) loop
			-- ToOut(FullRange - i*16*2 downto FullRange - 15 - i*16*2) 		:= Q_Arr(i);
			-- ToOut(FullRange - 16 - i*16*2 downto FullRange - 31 - i*16*2) 	:= I_Arr(i);
			ToOut(FullRange-1 - i*2*16 downto FullRange-1 - i*2*16 - 15)		:= Q_Arr(NumOfSignals - i);
			ToOut(FullRange-1 - i*2*16 - 16 downto FullRange-1 - i*2*16 - 31)	:= I_Arr(NumOfSignals - i);
		end loop;
		return ToOut;
	end function;
	
	function Get_I (InpArr : std_logic_vector) return IQ_Array is
		variable ToOut: IQ_Array (1 to InpArr'length/(2*16));
		variable NumOfSignals: integer;
		variable FullRange: integer;
	begin
		ToOut 			:= (others => (others => '0'));
		NumOfSignals	:= InpArr'length / (16*2);
		FullRange 		:= NumOfSignals*2*16;
		for i in 0 to (NumOfSignals-1) loop
			ToOut(NumOfSignals - i) := InpArr(FullRange-1 - i*2*16 - 16 downto FullRange-1 - i*2*16 - 31);
		end loop;
		return ToOut;
	end function;
	
	function Get_Q (InpArr : std_logic_vector) return IQ_Array is
		variable ToOut: IQ_Array (1 to InpArr'length/(2*16));
		variable NumOfSignals: integer;
		variable FullRange: integer;
	begin
		ToOut 			:= (others => (others => '0'));
		NumOfSignals	:= InpArr'length / (16*2);
		FullRange 		:= NumOfSignals*2*16;
		for i in 0 to (NumOfSignals-1) loop
			ToOut(NumOfSignals - i) := InpArr(FullRange-1 - i*2*16 downto FullRange-1 - i*2*16 - 15);
		end loop;
		return ToOut;
	end function;
	
end UniDec_Package;
