# Ctyun FPGA - Frequently Asked Questions
[切换到中文版](./FAQs_cn.md)

# Contents
[Overview](#sec_1) 

[Application Market](#sec_2)

[Development Language](#sec_3)

[FPGA](#sec_4)

[FPGA Shell](#sec_5) 

[Troubleshooting](#sec_6)

[FpgaCmdEntry](#sec_7)

[High-Risk Operations](#sec_8)

<a name="sec_1"></a>
## Overview

### Q1：What Is HDK?

HDK is short for Hardware Development Kit. 

### Q2：What Is SDK?

SDK is short for Software Development Kit. The SDK provides FPGA example running environment, drivers, tools, and applications.

<a name="sec_2"></a>
## Application Market
### Q1：What is ctyun FPGA Marketplace?

FPGA developers can share or sell their AEI files to other FPGA users on the ctyun FPGA Marketplace. 

<a name="sec_3"></a>
## Development Language
### Q1：What development languages does ctyun FPGA support?

Currently, the ctyun FPGA has a general type (OpenCL). OpenCL is developed by using the C language.

<a name="sec_4"></a>
## FPGA
### Q1：What is the FPGA model used by ctyun FPGA?

Currently, ctyun FPGA uses Xilinx UltraScale+ series xcvu9p-flgb2104-2-i cards.

<a name="sec_5"></a>
## FPGA Shell

### Q1：How can I design high-performance and high-quality code?


For details about the FPGA development of the general-purpose architecture, see the SDAccel Environment Profiling and Optimization Guide (https://www.xilinx.com/support/documentation/sw_manuals/xilinx2017_4/ug1207-sdaccel-optimization-guide.pdf).

<a name="sec_7"></a>
## FpgaCmdEntry
### Q1：What is FpgaCmdEntry?

FpgaCmdEntry is a tool used to operate the FPGA card on the VM. The tool allows users to load, clear, and query information on the FPGA card.

### Q2："Command busy" was displayed when I ran the FpgaCmdEntry command. What Do I Do?

**Causes:** 

The FPGA card is performing other tasks. 

**Solutions:** 

Wait for 30 seconds to 5 minutes and then run the FpgaCmdEntry command again.

### Q3："invalid AEI ID" was displayed when I ran the FpgaCmdEntry loading command. What Do I Do?

**Causes:** 
The AEI ID entered by the user is different from the AEI ID in the OBS bucket. 

**Solutions:** 

Check whether the AEI ID is correct and try again. If the problem persists, contact FusionSphere O&M personnel for support.

### Q4："internal error, please try FpgaCmdEntry IF -S <slot num> for details" was displayed when I ran the FpgaCmdEntry loading command. What Do I Do?

**Causes:** 

The AEI file header or AEI file imported by the user is incorrect. 

**Solutions:** 

Verify that the AEI loading file and registration process are normal according to the README file on GitHub, and that the registration tool is the latest version. Register the AEI ID again and run the loading command. If the problem persists, contact FusionSphere O&M personnel for support.

<a name="sec_8"></a>
## High-Risk Operations

### Q1：When I pressed Ctrl+C during the execution of xbsk test in OCL SDK, xbsk test failed to be executed again. What do I do?

This operation is prohibited. If you have performed this operation, reinstall the XDMA driver to rectify the fault.

### Q2：When I pressed Ctrl+C during the example execution in OCL SDK, the example failed to be executed again. What do I do?

This operation is prohibited. If you have performed this operation, use FpgaCmdEntry to manually load the example again to rectify the fault.


