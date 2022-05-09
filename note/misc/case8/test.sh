#########################################################################
# File Name: run.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Sun 05 Dec 2021 04:58:54 PM CST
#########################################################################
#This a complicated example, which contains a variety of situations to help us understand
#Ast.
#!/bin/bash
../../../bin/verilator -Wno-implicit has_valueX_and_valueZ.v ../LibBlackbox.v --xml-only
[ $hier ] && echo "In case8,$hier." && error=true
[ $flat ] && echo "In case8,$flat." && error=true
