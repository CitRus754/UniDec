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

entity SelectModule_TB is
--  Port ( );
end SelectModule_TB;

architecture Behavioral of SelectModule_TB is

    component SelectModule is
		generic(
            NumChannels	: integer;		-- total number of channels
            NumInputs   : integer;       -- number of separate sets of channels
            dmxWidth    : integer;
            mxWidth     : integer
        );
        port(
            Clk			: in std_logic;
            
            dmxSel		: in std_logic_vector(dmxWidth-1 downto 0);
            mxSel		: in std_logic_vector(mxWidth-1 downto 0);
            
            InSignal	: in DDS_Array(1 to NumInputs);

            OutSignal	: out std_logic_vector(31 downto 0)
        );
	end component;

    -- constants
    constant tbNumInputs    : integer := 16;

	-- Clk
	constant PERIOD			: time := 11.363636364 ns;	-- 88 MHz
	signal Clk				: std_logic := '0';
	
	-- Cntr signals
    signal cntr8            : std_logic_vector(2 downto 0) 	:= (others => '0');
	signal cntr128		    : std_logic_vector(6 downto 0) 	:= (others => '0');

    signal tbmxSel          : std_logic_vector(6 downto 0) 	:= (others => '0');

    signal tbDin3           : DDS_Array(1 to tbNumInputs)   := (others => (others => '0'));
    signal tbDin            : DDS_Array(1 to tbNumInputs)   := (others => (others => '0'));
    signal tbOut            : std_logic_vector(31 downto 0) 	:= (others => '0');
	
begin

	Clk 	<= not Clk after PERIOD/2;	
	
    process(Clk) begin
        if rising_edge(Clk) then
            cntr8 <= unsigned(cntr8) + 1;
            cntr128 <= unsigned(cntr128) + 1;
        end if;
    end process;

	sel_input: process(Clk) begin
		if rising_edge(Clk) then
            for i in 1 to tbNumInputs loop
				tbDin3(i)   <= unsigned(cntr8) + (i-1)*8 + 1;
                tbDin(i)    <= sxt(tbDin3,32);
			end loop;
        end if;
	end process;

	--------------------------------------------
	sel_inst: SelectModule
	generic map (NumChannels	=> 128, NumInputs   => 16, dmxWidth => 3, mxWidth   => 7)
	port map (	Clk 		=> Clk,
                dmxSel		=> cntr8,
				mxSel	    => tbmxSel,
				InSignal	=> tbDin,
				OutSignal	=> tbOut
			);
	
	
	
end Behavioral;
