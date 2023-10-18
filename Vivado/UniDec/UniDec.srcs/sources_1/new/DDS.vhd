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

entity DDS is
	generic(
		Num_Signals	: integer := 8					-- TDM (4 = 8/2)
		);
	port(
		Clk 			: in std_logic;						
		
		Start			: in std_logic;
		
		FCW				: in std_logic_vector(23 downto 0);
		Channel_Addr	: in std_logic_vector(2 downto 0);
		TVALID_IN		: in std_logic;
		
		TVALID_OUT		: out DV_Bus(1 to Num_Signals/2);
		Output_I		: out SinCos_Array(1 to Num_Signals/2);
		Output_Q		: out SinCos_Array(1 to Num_Signals/2)
		);
end DDS;

architecture Behavioral of DDS is

	component dds_compiler_1 is
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
	
	-- Selector
	signal Selector		: std_logic;
	
	-- Mux-demux signals
	signal dmxFCW		: FCW_Array(1 to Num_Signals)	:= (others => (others => '0'));
	signal dmxTV		: DV_Bus(1 to Num_Signals) 		:= (others => '0');
	
	signal mxFCW		: FCW_Array(1 to Num_Signals/2) 			:= (others => (others => '1'));
	signal mxTV			: DV_Bus(1 to Num_Signals/2) 			:= (others => '0');
	signal mxTV_d		: DV_Bus(1 to Num_Signals/2) 			:= (others => '0');
	signal mxTV_or		: DV_Bus(1 to Num_Signals/2) 			:= (others => '0');
	
	-- DDS signals
	signal dds_tlast	: DV_Bus(1 to Num_Signals/2) 			:= (others => '0');
	signal dds_tlast_d	: DV_Bus(1 to Num_Signals/2) 			:= (others => '0');
	
	signal dds_missing	: DV_Bus(1 to Num_Signals/2) 			:= (others => '0');
	signal dds_unexp	: DV_Bus(1 to Num_Signals/2) 			:= (others => '0');
	
	signal ddsTV		: DV_Bus(1 to Num_Signals/2) 			:= (others => '0');
	signal ddsOut		: DDS_Array(1 to Num_Signals/2)			:= (others => (others => '0'));
	
begin
	
	sel: process(Clk) begin
		if rising_edge(Clk) then
			if Start = '0' then
				Selector	<= '1';
			else
				Selector	<= not Selector;
			end if;
		end if;
	end process;
	
	demux_18: process(Channel_Addr,FCW,TVALID_IN)
		variable Addr	: integer;
	begin
	-- if rising_edge(Clk) then
		Addr := to_integer(unsigned(Channel_Addr));
		dmxFCW(Addr+1)	<= FCW;
		dmxTV(Addr+1)	<= TVALID_IN;
	-- end if;
	end process;
	
	-- demux_18: process(Clk) begin
		-- if rising_edge(Clk) then
			-- if		Channel_Addr = "000" then
				-- dmxFCW(1)	<= FCW;
				-- dmxTV(1)	<= TVALID_IN;
			-- elsif 	Channel_Addr = "001" then
				-- dmxFCW(2)	<= FCW;
				-- dmxTV(2)	<= TVALID_IN;
			-- elsif 	Channel_Addr = "010" then
				-- dmxFCW(3)	<= FCW;
				-- dmxTV(3)	<= TVALID_IN;
			-- elsif 	Channel_Addr = "011" then
				-- dmxFCW(4)	<= FCW;
				-- dmxTV(4)	<= TVALID_IN;
			-- elsif 	Channel_Addr = "100" then
				-- dmxFCW(5)	<= FCW;
				-- dmxTV(5)	<= TVALID_IN;
			-- elsif 	Channel_Addr = "101" then
				-- dmxFCW(6)	<= FCW;
				-- dmxTV(6)	<= TVALID_IN;
			-- elsif 	Channel_Addr = "110" then
				-- dmxFCW(7)	<= FCW;
				-- dmxTV(7)	<= TVALID_IN;
			-- else
				-- dmxFCW(8)	<= FCW;
				-- dmxTV(8)	<= TVALID_IN;
			-- end if;
		-- end if;
	-- end process;
	
	mux_21: process(Clk) begin
		if rising_edge(Clk) then
			for i in 1 to Num_Signals/2 loop
				if Selector = '0' then
					mxFCW(i) 	<= dmxFCW((i-1)*Num_Signals/4 + 1);
					mxTV(i)		<= dmxTV((i-1)*Num_Signals/4 + 1);
				else
					mxFCW(i) 	<= dmxFCW((i-1)*Num_Signals/4 + 2);
					mxTV(i)		<= dmxTV((i-1)*Num_Signals/4 + 2);
				end if;
			end loop;
		end if;
	end process;
	
	
	-- coupled TV
	process(Clk) begin
		if rising_edge(Clk) then
			mxTV_d	<= mxTV;
		end if;
	end process;
	
	-- or
	process(mxTV,mxTV_d) begin
		for i in 1 to Num_Signals/2 loop
			mxTV_or(i)	<= mxTV(i) or mxTV_d(i);
		end loop;
	end process;
	
	
	-- dds tlast signals
	process(Clk) begin
		if rising_edge(Clk) then
			for i in 1 to Num_Signals/2 loop
				if mxTV_or(i) = '0' then
					dds_tlast(i)	<= '0';
				else
					dds_tlast(i)	<= not dds_tlast(i);
					dds_tlast_d(i)	<= dds_tlast(i);
				end if;
			end loop;
		end if;
	end process;
	
	
	dds_inst: for i in 1 to Num_Signals/2 generate dds_2_channel: dds_compiler_1
		port map(
			aclk							=> Clk,
			s_axis_phase_tvalid				=> Start,
			s_axis_phase_tdata				=> mxFCW(i),
			s_axis_phase_tlast				=> dds_tlast(i),
			m_axis_data_tvalid				=> ddsTV(i),
			m_axis_data_tdata				=> ddsOut(i),
			event_s_phase_tlast_missing		=> dds_missing(i),
			event_s_phase_tlast_unexpected	=> dds_unexp(i)
		);
	end generate dds_inst;
	
	TVALID_OUT 	<= ddsTV;
	
	process(ddsOut) begin
		for i in 1 to Num_Signals/2 loop
			Output_I(i) <= ddsOut(i)(11 downto 0);
			Output_Q(i) <= ddsOut(i)(27 downto 16);
		end loop;
	end process;
	
end Behavioral;
