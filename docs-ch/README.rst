.. Github doesn't render images unless absolute URL
.. Do not know of a conditional tag, "only: github" nor "github display" works

.. image:: https://img.shields.io/badge/License-LGPL%20v3-blue.svg
    :target: https://www.gnu.org/licenses/lgpl-3.0]
.. image:: https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg
    :target: https://opensource.org/licenses/Artistic-2.0
.. image:: https://repology.org/badge/tiny-repos/verilator.svg?header=distro%20packages
    :target: https://repology.org/project/verilator/versions
.. image:: https://api.codacy.com/project/badge/Grade/fa78caa433c84a4ab9049c43e9debc6f
    :target: https://www.codacy.com/gh/verilator/verilator
.. image:: https://codecov.io/gh/verilator/verilator/branch/master/graph/badge.svg
    :target: https://codecov.io/gh/verilator/verilator
.. image:: https://github.com/verilator/verilator/workflows/build/badge.svg
    :target: https://github.com/verilator/verilator/actions?query=workflow%3Abuild


欢迎来到Verilator

====================

.. list-table::

   * - **欢迎使用Verilator，最快的Verilog/SystemVerilog模拟器。**
        * 接受可综合的 Verilog 或 SystemVerilog
        * 执行 lint 代码质量检查
        * 编译成多线程 C++ 或 SystemC
        * 生成 XML 到你自己的前端工具
     - |Logo|
   * - |verilator multithreaded performance|
     - **快速**
        * 优于许多商业模拟器
        * 单线程和多线程输出模型
   * - **广泛使用**
        * 广泛的工业和学术部署
        * Arm和RISC-V供应商IP提供的开箱即用支持
     - |verilator usage|
   * - |verilator community|
     - **社区驱动 & 开源许可**
        * 由 `CHIPS Alliance`_ 和 `Linux Foundation`_ 指导
        * 开放、自由，就像在speech和beer中一样
        * 为您的验证预算提供更多模拟
   * - **提供商业支持**
        * 商业支持合同
        * 设计支持合同
        * 增强合同
     - |verilator support|

什么是 Verilator 做的

===================

Verilator 使用命令行参数调用，行为类似于 gcc 或者 Synopsys 的 VCS。它 "验证" 指定的 Verilog 或 SystemVerilog 代码通过读取它并执行 lint 检查，并选择性插入断言检查和覆盖率分析点。它输出单线程或多线程 .cpp 和 .h 文件，即"Verilated"代码。

用户编写了一个小小的 C++/SystemC 装饰文件，它实例化了用户顶级模块的"Verilated"模型。这些 C++ 或 SystemC 文件然后由C++gcc/clang/MSVC++）编译。生成的可执行文件执行设计模拟。Verilator还支持将其生成的库（可选加密）链接到其他模拟器。

如果你期待寻找一个全功能替代 NC-Verilog，VCS 或者其他商业的 Verilog 模拟器，或者您正在寻找行为Verilog模拟器，例如quick class项目，则Verilator可能不是最佳选择。(我们建议使用 `Icarus Verilog`_)但是，如果你正在寻找一个将 SystemVerilog 迁移到 C++ 或 SystemC 的方案，或者你的团队只需编写一点C++代码感到舒服，那么Verilor就是你的工具。

性能

===========

Verilor并没有简单地将Verilog HDL转换成C++或SystemC。相反，Verilator 将您的代码编译成一个更快的优化和可选的线程分区模型，该模型反过来包装在C++/SystemC模块中。结果是编译的Verilog模型，即使在单个线程上执行也比独立的 SystemC 快10倍以上，在单个线程上执行也比解释的Verilog模拟器（如 `Icarus Verilog`_ ）快约100倍。多线程还可以获得2-10倍的加速（在解释的模拟器上产生200-1000倍的总加速）。

与封闭源代码的Verilog模拟器相比，Verilator通常具有类似或更好的性能(Carbon Design Systems Carbonator,Modelsim, Cadence Incisive/NC-Verilog, Synopsys VCS, VTOC, and Pragmatic
CVer/CVC)。并且, Verilator是开源的，所以你可以花在计算机上而不是许可证上。因此，Verilator为您提供最佳性价比。

安装 & 文档

============================

更多信息:

- `Verilator installation and package directory structure
  <https://verilator.org/install>`_

- `Verilator manual (HTML) <https://verilator.org/verilator_doc.html>`_,
  or `Verilator manual (PDF) <https://verilator.org/verilator_doc.pdf>`_

- `Subscribe to verilator announcements
  <https://github.com/verilator/verilator-announce>`_

- `Verilator forum <https://verilator.org/forum>`_

- `Verilator issues <https://verilator.org/issues>`_


支持

=======

Verilator是一个社区项目，在 `CHIPS Alliance`_ 和 `Linux Foundation`_ 的指导下。

我们感谢并欢迎您以任何形式作出的贡献；请参见 `对 Verilator 做贡献
<https://github.com/verilator/verilator/blob/master/docs/CONTRIBUTING.rst>`_.
感谢我们的 `贡献者和赞助者
<https://verilator.org/guide/latest/contributors.html>`_.

Verilator还支持和鼓励商业支持模式和组织； 请参见 `Verilator商业支持 
<https://verilator.org/verilator_commercial_support>`_.


相关项目

================

- `GTKwave <http://gtkwave.sourceforge.net/>`_ - 用于Verilator跟踪的波形查看器。

- `Icarus Verilog`_ - Icarus是一个功能齐全的解释型Verilog模拟器。如果Verilator不支持您的需求，也许Icarus可以。


开源许可证

============

Verilator is Copyright 2003-2021 by Wilson Snyder. (Report bugs to`Verilator Issues <https://verilator.org/issues>`_.)

Verilator is free software; you can redistribute it and/or modify it under
the terms of either the GNU Lesser General Public License Version 3 or the
Perl Artistic License Version 2.0. See the documentation for more details.

.. _CHIPS Alliance: https://chipsalliance.org
.. _Icarus Verilog: http://iverilog.icarus.com
.. _Linux Foundation: https://www.linuxfoundation.org
.. |Logo| image:: https://www.veripool.org/img/verilator_256_200_min.png
.. |verilator multithreaded performance| image:: https://www.veripool.org/img/verilator_multithreaded_performance_bg-min.png
.. |verilator usage| image:: https://www.veripool.org/img/verilator_usage_400x200-min.png
.. |verilator community| image:: https://www.veripool.org/img/verilator_community_400x125-min.png
.. |verilator support| image:: https://www.veripool.org/img/verilator_support_400x125-min.png
