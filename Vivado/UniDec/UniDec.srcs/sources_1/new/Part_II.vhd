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
		
		BitRvsCntr		: in std_logic_vector(6 downto 0);		-- bit-reversed counter (7 MSB bits)

		Stage3_Out		: out std_logic_vector(31 downto 0);
		Stage4_Out		: out std_logic_vector(31 downto 0);
		Stage5_Out		: out std_logic_vector(31 downto 0);
		Stage6_Out		: out std_logic_vector(31 downto 0);
		Stage7_Out		: out std_logic_vector(31 downto 0);
		Stage8_Out		: out std_logic_vector(31 downto 0);
		Stage9_Out		: out std_logic_vector(31 downto 0);

		FIR_TVALID		: out std_logic
		
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



	-- Synchronous signals
	signal SyncStart			: std_logic 		:= '0';
	signal sFCW_2				: std_logic_vector(23 downto 0);
	signal sInChanAddr			: std_logic_vector(2 downto 0);
	signal sOutChanAddr			: std_logic_vector(2 downto 0);
	
	signal CORE2_I, CORE2_Q		: IQ_Array(1 to Num_Signals/8)	:= (others => (others => '0'));

	-- Cntr signals
	signal Sel1					: std_logic 		:= '0';
	-- signal Sel1_w1              : std_logic 		:= '0';
	
	
	signal Sel_0	: std_logic_vector(2 downto 0) 	:= "000";
	signal Sel_1	: std_logic_vector(3 downto 0)	:= "0000";
	
	signal Sel_w1, Sel_w2, Sel_w3	: std_logic_vector(3 downto 0) 		:= "0000";
	signal Sel2						: std_logic_vector(3 downto 0) 		:= "0000";

	signal Sel3_w1, Sel3_w2, Sel3_w3, Sel3_w4, Sel3_w5	: std_logic_vector(2 downto 0) 		:= "000";
	signal Sel3					: std_logic_vector(2 downto 0) 		:= "000";

	-- DDS signals
	signal DDS_TV_out 			: DV_Bus(1 to Num_Signals/8) 		:= (others => '0');
	signal DDS_Cos				: SinCos_Array(1 to Num_Signals/8) 	:= (others => (others => '0'));
	signal DDS_Sin				: SinCos_Array(1 to Num_Signals/8) 	:= (others => (others => '0'));	
	
	-- CORE_2 signals
	signal FIR3_OutTV			: DV_Bus(1 to Num_Signals/8) 		:= (others => '0');					-- 128/8 = 16
	signal FIR3_Out				: DDS_Array(1 to Num_Signals/8) 	:= (others => (others => '0'));
	signal FIR3_Channels		: DDS_Array(1 to Num_Signals) 		:= (others => (others => '0'));
	signal ToStage3_Out			: std_logic_vector(31 downto 0)		:= (others => '0');
	
	-- fir_compiler_3
	signal FIR4_InTV			: DV_Bus(1 to Num_Signals/16) 		:= (others => '0');					-- 128/16 = 8
	signal FIR4_Input			: DDS_Array(1 to Num_Signals/16) 	:= (others => (others => '0'));
	signal FIR4_OutTV			: DV_Bus(1 to Num_Signals/16) 		:= (others => '0');
	signal FIR4_Out				: DDS_Array(1 to Num_Signals/16) 	:= (others => (others => '0'));
	signal FIR4_Channels		: DDS_Array(1 to Num_Signals) 		:= (others => (others => '0'));
	signal fir4_tr              : DV_Bus(1 to Num_Signals/16) 		:= (others => '0');	
	signal ToStage4_Out			: std_logic_vector(31 downto 0)		:= (others => '0');

	-- fir_compiler_4
	signal FIR5_InTV			: DV_Bus(1 to Num_Signals/32) 		:= (others => '0');					-- 128/32 = 4
	signal FIR5_Input			: DDS_Array(1 to Num_Signals/32) 	:= (others => (others => '0'));
	signal FIR5_OutTV			: DV_Bus(1 to Num_Signals/32) 		:= (others => '0');
	signal FIR5_Out				: DDS_Array(1 to Num_Signals/32) 	:= (others => (others => '0'));
	signal FIR5_Channels		: DDS_Array(1 to Num_Signals) 		:= (others => (others => '0'));
	signal fir5_tr              : DV_Bus(1 to Num_Signals/32) 		:= (others => '0');	
	signal ToStage5_Out			: std_logic_vector(31 downto 0)		:= (others => '0');	

	-- fir_compiler_5
	signal FIR6_InTV			: DV_Bus(1 to Num_Signals/64) 		:= (others => '0');					-- 128/64 = 2
	signal FIR6_Input			: DDS_Array(1 to Num_Signals/64) 	:= (others => (others => '0'));
	signal FIR6_OutTV			: DV_Bus(1 to Num_Signals/64) 		:= (others => '0');
	signal FIR6_Out				: DDS_Array(1 to Num_Signals/64) 	:= (others => (others => '0'));
	signal FIR6_Channels		: DDS_Array(1 to Num_Signals) 		:= (others => (others => '0'));
	signal fir6_tr              : DV_Bus(1 to Num_Signals/64) 		:= (others => '0');	
	signal ToStage6_Out			: std_logic_vector(31 downto 0)		:= (others => '0');

	-- fir_compiler_6
	signal FIR7_InTV			: std_logic	:= '0';
	signal FIR7_Input			: std_logic_vector(2 downto 0)	:= (others => '0');
	signal FIR7_OutTV			: std_logic	:= '0';
	signal FIR7_Out				: std_logic_vector(2 downto 0)	:= (others => '0');
	signal FIR7_Channels		: DDS_Array(1 to Num_Signals) 		:= (others => (others => '0'));
	signal fir7_tr              : std_logic	:= '0';
	signal ToStage7_Out			: std_logic_vector(31 downto 0)		:= (others => '0');

	signal FIR8_InTV			: std_logic	:= '0';
	signal FIR8_Input			: std_logic_vector(2 downto 0)	:= (others => '0');
	signal FIR8_OutTV			: std_logic	:= '0';
	signal FIR8_Out				: std_logic_vector(2 downto 0)	:= (others => '0');
	signal FIR8_Channels		: DDS_Array(1 to Num_Signals) 		:= (others => (others => '0'));
	signal fir8_tr              : std_logic	:= '0';
	signal ToStage8_Out			: std_logic_vector(31 downto 0)		:= (others => '0');

	signal FIR9_InTV			: std_logic	:= '0';
	signal FIR9_Input			: std_logic_vector(2 downto 0)	:= (others => '0');
	signal FIR9_OutTV			: std_logic	:= '0';
	signal FIR9_Out				: std_logic_vector(2 downto 0)	:= (others => '0');
	signal FIR9_Channels		: DDS_Array(1 to Num_Signals) 		:= (others => (others => '0'));
	signal fir9_tr              : std_logic	:= '0';
	signal ToStage9_Out			: std_logic_vector(31 downto 0)		:= (others => '0');



begin
	
	-- async -> sync signals
	process(Clk) begin
		if rising_edge(Clk) then
			SyncStart	<= AsyncStart;
			if SyncStart = '0' then
				sFCW_2			<= (others => '0');
				sInChanAddr		<= "000";
				sOutChanAddr	<= "000";
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
	process(Clk) begin
		if rising_edge(Clk) then
			if SyncStart = '0' then
				Sel1 	<= '1';
			else
				Sel1 	<= BitRvsCntr(6);
			end if;
		end if;
	end process;

	process(Clk) begin
		if rising_edge(Clk) then
			if SyncStart = '0' then
				Sel_w1	<= "0000";
				Sel_w2	<= "0000";
				Sel_w3	<= "0000";
				Sel2 	<= "0000";
			else
				Sel_w1	<= BitRvsCntr(6 downto 3);	-- select 16 channels
				Sel_w2	<= Sel_w1;
				Sel_w3	<= Sel_w2;
				Sel2	<= Sel_w3;
			end if;
		end if;
	end process;
	
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
	Sel_0	<= sOutChanAddr(6 downto 4);
	Sel_1	<= sOutChanAddr(3 downto 0);
	
	process(Clk)
		variable vSel16		: integer;
	begin
		vSel16		:= to_integer(unsigned(Sel2));
		if rising_edge(Clk) then
			for i in 1 to Num_Signals/16 loop
				FIR3_Channels((i-1)*16 + vSel16 + 1)	<= FIR4_Input(i);
			end loop;
		end if;
	end process;
	
	
	-- Stage_1 mux
	process(Clk)
		variable vSel0, vSel1, vSel16	: integer;
	begin
		vSel0	:= to_integer(unsigned(Sel_0));
		vSel1	:= to_integer(unsigned(BitRev(Sel_1)));
		vSel16	:= to_integer(unsigned(Sel2));
		if rising_edge(Clk) then
			ToStage3_Out	<= FIR3_Channels(vSel1 + 16*vSel0 + 1);	-- bit-reversed order!
		end if;
	end process;
	
	Stage3_Out	<= ToStage3_Out;	
	
	
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

	-- Select separate channels from FIR TDM outputs
	-- Clk is 88 MHz, output Fs = 1.1 MHz
	
	tdm_inst1: TDM_Matcher
	generic map(NumInps	=> Num_Signals/8)
	port map(
			Clk			=> Clk,
			Sel			=> Sel1,
			InTV		=> FIR3_OutTV,
			InSignal	=> FIR3_Out,
			OutTV		=> FIR4_InTV,
			OutSignal	=> FIR4_Input
	);
	
	tdm_inst2: TDM_Matcher
	generic map(NumInps	=> Num_Signals/16)
	port map(
			Clk			=> Clk,
			Sel			=> Sel1,
			InTV		=> FIR4_OutTV,
			InSignal	=> FIR4_Out,
			OutTV		=> FIR5_InTV,
			OutSignal	=> FIR5_Input
	);
	
	tdm_inst3: TDM_Matcher
	generic map(NumInps	=> Num_Signals/32)
	port map(
			Clk			=> Clk,
			Sel			=> Sel1,
			InTV		=> FIR5_OutTV,
			InSignal	=> FIR5_Out,
			OutTV		=> FIR6_InTV,
			OutSignal	=> FIR6_Input
	);
	
	tdm_inst4: TDM_Matcher_2
	port map(
			Clk			=> Clk,
			Sel			=> Sel1,
			InTV		=> FIR6_OutTV,
			InSignal	=> FIR6_Out,
			OutTV		=> FIR7_InTV,
			OutSignal	=> FIR7_Input
	);

	tdm_inst5: TDM_Matcher_2
	port map(
			Clk			=> Clk,
			Sel			=> Sel1,
			InTV		=> FIR7_OutTV,
			InSignal	=> FIR7_Out,
			OutTV		=> FIR8_TV,
			OutSignal	=> FIR8_Output
	);

	tdm_inst6: TDM_Matcher_2
	port map(
			Clk			=> Clk,
			Sel			=> Sel1,
			InTV		=> FIR8_OutTV,
			InSignal	=> FIR8_Out,
			OutTV		=> FIR9_TV,
			OutSignal	=> FIR9_Output
	);

	-- for FIR4_Output selection
	Sel3	<= BitRvsCntr;
	
	-- Selections!!!

end Behavioral;
