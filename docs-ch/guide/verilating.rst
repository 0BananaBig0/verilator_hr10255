.. Copyright 2003-2021 by Wilson Snyder.
.. SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

**********
验证
**********

Verilator 可能以以下五种方式使用:

* 带有 :vlopt:`--cc` 或者 :vlopt:`--sc` 选项， Verilator 将翻译设计分别转化为 C++ 或 SystemC 代码。参见 :ref:`C++ and SystemC Generation`。

* 带有 :vlopt:`--lint-only` 选项，Verilator 将 lint 设计以检查警告，但通常不会创建任何输出文件。

* 带有 :vlopt:`--xml-only` 选项，Verilator将创建 xml 输出，该输出可用于输入其他用户设计的工具。请参见 :file:`docs/xml.rst` 在对应的发行版本中。

* 带有 :vlopt:`-E` 选项，Verilator 将根据 IEEE 预处理规则对代码进行预处理，并将输出写入标准输出。这对于其他工具以及调试 "\`define" 语句的扩展方式非常有用。


.. _C++ and SystemC Generation:

C++与SystemC生成
==========================

当带有 :vlopt:`--cc` 选项时， Verilator 将 SystemVerilog 设计翻译为 C++；当带有 :vlopt:`--sc` 选项时，Verilator 将 SystemVerilog 设计翻译为 SystemC。

何时使用以下选项:

#. Verilator 读取输入的 Verilog 代码，确定所有 "顶级模块" ，即不用作其他单元格下实例的模块或程序。如果 :vlopt:`--top-module` 被使用，接下来移除这个顶级模块以及其他顶级模块，否则将发出 :vlopt:`MULTITOP` 警告。

#. Verilator 将输出的 C++/SystemC 代码文件写入 :vlopt:`--Mdir` 选项指定的目录，或默认为"obj_dir"。名称根据 :vlopt:`--prefix` 设置，或默认为顶部模块的名称。

#. 如果使用 :vlopt:`--exe` ，Verilator 将创建 makefiles 以生成模拟可执行文件，否则将创建 makefiles 以生成包含对象的归档（.a）。

#. 如果 :vlopt:`--build` 选项被使用，它将调用 :ref:`GNU Make` 或 :ref:`CMake` 来生成模型。

一旦模型被构建，接下来就可以直接运行，请参见 :ref:`Simulating` 。


.. _Hierarchical Verilation:

分层验证
=======================

大型设计可能需要较长时间（如 10 分钟以上）和巨大内存（如 100 GB以上）才能验证。在层次模式下，用户手动选择一些较大的较低层次块，以与较大的设计分离。例如，核心可以是层次块，并且从多核SoC中分离出来。Verilator在整个SoC上以分层模式运行。 Verilator将制作两个模型，一个用于CPU层次结构块，另一个用于SoC。SoC的验证代码将自动调用CPU验证模型。当前的分层验证基于 protect-lib 。每个层次结构块都验证为一个protect-lib。层次结构块的用户模块将看到一个由protect lib生成的小包装，而不是实际的设计。

用法
-----

用户需要将一个或多个中等大小的模块标记为层次结构块。有两种方法可以标记模块：

* 写 :option:`/*verilator&32;hier_block*/` 元注释在 HDL 代码中。

* 添加一行  :option:`hier_block` 在一个 :ref:`Configuration Files`.

接下来传递 :vlopt:`--hierarchical` 选项给 Verilator 。

编译时与不使用分层模式时相同。

.. code-block:: bash

    make -C obj_dir -f Vtop_module_name.mk


局限性
-----------

层次结构块有一些限制，包括以下：

* 无法使用上部模块或其他层次结构块中的 dot(.) 访问层次结构块。

* 无法跟踪块中的信号。

* Modport不能用于分层块边界。

* 模拟速度可能不如平面验证快，在平面验证中，所有模块都是全局调度的。

* 如果生成的时钟是在分层模型中生成的，并向上传递到另一个分层模型或顶层模块，则生成的时钟可能无法正常工作。

但是，支持以下用法：

* 嵌套的层次结构块。层次结构块可以实例化其他层次结构块。

* 参数化层次结构块。 层次结构块的参数可以使用以下方法重写：代码 :code:`#(.param_name(value))` 构造。

.. _Overlapping Verilation and Compilation:

重叠验证与编译
--------------------------------------

Verilator需要在分层验证中运行2+*N*次，其中*N*是分层块的数量。其中一个用于顶层模块，它引用所有其他层次结构块的包装器。另一个是初始化运行，它查找所有标记有 :option:`/*verilator&32;hier_block*/` 元注释的模块，并且创建一个计划并写入：文件 :file:`{prefix}_hier.mk`。此初始运行在内部调用其他*N*+1次运行，因此您不必关心这些*N*+1次运行。附加的*N*是针对每个分层块运行的验证程序。

如果 ::vlopt:`-j {jobs} <-j>` 选项被指定，层次结构块的验证并行运行。

如果 :vlopt:`--build` 选项被指定，一旦编译了层次结构块，C++编译也会运行。对其他层次块进行C++编译和验证。


交叉编译
=================

Verilator 支持交叉编译验证代码。这通常用于在 Linux 系统上运行 Verilator 并生成 C++ 代码，然后在 Windows 上编译。

交叉编译最多涉及三种不同的操作系统。构建系统是您配置和编译 Verilator 的地方，宿主系统是您运行 Verilator 的地方，目标系统是您编译 Verilator 代码并运行模拟。

目前， Verilator 要求构建和宿主系统类型相同，但目标系统类型可能不同。要支持此操作，请执行以下操作 :command:`./configure` 并在生成系统上生成Verilator。然后，在宿主系统上运行Verilator。最后，Verilator的输出可以在不同的目标系统上编译。为了支持这一点， Verilator 生成的任何文件都不会引用任何配置生成的生成系统特定文件，例如：:file:`config.h` （在 Verilator 中重命名为 :file:`config_build.h` 以减少混淆。）这种方法的缺点是 :file:`include/verilatedos.h` 必须自检测目标系统的需求，而不是使用configure。

目标系统也可能需要编辑 Makefiles ，Verilator生成的简单 Makefiles 假定目标系统与构建系统的类型相同。

.. _Multithreading:

多线程
==============

Verilator支持多线程仿真模型。

使用 :vlopt:`--no-threads`，默认情况下，模型不是线程安全的，使用多个线程调用一个或甚至不同的验证模型可能会导致不可预测的行为。这提供了最高的单线程性能。

使用 :vlopt:`--threads 1 <--threads>`, t生成的模型是单线程的，但是支持库是多线程安全的。这允许模型的不同实例化在不同的线程下运行。所有线程都是用户C++测试平台的职责。所有线程都是用户 C++ 测试平台负责。

使用 :vlopt:`--threads {N} <--threads>`, 当N至少为2时，生成的模型将被设计为在N个线程上并行运行。主线程调用 eval() 提供其中一个线程，生成的模型将创建和管理其他N-1个线程。用户有责任不使用超过可用的CPU内核。在CPU过度订阅的情况下，经过验证的模型不会产生活锁或死锁，但是，预期性能会比适当的线程和 CPU 内核效率差得多。

本节的其余部分将描述使用以下参数的行为： :vlopt:`--threads 1<--threads>` or :vlopt:`--threads {N} <--threads>` (not :vlopt:`--no-threads`).

:code:`VL_THREADED` 被定义在 C++ 代码里在编译多线程验证模块时，这将使验证支持类成为线程安全。

用于构造模型的线程必须与调用 :code:`eval()` 到该模型的线程相同，这称为 "eval thread"。用于执行某些全局操作（如保存和跟踪）的线程必须由"主线程"执行。在大多数情况下， eval 线程和主线程是相同的线程（即用户的顶级C++测试平台在单个线程上运行），但这不是必需的。

在多线程模型中频繁使用DPI导入的函数时，根据一些实验调整 :vlopt:`--instr-count-dpi` 选项可能有助于提高性能。这会通过调整DPI导入的假定执行时间来影响模型的分区。

:vlopt:`--trace-threads` 选项可用于使用多个线程生成跟踪转储。如果 :vlopt:`--trace-threads` 设置时 :vlopt:`--threads`` 没有设置，那么 :vlopt:`--trace-threads` 将意味着:vlopt: `--threads 1 <--threads>`，即：支持库将是线程安全的。

使用 :vlopt:`--trace-threads 0 <--trace-threads>` ，在主线程上生成跟踪转储。这再次提供了最高的单线程性能。

使用 :vlopt:`--trace-threads {N} <--trace-threads>` ，其中N至少为1，跟踪文件（例如： VerilatedVcdC 或 VerilatedFstC）将会创建并且管理N个额外线程，以生成跟踪转储。主线程将被释放以尽快继续执行，尽管在捕获跟踪时仍然需要对主线程进行一些阻塞。不同的跟踪格式可以使用不同数量的线程。请参阅 :vlopt:`--trace-threads` 选项。

在运行多线程模型时，默认的 Linux 任务调度器通常会对该模型起作用，因为它假定线程是短期的，因此通常会在同一物理核心内使用多个超线程来调度线程。为了获得最佳性能，请使用  :command:`numactl` （当线程计数合适时）在同一套接字上选择唯一的物理内核。这同样适用于 :vlopt:`--trace-threads`。

例如，如果模型验证使用 :vlopt:`--threads 4 <--threads>` ，我们将参考：

.. code-block:: bash

    egrep 'processor|physical id|core id' /proc/cpuinfo

选择位于同一套接字（0）上但不同物理核心的 0、1、2和3。（同样有用的是 :command:`numactl --hardware`，或 :command:`lscpu`，但不显示超线程内核。）然后执行：

.. code-block:: bash

    numactl -m 0 -C 0,1,2,3 -- verilated_executable_name

这将把内存限制在套接字0上，线程限制在内核0、1、2、3上（可能在套接字0上），从而优化性能。当然，如果您希望使用另一个模拟器（例如，socket 1），或者如果您使用不同数量的线程进行验证，则必须对此进行调整。要查看实际使用的CPU，请使用 :vlopt:`--prof-threads` 。

多线程Verilog和库支持
-----------------------------------------

$display/$stop/$finish延迟到 eval() 调用结束，以保持线程之间的顺序。这可能会导致在$stop或$finish之后完成其他任务。

如果使用  :vlopt:`--coverage`，则覆盖率例程是完全线程安全的。

如果使用DPI，Verilator会假定纯DPI导入是线程安全的，从而平衡性能和安全性。请参见 :vlopt:`--threads-dpi``。

如果使用 :vlopt:`--savable`，则保存/还原类不是多线程的，只能由 eval 线程调用。

如果使用 :vlopt:`--sc`，SystemC内核不是线程安全的，因此eval线程和主线程必须相同。

如果使用 :vlopt:`--trace`，则必须从主线程构造和调用跟踪类。

如果使用 :vlopt:`--vpi`，由于IEEE没有将 SystemVerilog vpi 构建为多线程， Verilator 要求所有 vpi 调用都只能从主线程进行。

.. _GNU Make:

GNU Make
========

Verilator默认为为模型创建GNU Make makefiles。当使用 :vlopt:`--build` 选项时，Verilator 将自动调用make。

如果从 makefile 构建 Verilator，则 :vlopt:`-MMD` 选项将创建一个依赖项文件，该文件仅允许 make 在输入Verilog文件更改时重新构建 Verilator。

.. _CMake:

CMake
=====

Verilator 可以使用 CMake 构建，CMake 负责构建 Verilator 和编译输出。examples/ 目录中有一个 CMake 示例。下面是一个最小的 CMakeLists.txt，它将构建在 :ref:`Example C++ Execution` 中的代码。

.. code-block:: CMake

     project(cmake_example)
     find_package(verilator HINTS $ENV{VERILATOR_ROOT})
     add_executable(Vour sim_main.cpp)
     verilate(Vour SOURCES our.v)

:code:`find_package` 将自动查找已安装的Verilator副本，如果设置了 VERILATOR_ROOT ，则使用本地版本。

建议使用CMake>=3.12和Ninja生成器，尽管其他组合也可以使用。要使用 CMake 构建，请跳转到包含 CMakeLists.txt 的文件夹并运行：

.. code-block:: bash

     mkdir build
     cd build
     cmake -GNinja ..
     ninja

或使用系统默认生成器生成：

.. code-block:: bash

     mkdir build
     cd build
     cmake ..
     cmake --build .

如果您正在构建示例，您应该有一个可执行文件来运行：

.. code-block:: bash

     ./Vour

该包将CMake变量 verilator_FOUND、verilator_ROOT 和v erilator_BIN 设置为适当的值，并创建一个 verilate()函数。verilate() 将自动创建自定义命令来运行 Verilator 并将生成的 C++ 源代码添加到指定的目标。

CMake 中的 Verilate
---------------------

.. code-block:: CMake

     verilate(target SOURCES source ... [TOP_MODULE top] [PREFIX name]
              [TRACE] [TRACE_FST] [SYSTEMC] [COVERAGE]
              [INCLUDE_DIRS dir ...] [OPT_SLOW ...] [OPT_FAST ...]
              [OPT_GLOBAL ..] [DIRECTORY dir] [THREADS num]
              [TRACE_THREADS num] [VERILATOR_ARGS ...])

Lowercase 和 ... 应替换为参数，大写部分分隔参数，可以按任何顺序传递，或者如果可选，则完全忽略。

可以多次调用 verilate(target ...)，以将其他 Verilog 模块添加到可执行文件或库目标。

生成验证的 SystemC 源代码时，还应包括 SystemC 包含目录和指向SystemC库的链接。

.. describe:: target

   Name of a target created by add_executable or add_library.

.. describe:: COVERAGE

   Optional. Enables coverage if present, equivalent to "VERILATOR_ARGS
   --coverage"

.. describe:: DIRECTORY

   Optional. Set the verilator output directory. It is preferable to use
   the default, which will avoid collisions with other files.

.. describe:: INCLUDE_DIRS

   Optional. Sets directories that Verilator searches (same as -y).

.. describe:: OPT_SLOW

   Optional. Set compiler options for the slow path. You may want to reduce
   the optimization level to improve compile times with large designs.

.. describe:: OPT_FAST

   Optional. Set compiler options for the fast path.

.. describe:: OPT_GLOBAL

   Optional. Set compiler options for the common runtime library used by
   Verilated models.

.. describe:: PREFIX

   Optional. Sets the Verilator output prefix. Defaults to the name of the
   first source file with a "V" prepended. Must be unique in each call to
   verilate(), so this is necessary if you build a module multiple times
   with different parameters. Must be a valid C++ identifier, i.e. contains
   no white space and only characters A-Z, a-z, 0-9 or _.

.. describe:: SOURCES

   List of Verilog files to Verilate. Must have at least one file.

.. describe:: SYSTEMC

   Optional. Enables SystemC mode, defaults to C++ if not specified.

   When using Accellera's SystemC with CMake support, a CMake target is
   available that simplifies the SystemC steps. This will only work if the
   SystemC installation can be found by CMake. This can be configured by
   setting the CMAKE_PREFIX_PATH variable during CMake configuration.

   Don't forget to set the same C++ standard for the Verilated sources as
   the SystemC library. This can be specified using the SYSTEMC_CXX_FLAGS
   environment variable.

.. describe:: THREADS

   Optional. Generated a multi-threaded model, same as "--threads".

.. describe:: TRACE_THREADS

   Optional. Generated multi-threaded trace dumping, same as
   "--trace-threads".

.. describe:: TOP_MODULE

   Optional. Sets the name of the top module. Defaults to the name of the
   first file in the SOURCES array.

.. describe:: TRACE

   Optional. Enables VCD tracing if present, equivalent to "VERILATOR_ARGS
   --trace".

.. describe:: TRACE_FST

   Optional. Enables FST tracing if present, equivalent to "VERILATOR_ARGS
   --trace-fst".

.. describe:: VERILATOR_ARGS

   Optional. Extra arguments to Verilator. Do not specify :vlopt:`--Mdir`
   or :vlopt:`--prefix` here, use DIRECTORY or PREFIX.


SystemC Link in CMake
---------------------

Verilator's CMake support provides a convenience function to automatically
find and link to the SystemC library.  It can be used as:

.. code-block:: CMake

     verilator_link_systemc(target)

where target is the name of your target.

The search paths can be configured by setting some variables:

.. describe:: SYSTEMC_INCLUDE

   Sets the direct path to the SystemC includes.

.. describe:: SYSTEMC_LIBDIR

   Sets the direct path to the SystemC libraries.

.. describe:: SYSTEMC_ROOT

   Sets the installation prefix of an installed SystemC library.

.. describe:: SYSTEMC

   Sets the installation prefix of an installed SystemC library. (Same as
   SYSTEMC_ROOT).
