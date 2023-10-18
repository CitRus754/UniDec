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

entity DDS_TB is
--  Port ( );
end DDS_TB;

architecture Behavioral of DDS_TB is

    component DDS is
		generic(
			Num_Signals	: integer := 8					-- TDM (4 = 8/2)
			);
		port(
			Clk 			: in std_logic;						
			
			FCW				: in std_logic_vector(23 downto 0);
			Channel_Addr	: in std_logic_vector(2 downto 0);
			TVALID_IN		: in std_logic;
			
			Selector		: in std_logic;
			
			TVALID_OUT		: out DV_Bus(1 to Num_Signals/2);
			Output_I		: out SinCos_Array(1 to Num_Signals/2);
			Output_Q		: out SinCos_Array(1 to Num_Signals/2)
			);
	end component;
	
	component BitReversedCounter_8 is
		port(
			Clk 		: in std_logic;									-- System Clock 88 MHz
			BitRvsCntr	: out std_logic_vector(7 downto 0)
		);
	end component;
	
	-- Constants
	constant Num8               : integer := 8;
	
	-- Clk
	constant PERIOD				: time := 11.363636364 ns;	-- 88 MHz
	signal Clk					: std_logic := '0';
	
	-- Cntr_8 signals
	signal mBitRvsCntr			: std_logic_vector(7 downto 0) 		:= (others => '0');
	
	-- DDS signals
	signal mFCW					: std_logic_vector(23 downto 0) 	:= (others => '0');
	signal mChanAddr			: std_logic_vector(2 downto 0) 		:= (others => '0');
	signal mDDS_TV				: std_logic := '0';
	
	signal mTV_Out				: DV_Bus(1 to Num8/2)		:= (others => '0');
	signal mOutput_I, mOutput_Q	: SinCos_Array(1 to Num8/2)	:= (others => (others => '0'));
	
	signal Chan0_I, Chan0_Q	    : SinCos_Array(1 to Num8/2)	:= (others => (others => '0'));
	signal Chan1_I, Chan1_Q	    : SinCos_Array(1 to Num8/2)	:= (others => (others => '0'));
	
begin

	Clk 	<= not Clk after PERIOD/2;	
	
	
	-- first - change Addr, then - FCW
	-- TVALID_IN set to '0' when change Addr; set to '1' in 1 PERIOD after FCW change
	-- Frequencies to set are:
	-- 2.75 MHz		:	x"100000"
	-- 8.25 MHz 	:	x"300000"
	-- 13.75 MHz	:	x"500000"
	-- 19.25 MHz 	:	x"700000"
	-- 24.75 MHz	:	x"900000"
	-- 30.25 MHz	:	x"b00000"
	-- 35.75 MHz	:	x"d00000"
	-- 41.25 MHz	:	x"f00000"
	
	dds_input: process begin
		wait for PERIOD;
		
		-- Channel 1
		mChanAddr	<= "000";
		mDDS_TV		<= '0';
		wait for 1 ns;
		mFCW		<= x"100000";	-- 2.75 MHz
		wait for PERIOD;
		mDDS_TV		<= '1';
		wait for 10*PERIOD;
		
		-- Channel 2		
		mChanAddr	<= "001";
		mDDS_TV		<= '0';
		wait for 1 ns;
		mFCW		<= x"300000";
		wait for PERIOD;
		mDDS_TV		<= '1';
		wait for 10*PERIOD;
		
		-- Channel 3
		mChanAddr	<= "010";
		mDDS_TV		<= '0';
		wait for 1 ns;
		mFCW		<= x"500000";
		wait for PERIOD;
		mDDS_TV		<= '1';
		wait for 10*PERIOD;
		
		-- Channel 4		
		mChanAddr	<= "011";
		mDDS_TV		<= '0';
		wait for 1 ns;
		mFCW		<= x"700000";
		wait for PERIOD;
		mDDS_TV		<= '1';
		wait for 10*PERIOD;
		
		-- Channel 5
		mChanAddr	<= "100";
		mDDS_TV		<= '0';
		wait for 1 ns;
		mFCW		<= x"900000";
		wait for PERIOD;
		mDDS_TV		<= '1';
		wait for 10*PERIOD;
		
		-- Channel 6		
		mChanAddr	<= "101";
		mDDS_TV		<= '0';
		wait for 1 ns;
		mFCW		<= x"b00000";
		wait for PERIOD;
		mDDS_TV		<= '1';
		wait for 10*PERIOD;
		
		-- Channel 7
		mChanAddr	<= "110";
		mDDS_TV		<= '0';
		wait for 1 ns;
		mFCW		<= x"d00000";
		wait for PERIOD;
		mDDS_TV		<= '1';
		wait for 10*PERIOD;
		
		-- Channel 8		
		mChanAddr	<= "111";
		mDDS_TV		<= '0';
		wait for 1 ns;
		mFCW		<= x"f00000";
		wait for PERIOD;
		mDDS_TV		<= '1';
		wait for 10*PERIOD;
		
		wait;
	end process;
	
	
	--------------------------------------------
	cnt_8: BitReversedCounter_8
	port map (	Clk 		=> Clk,
				BitRvsCntr 	=> mBitRvsCntr
			);
	
	
	dds_inst: DDS
	generic map (Num_Signals	=> 8)
	port map (	Clk 			=> Clk,
				FCW				=> mFCW,
				Channel_Addr	=> mChanAddr,
				TVALID_IN		=> mDDS_TV,
				Selector		=> mBitRvsCntr(7),
				TVALID_OUT		=> mTV_Out,
				Output_I		=> mOutput_I,
				Output_Q		=> mOutput_Q
			);
	
	select_chans: process (mBitRvsCntr) begin
		if mBitRvsCntr(7) = '1' then
			Chan0_I	<= mOutput_I;
			Chan0_Q	<= mOutput_Q;
		else
			Chan1_I	<= mOutput_I;
			Chan1_Q	<= mOutput_Q;
		end if;
	end process;
	
	
	
end Behavioral;
