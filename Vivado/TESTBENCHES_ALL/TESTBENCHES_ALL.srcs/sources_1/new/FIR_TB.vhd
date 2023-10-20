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

entity FIR_TB is
--  Port ( );
end FIR_TB;

architecture Behavioral of FIR_TB is

    component FIR_Reader_1 is
		generic(
			NumOfBits	: integer;
			i_1_File	: string;
			i_2_File	: string;
			q_1_File	: string;
			q_2_File	: string
		);
		port (
			inp_I_1	: out std_logic_vector ((NumOfBits - 1) downto 0);
			inp_I_2	: out std_logic_vector ((NumOfBits - 1) downto 0);
			inp_Q_1	: out std_logic_vector ((NumOfBits - 1) downto 0);
			inp_Q_2	: out std_logic_vector ((NumOfBits - 1) downto 0);
			
			dv		: out std_logic;
			rst		: in std_logic;
			rfd		: in std_logic;
			clk		: in std_logic
		);
	end component;
	
	component Clk_Divider is
		generic(
			Num_Freqs	: integer
		);
		port(
			Clk 		: in std_logic;									-- System Clock 88 MHz
			
			Clk_Out		: out std_logic_vector(Num_Freqs-1 downto 0)
		);
	end component;
	
	component fir_compiler_0 is
		PORT (
			aclk : IN STD_LOGIC;
			s_axis_data_tvalid : IN STD_LOGIC;
			s_axis_data_tready : OUT STD_LOGIC;
			s_axis_data_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			m_axis_data_tvalid : OUT STD_LOGIC;
			m_axis_data_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
			);
	end component;
	
	component FIR_Writer_1 is
		generic(
			NumOfBits 	: integer;
			File_name1	: string;
			File_name2	: string;
			File_name3	: string;
			File_name4	: string
			);
		port(
			clk			: in std_logic;
			dv			: in std_logic;
			sign		: in std_logic;
			
			DataIn_i_1 	: in std_logic_vector ((numOfBits-1) downto 0);
			DataIn_q_1 	: in std_logic_vector ((numOfBits-1) downto 0);
			DataIn_i_2 	: in std_logic_vector ((numOfBits-1) downto 0);
			DataIn_q_2 	: in std_logic_vector ((numOfBits-1) downto 0)
			);
	end component;
	
	
	
	-- Clk
	constant PERIOD				: time := 11.363636364 ns;	-- 88 MHz
	signal Clk					: std_logic := '0';
	
	-- Reader signals
	signal ReadReset			: std_logic := '0';
	signal mRFD 				: std_logic := '1';
	signal ReadEn				: std_logic := '1';
	signal m_inp_I_1, m_inp_Q_1 : std_logic_vector(15 downto 0) := (others => '0');
	signal m_inp_I_2, m_inp_Q_2 : std_logic_vector(15 downto 0) := (others => '0');
	signal m_inp_I_2_w1			: std_logic_vector(15 downto 0) := (others => '0');
	signal m_inp_Q_2_w1			: std_logic_vector(15 downto 0) := (others => '0');
	
	-- Clk divider signals
	signal mClk_Out				: std_logic_vector(1 downto 0) := "00";
	signal Clk44, Clk22			: std_logic := '0';
	
	-- FIR mux signals
	signal Sel_1, Sel_2			: std_logic := '0';
	signal S_Chan_0, S_Chan_1	: std_logic_vector(31 downto 0) := (others => '0');
	signal M_Chan_0, M_Chan_1	: std_logic_vector(31 downto 0) := (others => '0');
	signal fir_I_1, fir_Q_1 	: std_logic_vector(15 downto 0) := (others => '0');
	signal fir_I_2, fir_Q_2 	: std_logic_vector(15 downto 0) := (others => '0');
	
	-- FIR signals
	signal mTREADY 				: std_logic := '0';
	signal mTVALID 				: std_logic := '0';
	signal FIR_Input 			: std_logic_vector(31 downto 0) := (others => '0');
	signal FIR_Output 			: std_logic_vector(31 downto 0) := (others => '0');
	
	-- Writer signals
	signal WrSign				: std_logic := '1';
		
begin

	gen_clk: process begin
		loop
			Clk <= '0';
			wait for PERIOD/2;
			Clk <= '1';
			wait for PERIOD/2;
		end loop;
	end process;	
	
	
	----------------- Instantiations and Processes ---------------------
	
	Clk_div: Clk_Divider
	generic map(Num_Freqs 	=> 2)
	port map(	Clk 	=> Clk,
				Clk_Out => mClk_Out);
	
	Clk44 <= mClk_Out(0);
	Clk22 <= mClk_Out(1);
	
		
	Reader: FIR_Reader_1
	generic map(NumOfBits	=> 16,
				i_1_File	 => "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\inp_I_1.txt",
				i_2_File	 => "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\inp_I_2.txt",
				q_1_File	 => "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\inp_Q_1.txt",
				q_2_File	 => "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\inp_Q_2.txt"
			)
	port map (	clk 	=> Clk44,
				rst 	=> ReadReset,
				rfd 	=> mRFD,
				dv 		=> ReadEn,
				inp_I_1 => m_inp_I_1,
				inp_I_2 => m_inp_I_2,
				inp_Q_1	=> m_inp_Q_1,
				inp_Q_2 => m_inp_Q_2
			);
	
	-- delay 1 Clk cycle for S_Channel_1
	process(Clk) begin
		if rising_edge(Clk) then
			m_inp_I_2_w1 <= m_inp_I_2;
			m_inp_Q_2_w1 <= m_inp_Q_2;
		end if;
	end process;

	
	-- input mux	
	process(Clk) begin
		if rising_edge(Clk) then
			Sel_1 <= not Sel_1;
			if Sel_1 = '1' then
			    S_Chan_0    <= m_inp_Q_1 & m_inp_I_1;
				FIR_Input 	<= S_Chan_0;
			else
				S_Chan_1    <= m_inp_Q_2_w1 & m_inp_I_2_w1;
				FIR_Input 	<= S_Chan_1;
			end if;
		end if;
	end process;
	
	FIR: fir_compiler_0
	port map (	aclk 				=> Clk,
				s_axis_data_tvalid 	=> ReadEn,
				s_axis_data_tready 	=> mTREADY,
				s_axis_data_tdata 	=> FIR_Input,
				m_axis_data_tvalid 	=> mTVALID,
				m_axis_data_tdata 	=> FIR_Output
			);
	
	-- output mux
	process(Clk44) begin
		if rising_edge(Clk44) then
			Sel_2 <= not Sel_2;
			if Sel_2 = '1' then
				M_Chan_0 <= FIR_Output;
				fir_I_1 <= M_Chan_0(15 downto 0);
				fir_Q_1 <= M_Chan_0(31 downto 16);
			else
				M_Chan_1 <= FIR_Output;
				fir_I_2 <= M_Chan_1(15 downto 0);
				fir_Q_2 <= M_Chan_1(31 downto 16);
			end if;
		end if;
	end process;	
	
	
	Writer: FIR_Writer_1
	generic map (	NumOfBits	=> 16,
					File_name1	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\outp_I_1.txt",
					File_name2	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\outp_I_2.txt",
					File_name3	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\outp_Q_1.txt",
					File_name4	=> "E:\NTT\WorkingDirectory\09.23\Matlab\RdWrFiles\FIR\outp_Q_2.txt"
			)
	port map (	clk			=> Clk22,
				dv			=> mTVALID,
				sign		=> WrSign,
				
				DataIn_i_1	=> fir_I_1,
				DataIn_i_2	=> fir_I_2,
				DataIn_q_1	=> fir_Q_1,
				DataIn_q_2	=> fir_Q_2
			);

end Behavioral;