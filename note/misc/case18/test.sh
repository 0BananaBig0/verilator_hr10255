#########################################################################
# File Name: test.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Sun 05 Dec 2021 04:58:54 PM CST
#########################################################################
#This is a normal hierarchical netlist without vector.
#!/bin/bash
../../../bin/verilator tristate_buffer.v ../LibBlackbox.v --xml-only  -Wno-implicit
hier=`diff -bqBH HierNetlist.v standard/StandardHierNetlist.v`
flat=`diff -bqBH FlatNetlist.v standard/StandardFlatNetlist.v`
[ ! -z "$hier" ] && echo "In case18,$hier." && error=true
[ ! -z "$flat" ] && echo "In case18,$flat." && error=true
