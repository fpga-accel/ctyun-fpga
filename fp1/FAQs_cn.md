# 天翼云FPGA - 常见问题及解答
[Switch to the English version](./FAQs.md)

# 目录

[概况](#sec_1) 

[应用市场](#sec_2)

[开发语言](#sec_3)

[FPGA](#sec_4)

[FPGA Shell](#sec_5) 

[疑难解答](#sec_6)

[FpgaCmdEntry](#sec_7)

[高危操作](#sec_8)

<a name="sec_1"></a>
## 概况

### Q1：什么是HDK?

HDK是Hardware Development Kit的缩写，即硬件开发套件。

### Q2：什么是SDK?

SDK是Software Development Kit的缩写，即软件开发套件。SDK主要包含运行FPGA实例所需要的驱动、工具、运行环境以及应用程序。

<a name="sec_2"></a>
## 应用市场
### Q1：ctyun FPGA Marketplace是什么？

FPGA开发人员可以使用Marketplace将他们的AEI文件共享或出售给其他ctyun FPGA用户。 

<a name="sec_3"></a>
## 开发语言
### Q1：ctyun FPGA支持哪些开发语言?

目前ctyun FPGA有通用型（OpenCL），OpenCL主要采用C语言开发。

<a name="sec_4"></a>
## FPGA
### Q1：ctyun FPGA使用的FPGA型号是什么?

目前ctyun FPGA使用的FPGA是Xilinx公司的Ultra Scale+系列xcvu9p-flgb2104-2-i板卡。

<a name="sec_5"></a>
## FPGA Shell
### Q1：什么是Shell？

Shell是HDK提供的静态逻辑部分，包括PCIe、DDR4等外围接口设计。

### Q2：Shell的接口协议是axi4吗?

不完全是。目前Shell接口使用的协议有axi4，axi4-s，axi4-l三种协议，主要和不同接口处理的数据类型不同有关。

<a name="sec_6"></a>
## 疑难解答

### Q1：如何设计出高性能高质量的代码？


通用型架构FPGA开发请参考文档https://www.xilinx.com/support/documentation/sw_manuals/xilinx2017_4/ug1207-sdaccel-optimization-guide.pdf

<a name="sec_7"></a>
## FpgaCmdEntry
### Q1: 什么是FpgaCmdEntry？

FpgaCmdEntry是用户侧在虚拟机上对分配FPGA卡进行操作的工具，该工具支持用户对FPGA卡进行镜像加载、加载状态查询、清除镜像、告警信息查询、设备信息查询、虚拟点灯状态查询和工具版本号查询等操作。

### Q2: 为什么运行FpgaCmdEntry时会出现错误"Command busy"?

**现象原因：** 

该现象是由于当前FPGA卡正在执行其它任务导致。 

**解决方法：** 

等待30s~5min之后再执行FpgaCmdEntry命令。

### Q3: 为什么运行FpgaCmdEntry加载命令时会出现错误"invalid AEI ID"?

**现象原因：** 

提示AEI ID不可用有以下三种可能原因：

1）AEI ID错误，fis服务中不存在该AEI ID对应的AEI；

2）AEI ID对应的AEI非法，例如AEI正在创建中或创建失败；

3）用户不是AEI的所有者，同时用户创建当前虚机所使用的镜像与AEI也不存在关联关系（非云市场购买的AEI）；

**解决方法：** 

1）检查ak/sk配置

典型场景：用户A在自己的虚拟机内，使用用户B的ak/sk配置fisclient，随后进行AEI注册、创建和加载。

解决方法：用户A需要使用自己的ak/sk重新配置fisclient，随后进行AEI注册、创建和加载。

2）检查AEI关联关系

典型场景：开发者在将AEI发布到云市场前，没有将AEI和虚拟机镜像进行关联操作；或者是关联错了，例如开发者关联了AEI1，但实际加载时却使用了AEI2。

解决方法：使用同一区域中任意一个用户的ak/sk配置fisclient后，使用市场镜像ID执行"fis fpga-image-relation-list --image-id xxxxxx"命令查看镜像和AEI的关联信息。如果镜像未关联AEI，需要联系市场AEI的开发者（卖家）在将市场镜像下架后，对AEI和虚拟机镜像进行关联操作。

> 镜像ID获取方法：登录天翼云进入控制台，依次选择“弹性云服务器ECS”、“镜像服务”、要查询的镜像名称获取到镜像ID。

3）检查AEI是否可用

用户需要执行"fis fpga-image-list"命令，确认AEI的状态为active后，再使用相应的AEI ID进行加载操作。如果仍不能解决，请联系天翼技术支持进行恢复。

### Q4: 为什么运行FpgaCmdEntry加载命令时会出现错误"internal error, please try FpgaCmdEntry IF -S \<slot num> for details"?

**现象原因：** 

该现象是由于当前用户无权限加载此AEI或系统错误等原因导致，出现此问题后用户需要使用"FpgaCmdEntry IF -S \<slot num>"来进一步获取失败原因。 

#### Q4.1: 为什么失败原因为"GET_AEIFILE_ERR"?

**现象原因：** 

该现象是由于从OBS桶中下载AEI文件失败导致。

**解决方法：** 

检查输入的ID与当前的服务器类型是否匹配，如果确认AEI ID与服务器类型匹配，请联系天翼技术支持进行恢复。

> 获取服务器类型方法：执行"FpgaCmdEntry IF -S \<slot num>"命令获取Shell ID。如果ID为0101xxxx，服务器为fp1型（高性能架构）云服务器；如果ID为0121xxxx，服务器类型为fp1c型或fc1c（通用型架构）云服务器。

#### Q4.2: 为什么失败原因为"AEI_CHECK_ERR"?

**现象原因：** 

该现象是由于AEI文件头校验失败导致。

**解决方法：** 

检查输入的ID与当前的服务器类型是否匹配以及当前要加载的AEI是否基于当前FPGA的SHELL ID进行编译，如果仍不能解决，请联系天翼技术支持进行恢复。

#### Q4.3: 为什么失败原因为"INVALID_AEI_ID"?

**现象原因：** 

请参考Q3现象原因。

**解决方法：** 
请参考Q3解决方法。


<a name="sec_8"></a>
## 高危操作

### Q1：在OCL SDK操作中执行xbsk test过程中按ctrl+c按键，再次执行xbsk test时会失败

禁止执行此操作。如果不小心已执行了，则需要重新安装xdma驱动才能恢复。

### Q2：在OCL SDK操作中执行example的过程中按ctrl+c按键，再次执行example时会失败

禁止执行此操作。如果不小心已执行了，则用FpgaCmdEntry工具手动执行加载一次才能恢复。


