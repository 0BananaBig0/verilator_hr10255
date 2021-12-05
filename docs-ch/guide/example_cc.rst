.. Copyright 2003-2021 by Wilson Snyder.
.. SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

.. _Example C++ Execution:

C++执行实例
=====================

我们将把这个例子编译成C++。对于C++代码所做的扩展和注释版本, 参见
:file:`examples/make_tracing_c/sim_main.cpp` 在这个发行版本中.

.. include:: example_common_install.rst

现在，让我们创建一个示例 Verilog 和 C++ 包装文件：

.. code-block:: bash

     mkdir test_our
     cd test_our

     cat >our.v <<'EOF'
       module our;
          initial begin $display("Hello World"); $finish; end
       endmodule
     EOF

     cat >sim_main.cpp <<'EOF'
       #include "Vour.h"
       #include "verilated.h"
       int main(int argc, char** argv, char** env) {
           VerilatedContext* contextp = new VerilatedContext;
           contextp->commandArgs(argc, argv);
           Vour* top = new Vour{contextp};
           while (!contextp->gotFinish()) { top->eval(); }
           delete top;
           delete contextp;
           return 0;
       }
     EOF

现在我们在我们的小示例上运行Verilator。

.. code-block:: bash

     verilator -Wall --cc --exe --build sim_main.cpp our.v

分解这个指令如下:

#. :vlopt:`-Wall` 以便 Verilator 有更强的 lint 警告

#. :vlopt:`--cc` 获取C++输出 (相反 e.g. SystemC 或者 仅仅 linting).

#. :vlopt:`--exe` 与我们的 :command:`sim_main.cpp` 装饰文件一起，因此构建将创建一个可执行文件，而不仅仅是一个库。

#. :vlopt:`--build` 因此 Verilator 将会编译自己。这使我们不需要手动调用make作为一个单独的步骤。 您还可以编写自己的编译规则, 并且自己运行 make 我们将会展示在 :ref:`Example SystemC Execution`。 

#. 最后, :command:`our.v` 这是我们的SystemVerilog设计文件。

一旦 Verilator 完成工作，我们就可以看到在文件 :file:`obj_dir` 目录下看到生成的C++代码。

.. code-block:: bash

     ls -l obj_dir

(参见 :ref:`Files Read/Written` 以了解所创建的一些文件的说明)

现在我们运行它:

.. code-block:: bash

     obj_dir/Vour

我们得到的输出是:

.. code-block:: bash

     Hello World
     - our.v:2: Verilog $finish

实际上，最好使用Makefile为您运行这些步骤，这样当源代码更改时，它将自动运行所有适当的步骤。为了帮助验证，验证程序可以创建一个makefile依赖文件。有关执行此操作的示例，请参阅发行中的 :file:`examples` 目录。
