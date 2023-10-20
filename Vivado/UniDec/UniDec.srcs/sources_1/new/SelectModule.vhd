---------------------------------------
-- Engineer:	CitRus
-- Data:		12.10.2023
-- Project:		UniDec
---------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library work;
use work.UniDec_Package.all;


entity SelectModule is
	generic(
		NumChannels	: integer;      -- total number of channels
        NumInputs   : integer;      -- number of separate sets of channels
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
end SelectModule;

architecture Behavioral of SelectModule is

    signal FIR_Channels : DDS_Array(1 to NumChannels)   := (others => (others => '0'));

begin

	process(Clk)
        variable vSel   : integer;
    begin
        vSel    := to_integer(unsigned(dmxSel));
		if rising_edge(Clk) then
			for i in 1 to NumInputs loop
				FIR_Channels((i-1)*NumChannels/NumInputs + vSel + 1) <= InSignal(i);
			end loop;
		end if;
	end process;	
    
    OutSignal   <= FIR_Channels(1);

end Behavioral;
