#########################################################################
# File Name: test.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Sun 05 Dec 2021 04:58:54 PM CST
#########################################################################
#This a hierarchical netlist which has a blackbox that is not a standard cell.
#!/bin/bash
../../../bin/verilator only_assign.v ../LibBlackbox.v --xml-only
hier=`diff -bqBH HierNetlist.v standard/StandardHierNetlist.v`
flat=`diff -bqBH FlatNetlist.v standard/StandardFlatNetlist.v`
[ ! -z "$hier" ] && echo "In case16,$hier." && error=true
[ ! -z "$flat" ] && echo "In case16,$flat." && error=true
