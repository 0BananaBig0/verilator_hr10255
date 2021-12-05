.. Copyright 2003-2021 by Wilson Snyder.
.. SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

首先，您需要安装Verilator, 请参见 :ref:`Installation`. 简而言之，如果您使用操作系统的软件包管理器安装 Verilator，或者执行了 :command:`make install` 将Verilator放入默认路径，则您的环境中不需要任何特殊的内容，也不应设置 VERILATOR_ROOT。但是，如果您从源代码处安装了Verilator，并希望在编译Verilator的地方运行Verilator，则需要指向该工具包：

.. code-block:: bash

     # 见上文; 不要使用它如果你使用的是系统发行的 Verilator 
     export VERILATOR_ROOT=/path/to/where/verilator/was/installed
     export PATH=$VERILATOR_ROOT/bin:$PATH
