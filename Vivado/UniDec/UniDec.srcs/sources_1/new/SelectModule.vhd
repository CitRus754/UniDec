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
		NumChannels	: integer;      -- total number of channels (128)
        NumInputs   : integer      -- number of separate sets of channels
	);
	port(
		Clk			: in std_logic;

		Start		: in std_logic;
		SelTable	: in Select_Array(1 to NumChannels);
		ChanAddr	: in std_logic_vector(6 downto 0);
		
		InSignal	: in DDS_Array(1 to NumInputs);

		OutSignal	: out std_logic_vector(31 downto 0)
	);
end SelectModule;

architecture Behavioral of SelectModule is

    signal cntr	: integer := 0;

	signal FIR_Channels : DDS_Array(1 to NumChannels)   := (others => (others => '0'));

	signal ToOut 		: std_logic_vector(31 downto 0)	:= (others => '0');

begin

	-- cntr
	process(Clk) begin
		if rising_edge(Clk) then
			if Start = '0' then
				cntr 			<= 0;
				FIR_Channels	<= (others => (others => '0'));
			else
				if cntr = NumChannels/NumInputs then
					cntr <= 0;
				else
					cntr <= cntr + 1;
				end if;
			end if;
		end if;
	end process;
	
	process(Clk) begin
		if rising_edge(Clk) then
			for i in 1 to NumInputs loop
				FIR_Channels((i-1)*NumChannels/NumInputs + cntr + 1) <= InSignal(i);
			end loop;
		end if;
	end process;	
    
    -- select output channel
	process(Clk) begin
		if rising_edge(Clk) then
			for i in 1 to NumChannels loop
				if ChanAddr = SelTable(i) then
					ToOut	<= FIR_Channels(i);
					exit;
				end if;
			end loop;
		end if;
	end process;

	OutSignal	<= ToOut;

end Behavioral;
