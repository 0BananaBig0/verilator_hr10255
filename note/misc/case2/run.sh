#########################################################################
# File Name: run.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Sun 05 Dec 2021 04:58:54 PM CST
#########################################################################
#!/bin/bash
verilator ripple_adder_oasys_2021_h.syn.v ../LibBlackbox.v --xml-output netlist_h.xml
verilator ripple_adder_oasys_2021_h.syn.v ../LibBlackbox.v --xml-output netlist_nh.xml --flatten
