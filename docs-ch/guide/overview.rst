.. Copyright 2003-2021 by Wilson Snyder.
.. SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

*************
概述
*************

欢迎来到Verilator！

Verilor 将 Verilog [#]_ 和 SystemVerilog [#]_ 硬件描述语言（HDL）设计转换成 C++ 或 SystemC 模型，编译后可以执行。Verilator 不是传统的模拟器，而是编译器。

Verilator通常按如下方式使用：

1. ``verilator`` 使用命令行参数调用，类似于 GCC，或者其他模拟器例如 Cadence Verilog-XL/NC-Verilog 、Synopsys VCS。Verilator 读取指定的 SystemVerilog 代码, lints 它,可选地添加代码覆盖和波形跟踪支持，并将设计编译成源代码级多线程 C++ 或 SystemC "模型"。生成的 C++ 或 SystemC 模型以 .cpp 和 .h 文件的格式输出。这称为 "Verilating" ，过程为 "to Verilate" ；输出为 "Verilated" 模型。

2. 为了仿真，需要一个用户编写的小的C++包装器文件，"包装器"。这个包装器定义了C++标准函数 "main()" ，它实例化了 Verilated 模型以 C++／SystemC 对象的形式。

3. 用户C++包装器, Verilator 创建的文件, 一个由 Verilator 提供的"运行时库"，并且如果有适用的 SystemC 库，则用C++编译编译生成模拟可执行文件。

4. 生成的可执行文件将在 "模拟运行时" 期间执行实际模拟。

5. 如果启用地适当，可执行文件还可以生成可查看的设计波形跟踪。它还可以为后期分析创建覆盖率分析数据。

最好开始的地方是尝试 : ``案例`` 。

.. [#] Verilog is defined by the `Institute of Electrical and Electronics
       Engineers (IEEE) Standard for Verilog Hardware Description
       Language`, Std. 1364, released in 1995, 2001, and 2005.  The
       Verilator documentation uses the shorthand e.g. "IEEE 1394-2005" to
       refer to the e.g. 2005 version of this standard.

.. [#] SystemVerilog is defined by the `Institute of Electrical and
       Electronics Engineers (IEEE) Standard for SystemVerilog - Unified
       Hardware Design, Specification, and Verification Language`, Standard
       1800, released in 2005, 2009, 2012, and 2017.  The Verilator
       documentation uses the shorthand e.g. "IEEE 1800-2017" to refer to
       the e.g. 2017 version of this standard.
