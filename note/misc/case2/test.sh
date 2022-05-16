#########################################################################
# File Name: test.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Sun 05 Dec 2021 04:58:54 PM CST
#########################################################################
#This is a normal hierarchical netlist with a vector.
#!/bin/bash
../../../bin/verilator ripple_adder.v ../LibBlackbox.v --xml-only
hier=`diff -bqBH HierNetlist.v standard/StandardHierNetlist.v`
flat=`diff -bqBH FlatNetlist.v standard/StandardFlatNetlist.v`
[ $hier ] && echo "In case2,$hier." && error=true
[ $flat ] && echo "In case2,$flat." && error=true