#########################################################################
# File Name: test.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Fri 01 Apr 2022 08:10:35 PM CST
#########################################################################
#This is a complicated example.
#!/bin/bash
../../../bin/verilator -Wno-implicit --language 1364-2005 -Wno-litendian -Od -Wno-assignin --xml-only openmsp430_oasys_2021_h.syn.v ../LibBlackbox.v
[ $hier ] && echo "In case9992,$hier." && error=true
[ $flat ] && echo "In case9992,$flat." && error=true
