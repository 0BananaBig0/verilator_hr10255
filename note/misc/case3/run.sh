#########################################################################
# File Name: run.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Sun 05 Dec 2021 04:58:54 PM CST
#########################################################################
#!/bin/bash
~/Downloads/program/verilator/bin/verilator -Wno-implicit --language 1364-2005 -Wno-litendian -Od -Wno-assignin ../LibBlackbox.v oasys_rtl_oasys_2021_h.syn.v --xml-output netlist_h.xml
~/cpp_workspace/verilator_hr10255/bin/verilator -Wno-implicit --language 1364-2005 -Wno-litendian -Od -Wno-assignin ../LibBlackbox.v oasys_rtl_oasys_2021_h.syn.v --xml-only
# verilator -Wno-implicit --language 1364-2005 -Wno-litendian -Od -Wno-assignin --flatten ../LibBlackbox.v oasys_rtl_oasys_2021_h.syn.v --xml-output netlist_nh.xml
