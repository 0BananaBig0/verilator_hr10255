.. Copyright 2003-2021 by Wilson Snyder.
.. SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

.. _Examples in the Distribution:

发行版本中的示例
============================

请参见作为发行版一部分的 ``examples/`` 目录，在安装 verilator 情况下(在操作系统特定的位置，通常在 ``/usr/local/share/verilator/examples`` 中)。这些例子包括：

examples/make_hello_c
   Example GNU-make simple Verilog->C++ conversion
examples/make_hello_sc
   Example GNU-make simple Verilog->SystemC conversion
examples/make_tracing_c
   Example GNU-make Verilog->C++ with tracing
examples/make_tracing_sc
   Example GNU-make Verilog->SystemC with tracing
examples/make_protect_lib
   Example using --protect-lib
examples/cmake_hello_c
   Example building make_hello_c with CMake
examples/cmake_hello_sc
   Example building make_hello_sc with CMake
examples/cmake_tracing_c
   Example building make_tracing_c with CMake
examples/cmake_tracing_sc
   Example building make_tracing_sc with CMake
examples/cmake_protect_lib
   Example building make_protect_lib with CMake

要运行示例，请将示例复制到新目录并运行它。
::

      cp -rp {path_to}/examples/make_hello_c make_hello_c
      cd make_hello_c
      make
