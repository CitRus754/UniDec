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

entity UniDec_TB is
--  Port ( );
end UniDec_TB;

architecture Behavioral of UniDec_TB is

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
	
	component UniDec is
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
	signal Clk44			: std_logic := '0';
	-- signal Clk22			: std_logic := '0';
	-- signal Clk11			: std_logic := '0';
	
	signal tbStart			: std_logic := '0';			-- async
	
	-- Reader signals
	signal ReadReset		: std_logic := '0';
	signal ReadDv			: std_logic := '0';
	signal mRFD				: std_logic := '1';
	signal Din_I, Din_Q 	: std_logic_vector(15 downto 0) := (others => '0');

	-- Parts signals - async
	signal mFCW_1, mFCW_2	: std_logic_vector(23 downto 0) := (others => '0');
	signal mDDSAddr_1		: std_logic_vector(2 downto 0) 	:= (others => '0');
    signal mDDSAddr_2		: std_logic_vector(6 downto 0) 	:= (others => '0');
    signal mChanAddr_1		: std_logic_vector(2 downto 0) 	:= (others => '0');
    signal mChanAddr_2		: std_logic_vector(6 downto 0) 	:= (others => '0');
    signal mSw1             : std_logic_vector(2 downto 0) 	:= (others => '0');
    signal mSw2             : std_logic_vector(6 downto 0) 	:= (others => '0');
	
	-- Stages outputs
	signal tbStageSel       : std_logic_vector(3 downto 0) 	:= (others => '0');

    signal tbOut_I, tbOut_Q : std_logic_vector(15 downto 0) 	:= (others => '0');
	
	-- Writer signals
	signal WrTV				: std_logic := '1';
	signal WrSign			: std_logic := '1';
		
begin

	Clk 	<= not Clk after PERIOD/2;
	Clk44 	<= not Clk44 after PERIOD;	        -- for data reading
	-- Clk22   <= not Clk22 after 2*PERIOD;	    -- for data reading
	-- Clk11   <= not Clk11 after 4*PERIOD;	    -- for data reading
	
	dds1_input: process begin
		wait for PERIOD;
		
		tbStart	<= '1';

		-- Channel 2
		mDDSAddr_1	<= "010";
		wait for 1 ns;
		-- mFCW_1		<= x"01bed6";
		mFCW_1		<= x"000ee5";
		wait for 10*PERIOD;
		
		-- Channel 5		
		mDDSAddr_1	<= "101";
		wait for 1 ns;
		-- mFCW_1		<= x"037dac";
		mFCW_1		<= x"001dca";
		wait for 10*PERIOD;
		
		-- Channel 0
		mDDSAddr_1	<= "000";
		wait for 1 ns;
		-- mFCW_1		<= x"0094f2";
		mFCW_1		<= x"002caf";
		wait for 10*PERIOD;

		-- Channel 7		
		mDDSAddr_1	<= "111";
		wait for 1 ns;
		-- mFCW_1		<= x"04a790";
		mFCW_1		<= x"003b94";
		wait for 10*PERIOD;

		-- Channel 1		
		mDDSAddr_1	<= "001";
		wait for 1 ns;
		-- mFCW_1		<= x"0129e4";
		mFCW_1		<= x"004a79";
		wait for 10*PERIOD;

		-- Channel 3		
		mDDSAddr_1	<= "011";
		wait for 1 ns;
		-- mFCW_1		<= x"0253c8";
		mFCW_1		<= x"00595e";
		wait for 10*PERIOD;

		-- Channel 6
		mDDSAddr_1	<= "110";
		wait for 1 ns;
		-- mFCW_1		<= x"04129e";
		mFCW_1		<= x"006843";
		wait for 10*PERIOD;

		-- Channel 4
		mDDSAddr_1	<= "100";
		wait for 1 ns;
		-- mFCW_1		<= x"02e8ba";
		mFCW_1		<= x"007728";
		wait for 10*PERIOD;

		wait;
	end process;
	
	dds_input2: process begin
		wait for 100*PERIOD;
		mDDSAddr_2	<= "0000000";
		mFCW_2		<= x"0005f5";
		for i in 1 to 128 loop
			mDDSAddr_2	<= unsigned(mDDSAddr_2) + 1;
			wait for 1 ns;
			mFCW_2		<= unsigned(mFCW_2) + 500;
			wait for 10*PERIOD;
		end loop;

	end process;

	outp_chans: process begin
		wait for PERIOD;

		-- Channel 2
		mChanAddr_1	<= "010";
		wait for 10 us;

		-- Channel 5
		mChanAddr_1	<= "101";
		wait for 10 us;

		-- Channel 0
		mChanAddr_1	<= "000";
		wait for 10 us;

		-- Channel 7
		mChanAddr_1	<= "111";
		wait for 10 us;

		-- Channel 1
		mChanAddr_1	<= "001";
		wait for 10 us;

		-- Channel 3
		mChanAddr_1	<= "011";
		wait for 10 us;

		-- Channel 6
		mChanAddr_1	<= "110";
		wait for 10 us;

		-- Channel 4
		mChanAddr_1	<= "100";
		wait for 10 us;

		tbStageSel	<= "0000";

		wait;

	end process;

	switch_mod: process begin
		wait for 2*PERIOD;
		mSw1	<= "111";
		mSw2	<= "0000000";

		for i in 1 to 8 loop
			wait for 10*PERIOD;
			mSw1	<= unsigned(mSw1) + 1;
		end loop;
		
		mChanAddr_2	<= "0011001";

		-- for i in 1 to 128 loop
		-- 	wait for 10*PERIOD;
		-- 	mSw2	<= unsigned(mSw2) + 1;
		-- end loop;
		wait;
	end process;

	----------------- Instantiations ---------------------	
	Reader: ReadFile
	generic map (	NumOfBits	=> 16,
					Data_i_File => "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\Input_I.txt",
					Data_q_File	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\Input_Q.txt"
			)
	port map (	clk 	=> Clk44,
				rst 	=> ReadReset,
				rfd 	=> mRFD,
				dv 		=> ReadDv,
				data_i 	=> Din_I,
				data_q 	=> Din_Q
			);
		
	UUT: UniDec
	port map (
				Clk 			=> Clk,
				AsyncStart		=> tbStart,
				Input_I			=> Din_I,
				Input_Q			=> Din_Q,
				FCW_1			=> mFCW_1,
				DDSAddr_1		=> mDDSAddr_1,
                ChanAddr_1		=> mChanAddr_1,
                SwSel_1			=> mSw1,
                SwSel_2			=> mSw2,
                FCW_2			=> mFCW_2,
                DDSAddr_2		=> mDDSAddr_2,
                ChanAddr_2		=> mChanAddr_2,
                StageSelect		=> tbStageSel,
                Output_I		=> tbOut_I,
                Output_Q		=> tbOut_Q
				);
	
	
-- 	Writer: WriteFile
-- 	generic map (	NumOfBits	=> 16,
-- --					File_name1	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\DDS\DDS_Cos.txt",
-- --					File_name2	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\DDS\DDS_Sin.txt"
-- --					File_name1	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\Mix\Mix_I.txt",
-- --					File_name2	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\Mix\Mix_Q.txt"
-- 					File_name1	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\St2Ch7_I.txt",
-- 					File_name2	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\St2Ch7_Q.txt"
-- --					File_name1	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\DDS\DDS_Cos.txt",
-- --					File_name2	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\DDS\DDS_Sin.txt"
-- 			)
-- 	port map (	clk			=> Clk11,
-- 				dv			=> WrTV,
-- 				sign		=> WrSign,
-- 				DataIn_i	=> Chans_2_I(8),
-- 				DataIn_q	=> Chans_2_Q(8)
-- 			);
	
end Behavioral;
