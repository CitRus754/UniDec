----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.09.2023 16:51:03
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

entity Main is
	generic(
		Num_Inputs	: integer := 8
	);
	port(
		Clk 		: in std_logic;
		
		Input_I		: in	std_logic_vector(15 downto 0);		-- Input Signal
		Input_Q		: in	std_logic_vector(15 downto 0);
				
		DDS_DV_IN	: in	DV_Bus(1 to Num_Inputs);		-- AXI4 DDS Compiler
		DDS_DV_OUT	: out	DV_Bus(1 to Num_Inputs);
		FCW			: in	FCW_Array(1 to Num_Inputs);
		
		FIR_DV_IN	: in	DV_Bus(1 to Num_Inputs/2);		-- AXI4 FIR Compiler
		FIR_TR_1	: out	DV_Bus(1 to Num_Inputs/2);
		FIR_TR_2	: out	DV_Bus(1 to Num_Inputs/4);
		FIR_DV_OUT	: out	DV_Bus(1 to Num_Inputs/4);
		
		OutMux		: in 	std_logic_vector(2 downto 0);
		
		Output_I	: out	std_logic_vector(15 downto 0);		-- Output Signal
		Output_Q	: out	std_logic_vector(15 downto 0)
	);
end Main;

architecture Behavioral of Main is
	
	signal FIR_DV_1			: DV_Bus(1 to Num_Inputs/2);
	signal FIR_DV_2			: DV_Bus(1 to Num_Inputs/4);
	
	signal To_Core_2_I 		: IQ_Array(1 to Num_Inputs);
	signal To_Core_2_Q 		: IQ_Array(1 to Num_Inputs);
	
	signal From_Core_2_I 	: IQ_Array(1 to Num_Inputs);
	signal From_Core_2_Q 	: IQ_Array(1 to Num_Inputs);
	
	signal ToOut_I			: std_logic_vector(15 downto 0);
	signal ToOut_Q			: std_logic_vector(15 downto 0);

	component CORE_1 is
		generic(
		Num_Signals	: integer := 2
		);
	port(
		Clk 		: in 	std_logic;						-- System Clock 44 MHz
		
		Input_I		: in	IQ_Array(1 to Num_Signals);		-- Input Signal
		Input_Q		: in	IQ_Array(1 to Num_Signals);
		
		DDS_DV_IN	: in	DV_Bus(1 to Num_Signals);		-- AXI4 DDS Compiler
		DDS_DV_OUT	: out	DV_Bus(1 to Num_Signals);
		FCW			: in	FCW_Array(1 to Num_Signals);
		
		FIR_DV_IN	: in	std_logic;						-- AXI4 FIR Compiler
		FIR_TREADY  : out   std_logic;
		FIR_DV_OUT	: out	std_logic;
		
		Output_I	: out	IQ_Array(1 to Num_Signals);		-- Output Signal
		Output_Q	: out	IQ_Array(1 to Num_Signals)
		);
	end component;

	component CORE_2 is
		generic(
		Num_Signals	: integer := 4
		);
	port(
		Clk 		: in std_logic;
		
		Input_I		: in	IQ_Array(1 to Num_Signals);		-- Input Signal
		Input_Q		: in	IQ_Array(1 to Num_Signals);
				
		FIR_DV_IN	: in	std_logic;						-- AXI4 FIR Compiler
		FIR_TREADY	: out	std_logic;
		FIR_DV_OUT	: out	std_logic;
		
		Output_I	: out	IQ_Array(1 to Num_Signals);		-- Output Signal
		Output_Q	: out	IQ_Array(1 to Num_Signals)
		);
	end component;

begin

	-- CORE_1 instantiation

	Core_1_Inst: for i in 1 to Num_Inputs/2 generate Core1: CORE_1
		generic map (Num_Signals	=> 2)
		port map(
			Clk			=> Clk,
			Input_I(1)	=> Input_I,
			Input_I(2)	=> Input_I,
			Input_Q(1)	=> Input_Q,
			Input_Q(2)	=> Input_Q,
			DDS_DV_IN	=> DDS_DV_IN((i-1)*(Num_Inputs/4) + 1 to (i-1)*(Num_Inputs/4) + 2),
			DDS_DV_OUT	=> DDS_DV_OUT((i-1)*(Num_Inputs/4) + 1 to (i-1)*(Num_Inputs/4) + 2),
			FCW			=> FCW((i-1)*(Num_Inputs/4) + 1 to (i-1)*(Num_Inputs/4) + 2),
			FIR_DV_IN	=> FIR_DV_IN(i),
			FIR_TREADY	=> FIR_TR_1(i),
			FIR_DV_OUT	=> FIR_DV_1(i),
			Output_I	=> To_Core_2_I((i-1)*(Num_Inputs/4) + 1 to (i-1)*(Num_Inputs/4) + 2),
			Output_Q	=> To_Core_2_Q((i-1)*(Num_Inputs/4) + 1 to (i-1)*(Num_Inputs/4) + 2)
			);
	end generate Core_1_Inst;
	
	-- maybe better using function
	FIR_DV_2(1) <= FIR_DV_1(1) and FIR_DV_1(2);
	FIR_DV_2(2) <= FIR_DV_1(3) and FIR_DV_1(4);
	
	-- CORE_2 instantiation

	Core_2_Inst: for i in 1 to Num_Inputs/4 generate Core2: CORE_2
		generic map (Num_Signals	=> 4)
		port map(
			Clk 		=> Clk,
			Input_I		=> To_Core_2_I((i-1)*(Num_Inputs/2) + 1 to (i-1)*(Num_Inputs/2) + 4),
			Input_Q		=> To_Core_2_Q((i-1)*(Num_Inputs/2) + 1 to (i-1)*(Num_Inputs/2) + 4),					
			FIR_DV_IN	=> FIR_DV_2(i),
			FIR_TREADY	=> FIR_TR_2(i),
			FIR_DV_OUT	=> FIR_DV_OUT(i),
			Output_I	=> From_Core_2_I((i-1)*(Num_Inputs/2) + 1 to (i-1)*(Num_Inputs/2) + 4),
			Output_Q	=> From_Core_2_Q((i-1)*(Num_Inputs/2) + 1 to (i-1)*(Num_Inputs/2) + 4)
			);
	end generate Core_2_Inst;
	
	-- output mux
	process(Clk) begin
		if rising_edge(Clk) then
			case OutMux is
				when "000" =>
					ToOut_I <= From_Core_2_I(1);
					ToOut_Q <= From_Core_2_Q(1);
				when "001" =>
					ToOut_I <= From_Core_2_I(2);
					ToOut_Q <= From_Core_2_Q(2);
				when "010" =>
					ToOut_I <= From_Core_2_I(3);
					ToOut_Q <= From_Core_2_Q(3);
				when "011" =>
					ToOut_I <= From_Core_2_I(4);
					ToOut_Q <= From_Core_2_Q(4);
				when "100" =>
					ToOut_I <= From_Core_2_I(5);
					ToOut_Q <= From_Core_2_Q(5);
				when "101" =>
					ToOut_I <= From_Core_2_I(6);
					ToOut_Q <= From_Core_2_Q(6);
				when "110" =>
					ToOut_I <= From_Core_2_I(7);
					ToOut_Q <= From_Core_2_Q(7);
				when others =>
					ToOut_I <= From_Core_2_I(8);
					ToOut_Q <= From_Core_2_Q(8);
			end case;
		end if;
	end process;
	
	Output_I <= ToOut_I;
	Output_Q <= ToOut_Q;
	
end Behavioral;
