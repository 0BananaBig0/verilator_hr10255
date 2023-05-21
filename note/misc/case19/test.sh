#########################################################################
# File Name: test.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Sun 05 Dec 2021 04:58:54 PM CST
#########################################################################
#This a complicated example, which contains a variety of situations to help us understand
#Ast.
#!/bin/bash
../../../bin/verilator -Wno-implicit typical_example_many_inout.v ../LibBlackbox.v --xml-only
hier=`diff -bqBH HierNetlist.v standard/StandardHierNetlist.v`
flat=`diff -bqBH FlatNetlist.v standard/StandardFlatNetlist.v`
[ $hier ] && echo "In case19,$hier." && error=true
[ $flat ] && echo "In case19,$flat." && error=true
