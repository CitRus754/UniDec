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
-- Tasks:
-- 1. Think about for loop in assignments (115-137);
-- 2. Maybe make TVALID_OUT port opened.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.UniDec_Package.all;

entity DDS_2 is
	generic(
		Num_Signals	: integer := 80					-- TDM (10 = 80/8)
		);
	port(
		Clk 			: in std_logic;						
		
		FCW				: in std_logic_vector(23 downto 0);
		Channel_Addr	: in std_logic_vector(6 downto 0);		-- 7 bits to cover 80 dds modules
		TVALID_IN		: in std_logic;
		
		Selector		: in std_logic_vector(2 downto 0);		-- 3 bits for 8 signals
		
		TVALID_OUT		: out DV_Bus(1 to Num_Signals/8);
		Output_I		: out SinCos_Array(1 to Num_Signals/8);
		Output_Q		: out SinCos_Array(1 to Num_Signals/8)
		);
end DDS_2;

architecture Behavioral of DDS_2 is

	component dds_compiler_2 is
		PORT (
			aclk : IN STD_LOGIC;
			s_axis_phase_tvalid : IN STD_LOGIC;
			s_axis_phase_tdata : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
			s_axis_phase_tlast : IN STD_LOGIC;
			m_axis_data_tvalid : OUT STD_LOGIC;
			m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
			event_s_phase_tlast_missing : OUT STD_LOGIC;
			event_s_phase_tlast_unexpected : OUT STD_LOGIC
		);
	end component;
	
	-- Counter
	signal Cnt8			: integer := 0;
	
	-- Mux-demux signals
	signal dmxFCW		: FCW_Array(1 to Num_Signals)	:= (others => (others => '0'));
	signal dmxTV		: DV_Bus(1 to Num_Signals) 		:= (others => '0');
	
	signal mxFCW		: FCW_Array(1 to Num_Signals/8) := (others => (others => '0'));
	signal mxTV			: DV_Bus(1 to Num_Signals/8) 	:= (others => '0');
	
	-- DDS signals
	signal dds_tlast	: std_logic 					:= '0';
	signal dds_missing	: DV_Bus(1 to Num_Signals/8) 	:= (others => '0');
	signal dds_unexp	: DV_Bus(1 to Num_Signals/8) 	:= (others => '0');
	
	signal ddsTV		: DV_Bus(1 to Num_Signals/8) 	:= (others => '0');
	signal ddsOut		: DDS_Array(1 to Num_Signals/8)	:= (others => (others => '0'));
	
begin
	
	-- counter
	process(Clk) begin
		if rising_edge(Clk) then
			Cnt8 <= Cnt8 + 1;
		end if;
	end process;
	
	
	
	demux_180: process(Clk)
		variable Addr	: integer;
	begin
		if rising_edge(Clk) then
			Addr := to_integer(unsigned(Channel_Addr));
			dmxFCW(Addr+1)	<= FCW;
			dmxTV(Addr+1)	<= TVALID_IN;
		end if;
	end process;
	
	
	
	mux_81: process(Clk) begin
		if rising_edge(Clk) then
			for i in 1 to Num_Signals/8 loop
				if 		Selector = "000" then
					mxFCW(i) 	<= dmxFCW((i-1)*Num_Signals/10 + 1);
					mxTV(i)		<= dmxTV((i-1)*Num_Signals/10 + 1);
				elsif	Selector = "001" then
					mxFCW(i) 	<= dmxFCW((i-1)*Num_Signals/10 + 2);
					mxTV(i)		<= dmxTV((i-1)*Num_Signals/10 + 2);
				elsif	Selector = "010" then
					mxFCW(i) 	<= dmxFCW((i-1)*Num_Signals/10 + 3);
					mxTV(i)		<= dmxTV((i-1)*Num_Signals/10 + 3);
				elsif	Selector = "011" then
					mxFCW(i) 	<= dmxFCW((i-1)*Num_Signals/10 + 4);
					mxTV(i)		<= dmxTV((i-1)*Num_Signals/10 + 4);
				elsif	Selector = "100" then
					mxFCW(i) 	<= dmxFCW((i-1)*Num_Signals/10 + 5);
					mxTV(i)		<= dmxTV((i-1)*Num_Signals/10 + 5);
				elsif	Selector = "101" then
					mxFCW(i) 	<= dmxFCW((i-1)*Num_Signals/10 + 6);
					mxTV(i)		<= dmxTV((i-1)*Num_Signals/10 + 6);
				elsif	Selector = "110" then
					mxFCW(i) 	<= dmxFCW((i-1)*Num_Signals/10 + 7);
					mxTV(i)		<= dmxTV((i-1)*Num_Signals/10 + 7);
				else
					mxFCW(i) 	<= dmxFCW((i-1)*Num_Signals/10 + 8);
					mxTV(i)		<= dmxTV((i-1)*Num_Signals/10 + 8);
				end if;
			end loop;
		end if;
	end process;
	
	-- dds tlast signal
	process(Clk) begin
		if rising_edge(Clk) then
			if Cnt8 = 7 then
				dds_tlast <= '1';
			else
				dds_tlast <= '0';
			end if;
		end if;
	end process;
	
	
	dds_inst: for i in 1 to Num_Signals/8 generate dds_2_channel: dds_compiler_2
		port map(
			aclk							=> Clk,
			s_axis_phase_tvalid				=> mxTV(i),
			s_axis_phase_tdata				=> mxFCW(i),
			s_axis_phase_tlast				=> dds_tlast,
			m_axis_data_tvalid				=> ddsTV(i),
			m_axis_data_tdata				=> ddsOut(i),
			event_s_phase_tlast_missing		=> dds_missing(i),
			event_s_phase_tlast_unexpected	=> dds_unexp(i)
		);
	end generate dds_inst;
	
	TVALID_OUT 	<= ddsTV;
	
	process(ddsOut) begin
		for i in 1 to Num_Signals/8 loop
			Output_I(i) <= ddsOut(i)(11 downto 0);
			Output_Q(i) <= ddsOut(i)(27 downto 16);
		end loop;
	end process;
	
end Behavioral;
