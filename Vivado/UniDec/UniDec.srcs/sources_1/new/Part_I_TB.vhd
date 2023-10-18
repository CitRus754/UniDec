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

entity Part_I_TB is
--  Port ( );
end Part_I_TB;

architecture Behavioral of Part_I_TB is

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
			-- Channel_Addr_1	: in std_logic_vector(2 downto 0);
			DDS_TVALID_1	: in std_logic;
            
            BitRvsCntr		: in std_logic_vector(2 downto 0);		-- bit-reversed counter (3 MSB bits)
                    
            -- Debug!
            -- Chan0_I, Chan0_Q: out IQ_Array(1 to Num_Signals/2);
            -- Chan1_I, Chan1_Q: out IQ_Array(1 to Num_Signals/2);
            
            -- Stages 1-2 outputs
            Stage1_Channels	: out DDS_Array(1 to Num_Signals);
            Stage2_Channels	: out DDS_Array(1 to Num_Signals);
            FIR2_TVALID		: out std_logic
            
            
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
	signal Clk22			: std_logic := '0';
	signal Clk11			: std_logic := '0';
	
	signal tbStart			: std_logic := '0';			-- async
	
	-- Constants and so on
	constant Num8           : integer := 8;
	signal ClkCntr          : integer := 0;
	signal SmpCntr_w        : integer := 0;
	signal SmpCntr        	: integer := 0;
	
	-- Cntr_8 signals
	signal mBitRvsCntr		: std_logic_vector(7 downto 0) 	:= (others => '0');
	
	-- Reader signals
	signal ReadReset		: std_logic := '0';
	signal ReadDv			: std_logic := '0';
	signal mRFD				: std_logic := '1';
	signal Din_I, Din_Q 	: std_logic_vector(15 downto 0) := (others => '0');
	
	-- Part_I signals - async
	signal mFCW				: std_logic_vector(23 downto 0) := (others => '0');
	signal mChanAddr		: std_logic_vector(2 downto 0) 	:= (others => '0');
	signal tbOutChanAddr	: std_logic_vector(2 downto 0) 	:= (others => '0');
	signal mDDS_TV			: std_logic := '0';
	
	-- Debug!
	-- signal tbCh0_I, tbCh0_Q, tbCh1_I, tbCh1_Q	: IQ_Array(1 to Num8/2)	:= (others => (others => '0'));
	signal Chans_1_I, Chans_1_Q	: IQ_Array(1 to Num8)	:= (others => (others => '0'));
	signal Chans_2_I, Chans_2_Q	: IQ_Array(1 to Num8)	:= (others => (others => '0'));
	
	signal Chans_1, Chans_2	: DDS_Array(1 to 8)	:= (others => (others => '0'));
	
	signal mFIR_TV_out		: std_logic := '0';
	
--	-- Writer signals
	signal WrTV				: std_logic := '1';
	signal WrSign			: std_logic := '1';
		
begin

	Clk 	<= not Clk after PERIOD/2;
	Clk44 	<= not Clk44 after PERIOD;	-- for data reading
	Clk22   <= not Clk22 after 2*PERIOD;	-- for data reading
	Clk11   <= not Clk11 after 4*PERIOD;	-- for data reading
	
--	process(Clk) begin
--	   if rising_edge(Clk) then
	       ClkCntr <= ClkCntr+1 when rising_edge(Clk);
	       SmpCntr <= ClkCntr+1 when rising_edge(mBitRvsCntr(7));
--	   end if;
--    end process;	
	
		process(Clk) begin
	   if rising_edge(Clk) then
	       SmpCntr_w <= SmpCntr;
	   end if;
    end process;	
	
	-- first - change Addr, then - FCW
	-- TVALID_IN set to '0' when change Addr and change FCW; set to '1' in 1 PERIOD after 1 ns
	-- Frequencies (negative sine!) to set are:
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
		
		tbStart	<= '1';

-- 		-- Channel 0
-- 		mChanAddr	<= "000";
-- 		mDDS_TV		<= '0';
-- 		wait for 1 ns;
-- 		mFCW		<= x"0094f2";	-- 100k
-- --		mFCW		<= x"100000";
-- --		wait for PERIOD;
-- 		mDDS_TV		<= '1';
-- 		wait for 100*PERIOD;
		
-- 		-- Channel 1		
-- 		mChanAddr	<= "001";
-- 		mDDS_TV		<= '0';
-- 		wait for 1 ns;
-- 		mFCW		<= x"0129e4";
-- --		mFCW		<= x"300000";
-- --		wait for PERIOD;
-- 		mDDS_TV		<= '1';
-- 		wait for 100*PERIOD;
		
-- 		-- Channel 2
-- 		mChanAddr	<= "010";
-- 		mDDS_TV		<= '0';
-- 		wait for 1 ns;
-- 		mFCW		<= x"01bed6";
-- --		mFCW		<= x"500000";
-- --		wait for PERIOD;
-- 		mDDS_TV		<= '1';
-- 		wait for 100*PERIOD;
		
-- 		-- Channel 3		
-- 		mChanAddr	<= "011";
-- 		mDDS_TV		<= '0';
-- 		wait for 1 ns;
-- 		mFCW		<= x"0253c8";
-- --		mFCW		<= x"700000";
-- --		wait for PERIOD;
-- 		mDDS_TV		<= '1';
-- 		wait for 100*PERIOD;
		
-- 		-- Channel 4
-- 		mChanAddr	<= "100";
-- 		mDDS_TV		<= '0';
-- 		wait for 1 ns;
-- 		mFCW		<= x"02e8ba";
-- --		mFCW		<= x"900000";
-- --		wait for PERIOD;
-- 		mDDS_TV		<= '1';
-- 		wait for 100*PERIOD;
		
-- 		-- Channel 5		
-- 		mChanAddr	<= "101";
-- 		mDDS_TV		<= '0';
-- 		wait for 1 ns;
-- 		mFCW		<= x"037dac";
-- --		mFCW		<= x"b00000";
-- --		wait for PERIOD;
-- 		mDDS_TV		<= '1';
-- 		wait for 100*PERIOD;
		
		-- Channel 6
		mChanAddr	<= "110";
		mDDS_TV		<= '0';
		wait for 1 ns;
		mFCW		<= x"04129e";
--		mFCW		<= x"d00000";
--		wait for PERIOD;
		mDDS_TV		<= '1';
		wait for 100*PERIOD;
		
-- 		-- Channel 7		
-- 		mChanAddr	<= "111";
-- 		mDDS_TV		<= '0';
-- 		wait for 1 ns;
-- 		mFCW		<= x"04a790";
-- --		mFCW		<= x"f00000";
-- --		wait for PERIOD;
-- 		mDDS_TV		<= '1';
-- 		wait for 100*PERIOD;
		
		wait;
	end process;
	
	/* gen_inp: process begin
		wait for PERIOD;
		mChanAddr	<= "000";
		mFCW		<= x"0094f2";	-- 100k
		mDDS_TV		<= '1';
		wait for 0.1 ns;
		mChanAddr	<= "001";
		mFCW		<= x"0129e4";	-- 200k
		wait for 0.1 ns;
		mChanAddr	<= "010";
		mFCW		<= x"01bed6";	-- 300k
		wait for 0.1 ns;
		mChanAddr	<= "011";
		mFCW		<= x"0253c8";	-- 400k
		wait for 0.1 ns;
		mChanAddr	<= "100";
		mFCW		<= x"02e8ba";	-- 500k
		wait for 0.1 ns;
		mChanAddr	<= "101";
		mFCW		<= x"037dac";	-- 600k
		wait for 0.1 ns;
		mChanAddr	<= "110";
		mFCW		<= x"04129e";	-- 700k
		wait for 0.1 ns;
		mChanAddr	<= "111";
		mFCW		<= x"04a790";	-- 800k
		wait;
	end process; */
	
	outp_chans: process begin
		wait for PERIOD;
        
        -- -- Channel 0
		-- tbOutChanAddr	<= "000";
		-- wait for 20 us;

		-- -- Channel 1
		-- tbOutChanAddr	<= "001";
		-- wait for 20 us;

		-- -- Channel 2
		-- tbOutChanAddr	<= "010";
		-- wait for 20 us;

		-- -- Channel 3
		-- tbOutChanAddr	<= "011";
		-- wait for 20 us;

		-- -- Channel 4
		-- tbOutChanAddr	<= "100";
		-- wait for 20 us;

		-- -- Channel 5
		-- tbOutChanAddr	<= "101";
		-- wait for 20 us;

		-- Channel 6
		tbOutChanAddr	<= "110";
		wait for 20 us;

		-- -- Channel 7
		-- tbOutChanAddr	<= "111";
		-- wait for 20 us;

		wait;

	end process;

	----------------- Instantiations ---------------------
	cnt_8: BitReversedCounter_8
	port map (	Clk 		=> Clk,
				BitRvsCntr 	=> mBitRvsCntr
			);
	
	
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
		
	UUT: Part_I
	generic map (Num_Signals => 8)
	port map (
				Clk 			=> Clk,
				AsyncStart		=> tbStart,
				Input_I			=> Din_I,
				Input_Q			=> Din_Q,				
				FCW_1			=> mFCW,
				InChanAddr		=> mChanAddr,
				OutChanAddr		=> tbOutChanAddr,
				-- Channel_Addr_1	=> mChanAddr,
				DDS_TVALID_1	=> mDDS_TV,
				BitRvsCntr		=> mBitRvsCntr(7 downto 5),
				
				-- Debug!
				-- Chan0_I			=> tbCh0_I,
				-- Chan0_Q			=> tbCh0_Q,
				-- Chan1_I			=> tbCh1_I,
				-- Chan1_Q			=> tbCh1_Q,
				
				Stage1_Channels	=> Chans_1,
				Stage2_Channels	=> Chans_2,
				FIR2_TVALID		=> mFIR_TV_out
				
				);
	
	
	----------------fir1Debug!--------------
	Chans_1_I(1) <= Chans_1(1)(15 downto 0);
	Chans_1_I(2) <= Chans_1(2)(15 downto 0);
	Chans_1_I(3) <= Chans_1(3)(15 downto 0);
	Chans_1_I(4) <= Chans_1(4)(15 downto 0);
	Chans_1_I(5) <= Chans_1(5)(15 downto 0);
	Chans_1_I(6) <= Chans_1(6)(15 downto 0);
	Chans_1_I(7) <= Chans_1(7)(15 downto 0);
	Chans_1_I(8) <= Chans_1(8)(15 downto 0);
	
	Chans_1_Q(1) <= Chans_1(1)(31 downto 16);
	Chans_1_Q(2) <= Chans_1(2)(31 downto 16);
	Chans_1_Q(3) <= Chans_1(3)(31 downto 16);
	Chans_1_Q(4) <= Chans_1(4)(31 downto 16);
	Chans_1_Q(5) <= Chans_1(5)(31 downto 16);
	Chans_1_Q(6) <= Chans_1(6)(31 downto 16);
	Chans_1_Q(7) <= Chans_1(7)(31 downto 16);
	Chans_1_Q(8) <= Chans_1(8)(31 downto 16);
--	---------------------------------------
	
--	----------------fir2Debug!--------------
	Chans_2_I(1) <= Chans_2(1)(15 downto 0);
	Chans_2_I(2) <= Chans_2(2)(15 downto 0);
	Chans_2_I(3) <= Chans_2(3)(15 downto 0);
	Chans_2_I(4) <= Chans_2(4)(15 downto 0);
	Chans_2_I(5) <= Chans_2(5)(15 downto 0);
	Chans_2_I(6) <= Chans_2(6)(15 downto 0);
	Chans_2_I(7) <= Chans_2(7)(15 downto 0);
	Chans_2_I(8) <= Chans_2(8)(15 downto 0);
	
	Chans_2_Q(1) <= Chans_2(1)(31 downto 16);
	Chans_2_Q(2) <= Chans_2(2)(31 downto 16);
	Chans_2_Q(3) <= Chans_2(3)(31 downto 16);
	Chans_2_Q(4) <= Chans_2(4)(31 downto 16);
	Chans_2_Q(5) <= Chans_2(5)(31 downto 16);
	Chans_2_Q(6) <= Chans_2(6)(31 downto 16);
	Chans_2_Q(7) <= Chans_2(7)(31 downto 16);
	Chans_2_Q(8) <= Chans_2(8)(31 downto 16);
	---------------------------------------
	
	
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
