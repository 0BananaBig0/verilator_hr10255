.. Copyright 2003-2021 by Wilson Snyder.
.. SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

******************************
FAQ/常见问题
******************************

.. Extra heading level here so sidebar index looks nice

问题
=========

我能贡献吗？
"""""""""""""""""

请共享！只要提交一个请求，或者提出一个问题来讨论，如果你在寻找帮助的话。有关更多信息，请参阅我们的贡献者协议。


Verilator的使用范围有多广？
"""""""""""""""""""""""""""""

Verilator 被许多最大的silicon 设计公司、CERN等大型组织甚至大学生项目使用。

Verilator 是 "big 4" 的仿真器之一(可用的4个主要SystemVerilog模拟器之一, 即封闭源代码产品 Synopsys VCS (tm)、Mentor Questa/ModelSim(tm)、Cadence Xcelium/Incisive/NC Verilog/NC Sim(tm)和开放源代码Verilator。)这三个封闭源代码产品通常统称为"big 3"模拟器。

Verilator是否在Windows下运行？
"""""""""""""""""""""""""""""""""

是的，理想情况下在 Windows Linux 子系统（WSL2）下运行Ubuntu。或者使用 Cygwin，尽管这往往较慢，并且没有定期测试。Verilated 输出也在微软 Visual C++ 下编译，但这也不是经过试验的。

你能提供二进制文件吗？
"""""""""""""""""""""""""

您可以通过系统包管理器 (apt、yum等) 在许多Linux发行版上安装 Verilator，包括 Debian、Ubuntu、SuSE、RedHat等。这些包由Linux发行版提供，通常会滞后于主线 Verilator 仓库的版本。如果您的发行版没有可用的二进制软件包，请你设置一个怎么样？


它怎么能比 (name-a-big-3-closed-source-simulator) 更快?
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

一般来说，问题的隐含部分是 "... 他们可以投入所有的人力来开发它。"

大多数模拟器必须符合完整的IEEE 1364（Verilog）和IEEE 1800（SystemVerilog）标准，这意味着它们必须是事件驱动的。这使他们无法对块进行重新排序和进行网表式优化，而这正是大部分收益的来源。

你不应该被违规行为吓倒。您的合成工具不符合开始时的整个标准，因此您的模拟器也不必符合。Verilator更接近合成解释，因此这对于从事 silicon 是一件好事。

Verilator 输出是否仍受我自己的许可/版权保护？
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

是的，这就像在程序中使用 GCC 一样；这就是为什么Verilator使用 "GNU **Lesser** Public License Version 3" 而不是更典型的 "GNU Public License"。

有关详细信息，请参阅许可证，但简而言之，如果更改Verilator本身或Verilator包含的头文件，则必须使源代码在GNU Lesser Public许可证下可用。但是，Verilator 的输出(验证代码) 仅 "包含" 许可文件，因此您 **不** 需要开源发布 Verilator 的任何输出。

您还可以选择使用 Perl Artic 许可证，它同样不要求您发布 Verilog 或生成的代码，还允许您修改 Verilator 供内部使用，而无需分发修改后的版本。但请回馈社区！

一个限制是，您不能在任何许可证下发布包含 Verilator 的封闭源代码的 Verilog 仿真产品。也就是说，您可以拥有商业产品，但必须提供源代码。

按照开源的标准，对 Verilator 的贡献将置于 Verilator 版权和 LGPL/Artistic license 之下。小型测试用例将发布到公共领域，以便它们可以在任何地方使用，大型测试将在 LGPL/ARTIC 下使用，除非另有要求。

为什么运行Verilator（创建模型）这么慢？
"""""""""""""""""""""""""""""""""""""""""""""""""""""

Verilator 可能需要比生成的模拟器所需的内存更多的内存，因为Verilator在内部创建生成的模拟器的所有状态以优化它。如果花费的时间超过几分钟左右（并且您没有使用 :vlopt:`--debug`，因为调试模式是磁盘绑定的），请查看您的机器是否正在分页；很可能您需要在内存更大的机器上运行它。众所周知，超大设计的驻留集大小超过了64 GB。或者，请参阅 :ref:`Hierarchical Verilation` 。

如何在C++中生成波形（跟踪）？
""""""""""""""""""""""""""""""""""""""""""""

另请参见下一个有关SystemC模式下跟踪的问题。

A. 将 :vlopt:`--trace` 选项传递给 Verilator ，并在顶级C代码中调用 ``Verilated::traceEverOn(true)``。然后您可以使用 ``$dumpfile`` 和 ``$dumpvars`` 启用跟踪，与任何 Verilog 模拟器一样。请参见发行中的 ``examples/make_tracing_c`` 。

B. 或者，对于细粒度控件，或者具有多个已验证模块的C++文件，您也可以创建纯C++的跟踪。创建一个 VerilatedVCD 对象，并在主循环中紧接着 ``eval()`` 调用 ``trace_object->dump(contextp->time())`` 每个时间步，最后调用 ``trace_object->close()``。

   .. code-block:: C++
      :emphasize-lines: 1,5-8,12

      #include "verilated_vcd_c.h"
      ...
      int main(int argc, char** argv, char** env) {
          const std::unique_ptr<VerilatedContext> contextp{new VerilatedContext};
          ...
          Verilated::traceEverOn(true);
          VerilatedVcdC* tfp = new VerilatedVcdC;
          topp->trace(tfp, 99);  // Trace 99 levels of hierarchy
          tfp->open("obj_dir/t_trace_ena_cc/simx.vcd");
          ...
          while (contextp->time() < sim_time && !contextp->gotFinish()) {
              contextp->timeInc(1);
              topp->eval();
              tfp->dump(contextp->time());
          }
          tfp->close();
      }

您还需要编译 :file:`verilated_vcd_c.cpp` 并将其添加到您的链接中，最好通过在Makefile的 :code:`$(VK_GLOBAL_OBJS)` 链接规则中添加依赖项。如果使用Verilator :vlopt:`--exe` 选项，则可以完成此操作。

如果希望所有数据都放在同一输出文件中，可以对具有相同跟踪文件的多个验证对象调用 :code:`trace_object->trace()`。

如何在 SystemC 中生成波形（跟踪）？
""""""""""""""""""""""""""""""""""""""""""""""""

A. Pass the :vlopt:`--trace` option to Verilator, and in your top level
   :code:`sc_main()`, call :code:`Verilated::traceEverOn(true)`.  Then you
   may use :code:`$dumpfile` and code:`$dumpvars` to enable traces, same as
   with any Verilog simulator, see the non-SystemC example in
   :file:`examples/make_tracing_c`. This will trace only the module
   containing the :code:`$dumpvar`.

B. Or, you may create a trace purely from SystemC, which may trace all
   Verilated designs in the SystemC model. Create a VerilatedVcdSc object
   as you would create a normal SystemC trace file.  For an example, see
   the call to ``VerilatedVcdSc`` in the
   :file:`examples/make_tracing_sc/sc_main.cpp` file of the distribution,
   and below.

C. Alternatively you may use the C++ trace mechanism described in the
   previous question, note the timescale and timeprecision will be
   inherited from your SystemC settings.

   .. code-block:: C++
      :emphasize-lines: 1,5-8

      #include "verilated_vcd_sc.h"
      ...
      int main(int argc, char** argv, char** env) {
          ...
          Verilated::traceEverOn(true);
          VerilatedVcdSc* tfp = new VerilatedVcdSc;
          topp->trace(tfp, 99);  // Trace 99 levels of hierarchy
          tfp->open("obj_dir/t_trace_ena_cc/simx.vcd");
          ...
          sc_start(1);
          ...
          tfp->close();
      }



You also need to compile :file:`verilated_vcd_sc.cpp` and
:file:`verilated_vcd_c.cpp` and add them to your link, preferably by adding
the dependencies in your Makefile's :code:`$(VK_GLOBAL_OBJS)` link rule.
This is done for you if using the Verilator :vlopt:`--exe` option.

You can call :code:`->trace()` on multiple Verilated objects with the same
trace file if you want all data to land in the same output file.

When using SystemC 2.3, the SystemC library must have been built with the
experimental simulation phase callback based tracing disabled. This is
disabled by default when building SystemC with its configure based build
system, but when building SystemC with CMake, you must pass
``-DENABLE_PHASE_CALLBACKS_TRACING=OFF`` to disable this feature.


How do I generate FST waveforms (traces) in C++ or SystemC?
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

FST is a trace file format developed by GTKWave.  Verilator provides basic
FST support.  To dump traces in FST format, add the :vlopt:`--trace-fst`
option to Verilator and either A. use :code:`$dumpfile & $dumpvars` in
Verilog as described in the VCD example above,

Or, in C++ change the include described in the VCD example above:

.. code-block:: C++

      #include "verilated_fst_c.h"
      VerilatedFstC* tfp = new VerilatedFstC;


Or, in SystemC change the include described in the VCD example above:

.. code-block:: C++

      #include "verilated_fst_sc.h"
      VerilatedFstC* tfp = new VerilatedFstSc;


Note that currently supporting both FST and VCD in a single simulation is
impossible, but such requirement should be rare.  You can however ifdef
around the trace format in your C++ main loop, and select VCD or FST at
build time, should you require.


How do I view waveforms (aka dumps or traces)?
""""""""""""""""""""""""""""""""""""""""""""""

Verilator creates standard VCD (Value Change Dump) and FST files.  VCD
files are viewable with the open source GTKWave (recommended) or Dinotrace
(legacy) programs, or any of the many closed-source offerings; FST is
supported only by GTKWave.


How do I speed up writing large waveform (trace) files?
"""""""""""""""""""""""""""""""""""""""""""""""""""""""

A. Instead of calling ``VerilatedVcdC->open`` or ``$dumpvars`` at the
   beginning of time, delay calling it until the time stamp where you want
   tracing to begin.

B. Add the :option:`/*verilator&32;tracing_off*/` metacomment to any very
   low level modules you never want to trace (such as perhaps library
   cells).

C. Use the :vlopt:`--trace-depth` option to limit the depth of tracing, for
   example :vlopt:`--trace-depth 1 <--trace-depth>` to see only the top
   level signals.

D. You can also consider using FST tracing instead of VCD. FST dumps are a
   fraction of the size of the equivalent VCD. FST tracing can be slower
   than VCD tracing, but it might be the only option if the VCD file size
   is prohibitively large.

E. Be sure you write your trace files to a local solid-state drive, instead
   of to a network drive.  Network drives are generally far slower.


Where is the translate_off command?  (How do I ignore a construct?)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Translate on/off pragmas are generally a bad idea, as it's easy to have
mismatched pairs, and you can't see what another tool sees by just
preprocessing the code.  Instead, use the preprocessor; Verilator defines
the ``\`VERILATOR`` define for you, so just wrap the code in an ifndef
region:

 .. code-block:: sv
    :emphasize-lines: 1

    `ifndef VERILATOR
       Something_Verilator_Dislikes;
    `endif

Most synthesis tools similarly define SYNTHESIS for you.


Why do I get "unexpected 'do'" or "unexpected 'bit'" errors?
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

The words \ ``do``\ , \ ``bit``\ , \ ``ref``\ , \ ``return``\ , and others
are reserved keywords in SystemVerilog.  Older Verilog code might use these
as identifiers.  You should change your code to not use them to ensure it
works with newer tools.  Alternatively, surround them by the Verilog
2005/SystemVerilog begin_keywords pragma to indicate Verilog 2001 code.

.. code-block:: sv
   :emphasize-lines: 1

   `begin_keywords "1364-2001"
      integer bit; initial bit = 1;
   `end_keywords


If you want the whole design to be parsed as Verilog 2001, see the
:vlopt:`--default-language` option.


How do I prevent my assertions from firing during reset?
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Call :code:`Verilated::assertOn(false)` before you first call the model,
then turn it back on after reset.  It defaults to true.  When false, all
assertions controlled by :vlopt:`--assert` are disabled.


Why do I get "undefined reference to sc_time_stamp()?
"""""""""""""""""""""""""""""""""""""""""""""""""""""

In Verilator 4.200 and later, using the timeInc function is recommended
instead.  See the :ref:`Connecting to C++` examples.  Some linkers (MSVC++)
still require :code:`sc_time_stamp()` to be defined, either define this
with :code:`double sc_time_stamp() { return 0; }` or compile the Verilated
code with :code:`-CFLAGS -DVL_TIME_CONTEXT`.

Prior to Verilator 4.200, the :code:`sc_time_stamp()` function needs to be
defined in C++ (non SystemC) to return the current simulation time.


Why do I get "undefined reference to \`VL_RAND_RESET_I' or \`Verilated::...'"?
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

You need to link your compiled Verilated code against the
:code:`verilated.cpp` file found in the include directory of the Verilator
kit.  This is one target in the ``$(VK_GLOBAL_OBJS)`` make variable, which
should be part of your Makefile's link rule.  If you use :vlopt:`--exe`,
this is done for you.


Is the PLI supported?
"""""""""""""""""""""

Only somewhat.  More specifically, the common PLI-ish calls $display,
$finish, $stop, $time, $write are converted to C++ equivalents.  You can
also use the "import DPI" SystemVerilog feature to call C code (see the
chapter above).  There is also limited VPI access to public signals.

If you want something more complex, since Verilator emits standard C++
code, you can simply write your own C++ routines that can access and modify
signal values without needing any PLI interface code, and call it with
$c("{any_c++_statement}").

See the :ref:`Connecting` section.


How do I make a Verilog module that contain a C++ object?
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

You need to add the object to the structure that Verilator creates, then
use $c to call a method inside your object.  The
:file:`test_regress/t/t_extend_class` files in the distribution show an
example of how to do this.


How do I get faster build times?
""""""""""""""""""""""""""""""""

* When running make, pass the make variable VM_PARALLEL_BUILDS=1 so that
  builds occur in parallel. Note this is now set by default if an output
  file was large enough to be split due to the :vlopt:`--output-split`
  option.

* Verilator emits any infrequently executed "cold" routines into separate
  __Slow.cpp files. This can accelerate compilation as optimization can be
  disabled on these routines. See the OPT_FAST and OPT_SLOW make variables
  and :ref:`Benchmarking & Optimization`.

* Use a recent compiler.  Newer compilers tend to be faster.

* Compile in parallel on many machines and use caching; see the web for the
  ccache, distcc and icecream packages. ccache will skip GCC runs between
  identical source builds, even across different users.  If ccache was
  installed when Verilator was built it is used, or see OBJCACHE
  environment variable to override this. Also see the
  :vlopt:`--output-split` option and :ref: `Profiling ccache efficiency`

* To reduce the compile time of classes that use a Verilated module (e.g. a
  top CPP file) you may wish to add a
  :option:`/*verilator&32;no_inline_module*/` metacomment to your top level
  module. This will decrease the amount of code in the model's Verilated
  class, improving compile times of any instantiating top level C++ code,
  at a relatively small cost of execution performance.

* Use :ref:`hierarchical verilation`.


Why do so many files need to recompile when I add a signal?
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Adding a new signal requires the symbol table to be recompiled.  Verilator
uses one large symbol table, as that results in 2-3 less assembly
instructions for each signal access.  This makes the execution time 10-15%
faster, but can result in more compilations when something changes.


How do I access Verilog functions/tasks in C?
"""""""""""""""""""""""""""""""""""""""""""""

Use the SystemVerilog Direct Programming Interface.  You write a Verilog
function or task with input/outputs that match what you want to call in
with C.  Then mark that function as a DPI export function.  See the DPI
chapter in the IEEE Standard.


How do I access C++ functions/tasks in Verilog?
"""""""""""""""""""""""""""""""""""""""""""""""

Use the SystemVerilog Direct Programming Interface.  You write a Verilog
function or task with input/outputs that match what you want to call in
with C.  Then mark that function as a DPI import function.  See the DPI
chapter in the IEEE Standard.


How do I access signals in C?
"""""""""""""""""""""""""""""

The best thing to do is to make a SystemVerilog "export DPI" task or
function that accesses that signal, as described in the DPI chapter in the
manual and DPI tutorials on the web.  This will allow Verilator to better
optimize the model and should be portable across simulators.

If you really want raw access to the signals, declare the signals you will
be accessing with a :option:`/*verilator&32;public*/` metacomment before
the closing semicolon.  Then scope into the C++ class to read the value of
the signal, as you would any other member variable.

Signals are the smallest of 8-bit unsigned chars (equivalent to uint8_t),
16-bit unsigned shorts (uint16_t), 32-bit unsigned longs (uint32_t), or
64-bit unsigned long longs (uint64_t) that fits the width of the signal.
Generally, you can use just uint32_t's for 1 to 32 bits, or vluint64_t for
1 to 64 bits, and the compiler will properly up-convert smaller entities.
Note even signed ports are declared as unsigned; you must sign extend
yourself to the appropriate signal width.

Signals wider than 64 bits are stored as an array of 32-bit uint32_t's.
Thus to read bits 31:0, access signal[0], and for bits 63:32, access
signal[1].  Unused bits (for example bit numbers 65-96 of a 65-bit vector)
will always be zero.  If you change the value you must make sure to pack
zeros in the unused bits or core-dumps may result, because Verilator strips
array bound checks where it believes them to be unnecessary to improve
performance.

In the SYSTEMC example above, if you had in our.v:

 .. code-block:: sv

      input clk /*verilator public*/;
      // Note the placement of the semicolon above

From the sc_main.cpp file, you'd then:

 .. code-block:: C++

      #include "Vour.h"
      #include "Vour_our.h"
      cout << "clock is " << top->our->clk << endl;


In this example, clk is a bool you can read or set as any other variable.
The value of normal signals may be set, though clocks shouldn't be changed
by your code or you'll get strange results.


模块应该是Verilog还是SystemC？
"""""""""""""""""""""""""""""""""""""""""
有时，有一个块只是连接实例，需要选择是用Verilog还是SystemC编写。在其他条件相同的情况下，当Verilator看到所有设计时，性能最佳。因此，请查看设计的层次结构，将实例标记为SystemC或Verilog。然后：

* 下面只有SystemC实例的模块必须是SystemC。

* 下面混合了Verilog和SystemC实例的模块必须是SystemC。（因为Verilator无法连接到较低级别的SystemC实例。）

* 下面只有Verilog实例的模块可以是，但为了获得最佳性能，应该是Verilog。（例外情况是，如果您有一个多次实例化的设计；在这种情况下，验证一个较低的模块并将该验证实例多次实例化为SystemC模块*可能*会更快。）
