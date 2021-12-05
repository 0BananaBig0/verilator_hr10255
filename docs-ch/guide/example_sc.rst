.. Copyright 2003-2021 by Wilson Snyder.
.. SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

.. _Example SystemC Execution:

SystemC执行示例
=========================

这是一个类似于 :ref:`Example C++ Execution` 的例子，但是使用SystemC。同时我们显示地运行 make。

.. include:: example_common_install.rst

现在，让我们创建一个示例 Verilog 和 SystemC 装饰文件：

.. code-block:: bash

     mkdir test_our_sc
     cd test_our_sc

     cat >our.v <<'EOF'
       module our (clk);
          input clk;  // Clock is required to get initial activation
          always @(posedge clk)
             begin $display("Hello World"); $finish; end
       endmodule
     EOF

     cat >sc_main.cpp <<'EOF'
       #include "Vour.h"
       int sc_main(int argc, char** argv) {
           Verilated::commandArgs(argc, argv);
           sc_clock clk{"clk", 10, SC_NS, 0.5, 3, SC_NS, true};
           Vour* top = new Vour{"top"};
           top->clk(clk);
           while (!Verilated::gotFinish()) { sc_start(1, SC_NS); }
           delete top;
           return 0;
       }
     EOF

现在，我们在我们的小示例上运行Verilator：

.. code-block:: bash

     verilator -Wall --sc --exe sc_main.cpp our.v

此示例不使用--build，因此我们需要显式编译它：

.. code-block:: bash

     make -j -C obj_dir -f Vour.mk Vour

现在我们运行它：

.. code-block:: bash

     obj_dir/Vour

在 SystemC 编译之后，我们得到与C++示例相同的输出：

.. code-block:: bash

     SystemC 2.3.3-Accellera

     Hello World
     - our.v:4: Verilog $finish

实际上，最好使用Makefile为您运行这些步骤，这样当源代码更改时，它将自动运行所有适当的步骤。为了帮助验证，验证程序可以创建一个makefile依赖文件。有关执行此操作的示例，请参阅发行中的 :file:`examples` 目录。

