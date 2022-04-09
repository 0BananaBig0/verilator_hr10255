#########################################################################
# File Name: run.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Fri 01 Apr 2022 08:10:35 PM CST
#########################################################################
#!/bin/bash

~/cpp_workspace/verilator_hr10255/bin/verilator -Wno-implicit --language 1364-2005 -Wno-litendian -Od -Wno-assignin --xml-output netlist_h.xml input.v
