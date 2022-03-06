# verilator 工作流程

Verilator 的主流程实际上可以使用 Verilator.cpp 中的 ``provess()`` 函数的流程来描述,其主要步骤如下:

- 读取 verilog 文件，使用 Flex 对其进行词法分析，使用 Bison 对其进行语法分析,这个过程中
  verilator 内部将会生成一个抽象语法树AST。
- 扫描 AST，修正部分语法方便后续处理，例如像 cppcheck 将所有的 typedef 都替换为 using。
- AST中的单元开始链接，随后函数以及变量也会链接到其定义去。
- verilator 输出以 C++ 形式的模块仿真代码。

从上述的步骤中，不难发现 verilator 并没有独自完成所有编译原理上的工作，它将词法分析交给了 Flex
完成，而将语法分析交给了 Bison 完成，而 verilator 则自己完善关于 verilog 的语义分析。

对于层次化网表扁平化技术研究，verilator的仿真功能是多余的，真正有价值的是 verilator 对 verilog
的语义分析，也就是其在编译原理过程中产生的抽象语法树；有了这一棵经过语法分析的抽象语法树，让网表从
磁盘中读取到内存中变为了可能。
