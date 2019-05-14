# FPGA Accelerated Cloud Server Instance Feature Overview
[切换到中文版](./release_note_cn.md)


* Users can flexibly select general-purpose instances (opencl) based on their acceleration types.  

* Each user can apply for one, two, four, or eight VU9P FPGA acceleration cards.

* Interfaces available for FPGA acceleration card users are as follows:
  - `One PCIe Gen3 x16` interface    
  - `Four DDR4` RDIMM interfaces

* PCIe features are as follows:

  `Two PFs`

* Interface features between user logic and static logic are as follows:
  * The data channel from user logic to static logic uses the AXI4-MM interface with a bit width of `512 bits`.
  * The control channel from user logic to static logic uses the AXI4-Lite interface with a bit width of `32 bits`.


* The DDR interface partition is as follows:
  - One DDR controller is placed in the static logic partition.
  - Three DDR controllers are placed in the user logic partition.
  - A maximum of four DDR controllers can be used.

# Release 1.0.0

- This is the first public version of the ctyun FPGA design instance. For details about its functions, see **FPGA Design Instance Feature Overview** and **FPGA Design Instance Feature Description**.

---
# FPGA Instance Feature Description

# Contents

## 1 [Project Building](#Project Building)
## 2 [Application Tests](#Application Tests)
## 3 [Tools and Environment](#Tools and Environment)
## 4 [License Requirements](#License Requirements)
## 5 [Features To Be Supported](#Features To Be Supported)
***
<a name="Project Building"></a>
# Project Building

## Overview
Before building a project, `ensure that SDx and license are installed`. The project building aims to design a project that meets the timing requirements through the minimum modification.

## Features

* SDAccel designs

* `OpenCL, C, and C++` coding

* User configuration and command execution decoupling. To build a project, you only need to `define the project name and path`.

* PR verification

* `One-click` user directory creation

* SHELL SHA256 check


---

# Application Tests

## Overview

In the `fp1/software/` directory, there is an application project subdirectory. You can compile an application project by using script code (applications) to test features or functions of the project. For details, see readme in this directory.

---

<a name="Tools and Environment"></a>

# Tools and Environment

* The supported tools and environment are as follows:
  - Linux `centos 7.3`  
  - Xilinx `SDAccel 2017.4.op` 

---

<a name="License Requirements"></a>

# License Requirements
* The required licenses are as follows:      
  - SysGen  
  - PartialReconfiguration  
  - Simulation  
  - Analyzer  
  - HLS  
  - ap_opencl  
  - XCVU9P  
  - EncryptedWriter_v2  
  - xcvu9p_bitgen  
---
<a name="Features To Be Supported"></a>

# Features to Be Supported
* Streaming DMA (EA)
* Host accessible URAM/BRAM
* Multiple Process Support
* Embedded Scheduler
* peer to peer
