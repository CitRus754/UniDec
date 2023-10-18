// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Wed Oct  4 16:13:11 2023
// Host        : PC-004970 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ dds_compiler_1_stub.v
// Design      : dds_compiler_1
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx485tffg1157-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dds_compiler_v6_0_20,Vivado 2020.2" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(aclk, s_axis_phase_tvalid, 
  s_axis_phase_tdata, s_axis_phase_tlast, m_axis_data_tvalid, m_axis_data_tdata, 
  event_s_phase_tlast_missing, event_s_phase_tlast_unexpected)
/* synthesis syn_black_box black_box_pad_pin="aclk,s_axis_phase_tvalid,s_axis_phase_tdata[23:0],s_axis_phase_tlast,m_axis_data_tvalid,m_axis_data_tdata[31:0],event_s_phase_tlast_missing,event_s_phase_tlast_unexpected" */;
  input aclk;
  input s_axis_phase_tvalid;
  input [23:0]s_axis_phase_tdata;
  input s_axis_phase_tlast;
  output m_axis_data_tvalid;
  output [31:0]m_axis_data_tdata;
  output event_s_phase_tlast_missing;
  output event_s_phase_tlast_unexpected;
endmodule
