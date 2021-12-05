.. Copyright 2003-2021 by Wilson Snyder.
.. SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0

.. _Installation:

************
安装
************

本节讨论如何安装Verilator。

.. _Package Manager Quick Install:

软件包管理器快速安装
=============================

使用发行版的包管理器是最简单的入门方法。 (注意：软件包不太可能有最新版本，因此 :ref:`Git Install` 可能是更好的选择)。使用包管理器安装如下

::

   apt-get install verilator   # On Ubuntu

有关其他发行版本，请参见 `Repology Verilator Distro Packages <https://repology.org/project/verilator>`__.

.. _Git Install:

Git快速安装
=================

从Git安装Verilator提供了最大的灵活性。有关其他选项和详细信息，请参阅：参考 :ref:`Detailed Build Instructions`。

简言之，要从git安装：

::

   # Prerequisites:
   #sudo apt-get install git perl python3 make autoconf g++ flex bison ccache
   #sudo apt-get install libgoogle-perftools-dev numactl perl-doc
   #sudo apt-get install libfl2  # Ubuntu only (ignore if gives error)
   #sudo apt-get install libfl-dev  # Ubuntu only (ignore if gives error)
   #sudo apt-get install zlibc zlib1g zlib1g-dev  # Ubuntu only (ignore if gives error)

   git clone https://github.com/verilator/verilator   # Only first time

   # Every time you need to build:
   unsetenv VERILATOR_ROOT  # For csh; ignore error if on bash
   unset VERILATOR_ROOT  # For bash
   cd verilator
   git pull         # Make sure git repository is up-to-date
   git tag          # See what versions exist
   #git checkout master      # Use development branch (e.g. recent bug fixes)
   #git checkout stable      # Use most recent stable release
   #git checkout v{version}  # Switch to specified release version

   autoconf         # Create ./configure script
   ./configure      # Configure and create Makefile
   make -j `nproc`  # Build Verilator itself (if error, try just 'make')
   sudo make install


.. _Detailed Build Instructions:

详细的构建说明
===========================

本节描述构建过程的细节，并假设您是从Git构建的。 有关在Linux发行版中使用预构建的二进制文件的信息，请参见 :ref:`Package Manager Quick Install`.


操作系统要求
---------------

Verilator 是已经发行的，在 Ubuntu 上进行了初步测试，在 FreeBSD 和 Apple OS-X 上进行了额外测试。 这些版本还构建在 Redhat Linux 和其他 GNU/Linux 平台上。Verilator 还可用于 Linux 的 Windows子系统（WSL2）、Cygwin下的Windows和MinGW下的Windows（gcc-mno Cygwin）。验证输出(不是 Verilator 本身)在上述所有选项下编译，并使用 MSVC++。

安装前置条件
---------------------

要构建或运行Verilator，您需要以下标准软件包：

::

   sudo apt-get install git perl python3 make
   sudo apt-get install g++  # Alternatively, clang
   sudo apt-get install libgz  # Non-Ubuntu (ignore if gives error)
   sudo apt-get install libfl2  # Ubuntu only (ignore if gives error)
   sudo apt-get install libfl-dev  # Ubuntu only (ignore if gives error)
   sudo apt-get install zlibc zlib1g zlib1g-dev  # Ubuntu only (ignore if gives error)

要生成或运行以下选项是可选的，但应进行安装以获得良好的性能：

::

   sudo apt-get install ccache  # If present at build, needed for run
   sudo apt-get install libgoogle-perftools-dev numactl perl-doc

要构建Verilator，您需要安装这些软件包；运行Verilator时无需提供以下信息：

::

   sudo apt-get install git autoconf flex bison

那些开发Verilator本身的人也可能需要这些（参见internals.rst）：

::

   sudo apt-get install gdb graphviz cmake clang clang-format-11 gprof lcov
   sudo pip3 install sphinx sphinx_rtd_theme breathe
   cpan install Pod::Perldoc
   cpan install Parallel::Forker


安装SystemC
^^^^^^^^^^^^^^^

如果你使用 SystemC（vs straight C++ output），下载 `SystemC <https://www.accellera.org/downloads/standards/systemc>`__ 。按照他们的安装说明进行操作。 您需要设置 :option:`SYSTEMC_INCLUDE` 环境变量以指向包含 ``systemc.h`` 的目录，并设置 :option:`SYSTEMC_LIBDIR` 环境变量以指向包含 ``libsystemc.a`` 的目录。


安装GTKWave
^^^^^^^^^^^^^^^

要使用 Verilator FST 跟踪，您需要 `GTKwave <http://gtkwave.sourceforge.net/>`__ 已安装，但在 Verilator 构建时不需要安装。

获取源码
--------------

从git存仓库中获取源代码：（您只需执行一次即可。）

::

   git clone https://github.com/verilator/verilator   # Only first time
   ## Note the URL above is not a page you can see with a browser, it's for git only

输入 checkout 并且决定哪个版本/分支你将使用:

::

   cd verilator
   git pull        # Make sure we're up-to-date
   git tag         # See what versions exist
   #git checkout master      # Use development branch (e.g. recent bug fix)
   #git checkout stable      # Use most recent release
   #git checkout v{version}  # Switch to specified release version


自动配置
--------------

创建配置脚本：

::

   autoconf        # Create ./configure script


最终安装选项
-----------------------------

在配置构建之前，您必须决定最终如何将Verilator安装到您的系统上。Verilator将编译环境变量的当前值 :option:`VERILATOR_ROOT` 、:option:`SYSTEMC_INCLUDE` 和 :option:`SYSTEMC_LIBDIR` 作为默认值编译到可执行文件中，因此在配置之前它们必须是正确的。

以下是几种安装方式：


1. 从 VERILATOR_ROOT 位置运行 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

我们个人最喜欢的是始终从它的Git目录运行Verilator。这允许最简单的实验和升级，并允许Verilator的多个版本在一个系统上共存。

::

   export VERILATOR_ROOT=`pwd`   # if your shell is bash
   setenv VERILATOR_ROOT `pwd`   # if your shell is csh
   ./configure
   # Running will use files from $VERILATOR_ROOT, so no install needed

注意：安装（以下步骤）后，调用程序或shell必须设置环境变量 :option:`VERILATOR_ROOT` 以指向此Git目录，然后执行 ``$VERILATOR_ROOT/bin/verilator``，它将找到所有所需文件的路径。


2. 安装到特定位置
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

您最终可能要安装到一个 project/company-wide "CAD"工具的磁盘上，该磁盘可能支持每个工具的多个版本。告诉配置最终的目标目录名。我们建议目标位置包括Verilator版本名：

::

   unset VERILATOR_ROOT      # if your shell is bash
   unsetenv VERILATOR_ROOT   # if your shell is csh
   # For the tarball, use the version number instead of git describe
   ./configure --prefix /CAD_DISK/verilator/`git describe | sed "s/verilator_//"`

注意：安装后（以下步骤），如果使用 `modulecmd <http://modules.sourceforge.net/>`__ ，您将需要如下所示的模块文件：

::

   set install_root /CAD_DISK/verilator/{version-number-used-above}
   unsetenv VERILATOR_ROOT
   prepend-path PATH $install_root/bin
   prepend-path MANPATH $install_root/man
   prepend-path PKG_CONFIG_PATH $install_root/share/pkgconfig


3. 安装到特定路径中
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

您最终可能会将Verilator安装到特定的安装前缀中，因为大多数 GNU 工具都支持：

::

   unset VERILATOR_ROOT      # if your shell is bash
   unsetenv VERILATOR_ROOT   # if your shell is csh
   ./configure --prefix /opt/verilator-VERSION

然后在安装（以下步骤）后，您需要将 ``/opt/verilator-VERSION/bin`` 添加到您的 ``$PATH`` 环境变量中。


4. 安装到系统的全局路径
^^^^^^^^^^^^^^^^^^^^^^^^^^

最后一个选项是最终使用configure的默认系统路径全局安装Verilator：

::

   unset VERILATOR_ROOT      # if your shell is bash
   unsetenv VERILATOR_ROOT   # if your shell is csh
   ./configure

然后，在安装（下面）后，二进制文件应该位于 ``$PATH`` 环境变量中的某个位置。


配置
---------

在上一步中描述了配置包的命令。开发人员应该配置更完整以便更完整的开发者测试。这些测试可能需要额外的包。

::

   export VERILATOR_AUTHOR_SITE=1    # Put in your .bashrc
   ./configure --enable-longtests  ...above options...


编译
-------

编译 Verilator:

::

   make -j `nproc`  # Or if error on `nproc`, the number of CPUs in system


测试
----

通过运行自检检查编译：

::

   make test


安装
-------

如果你使用的安装方案不是 `1. Run-in-Place from VERILATOR_ROOT <#_1_run_in_place_from_verilator_root>`__，使用以下方式安装:

::

   make install


.. Docker Build Environment

.. include:: ../../ci/docker/buildenv/README.rst


.. Docker Run Environment

.. include:: ../../ci/docker/run/README.rst
