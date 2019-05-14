# FPGA镜像加载工具
[Switch to the English version](./README.md)

## 目录

1. [FPGA镜像加载工具](#about_tool)
2. [工具的编译和安装](#tool_setup)
3. [工具的使用](#tool_usage)
4. [工具使用实例：加载FPGA镜像](#load_fpga)
5. [工具的卸载](#tool_uninstall)

<a name="about_tool"></a>
## 1 FPGA镜像加载工具
FPGA镜像加载工具是作为FPGA开发套件的一部分，工具 **FpgaCmdEntry** 实现了FPGA镜像加载、加载状态查询、清除镜像、告警信息查询、设备信息查询、虚拟点灯状态查询和工具版本号查询的功能。FPGA工具目录结构如下：

	linux-htucef:/home/ctyun-fpga/cli/fpga_tool # ll
	total 40
	drwxr-xr-x. 2 root root 4096 Dec 20 14:33 build
	drwxr-xr-x. 2 root root 4096 Dec 20 14:33 docs
	-rw-r--r--. 1 root root 2941 Dec 20 14:33 fpga_tool_setup.sh
	-rw-r--r--. 1 root root 2292 Dec 20 14:33 fpga_tool_uninstall.sh
	-rw-r--r--. 1 root root 1584 Dec 20 14:33 LICENSE.txt
	-rw-r--r--. 1 root root 4616 Dec 20 14:33 README_CN.md
	-rw-r--r--. 1 root root 4802 Dec 20 14:33 README.md
	drwxr-xr-x. 5 root root 4096 Dec 20 14:33 src



[*文件夹src*](./src/) 用于存放FPGA镜像加载工具的源码

[*文件夹build*](./build/) 用于存放工具编译、安装和卸载的脚本文件

[*文件夹docs*](./docs/) 用于存放工具相关的说明文档

[*LICENSE.txt*](./LICENSE.txt) 为许可文件

[*README.md*](./README.md) 是加载工具说明文档

[*fpga_tool_setup.sh*](./fpga_tool_setup.sh) 是工具编译安装脚本

[*fpga_tool_uninstall.sh*](./fpga_tool_uninstall.sh) 是工具卸载脚本


> 在使用本工具前，请按照编译和安装指导完成工具的编译和安装。

> 安装完成后，请按照操作指导中列出的指令来实现加载、查询等功能。

<a name="tool_setup"></a>
## 2 工具的编译和安装
工具的编译和安装步骤如下：

步骤1：FPGA镜像加载工具的编译依赖于GCC，编译安装前使用命令`gcc --version`确认GCC是否已安装。若未安装GCC，请进行安装。
	
	linux-htucef:/ # gcc --version
	gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
	Copyright (C) 2015 Free Software Foundation, Inc.
	This is free software; see the source for copying conditions.  There is NO
	warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
步骤2：工具的安装需要root权限，请在编译和安装前确认是否已获取此权限。

步骤3：执行命令`bash fpga_tool_setup.sh`完成工具的编译和安装。
	
	linux-htucef:/home/ctyun-fpga/cli/fpga_tool # bash fpga_tool_setup.sh 
	FPGA_TOOL SETUP MESSAGE:Done setting environment variables.
	Entering /home/ctyun-fpga/cli/fpga_tool/build/../src
	rm -rf /home/ctyun-fpga/cli/fpga_tool/src/../dist/tool_obj 
	rm -f  /home/ctyun-fpga/cli/fpga_tool/src/../dist/FpgaCmdEntry
	gcc -c ...
	...
	finish FpgaCmdEntry
	FPGA_TOOL SETUP MESSAGE: Build completed.
	FPGA_TOOL INSTALL MESSAGE: Executing as root...
	FPGA_TOOL INSTALL MESSAGE: Copy libfpgamgmt.so to /usr/lib64 success
	FPGA_TOOL INSTALL MESSAGE: Set the privilege of /usr/lib64/libfpgamgmt.so success
	FPGA_TOOL INSTALL MESSAGE: Copy FpgaCmdEntry to /usr/local/bin success
	FPGA_TOOL INSTALL MESSAGE: Set the privilege of /usr/local/bin/FpgaCmdEntry success
	FPGA_TOOL SETUP MESSAGE: Setup fpga_tool success.

<a name="tool_usage"></a>
## 3 工具的使用
FPGA镜像加载工具编译和安装完成后，可在任一目录下调用工具进行设备信息查询、镜像加载、加载状态查询、镜像清除、告警信息查询、虚拟点灯状态查询和工具版本号查询等。

[FPGA加载工具使用说明](./docs/load_tool_operation_instuctions_cn.md)

<a name="load_fpga"></a>
## 4 工具使用实例：加载FPGA镜像
在注册好一个FPGA镜像后，就可以使用工具来进行镜像加载了。

[加载FPGA镜像](./docs/load_an_fpga_image_cn.md)

<a name="tool_uninstall"></a>
## 5 工具的卸载
工具的卸载步骤如下：

步骤1：工具的卸载需要root权限，请在卸载前确认是否已获取此权限。

步骤2：执行命令`bash fpga_tool_uninstall.sh`完成工具的卸载。

	linux-htucef:/home/ctyun-fpga/cli/fpga_tool # bash fpga_tool_uninstall.sh 
	Entering /home/ctyun-fpga/cli/fpga_tool/build/../src
	rm -rf /home/ctyun-fpga/cli/fpga_tool/src/../dist/tool_obj 
	rm -f  /home/ctyun-fpga/cli/fpga_tool/src/../dist/libfpgamgmt.so
	rm -rf /home/ctyun-fpga/cli/fpga_tool/src/../dist/tool_obj
	rm -f  /home/ctyun-fpga/cli/fpga_tool/src/../dist/FpgaCmdEntry
	FPGA_TOOL CLEAN MESSAGE:Clean success
	FPGA_TOOL UNISTALL MESSAGE: Unistall completed.




\----End