# hardware说明

[Switch to the English version](./README.md)

<div id="table-of-contents">
<h2>目录</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. <b>子目录结构</b></a></li>
<li><a href="#sec-2">2. <b>子目录说明</b></a></li>
<li><a href="#sec-3">3. <b>天翼fpga云服务硬件开发说明</b></a>
<ul>
<li><a href="#sec-3-1">3.1. <b>申请实例</b></a></li>
</ul>
<ul>
<li><a href="#sec-3-2">3.2. <b>初始化环境变量</b></a></li>
</ul>
<ul>
<li><a href="#sec-3-3">3.3. <b>构建example</b></a></li>
</ul>
<ul>
<li><a href="#sec-3-4">3.4. <b>自定义设计</b></a></li>
</ul>
</div>
</div>

<a id="sec-1" name="sec-1"></a>

## 1. 子目录结构

- **hardware/**

  - sdaccel_design/
  - LICENSE.txt
  - version_hdk_tag.txt
  - version_note_sdaccel.txt

<a id="sec-2" name="sec-2"></a>

## 2. 子目录说明

- sdaccel_design

  本文件承载基于sdaccel开发工具套件的所有设计文件，包括库文件、源码、执行脚本等。

- LICENSE.txt

  本文件承载的是HDK的License，用户不可以对该文件内容做任何更改。

- version_hdk_tag.txt  

  上传github时的tag信息。

- version_note_sdaccel.txt  

  本文档承载的是基于sdx工具开发的静态逻辑的**版本号**，用户不可以对该文件内容做任何更改。  

<a id="sec-3" name="sec-3"></a>

## 3. 天翼fpga云服务硬件开发说明

天翼FPGA云服务提供了基于SDAccel的c/c++/opencl等语言开发模式。用户可以依据自身的情况灵活选择开发模式，并在对应的目录结构下完成自己的加速设计。

- SDAccel c/c++/opencl语言的开发模式

1.该开发模式适合有软件开发经验的用户使用。
2.支持SDAccel开发流程，用户灵活选择使用c/c++/opencl语言进行开发、仿真和测试。
3.对应的目录结构为 **sdaccel_design**。

说明：天翼fpga云服务硬件开发只能用于**centos7.3**系统，并提供了所有的设计文件和脚本，用户可以在fpga云服务器上使用预安装的工具进行**开发、仿真和[构建AEI](../docs/Register_an_FPGA_image_for_an_OpenCL_project_cn.md)**。

<a id="sec-3-1" name="sec-3-1"></a>

### 3.1  申请实例

用户使用fpga云服务之前需要**申请一个带有SDA工具和相应license的实例（通用型）**，申请参考云服务网站：http://support.huaweicloud.com/usermanual-fpga/zh-cn_topic_0069154765.html

<a id="sec-3-2" name="sec-3-2"></a>

### 3.2 初始化环境变量

说明：环境变量只需要配置一次，如果已经配置过则可以跳过此步骤（如果重新打开terminal，则需重新执行该步骤）。

1.切换到工程根目录，命令如下：*(默认工程路径位置，用户可将工程复制或者移动到其他文件夹)*

```bash
  $ cd ctyun-fpga/fp1
```

2.配置**setup.cfg**文件中的用户自定义信息，详细说明与执行步骤参见[fp1开发套件说明](../README_CN.md)中的**配置License和配置环境变量的方法**章节相关内容；

3.执行**setup.sh**设置环境变量以及工程相关依赖，命令如下：

```bash
  $ source setup.sh
```

每次执行`source setup.sh`命令时，HDK会执行以下三个步骤的检测：

1. 逐一检测所有工具的License是否已配置以及工具是否已安装（工程的初始状态是未安装的）；
2. 逐一告知工具是否已安装成功；
3. 打印出所有已安装的工具版本信息。

**注意**：如果是第一次安装本工程或者是完成版本升级，首次设置环境变量，HDK除了进行以上三步检测外还会执行以下步骤：

1. OpenCL调用SDx工具及DSA等压缩包；
2. OpenCL下载OBS桶中的DSA文件和压缩包，该过程大约需要3~5分钟，请耐心等待。

<a id="sec-3-3" name="sec-3-3"></a>

#### 3.3 构建example

用户可按照example目录下面的README.md中的指导完成工程的开发、仿真与构建。

说明：mmult_hls、vadd_cl、vadd_rtl为通用型架构的样例，功能介绍见[OCL example简介](./sdaccel_design/examples/README_CN.md)。

- mmult_hls的工程构建和仿真(暂不支持)详细步骤与说明请参见[mmult_hls用户指南](./sdaccel_design/examples/mmult_hls/README_CN.md)；

- vadd_cl的工程构建和仿真(暂不支持)详细步骤与说明请参见[vadd_cl用户指南](./sdaccel_design/examples/vadd_cl/README_CN.md)；

- vadd_rtl的工程构建仿真(暂不支持)详细步骤与说明请参见[vadd_rtl用户指南](./sdaccel_design/examples/vadd_rtl/README_CN.md)；

<a id="sec-3-4" name="sec-3-4"></a>

### 3.4 自定义设计

如果用户使用SDAccel进行开发，请在配置完成环境变量后执行以下命令：

```bash
  $ cd ctyun-fpga/fp1/hardware/sdaccel_design/user
  $ sh create_prj.sh
```
