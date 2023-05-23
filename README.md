# 说明

## 1，master和devel/OldVerilator分支的区别

### 1)所使用的verilator版本不同

    (1) master分支所使用的verilator的版本为 Verilator 4.215 devel
    (2) devel/OldVerilator分支所使用的verilator的版本为 Verilator 4.025 devel

### 2)提取的网表的输出格式的排版不一样

    (1) master分支输出的verilog格式的排版格式为input, inout, output, wire；
    (2) devel/OldVerilator分支输出的verilog格式的排版格式为inout, input, output, wire；

## 2，本仓库的使用说明

    直接在本仓库的根目录执行下面的命令,verilator会逐个读取本仓库已有的案例电路进行网表信息提取，
    提取完网表信息的网表会在其相对应的文件夹里面生成FlatNetlist.v和HierNetlist.v文件。HierNetlist.v
    文件是层次化标准单元网表，而FlatNetlist.v则是平铺后的标准单元网表。每个案例standard文件夹里面的
    文件都是经过人工检查确保和输入网表信息一致的文件。verilator在读取案例电路时，每次都必须读取
    LibBlackbox.v文件，该文件是标准单元网表的黑盒子信息。verilator在读取使用LibBlackbox.v的标准单元
    的电路时，也必须读取LibBlackbox.v文件。

```
source note/misc/test.sh
```

