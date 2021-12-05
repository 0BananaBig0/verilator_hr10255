.. Copyright 2003-2021 by Wilson Snyder.
.. SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

*******************************
贡献和报告bug
*******************************

公告
=============

要获得有关新版本和其他重要公告的通知，请转到 `Verilator announcement repository <https://github.com/verilator/verilator-announce>`__ 然后按照那里的指示去做。


报告错误
==============

首先，检查 :ref:`Language Limitations` 部分。

接下来，尝试 :vlopt:`--debug` 选项。这将启用额外的内部断言，并可能有助于识别问题。

最后，将您的代码减少到可能出现错误的最小例程。更好的方法是，在 :file:`test_regress/t` 目录中创建一个测试，如下所示：

.. code-block:: bash

       cd test_regress
       cp -p t/t_EXAMPLE.pl t/t_BUG.pl
       cp -p t/t_EXAMPLE.v t/t_BUG.v

关于如何在 :file:`test_regress/driver.pl` 文档中编写一个好的测试，有很多提示，可以通过运行：

.. code-block:: bash

       cd $VERILATOR_ROOT  # Need the original distribution kit
       test_regress/driver.pl --help

编辑 :file:`t/t_BUG.pl` 以适合您的示例；你可以在Verilog代码中做任何你想做的事情；只需确保它保留单个clk输入，而不保留任何输出。现在，以下操作应该失败：

.. code-block:: bash

       cd $VERILATOR_ROOT  # Need the original distribution kit
       cd test_regress
       t/t_BUG.pl  # Run on Verilator
       t/t_BUG.pl --debug # Run on Verilator, passing --debug to Verilator
       t/t_BUG.pl --vcs  # Run on VCS simulator
       t/t_BUG.pl --nc|--iv|--ghdl  # Likewise on other simulators

测试驱动程序接受许多选项，其中许多选项反映了 Verilator 主选项。例如，上一个测试可以在启用调试的情况下运行。运行以下命令可以查看完整的测试选项集 :command:`driver.pl --help`，如上所示。

最后，在 `Verilator Issues <https://verilator.org/issues>`_ 反馈 bug。该 bug将公开可见；如果不可接受，请将错误报告邮寄至 ``wsnyder@wsnyder.org``.


.. Contributing
.. ===========
.. include:: ../CONTRIBUTING.rst
