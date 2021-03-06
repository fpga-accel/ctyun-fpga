使用基于SDAccel的Example
========================

[Switch to the English version](./Using_an_SDAccel_based_Example.md)

功能描述
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SDAccel Example示例实现基于SDAccel的仿真及硬件测试流程。本例基于mmult_hls示例说明，其他示例如vadd_cl、 vadd_rtl等示例操作参见mmult_hls。  

使用SDAccel HDK
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SDAccel HDK主要完成SDAccel开发流程的编译和仿真部分，需要在SDAccel编译环境下运行。用户申请SDAccel开发环境，登录VM，从github上获取最新的开发套件fp1完整目录，建议存放在“ctyun-fpga”目录下。本文档基于"ctyun-fpga/fp1/"目录说明。

### 使用步骤如下所示

1.  进入SDAccel开发编译环境。

##### 说明:

  编译环境必须包含：  
  fp1开发目录（配置部分和hardware必需，其他可选）。  
  SDx开发工具。

2.  设置EDA工具License。

  用户打开“ctyun-fpga/fp1/”路径下的“setup.cfg”文件，将文件中XILINX_LIC_SETUP的值配置为License服务器的IP地址。设置FPGA_DEVELOP_MODE="sdx"；VIVADO_VER_REQ="2017.4.op"

```bash
FPGA_DEVELOP_MODE="sdx"  
VIVADO_VER_REQ="2017.4.op" 

华北：
XILINX_LIC_SETUP="2100@100.125.1.240:2100@100.125.1.245"

华南：
XILINX_LIC_SETUP="2100@100.125.16.137:2100@100.125.16.138"

华东：
XILINX_LIC_SETUP="2100@100.125.17.108:2100@100.125.17.109"
```

##### 说明:
  天翼提供的Xilinx软件License *仅限root账号* 使用。

3.  配置开发环境。

  执行**ctyun-fpga/fp1/setup.sh**脚本完成硬件开发环境的配置。

  	cd ctyun-fpga/fp1
  	export HW_FPGA_DIR=$(pwd)
  	source $HW_FPGA_DIR/setup.sh
##### 说明:
  参见目录ctyun-fpga/fp1/README、配置环境部分。

4. 编译example。
   ```
   cd $HW_FPGA_DIR/hardware/sdaccel_design/examples/mmult_hls/scripts
   sh compile.sh compile_mode
   ```

##### 说明:
   以下步骤的命令都可以通过–h参数获取帮助信息。  
   *compile_mode*为三种编译模式，对应可选择：  
   cpu_em ------------ cpu仿真模式，编译结束生成bin_mmult_cpu_emu.xclbin  
   hw_em ------------- 硬件仿真模式，编译结束生成bin_mmult_hw_emu.xclbin   
   hw ------------------ 硬件编译模式，编译结束生成bin_mmult_hw.xclbin   
   用户根据自身需求选择对应编译模式即可。  
   具体使用方法请参考[示例介绍](../hardware/sdaccel_design/examples/mmult_hls/README_CN.md)。

5.  仿真example。

进行mmult的cpu_em仿真编译：


   ```
    cd $HW_FPGA_DIR/hardware/sdaccel_design/examples/mmult_hls/scripts
    sh run.sh emu ../prj/bin/mmult ../prj/bin/bin_mmult_cpu_emu.xclbin
   ```

进行mmult的hw_em仿真编译：

   ```
    cd $HW_FPGA_DIR/hardware/sdaccel_design/examples/mmult_hls/scripts
    sh run.sh emu ../prj/bin/mmult ../prj/bin/bin_mmult_hw_emu.xclbin
   ```

##### 说明:

   `emu`为compile_mode

   `../prj/bin/mmult`为编译生成的主机程序（硬件编译模式不支持仿真）：  
   mmult_hls示例 -------------------------- 对应主机程序为mmult  
   vadd_cl示例 ----------------------------- 对应主机程序为vadd  
   vadd_rtl示例 ----------------------------- 对应主机程序为host

   `../prj/bin/bin_mmult_hw_emu.xclbin`为编译生成的xclbin文件,不同的编译模式对应不同的xclbin文件：  
   *compile_mode*为cpu_em ----------- 对应选择bin_mmult_cpu_emu.xclbin  
   *compile_mode*为hw_em ------------ 对应选择bin_mmult_hw_emu.xclbin  

   不需要仿真测试时，请跳过本步骤。

6. 硬件测试。

  按照步骤4选择hw模式编译并生成xclbin文件。

##### 说明:

xclbin文件名称需要用户根据自己的具体名称进行相应调整。


使用SDAccel SDK
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

##### 说明:

在生成xclbin文件后，需要先完成[AEI注册](./Register_an_FPGA_image_for_an_OpenCL_project_cn.md)及SDK编译后才能使用SDK。

SDAccel的SDK平台主要实现对硬件的测试，需要在执行环境下编译host程序并运行，本部分内容以mmult_hls实例为例作使用方法介绍。

1.  进入SDAccel开发执行环境。

##### 说明:

  执行环境必须包含：  
  fp1开发目录（配置部分和software必需，其他可选）。  
  SDx开发工具。  
  SDAccel硬件。

2. 配置执行环境。

  执行ctyun-fpga/fp1/setup.sh脚本完成硬件开发环境的配置。

  	cd ctyun-fpga/fp1
  	export SW_FPGA_DIR=$(pwd)
  	source $SW_FPGA_DIR/setup.sh
##### 说明:

  参见目录ctyun-fpga/fp1/README_CN.md配置环境部分。

3.  进入主机应用程序所在文件目录。

    cd $SW_FPGA_DIR/software/app/sdaccel_app

4.  编译host。

  进入示例host所在目录，执行make，生成相应的可执行文件mmult。

  	cd $SW_FPGA_DIR/software/app/sdaccel_app/mmult_hls
  	make

##### 说明:

  编译不同示例生成各示例对应的主机程序：  
  mmult_hls示例 -------------------------- 对应主机程序为mmult  
  vadd_cl示例 ----------------------------- 对应主机程序为vadd  
  vadd_rtl示例 ----------------------------- 对应主机程序为vadd

5.  硬件测试。

  执行run.sh完成硬件的加载与测试，具体步骤如下：

  	cd $SW_FPGA_DIR/software/app/sdaccel_app/mmult_hls
  	sh run.sh mmult $SW_FPGA_DIR/hardware/sdaccel_design/examples/mmult_hls/prj/bin/sdk_aeiid.xclbin 0

上面run.sh脚本末尾的0表示slot号，该号在用户申请环境时得到。比如用户申请了一个带4张FPGA加速卡的虚拟机环境，则slot号为0、1、2、3。

##### 说明:

  run.sh具体使用请执行sh run.sh -h查看。  
