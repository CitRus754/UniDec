----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.09.2023 16:51:03
-- Design Name: 
-- Module Name: Main - Behavioral
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

entity UniDec is
	port(
		Clk 			: in std_logic;							-- Main clock 88 MHz
		
		Input_I			: in std_logic_vector(15 downto 0);		-- Input Signal
		Input_Q			: in std_logic_vector(15 downto 0);
				
		FCW_1			: in std_logic_vector(23 downto 0);		-- For Part_I
		Channel_Addr_1	: in std_logic_vector(2 downto 0);
		DDS_TVALID_1	: in std_logic;
		
		FCW_2			: in std_logic_vector(23 downto 0);		-- For Part_II
		Channel_Addr_2	: in std_logic_vector(6 downto 0);
		DDS_TVALID_2	: in std_logic;
		
		Signal_Select	: in std_logic_vector(3 downto 0);
		
		Output_I		: out std_logic_vector(15 downto 0);	-- Output Signal
		Output_Q		: out std_logic_vector(15 downto 0)
	);
end UniDec;

architecture Behavioral of UniDec is

	component Part_I is
		generic(
			Num_Signals	: integer := 8
			);
		port(
			Clk 			: in std_logic;						
			
			Input_I			: in std_logic_vector(15 downto 0);		-- Input Signal
			Input_Q			: in std_logic_vector(15 downto 0);
			
			FCW_1			: in std_logic_vector(23 downto 0);		-- For Part_I
			Channel_Addr_1	: in std_logic_vector(2 downto 0);
			DDS_TVALID_1	: in std_logic;
			
			Output_I		: out IQ_Array(1 to Num_Signals);		-- Output Signal
			Output_Q		: out IQ_Array(1 to Num_Signals)
			);
	end component;

	component Switch is
		generic(
			Num_Inputs	: integer := 8;
			Num_Outputs	: integer := 80
			);
		port(
			Clk 			: in std_logic;						
			
			Input_I			: in IQ_Array(1 to Num_Inputs);		-- Input Signal
			Input_Q			: in IQ_Array(1 to Num_Inputs);
			
			Channel_Addr_1	: in std_logic_vector(2 downto 0);
			Channel_Addr_2	: in std_logic_vector(6 downto 0);
			
			Output_I		: out IQ_Array(1 to Num_Outputs);	-- Output Signal
			Output_Q		: out IQ_Array(1 to Num_Outputs)
			);
	end component;
	
	component Part_II is
		generic(
			Num_Signals	: integer := 80
			);
		port(
			Clk 			: in std_logic;						
			
			Input_I			: in IQ_Array(1 to Num_Signals);		-- Input Signal
			Input_Q			: in IQ_Array(1 to Num_Signals);
			
			FCW_2			: in std_logic_vector(23 downto 0);		-- For Part_II
			Channel_Addr_2	: in std_logic_vector(6 downto 0);
			DDS_TVALID_2	: in std_logic;
			
			Output_I		: out IQ_Array(1 to Num_Signals);		-- Output Signal
			Output_Q		: out IQ_Array(1 to Num_Signals)
			);
	end component;
	
	component Selector is
		generic(
			Num_Signals	: integer := 80
			);
		port(
			Clk 			: in std_logic;						
			
			Input_I			: in IQ_Array(1 to Num_Signals);		-- Input Signal
			Input_Q			: in IQ_Array(1 to Num_Signals);
			
			Channel_Addr_2	: in std_logic_vector(6 downto 0);
			Signal_Select	: in std_logic_vector(3 downto 0);
			
			Output_I		: out std_logic_vector(15 downto 0);		-- Output Signal
			Output_Q		: out std_logic_vector(15 downto 0)
			);
	end component;
	
begin

	
	
end Behavioral;
