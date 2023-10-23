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
use IEEE.numeric_std.all;

library work;
use work.UniDec_Package.all;

entity Part_II is
	generic(
		Num_Signals	: integer := 128
		);
	port(
		Clk 			: in std_logic;						
		
		AsyncStart		: in std_logic;
		
		Input_I			: in IQ_Array(1 to Num_Signals/8);		-- Input Signal
		Input_Q			: in IQ_Array(1 to Num_Signals/8);
		
		FCW_2			: in std_logic_vector(23 downto 0);		-- For DDS_1
		InChanAddr		: in std_logic_vector(6 downto 0);
		OutChanAddr		: in std_logic_vector(6 downto 0);
		
		-- BitRvsCntr		: in std_logic_vector(6 downto 0);		-- bit-reversed counter (7 MSB bits)

		Stage3_Out		: out std_logic_vector(31 downto 0);
		Stage4_Out		: out std_logic_vector(31 downto 0);
		Stage5_Out		: out std_logic_vector(31 downto 0);
		Stage6_Out		: out std_logic_vector(31 downto 0);
		Stage7_Out		: out std_logic_vector(31 downto 0);
		Stage8_Out		: out std_logic_vector(31 downto 0);
		Stage9_Out		: out std_logic_vector(31 downto 0)
		
		);
end Part_II;

architecture Behavioral of Part_II is

	-- Part_II module consists of CORE_2 (x16), fir_compiler_3 (x8), fir_compiler_4 (x4), fir_compiler_5 (x2), fir_compiler_6 (x1) and DDS
	
	component CORE_2 is
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
	end component;
	
	component DDS_2 is
		generic(
			Num_Signals	: integer := 128				-- TDM (10 = 80/8)
			);
		port(
			Clk				: in std_logic;						
			
			Start			: in std_logic;

			FCW				: in std_logic_vector(23 downto 0);
			Channel_Addr	: in std_logic_vector(6 downto 0);			-- 7 bits to cover up to 128 dds modules
			
			TVALID_OUT		: out DV_Bus(1 to Num_Signals/8);
			Output_I		: out SinCos_Array(1 to Num_Signals/8);
			Output_Q		: out SinCos_Array(1 to Num_Signals/8)
			);
	end component;
	
	component TDM_Matcher is
		generic(
			NumInps		: integer		-- 16
		);
		port(
            Clk			: in std_logic;
            
            Sel			: in std_logic;
            
            InTV		: in DV_Bus(1 to NumInps);
            InSignal	: in DDS_Array(1 to NumInps);
            
            OutTV		: out DV_Bus(1 to NumInps/2);
            OutSignal	: out DDS_Array(1 to NumInps/2)
        );
	end component;
	
	component TDM_Matcher_2 is
		port(
            Clk			: in std_logic;
            
            Sel			: in std_logic;
            
            InTV		: in DV_Bus(1 to 2);
            InSignal	: in DDS_Array(1 to 2);
            
            OutTV		: out std_logic;
            OutSignal	: out std_logic_vector(31 downto 0)
        );
	end component;
	
	component fir_compiler_3 is				-- D = 5
		PORT (
			aclk : IN STD_LOGIC;
			s_axis_data_tvalid : IN STD_LOGIC;
			s_axis_data_tready : OUT STD_LOGIC;
			s_axis_data_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			m_axis_data_tvalid : OUT STD_LOGIC;
			m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	end component;
	
	component fir_compiler_4 is				-- D = 5
		PORT (
			aclk : IN STD_LOGIC;
			s_axis_data_tvalid : IN STD_LOGIC;
			s_axis_data_tready : OUT STD_LOGIC;
			s_axis_data_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			m_axis_data_tvalid : OUT STD_LOGIC;
			m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	end component;

	component fir_compiler_5 is				-- D = 2
		PORT (
			aclk : IN STD_LOGIC;
			s_axis_data_tvalid : IN STD_LOGIC;
			s_axis_data_tready : OUT STD_LOGIC;
			s_axis_data_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			m_axis_data_tvalid : OUT STD_LOGIC;
			m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	end component;
	
	component fir_compiler_6 is				-- D = 2
		PORT (
			aclk : IN STD_LOGIC;
			s_axis_data_tvalid : IN STD_LOGIC;
			s_axis_data_tready : OUT STD_LOGIC;
			s_axis_data_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			m_axis_data_tvalid : OUT STD_LOGIC;
			m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	end component;
	
	component SelectModule is
		generic(
			NumChannels	: integer;      -- total number of channels (128)
			NumInputs   : integer      -- number of separate sets of channels
		);
		port(
			Clk			: in std_logic;

			Start		: in std_logic;
			SelTable	: in Select_Array(1 to NumChannels);
			ChanAddr	: in std_logic_vector(6 downto 0);
			
			InSignal	: in DDS_Array(1 to NumInputs);

			OutSignal	: out std_logic_vector(31 downto 0)
		);
	end component;

	component SelectModule_0 is
		generic(
			NumChannels	: integer      -- total number of channels (128)
		);
		port(
			Clk			: in std_logic;

			Start		: in std_logic;
			SelTable	: in Select_Array(1 to NumChannels);
			ChanAddr	: in std_logic_vector(6 downto 0);
			
			InSignal	: in std_logic_vector(31 downto 0);

			OutSignal	: out std_logic_vector(31 downto 0)
		);
	end component;

	-- constants
	constant tbNumInputs	: integer := 128;

	-- Tables
    constant CORE_2_table     : Select_Array(1 to tbNumInputs) := (
        "0000000", "0000001", "0000010", "0000011", "0000100", "0000101", "0000110", "0000111", "0001000", "0001001", "0001010", "0001011", "0001100", "0001101", "0001110", "0001111",
        "0010000", "0010001", "0010010", "0010011", "0010100", "0010101", "0010110", "0010111", "0011000", "0011001", "0011010", "0011011", "0011100", "0011101", "0011110", "0011111",
        "0100000", "0100001", "0100010", "0100011", "0100100", "0100101", "0100110", "0100111", "0101000", "0101001", "0101010", "0101011", "0101100", "0101101", "0101110", "0101111",
        "0110000", "0110001", "0110010", "0110011", "0110100", "0110101", "0110110", "0110111", "0111000", "0111001", "0111010", "0111011", "0111100", "0111101", "0111110", "0111111",
        "1000000", "1000001", "1000010", "1000011", "1000100", "1000101", "1000110", "1000111", "1001000", "1001001", "1001010", "1001011", "1001100", "1001101", "1001110", "1001111",
        "1010000", "1010001", "1010010", "1010011", "1010100", "1010101", "1010110", "1010111", "1011000", "1011001", "1011010", "1011011", "1011100", "1011101", "1011110", "1011111",
        "1100000", "1100001", "1100010", "1100011", "1100100", "1100101", "1100110", "1100111", "1101000", "1101001", "1101010", "1101011", "1101100", "1101101", "1101110", "1101111",
        "1110000", "1110001", "1110010", "1110011", "1110100", "1110101", "1110110", "1110111", "1111000", "1111001", "1111010", "1111011", "1111100", "1111101", "1111110", "1111111"
    );

    constant FIR3_table     : Select_Array(1 to tbNumInputs) := (
        "0000000", "0001000", "0000001", "0001001", "0000010", "0001010", "0000011", "0001011", "0000100", "0001100", "0000101", "0001101", "0000110", "0001110", "0000111", "0001111",
        "0010000", "0011000", "0010001", "0011001", "0010010", "0011010", "0010011", "0011011", "0010100", "0011100", "0010101", "0011101", "0010110", "0011110", "0010111", "0011111",
        "0100000", "0101000", "0100001", "0101001", "0100010", "0101010", "0100011", "0101011", "0100100", "0101100", "0100101", "0101101", "0100110", "0101110", "0100111", "0101111",
        "0110000", "0111000", "0110001", "0111001", "0110010", "0111010", "0110011", "0111011", "0110100", "0111100", "0110101", "0111101", "0110110", "0111110", "0110111", "0111111",
        "1000000", "1001000", "1000001", "1001001", "1000010", "1001010", "1000011", "1001011", "1000100", "1001100", "1000101", "1001101", "1000110", "1001110", "1000111", "1001111",
        "1010000", "1011000", "1010001", "1011001", "1010010", "1011010", "1010011", "1011011", "1010100", "1011100", "1010101", "1011101", "1010110", "1011110", "1010111", "1011111",
        "1100000", "1101000", "1100001", "1101001", "1100010", "1101010", "1100011", "1101011", "1100100", "1101100", "1100101", "1101101", "1100110", "1101110", "1100111", "1101111",
        "1110000", "1111000", "1110001", "1111001", "1110010", "1111010", "1110011", "1111011", "1110100", "1111100", "1110101", "1111101", "1110110", "1111110", "1110111", "1111111"
    );

    constant FIR4_table     : Select_Array(1 to tbNumInputs) := (
        "0000000", "0010000", "0001000", "0011000", "0000001", "0010001", "0001001", "0011001", "0000010", "0010010", "0001010", "0011010", "0000011", "0010011", "0001011", "0011011",
        "0000100", "0010100", "0001100", "0011100", "0000101", "0010101", "0001101", "0011101", "0000110", "0010110", "0001110", "0011110", "0000111", "0010111", "0001111", "0011111",
        "0100000", "0110000", "0101000", "0111000", "0100001", "0110001", "0101001", "0111001", "0100010", "0110010", "0101010", "0111010", "0100011", "0110011", "0101011", "0111011",
        "0100100", "0110100", "0101100", "0111100", "0100101", "0110101", "0101101", "0111101", "0100110", "0110110", "0101110", "0111110", "0100111", "0110111", "0101111", "0111111",
        "1000000", "1010000", "1001000", "1011000", "1000001", "1010001", "1001001", "1011001", "1000010", "1010010", "1001010", "1011010", "1000011", "1010011", "1001011", "1011011",
        "1000100", "1010100", "1001100", "1011100", "1000101", "1010101", "1001101", "1011101", "1000110", "1010110", "1001110", "1011110", "1000111", "1010111", "1001111", "1011111",
        "1100000", "1110000", "1101000", "1111000", "1100001", "1110001", "1101001", "1111001", "1100010", "1110010", "1101010", "1111010", "1100011", "1110011", "1101011", "1111011",
        "1100100", "1110100", "1101100", "1111100", "1100101", "1110101", "1101101", "1111101", "1100110", "1110110", "1101110", "1111110", "1100111", "1110111", "1101111", "1111111"
    );

    constant FIR5_table     : Select_Array(1 to tbNumInputs) := (
        "0000000", "0100000", "0010000", "0110000", "0001000", "0101000", "0011000", "0111000", "0000001", "0100001", "0010001", "0110001", "0001001", "0101001", "0011001", "0111001",
        "0000010", "0100010", "0010010", "0110010", "0001010", "0101010", "0011010", "0111010", "0000011", "0100011", "0010011", "0110011", "0001011", "0101011", "0011011", "0111011",
        "0000100", "0100100", "0010100", "0110100", "0001100", "0101100", "0011100", "0111100", "0000101", "0100101", "0010101", "0110101", "0001101", "0101101", "0011101", "0111101",
        "0000110", "0100110", "0010110", "0110110", "0001110", "0101110", "0011110", "0111110", "0000111", "0100111", "0010111", "0110111", "0001111", "0101111", "0011111", "0111111",
        "1000000", "1100000", "1010000", "1110000", "1001000", "1101000", "1011000", "1111000", "1000001", "1100001", "1010001", "1110001", "1001001", "1101001", "1011001", "1111001",
        "1000010", "1100010", "1010010", "1110010", "1001010", "1101010", "1011010", "1111010", "1000011", "1100011", "1010011", "1110011", "1001011", "1101011", "1011011", "1111011",
        "1000100", "1100100", "1010100", "1110100", "1001100", "1101100", "1011100", "1111100", "1000101", "1100101", "1010101", "1110101", "1001101", "1101101", "1011101", "1111101",
        "1000110", "1100110", "1010110", "1110110", "1001110", "1101110", "1011110", "1111110", "1000111", "1100111", "1010111", "1110111", "1001111", "1101111", "1011111", "1111111"
    );

    constant FIR6_table     : Select_Array(1 to tbNumInputs) := (
        "0000000", "1000000", "0100000", "1100000", "0010000", "1010000", "0110000", "1110000", "0001000", "1001000", "0101000", "1101000", "0011000", "1011000", "0111000", "1111000",
        "0000001", "1000001", "0100001", "1100001", "0010001", "1010001", "0110001", "1110001", "0001001", "1001001", "0101001", "1101001", "0011001", "1011001", "0111001", "1111001",
        "0000010", "1000010", "0100010", "1100010", "0010010", "1010010", "0110010", "1110010", "0001010", "1001010", "0101010", "1101010", "0011010", "1011010", "0111010", "1111010",
        "0000011", "1000011", "0100011", "1100011", "0010011", "1010011", "0110011", "1110011", "0001011", "1001011", "0101011", "1101011", "0011011", "1011011", "0111011", "1111011",
        "0000100", "1000100", "0100100", "1100100", "0010100", "1010100", "0110100", "1110100", "0001100", "1001100", "0101100", "1101100", "0011100", "1011100", "0111100", "1111100",
        "0000101", "1000101", "0100101", "1100101", "0010101", "1010101", "0110101", "1110101", "0001101", "1001101", "0101101", "1101101", "0011101", "1011101", "0111101", "1111101",
        "0000110", "1000110", "0100110", "1100110", "0010110", "1010110", "0110110", "1110110", "0001110", "1001110", "0101110", "1101110", "0011110", "1011110", "0111110", "1111110",
        "0000111", "1000111", "0100111", "1100111", "0010111", "1010111", "0110111", "1110111", "0001111", "1001111", "0101111", "1101111", "0011111", "1011111", "0111111", "1111111"
    );

	-- Synchronous signals
	signal SyncStart			: std_logic 		:= '0';
	signal sFCW_2				: std_logic_vector(23 downto 0)	:= (others => '0');
	signal sInChanAddr			: std_logic_vector(6 downto 0)	:= (others => '0');
	signal sOutChanAddr			: std_logic_vector(6 downto 0)	:= (others => '0');
	
	signal CORE2_I, CORE2_Q		: IQ_Array(1 to Num_Signals/8)	:= (others => (others => '0'));

	-- Cntr signals
	signal Sel1					: std_logic 		:= '0';
	-- signal Sel1_w1              : std_logic 		:= '0';
	
	
	-- signal Sel_0	: std_logic_vector(2 downto 0) 	:= "000";
	-- signal Sel_1	: std_logic_vector(3 downto 0)	:= "0000";
	
	-- signal Sel_w1, Sel_w2, Sel_w3	: std_logic_vector(3 downto 0) 		:= "0000";
	-- signal Sel2						: std_logic_vector(3 downto 0) 		:= "0000";

	-- signal Sel3_w1, Sel3_w2, Sel3_w3, Sel3_w4, Sel3_w5	: std_logic_vector(2 downto 0) 		:= "000";
	-- signal Sel3					: std_logic_vector(2 downto 0) 		:= "000";

	-- DDS signals
	signal DDS_TV_out 			: DV_Bus(1 to Num_Signals/8) 		:= (others => '0');
	signal DDS_Cos				: SinCos_Array(1 to Num_Signals/8) 	:= (others => (others => '0'));
	signal DDS_Sin				: SinCos_Array(1 to Num_Signals/8) 	:= (others => (others => '0'));	
	
	-- CORE_2 signals
	signal FIR3_OutTV			: DV_Bus(1 to Num_Signals/8) 		:= (others => '0');					-- 128/8 = 16
	signal FIR3_Out				: DDS_Array(1 to Num_Signals/8) 	:= (others => (others => '0'));
	signal ToStage3_Out			: std_logic_vector(31 downto 0)		:= (others => '0');
	
	-- fir_compiler_3
	signal FIR4_InTV			: DV_Bus(1 to Num_Signals/16) 		:= (others => '0');					-- 128/16 = 8
	signal FIR4_Input			: DDS_Array(1 to Num_Signals/16) 	:= (others => (others => '0'));
	signal FIR4_OutTV			: DV_Bus(1 to Num_Signals/16) 		:= (others => '0');
	signal FIR4_Out				: DDS_Array(1 to Num_Signals/16) 	:= (others => (others => '0'));
	signal fir4_tr              : DV_Bus(1 to Num_Signals/16) 		:= (others => '0');	
	signal ToStage4_Out			: std_logic_vector(31 downto 0)		:= (others => '0');

	-- fir_compiler_4
	signal FIR5_InTV			: DV_Bus(1 to Num_Signals/32) 		:= (others => '0');					-- 128/32 = 4
	signal FIR5_Input			: DDS_Array(1 to Num_Signals/32) 	:= (others => (others => '0'));
	signal FIR5_OutTV			: DV_Bus(1 to Num_Signals/32) 		:= (others => '0');
	signal FIR5_Out				: DDS_Array(1 to Num_Signals/32) 	:= (others => (others => '0'));
	signal fir5_tr              : DV_Bus(1 to Num_Signals/32) 		:= (others => '0');	
	signal ToStage5_Out			: std_logic_vector(31 downto 0)		:= (others => '0');	

	-- fir_compiler_5
	signal FIR6_InTV			: DV_Bus(1 to Num_Signals/64) 		:= (others => '0');					-- 128/64 = 2
	signal FIR6_Input			: DDS_Array(1 to Num_Signals/64) 	:= (others => (others => '0'));
	signal FIR6_OutTV			: DV_Bus(1 to Num_Signals/64) 		:= (others => '0');
	signal FIR6_Out				: DDS_Array(1 to Num_Signals/64) 	:= (others => (others => '0'));
	signal fir6_tr              : DV_Bus(1 to Num_Signals/64) 		:= (others => '0');	
	signal ToStage6_Out			: std_logic_vector(31 downto 0)		:= (others => '0');

	-- fir_compiler_6
	signal FIR7_InTV			: std_logic						:= '0';
	signal FIR7_Input			: std_logic_vector(31 downto 0)	:= (others => '0');
	signal FIR7_OutTV			: std_logic						:= '0';
	signal FIR7_Out				: std_logic_vector(31 downto 0)	:= (others => '0');
	signal fir7_tr              : std_logic						:= '0';
	signal ToStage7_Out			: std_logic_vector(31 downto 0)	:= (others => '0');

	signal FIR8_InTV			: std_logic						:= '0';
	signal FIR8_Input			: std_logic_vector(31 downto 0)	:= (others => '0');
	signal FIR8_OutTV			: std_logic						:= '0';
	signal FIR8_Out				: std_logic_vector(31 downto 0)	:= (others => '0');
	signal fir8_tr              : std_logic						:= '0';
	signal ToStage8_Out			: std_logic_vector(31 downto 0)	:= (others => '0');

	signal FIR9_InTV			: std_logic						:= '0';
	signal FIR9_Input			: std_logic_vector(31 downto 0)	:= (others => '0');
	signal FIR9_OutTV			: std_logic						:= '0';
	signal FIR9_Out				: std_logic_vector(31 downto 0)	:= (others => '0');
	signal fir9_tr              : std_logic						:= '0';
	signal ToStage9_Out			: std_logic_vector(31 downto 0)	:= (others => '0');

begin
	
	-- async -> sync signals
	process(Clk) begin
		if rising_edge(Clk) then
			SyncStart	<= AsyncStart;
			if SyncStart = '0' then
				sFCW_2			<= (others => '0');
				sInChanAddr		<= (others => '0');
				sOutChanAddr	<= (others => '0');
			else
				sFCW_2			<= FCW_2;
				sInChanAddr		<= InChanAddr;
				sOutChanAddr	<= OutChanAddr;
			end if;
		end if;
	end process;
	
	process(Clk) begin
		if rising_edge(Clk) then
			if SyncStart = '0' then
				CORE2_I	<= (others => (others => '0'));
				CORE2_Q	<= (others => (others => '0'));
			else
				for i in 1 to Num_Signals/8 loop
					CORE2_I(i)	<= Input_I(i);
					CORE2_Q(i)	<= Input_Q(i);
				end loop;
			end if;
		end if;
	end process;
	
	-- selectors
	-- process(Clk) begin
	-- 	if rising_edge(Clk) then
	-- 		if SyncStart = '0' then
	-- 			Sel1 	<= '1';
	-- 		else
	-- 			Sel1 	<= BitRvsCntr(6);
	-- 		end if;
	-- 	end if;
	-- end process;

	-- process(Clk) begin
	-- 	if rising_edge(Clk) then
	-- 		if SyncStart = '0' then
	-- 			Sel_w1	<= "0000";
	-- 			Sel_w2	<= "0000";
	-- 			Sel_w3	<= "0000";
	-- 			Sel2 	<= "0000";
	-- 		else
	-- 			Sel_w1	<= BitRvsCntr(6 downto 3);	-- select 16 channels
	-- 			Sel_w2	<= Sel_w1;
	-- 			Sel_w3	<= Sel_w2;
	-- 			Sel2	<= Sel_w3;
	-- 		end if;
	-- 	end if;
	-- end process;
	
	-- dds instantiation
	dds_inst: DDS_2
	generic map(Num_Signals => 128)
	port map(
		Clk				=> Clk,
		Start			=> SyncStart,
		FCW				=> sFCW_2,
		Channel_Addr	=> sInChanAddr,
		TVALID_OUT		=> DDS_TV_out,
		Output_I		=> DDS_Cos,
		Output_Q		=> DDS_Sin
		);
	
		
	-- core_2 instantiation
	core_2_inst: for i in 1 to Num_Signals/8 generate core: CORE_2
		port map(
			Clk 		=> Clk,			
			Input_I		=> CORE2_I(i),
			Input_Q		=> CORE2_Q(i),			
			DDS_Ena		=> DDS_TV_out(i),
			DDS_I		=> DDS_Cos(i),
			DDS_Q		=> DDS_Sin(i),					
			FIR_TVALID	=> FIR3_OutTV(i),
			FIR_Output	=> FIR3_Out(i)
			);
	end generate core_2_inst;	
	
	
	-- Select separate channels from FIR TDM outputs
	-- Clk is 88 MHz, output Fs = 5.5 MHz
	-- Designations: Sk(i) - k-th sample of i-th channel
	-- FIR output is 16 channels: 2 parallel (Q-I) and 8 interleaved
	
	
	-- Stage 3 outputs; bit-reversed order in array FIR3_Channels
	-- array index:		1-2-3-4-5-6-7-8-...-121-122-123-124-125-126-127-128
	-- channel number:	0-64-32-96-...-127
		
	-- for FIR4_Input selection
	-- Sel_0	<= sOutChanAddr(6 downto 4);
	-- Sel_1	<= sOutChanAddr(3 downto 0);
	
	-- process(Clk)
	-- 	variable vSel16		: integer;
	-- begin
	-- 	vSel16		:= to_integer(unsigned(Sel2));
	-- 	if rising_edge(Clk) then
	-- 		for i in 1 to Num_Signals/16 loop
	-- 			FIR3_Channels((i-1)*16 + vSel16 + 1)	<= FIR4_Input(i);
	-- 		end loop;
	-- 	end if;
	-- end process;
	
	
	-- -- Stage_1 mux
	-- process(Clk)
	-- 	variable vSel0, vSel1, vSel16	: integer;
	-- begin
	-- 	vSel0	:= to_integer(unsigned(Sel_0));
	-- 	vSel1	:= to_integer(unsigned(BitRev(Sel_1)));
	-- 	vSel16	:= to_integer(unsigned(Sel2));
	-- 	if rising_edge(Clk) then
	-- 		ToStage3_Out	<= FIR3_Channels(vSel1 + 16*vSel0 + 1);	-- bit-reversed order!
	-- 	end if;
	-- end process;
	
	-- Stage3_Out	<= ToStage3_Out;	
	
	

	------------------------------------
	---------FIRs instantiation---------
	------------------------------------
	fir3_inst: for i in 1 to Num_Signals/16 generate FIRs: fir_compiler_3
		port map(
			aclk 				=> Clk,
			s_axis_data_tvalid 	=> FIR4_InTV(i),
			s_axis_data_tready 	=> fir4_tr(i),
			s_axis_data_tdata 	=> FIR4_Input(i),
			m_axis_data_tvalid 	=> FIR4_OutTV(i),
			m_axis_data_tdata 	=> FIR4_Out(i)
		);
	end generate fir3_inst;
	
	fir4_inst: for i in 1 to Num_Signals/32 generate FIRs: fir_compiler_4
		port map(
			aclk 				=> Clk,
			s_axis_data_tvalid 	=> FIR5_InTV(i),
			s_axis_data_tready 	=> fir5_tr(i),
			s_axis_data_tdata 	=> FIR5_Input(i),
			m_axis_data_tvalid 	=> FIR5_OutTV(i),
			m_axis_data_tdata 	=> FIR5_Out(i)
		);
	end generate fir4_inst;

	fir5_inst: for i in 1 to Num_Signals/64 generate FIRs: fir_compiler_5
		port map(
			aclk 				=> Clk,
			s_axis_data_tvalid 	=> FIR6_InTV(i),
			s_axis_data_tready 	=> fir6_tr(i),
			s_axis_data_tdata 	=> FIR6_Input(i),
			m_axis_data_tvalid 	=> FIR6_OutTV(i),
			m_axis_data_tdata 	=> FIR6_Out(i)
		);
	end generate fir5_inst;
	
	fir6_inst: fir_compiler_6
	port map(
		aclk 				=> Clk,
		s_axis_data_tvalid 	=> FIR7_InTV,
		s_axis_data_tready 	=> fir7_tr,
		s_axis_data_tdata 	=> FIR7_Input,
		m_axis_data_tvalid 	=> FIR7_OutTV,
		m_axis_data_tdata 	=> FIR7_Out
	);

	fir7_inst: fir_compiler_6
	port map(
		aclk 				=> Clk,
		s_axis_data_tvalid 	=> FIR8_InTV,
		s_axis_data_tready 	=> fir8_tr,
		s_axis_data_tdata 	=> FIR8_Input,
		m_axis_data_tvalid 	=> FIR8_OutTV,
		m_axis_data_tdata 	=> FIR8_Out
	);

	fir8_inst: fir_compiler_6
	port map(
		aclk 				=> Clk,
		s_axis_data_tvalid 	=> FIR9_InTV,
		s_axis_data_tready 	=> fir9_tr,
		s_axis_data_tdata 	=> FIR9_Input,
		m_axis_data_tvalid 	=> FIR9_OutTV,
		m_axis_data_tdata 	=> FIR9_Out
	);





	------------------------------------
	-----TDM matchers instantiation-----
	------------------------------------
	tdm_inst3: TDM_Matcher
	generic map(NumInps	=> Num_Signals/8)
	port map(
			Clk			=> Clk,
			Sel			=> Sel1,
			InTV		=> FIR3_OutTV,
			InSignal	=> FIR3_Out,
			OutTV		=> FIR4_InTV,
			OutSignal	=> FIR4_Input
	);
	
	tdm_inst4: TDM_Matcher
	generic map(NumInps	=> Num_Signals/16)
	port map(
			Clk			=> Clk,
			Sel			=> Sel1,
			InTV		=> FIR4_OutTV,
			InSignal	=> FIR4_Out,
			OutTV		=> FIR5_InTV,
			OutSignal	=> FIR5_Input
	);
	
	tdm_inst5: TDM_Matcher
	generic map(NumInps	=> Num_Signals/32)
	port map(
			Clk			=> Clk,
			Sel			=> Sel1,
			InTV		=> FIR5_OutTV,
			InSignal	=> FIR5_Out,
			OutTV		=> FIR6_InTV,
			OutSignal	=> FIR6_Input
	);
	
	tdm_inst6: TDM_Matcher_2
	port map(
			Clk			=> Clk,
			Sel			=> Sel1,
			InTV		=> FIR6_OutTV,
			InSignal	=> FIR6_Out,
			OutTV		=> FIR7_InTV,
			OutSignal	=> FIR7_Input
	);

	-- for FIR4_Output selection
	-- Sel3	<= BitRvsCntr;
	
	------------------------------------
	-----SelectModules instantiation----
	------------------------------------
	sel_stage3: SelectModule
	generic map(NumChannels	=> 128, NumInputs	=> 8)
	port map(
			Clk			=> Clk,
			Start		=> SyncStart,
			SelTable	=> CORE_2_table,
			ChanAddr	=> sOutChanAddr,
			InSignal	=> FIR4_Input,
			OutSignal	=> ToStage3_Out
	);

	sel_stage4: SelectModule
	generic map(NumChannels	=> 128, NumInputs	=> 4)
	port map(
			Clk			=> Clk,
			Start		=> SyncStart,
			SelTable	=> FIR3_table,
			ChanAddr	=> sOutChanAddr,
			InSignal	=> FIR5_Input,
			OutSignal	=> ToStage4_Out
	);

	sel_stage5: SelectModule
	generic map(NumChannels	=> 128, NumInputs	=> 2)
	port map(
			Clk			=> Clk,
			Start		=> SyncStart,
			SelTable	=> FIR4_table,
			ChanAddr	=> sOutChanAddr,
			InSignal	=> FIR6_Input,
			OutSignal	=> ToStage5_Out
	);

	sel_stage6: SelectModule_0
	generic map(NumChannels	=> 128)
	port map(
			Clk			=> Clk,
			Start		=> SyncStart,
			SelTable	=> FIR5_table,
			ChanAddr	=> sOutChanAddr,
			InSignal	=> FIR7_Input,
			OutSignal	=> ToStage6_Out
	);

	sel_stage7: SelectModule_0
	generic map(NumChannels	=> 128)
	port map(
			Clk			=> Clk,
			Start		=> SyncStart,
			SelTable	=> FIR6_table,
			ChanAddr	=> sOutChanAddr,
			InSignal	=> FIR7_Out,
			OutSignal	=> ToStage7_Out
	);

	sel_stage8: SelectModule_0
	generic map(NumChannels	=> 128)
	port map(
			Clk			=> Clk,
			Start		=> SyncStart,
			SelTable	=> FIR6_table,			-- the same table
			ChanAddr	=> sOutChanAddr,
			InSignal	=> FIR8_Out,
			OutSignal	=> ToStage8_Out
	);

	sel_stage9: SelectModule_0
	generic map(NumChannels	=> 128)
	port map(
			Clk			=> Clk,
			Start		=> SyncStart,
			SelTable	=> FIR6_table,			-- the same table
			ChanAddr	=> sOutChanAddr,
			InSignal	=> FIR9_Out,
			OutSignal	=> ToStage9_Out
	);

end Behavioral;
