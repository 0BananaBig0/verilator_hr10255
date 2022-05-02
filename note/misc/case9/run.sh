#########################################################################
# File Name: run.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Sun 05 Dec 2021 04:58:54 PM CST
#########################################################################
#!/bin/bash
~/Downloads/program/verilator/bin/verilator vector_order.v ../LibBlackbox.v --xml-output netlist_h.xml -Wno-litendian -Wno-selrange
~/cpp_workspace/verilator_hr10255/bin/verilator vector_order.v ../LibBlackbox.v --xml-only -Wno-litendian
