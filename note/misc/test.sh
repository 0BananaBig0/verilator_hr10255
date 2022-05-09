#########################################################################
# File Name: test.sh
# Author: 16hxliang3
# mail: 16hxliang3@stu.edu.cn
# Created Time: Mon 09 May 2022 04:46:44 PM CST
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
      source test.sh;
      cd ..;
    fi
done
[ ! $error ] && echo "All files passed the test, no errors were found."
cd $current_path
