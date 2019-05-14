# FPGA开发套件
[Switch to the English version](./README.md)

# 目录

+ [1 关于FPGA开发套件](#sec_1)
+ [2 使用前准备](#sec_2)
  + [2.1 开发套件的下载](#sec_2_1)
  + [2.2 FPGA镜像管理工具的安装和配置](#sec_2_2)
+ [3 使用开发套件](#sec_3)


<a name="sec_1"></a>
# 1 关于开发套件
FPGA开发套件是一款基于华为企业云服务的FPGA硬件与软件开发工具套件，本套件不仅能够帮助用户完成FPGA相关的设计、仿真、逻辑文件生成以及一键式编译运行，而且还能为用户提供专业的设计以及验证组件，帮助开发者更高效的实现FPGA的开发。目前FPGA开发套件只有fp1开发套件，fp1开发套件分为硬件开发套件和应用开发套件两个部分。硬件开发套件可以帮助用户完成工程编译、工程仿真、生成dcp文件或xclbin文件，最终完成FPGA镜像的注册；应用开发套件可以指引用户完成FPGA镜像加载以及用户应用的编写和调试。

<a name="sec_2"></a>
# 2 使用前准备
在使用FPGA开发套件前，必须要执行2.1~2.2步骤，完成开发套件的获取以及工具的安装及配置等。

<a name="sec_2_1"></a>
## 2.1 开发套件的下载

+ 对于https连接执行`git clone https://github.com/fpga-accel/ctyun-fpga.git`命令将开发套件下载到您的本地服务器。

+ 对于ssh连接执行`git clone git@github.com:fpga-accel/ctyun-fpga.git`命令将开发套件下载到您的本地服务器。

> 当在弹性云服务器中下载开发套件时，请确保弹性云服务器已经绑定了弹性IP。<br/>
> 开发套件的下载依赖git工具，请确保在执行下载操作前已安装此软件。

<a name="sec_2_2"></a>
## 2.2 FPGA镜像管理工具的安装和配置
FPGA镜像管理工具fisclient是一款跨平台命令行工具，用于FPGA镜像管理，而镜像管理是进行FPGA镜像加载前的必须步骤。通过fisclient，用户可以实现FPGA镜像的删除、查询等操作。此外，fisclient还提供了FPGA镜像（AEI，Accelerated Engine Image）和弹性云服务器镜像之间关联关系的管理功能。用户在创建AEI和弹性云服务器镜像之间的关联关系后，可以将弹性云服务器镜像发布到云市场或共享给其他用户。

> 管理工具的安装和配置请参见[fisclient README](./cli/fisclient/README_CN.md)安装和配置部分。


<a name="sec_3"></a>
# 3 使用开发套件
FPGA开发套件是一套云化FPGA硬件和软件开发工具套件。fp1开发套件面向fp1型和fp1c型云服务器，适用于视频处理、机器学习、基因组学研究、金融风险分析等场景。

+ fp1开发套件详细说明，参见[README_CN.md](./fp1/README_CN.md)。



\----End