#########################################################################
# File Name: test.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Sun 05 Dec 2021 04:58:54 PM CST
#########################################################################
#This an example to test effect of the vector range, like a[l:r], l > r or l < r
#!/bin/bash
../../../bin/verilator vector_order.v ../LibBlackbox.v --xml-only -Wno-litendian
hier=`diff -bqBH HierNetlist.v standard/StandardHierNetlist.v`
flat=`diff -bqBH FlatNetlist.v standard/StandardFlatNetlist.v`
[ ! -z "$hier" ] && echo "In case4,$hier." && error=true
[ ! -z "$flat" ] && echo "In case4,$flat." && error=true
