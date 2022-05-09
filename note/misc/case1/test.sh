#########################################################################
# File Name: run.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Sun 05 Dec 2021 04:58:54 PM CST
#########################################################################
#This is a normal hierarchical netlist without vector.
#!/bin/bash
../../../bin/verilator full_adder.v ../LibBlackbox.v --xml-only
