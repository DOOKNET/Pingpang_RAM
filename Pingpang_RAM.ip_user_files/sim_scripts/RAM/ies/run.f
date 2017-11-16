-makelib ies/xil_defaultlib -sv \
  "E:/Softwares/Vivado/Vivado/2016.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies/xpm \
  "E:/Softwares/Vivado/Vivado/2016.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/blk_mem_gen_v8_3_5 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_3.v" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../Design/IP_Core/RAM/RAM/sim/RAM.v" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib

