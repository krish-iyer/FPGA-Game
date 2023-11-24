# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param gui.logEvents 1
set_param gui.dontCheckVersion 1
set_param xicom.use_bs_reader 1
set_param gui.developerMode 1
set_param chipscope.maxJobs 4
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /home/krishnan/vivado_ws/vga/vga.cache/wt [current_project]
set_property parent.project_path /home/krishnan/vivado_ws/vga/vga.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property board_part_repo_paths {/tools/Xilinx/Vivado/2019.2/data/boards/board_files} [current_project]
set_property board_part digilentinc.com:nexys-a7-100t:part0:1.3 [current_project]
set_property ip_output_repo /home/krishnan/vivado_ws/vga/vga.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files /home/krishnan/vivado_ws/vga/vga.srcs/sources_1/new/coe_map80_50.coe
read_verilog -library xil_defaultlib {
  /home/krishnan/vivado_ws/vga/vga.srcs/sources_1/new/clk_div.v
  /home/krishnan/vivado_ws/vga/vga.srcs/sources_1/new/drawcon.v
  /home/krishnan/vivado_ws/vga/vga.srcs/sources_1/new/vga_out.v
  /home/krishnan/vivado_ws/vga/vga.srcs/sources_1/new/game_top.v
}
read_ip -quiet /home/krishnan/vivado_ws/vga/vga.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xci
set_property used_in_implementation false [get_files -all /home/krishnan/vivado_ws/vga/vga.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc]
set_property used_in_implementation false [get_files -all /home/krishnan/vivado_ws/vga/vga.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc]
set_property used_in_implementation false [get_files -all /home/krishnan/vivado_ws/vga/vga.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc]

read_ip -quiet /home/krishnan/vivado_ws/vga/vga.srcs/sources_1/ip/pacman_map_blockmem/pacman_map_blockmem.xci
set_property used_in_implementation false [get_files -all /home/krishnan/vivado_ws/vga/vga.srcs/sources_1/ip/pacman_map_blockmem/pacman_map_blockmem_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc /home/krishnan/vivado_ws/vga/vga.srcs/constrs_1/imports/cs256-fall23/nexys-a7-100t-master.xdc
set_property used_in_implementation false [get_files /home/krishnan/vivado_ws/vga/vga.srcs/constrs_1/imports/cs256-fall23/nexys-a7-100t-master.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top game_top -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef game_top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file game_top_utilization_synth.rpt -pb game_top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
