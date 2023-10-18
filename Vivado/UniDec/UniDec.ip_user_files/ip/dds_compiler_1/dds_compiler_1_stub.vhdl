-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
-- Date        : Fri Oct  6 14:53:36 2023
-- Host        : PC-004970 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/NTT/WorkingDirectory/09.23/Vivado/UniDec/UniDec.gen/sources_1/ip/dds_compiler_1/dds_compiler_1_stub.vhdl
-- Design      : dds_compiler_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xczu9eg-ffvb1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dds_compiler_1 is
  Port ( 
    aclk : in STD_LOGIC;
    s_axis_phase_tvalid : in STD_LOGIC;
    s_axis_phase_tdata : in STD_LOGIC_VECTOR ( 23 downto 0 );
    s_axis_phase_tlast : in STD_LOGIC;
    m_axis_data_tvalid : out STD_LOGIC;
    m_axis_data_tdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    event_s_phase_tlast_missing : out STD_LOGIC;
    event_s_phase_tlast_unexpected : out STD_LOGIC
  );

end dds_compiler_1;

architecture stub of dds_compiler_1 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,s_axis_phase_tvalid,s_axis_phase_tdata[23:0],s_axis_phase_tlast,m_axis_data_tvalid,m_axis_data_tdata[31:0],event_s_phase_tlast_missing,event_s_phase_tlast_unexpected";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dds_compiler_v6_0_20,Vivado 2020.2";
begin
end;
