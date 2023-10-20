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
	
	type Select_Array	is array(integer range <>) of std_logic_vector(6 downto 0);
	
	function Merge_Signals (I_Arr, Q_Arr : IQ_Array) return std_logic_vector;
	function Get_I (InpArr : std_logic_vector) return IQ_Array;
	function Get_Q (InpArr : std_logic_vector) return IQ_Array;
	function Bus_AND (InpBus : DV_Bus) return std_logic;
	function Bus_OR (InpBus : DV_Bus) return std_logic;
	function BitRev (Din: std_logic_vector) return std_logic_vector;



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
	
	function Bus_AND (InpBus : DV_Bus) return std_logic is
		variable ToOut: std_logic;
	begin
		ToOut := '1';
		for i in 1 to InpBus'length loop
			ToOut := ToOut and InpBus(i);
		end loop;
		return ToOut;
	end function;
	
	function Bus_OR (InpBus : DV_Bus) return std_logic is
		variable ToOut: std_logic;
	begin
		ToOut := '0';
		for i in 1 to InpBus'length loop
			ToOut := ToOut or InpBus(i);
		end loop;
		return ToOut;
	end function;
	
	function BitRev (Din: std_logic_vector) return std_logic_vector is
		variable ToOut: std_logic_vector;
	begin
		for i in Din'range loop
			ToOut(ToOut'left - i) := Din(i);
		end loop;
		return ToOut;
	end function;


end UniDec_Package;
