#########################################################################
# File Name: test.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Sun 05 Dec 2021 04:58:54 PM CST
#########################################################################
#This case is use to test void HierNetlistVisitor::swapEmptyAndNotEmptyStdCellPosition()
#!/bin/bash
../../../bin/verilator -Wno-implicit has_memory_PLL_blackbox.v ../LibBlackbox.v --xml-only
hier=`diff -bqBH HierNetlist.v standard/StandardHierNetlist.v`
flat=`diff -bqBH FlatNetlist.v standard/StandardFlatNetlist.v`
[ ! -z "$hier" ] && echo "In case11,$hier." && error=true
[ ! -z "$flat" ] && echo "In case11,$flat." && error=true
