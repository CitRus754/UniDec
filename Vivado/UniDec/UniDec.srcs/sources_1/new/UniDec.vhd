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
		AsyncStart		: in std_logic;							-- General start
		
		Input_I			: in std_logic_vector(15 downto 0);		-- Input Signal
		Input_Q			: in std_logic_vector(15 downto 0);
				
		FCW_1			: in std_logic_vector(23 downto 0);		-- For Part_I
		DDSAddr_1		: in std_logic_vector(2 downto 0);
		ChanAddr_1		: in std_logic_vector(2 downto 0);
		
		SwSel_1			: in std_logic_vector(2 downto 0);
		SwSel_2			: in std_logic_vector(6 downto 0);

		FCW_2			: in std_logic_vector(23 downto 0);		-- For Part_II
		DDSAddr_2		: in std_logic_vector(6 downto 0);
		ChanAddr_2		: in std_logic_vector(6 downto 0);
		
		StageSelect		: in std_logic_vector(3 downto 0);
		
		Output_I		: out std_logic_vector(15 downto 0);	-- Output Signal
		Output_Q		: out std_logic_vector(15 downto 0)
	);
end UniDec;

architecture Behavioral of UniDec is

	component BitReversedCounter_8 is
		port(
			Clk 		: in std_logic;									-- System Clock 88 MHz
			BitRvsCntr	: out std_logic_vector(7 downto 0)
		);
	end component;
	
	component Part_I is
		generic(
			Num_Signals	: integer := 8
			);
		port(
			Clk 			: in std_logic;						
			
			AsyncStart		: in std_logic;
			
			Input_I			: in std_logic_vector(15 downto 0);		-- Input Signal
			Input_Q			: in std_logic_vector(15 downto 0);
			
			FCW_1			: in std_logic_vector(23 downto 0);		-- For DDS_1
			InChanAddr		: in std_logic_vector(2 downto 0);
			OutChanAddr		: in std_logic_vector(2 downto 0);
			SwitchAddr		: in std_logic_vector(2 downto 0);
			
			BitRvsCntr		: in std_logic_vector(2 downto 0);		-- bit-reversed counter (3 MSB bits)

			Stage1_Out		: out std_logic_vector(31 downto 0);
			Stage2_Out		: out std_logic_vector(31 downto 0);

			SwitchSignal	: out std_logic_vector(31 downto 0);

			FIR2_TVALID		: out std_logic
			
		);
	end component;

	component SwitchModule is
		generic(
			NumChannels	: integer
		);
		port(
			Clk 		: in std_logic;							-- System Clock 88 MHz

			DataIn      : in std_logic_vector(31 downto 0); 
			SwAddr      : in std_logic_vector(6 downto 0);      -- to switch up to 128 channels

			DataOut_I   : out IQ_Array(1 to NumChannels/8);
			DataOut_Q   : out IQ_Array(1 to NumChannels/8)
		);
	end component;
	
	component Part_II is
		generic(
			Num_Signals	: integer := 128
			);
		port(
			Clk 			: in std_logic;
			
			AsyncStart		: in std_logic;
			
			Input_I			: in IQ_Array(1 to Num_Signals/8);		-- Input Signal
			Input_Q			: in IQ_Array(1 to Num_Signals/8);
			
			FCW_2			: in std_logic_vector(23 downto 0);		-- For DDS_2
			InChanAddr		: in std_logic_vector(6 downto 0);
			OutChanAddr		: in std_logic_vector(6 downto 0);

			Stage3_Out		: out std_logic_vector(31 downto 0);
			Stage4_Out		: out std_logic_vector(31 downto 0);
			Stage5_Out		: out std_logic_vector(31 downto 0);
			Stage6_Out		: out std_logic_vector(31 downto 0);
			Stage7_Out		: out std_logic_vector(31 downto 0);
			Stage8_Out		: out std_logic_vector(31 downto 0);
			Stage9_Out		: out std_logic_vector(31 downto 0)
			
			);
	end component;
	
	constant	Num128	: integer := 128;
	
	signal mBitRvsCntr	: std_logic_vector(7 downto 0) 	:= (others => '0');

	signal Part1_TV		: std_logic := '0';
	signal ToSwitch		: std_logic_vector(31 downto 0) 	:= (others => '0');

	signal Part2_I		: IQ_Array(1 to Num128/8)	:= (others => (others => '0'));
	signal Part2_Q		: IQ_Array(1 to Num128/8)	:= (others => (others => '0'));

	signal Stage1, Stage2, Stage3	: std_logic_vector(31 downto 0) 	:= (others => '0');
	signal Stage4, Stage5, Stage6	: std_logic_vector(31 downto 0) 	:= (others => '0');
	signal Stage7, Stage8, Stage9	: std_logic_vector(31 downto 0) 	:= (others => '0');

	signal StageOut					: std_logic_vector(31 downto 0) 	:= (others => '0');

begin

	-- instantiations
	cnt_8: BitReversedCounter_8
	port map (	Clk 		=> Clk,
				BitRvsCntr 	=> mBitRvsCntr
			);


	part1_inst: Part_I
	generic map(Num_Signals => 8)
	port map(
		Clk 			=> Clk,
		AsyncStart		=> AsyncStart,
		Input_I			=> Input_I,
		Input_Q			=> Input_Q,
		FCW_1			=> FCW_1,
		InChanAddr		=> DDSAddr_1,
		OutChanAddr		=> ChanAddr_1,
		SwitchAddr		=> SwSel_1,
		BitRvsCntr		=> mBitRvsCntr(7 downto 5),
		Stage1_Out		=> Stage1,
		Stage2_Out		=> Stage2,
		SwitchSignal	=> ToSwitch,
		FIR2_TVALID		=> Part1_TV
		);

	switch_inst: SwitchModule
	generic map(NumChannels => 128)
	port map(
		Clk 		=> Clk,
		DataIn		=> ToSwitch,
		SwAddr		=> SwSel_2,
		DataOut_I	=> Part2_I,
		DataOut_Q	=> Part2_Q
		);
	
	part2_inst: Part_II
	generic map(Num_Signals => 128)
	port map(
		Clk 			=> Clk,
		AsyncStart		=> AsyncStart,
		Input_I			=> Part2_I,
		Input_Q			=> Part2_Q,
		FCW_2			=> FCW_2,
		InChanAddr		=> DDSAddr_2,
		OutChanAddr		=> ChanAddr_2,
		Stage3_Out		=> Stage3,
		Stage4_Out		=> Stage4,
		Stage5_Out		=> Stage5,
		Stage6_Out		=> Stage6,
		Stage7_Out		=> Stage7,
		Stage8_Out		=> Stage8,
		Stage9_Out		=> Stage9
		);

	
	-- stage select
	process(Clk) begin
		if rising_edge(Clk) then
			if 		StageSelect = "0000" then
				StageOut	<= Stage1;
			elsif	StageSelect = "0001" then
				StageOut	<= Stage2;
			elsif	StageSelect = "0010" then
				StageOut	<= Stage3;
			elsif	StageSelect = "0011" then
				StageOut	<= Stage4;
			elsif	StageSelect = "0100" then
				StageOut	<= Stage5;
			elsif	StageSelect = "0101" then
				StageOut	<= Stage6;
			elsif	StageSelect = "0110" then
				StageOut	<= Stage7;
			elsif	StageSelect = "0111" then
				StageOut	<= Stage8;
			elsif	StageSelect = "1000" then
				StageOut	<= Stage9;
			else StageOut	<= (others => '0');
			end if;
		end if;
	end process;

	Output_I	<= StageOut(15 downto 0);
	Output_Q	<= StageOut(31 downto 16);
	
end Behavioral;
