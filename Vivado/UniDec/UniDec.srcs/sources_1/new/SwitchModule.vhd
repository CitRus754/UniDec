----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.09.2023 15:50:32
-- Design Name: 
-- Module Name: CORE_1 - Behavioral
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
use IEEE.std_logic_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SwitchModule is
	generic(
		NumChannels	: integer
	);
	port(
		Clk 		: in std_logic;							-- System Clock 88 MHz

        DataIn      : in std_logic_vector(31 downto 0); 
		SwAddr      : in std_logic_vector(6 downto 0);      -- to switch up to 128 channels

        DataOut_I   : out IQ_Array(1 to NumChannels/8);
        DataOut_Q   : out IQ_Array(1 to NumChannels/8);
	);
end SwitchModule;

architecture Behavioral of SwitchModule is

	signal dmx1_80      : DDS_Array(1 to NumChannels)   := (others => (others => '0'));
    signal mx80_16      : DDS_Array(1 to NumChannels/8)   := (others => (others => '0'));

    signal mxCntr: integer    := 0;
	
begin

    -- cntr
    process(Clk)
    begin
        if rising_edge(Clk) then
            if mxCntr = 7 then
                mxCntr    <= 0;
            else
                mxCntr    <= mxCntr + 1;
            end if;
        end if;
    end process;

	-- demux 1-80
    process(DataIn,SwAddr)
        variable Addr	: integer;
    begin
		Addr := to_integer(unsigned(SwAddr));
		dmx1_80(Addr+1)	<= DataIn;
	end process;
	
    -- muxers 80-16: N channels of 11 MHz -> N/8 TDM-channels of 88 MHz
    process(Clk)
        variable cntr   : integer;
    begin
        cntr    := mxCntr;
        if rising_edge(Clk) then
            for i in 1 to NumChannels/8 loop
                mx80_16(i)  <= dmx1_80((i-1)*8 + cntr + 1);
            end loop;
        end if;
    end process;

    process(mx80_16) begin
        for i in 1 to NumChannels/8 loop
            DataOut_I(i) <= mx80_16(i)(15 downto 0);
            DataOut_Q(i) <= mx80_16(i)(31 downto 16);
        end loop;
        
    end process;

end Behavioral;
