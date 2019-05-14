# FPGA Development Suite
[ÇÐ»»µ½ÖÐÎÄ°æ](./README_CN.md)

# Contents

+ [1 Introduction to the FPGA Development Suite](#sec_1)
+ [2 Preparations](#sec_2)
  + [2.1 Downloading the Development Suite](#sec_2_1)
  + [2.2 Installing and Configuring the FPGA Image Management Tool](#sec_2_2)
+ [3 Using the Development Suite](#sec_3)


<a name="sec_1"></a>
# 1 Introduction to the FPGA Development Suite
The FPGA development suite is a set of HWS-based cloud FPGA hardware/software development tools. This suite helps users to design, simulate, implement, and jointly run FPGA, and provides professional design and verification components to help users efficiently implement FPGA development. Currently, the FPGA development suite has only the fp1 development suite. The fp1 development suite consists of the hardware development suite and application development suite. The hardware development suite helps users to complete project compilation, simulation, generate the .dcp or .xclbin file, and finally register an FPGA image. The application development suite guides users to register and load an FPGA image, and compile and debug user applications.

<a name="sec_2"></a>
# 2 Preparations
Before using the FPGA development suite, you must perform operations in 2.1 and 2.2 to obtain the development suite and install and configure the tool.

<a name="sec_2_1"></a>
## 2.1 Downloading the Development Suite

+ For HTTPS connections, run the `git clone https://github.com/fpga-accel/ctyun-fpga.git` command to download the suite.

+ For SSH connections, run the `git clone git@github.com:fpga-accel/ctyun-fpga.git` command to download the suite.

> Ensure that the ECS is bound with an EIP before using the ECS to download the development suite.<br/>
> Development suite downloading depends on the Git tool. Ensure that the software is installed before downloading.

<a name="sec_2_2"></a>
## 2.2 Installing and Configuring the FPGA Image Management Tool
The fisclient is a cross-platform command-line interface (CLI) tool used for FPGA image management, which is mandatory before FPGA image loading. By using fisclient, you can perform operations such as deleting and querying FPGA images. In addition, you can manage the association between Accelerated Engine Image (AEIs) and elastic cloud server (ECS) images. You can associate an AEI with an ESC image, and release the AEI to the cloud market or share it with other users through the ESC image.

> For details about how to install and configure the management tool, see [fisclient README](./cli/fisclient/README.md).

<a name="sec_3"></a>
# 3 Using the Development Suite
The FPGA development suite is a set of cloud-based FPGA hardware and software development tools. The FP1 development suite applies to FP1 and FP1C cloud servers in scenarios such as video processing, machine learning, genomics research, and financial risk analysis. 

+ For details about the FP1 development suite, see [README.md](./fp1/README.md).

\----End
