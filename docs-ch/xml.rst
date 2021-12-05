|Logo|

***************************
Verilator XML输出格式
***************************

介绍
============

本文档描述了Verilator的XML输出。 有关更信息的信息，请参见 `verilator.org <https://verilator.org>`__.


概括
=======

Verilator的XML输出是使用 ``--xml-only`` 标志启用的。它包含有关详细设计的受限信息，包括文件、模块、实例层次结构、逻辑和数据类型。没有正式的格式，因为XML文档的部分结构与编译后的代码相匹配，这需要一个格式来描述合法的 SystemVerilog 结构。预期用途是使其他下游工具能够利用 Verilator 的解析器。


结构
=========

XML文档由顶层 ``verilator_XML`` 元素中的4个 section 组成：

``<files>``\ ... ``</files>``
   这个 section 包含已读取的所有设计文件的列表，包括内置构件和命令行作为它们自己的入口。每个 ``<file>`` 都有一个属性 ``id`` ，该属性是该文件特有的一个简短 ASCII 字符串。其他元素 ``loc`` 属性使用此 id 引用特定文件。

``<module_files>``\ ... ``</module_files>``
   这个 section 列出了包含 Verilog 模块定义的所有文件。此元素的内容是 ``<files>`` 元素内容的子集。

``<cells>``\ ... ``</cells>``
   XML文档的 cell section 包含设计实例层次结构。每个实例都由具有以下属性的 ``<cell>`` 元素表示：

   -  ``fl`` (废弃): 模块实例化对应的文件id和行号。使用 ``loc`` 代替。

   -  ``loc``: 文件id,模块实例所在标识符的第一行号、最后一行号、第一列号和最后一列号,以逗号分隔。

   -  ``name``: 实例名称。

   -  ``submodname``: 使用特殊参数值简写的模块名称(如果有的话)。

   -  ``hier``: 完整的层次结构路径。

``<netlist>``\ ... ``</netlist>``
   netlist section 包含 ``<module>`` \ ... ``</module>`` 元素，每个 module 都描述了该模块的内容, 和一个单独 ``<typetable>`` \ ... ``</typetable>`` 元素，列出模块中使用的所有类型。每种类型都有一个数字的 ``id`` 属性，该属性由 ``<module>`` 元素中使用 ``dtype_id`` 属性引用。



Distribution
============

Copyright 2020-2021 by Wilson Snyder. Verilator is free software; you can
redistribute it and/or modify it under the terms of either the GNU Lesser
General Public License Version 3 or the Perl Artistic License Version 2.0.

.. |Logo| image:: https://www.veripool.org/img/verilator_256_200_min.png
