#########################################################################
# File Name: test.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Sun 05 Dec 2021 04:58:54 PM CST
#########################################################################
#!/bin/bash
../../../bin/verilator -Wno-implicit assign_connect_to_empty_signal.v ../LibBlackbox.v --xml-only
hier=`diff -bqBH HierNetlist.v standard/StandardHierNetlist.v`
flat=`diff -bqBH FlatNetlist.v standard/StandardFlatNetlist.v`
[ ! -z "$hier" ] && echo "In case17,$hier." && error=true
[ ! -z "$flat" ] && echo "In case17,$flat." && error=true
