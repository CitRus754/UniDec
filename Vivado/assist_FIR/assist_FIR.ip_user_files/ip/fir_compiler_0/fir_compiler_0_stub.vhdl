-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
-- Date        : Fri Sep 22 15:51:22 2023
-- Host        : DESKTOP-CITRUS running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/NTT/WorkingDirectory/09.23/Vivado/assist_FIR/assist_FIR.gen/sources_1/ip/fir_compiler_0/fir_compiler_0_stub.vhdl
-- Design      : fir_compiler_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7vx485tffg1157-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fir_compiler_0 is
  Port ( 
    aclk : in STD_LOGIC;
    s_axis_data_tvalid : in STD_LOGIC;
    s_axis_data_tready : out STD_LOGIC;
    s_axis_data_tdata : in STD_LOGIC_VECTOR ( 7 downto 0 );
    m_axis_data_tvalid : out STD_LOGIC;
    m_axis_data_tdata : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );

end fir_compiler_0;

architecture stub of fir_compiler_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "aclk,s_axis_data_tvalid,s_axis_data_tready,s_axis_data_tdata[7:0],m_axis_data_tvalid,m_axis_data_tdata[7:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "fir_compiler_v7_2_15,Vivado 2020.2";
begin
end;