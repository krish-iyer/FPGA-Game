-makelib ies_lib/xpm -sv \
  "/tools/Xilinx/Vitis/Vivado/2019.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/tools/Xilinx/Vitis/Vivado/2019.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "/tools/Xilinx/Vitis/Vivado/2019.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_4 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../vga.srcs/sources_1/ip/pacman_map_blockmem/sim/pacman_map_blockmem.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib
