#########################################################################
# File Name: update_standard.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Tue 10 May 2022 03:28:10 PM CST
#########################################################################
#!/bin/bash
current_path=`pwd`
git=`find . -name ".git"`;
while [ ! $git ]
do
  cd ..;
  git=`find . -name ".git"`;
done
cd note/misc;
for dir in `ls`; do                  #历遍ls命令显示目录
    if test -d $dir
    then
      cd $dir;                         #进入某个目录
      rm -rf standard_old
      mv FlatNetlist.v StandardFlatNetlist.v;
      mv HierNetlist.v StandardHierNetlist.v;
      mv standard standard_old
      mkdir standard;
      mv StandardHierNetlist.v StandardFlatNetlist.v standard;
      cd ..;
    fi
done
cd $current_path

