# Hardware Description

[切换到中文版](./README_CN.md)

<div id="table-of-contents">
<h2>Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">1. <b>Subdirectory Structure</b></a></li>
<li><a href="#sec-2">2. <b>Subdirectory Description</b></a></li>
<li><a href="#sec-3">3. <b>Description of FAC-Based Hardware Development</b></a>
<ul>
<li><a href= "#sec-3-1" >3.1. <b>Applying for an Example</b></a></li>
</ul>
<ul>
<li><a href= "#sec-3-2" >3.2. <b>Initializing Environment Variables</b></a></li>
</ul>
<ul>
<li><a href= "#sec-3-3" >3.3. <b> Building an Example</b></a></li>
</ul>
<ul>
<li><a href= "#sec-3-4" >3.4. <b>Customizing Design</b></a></li>
</ul>
</ul>
</div>
</div>

<a id="sec-1" name="sec-1"></a>

## 1 Subdirectory Structure

- **hardware/**

  - sdaccel_design/
  - LICENSE.txt
  - version_hdk_tag.txt
  - version_note_sdaccel.txt

<a id="sec-2" name="sec-2"></a>

## 2 Subdirectory Description


- sdaccel_design

  This folder stores all SDAccel-based designs, including library files and folders, source code, and execution scripts.

- LICENSE.txt

  This is the license file of the HDK. Do not modify the contents of this file.


- version_hdk_tag.txt

- This document records tags information when the HDK is uploaded to the github.

- version_note_sdaccel.txt

  This document describes the **version** of SDx-based static logic. Do not modify the contents of this file.  

<a id="sec-3" name="sec-3"></a>

## 3 Description of FAC-Based Hardware Development

ctyun FPGA Accelerated Cloud (FAC) services provide SDAccel-based development mode using C, C++, and OpenCl. You can flexibly choose a development mode as required and complete the acceleration design in the corresponding directory structure.

- SDAccel Development Mode Using C, C++, and OpenCl

1. This development mode is applicable to users with software development experience.
2. It supports the SDAccel development process. You can use C, C++, and OpenCl for development, simulation, and testing.
3. The corresponding directory structure is **sdaccel_design**.

**Note**

FAC-based hardware development can be implemented only in the **CentOS 7.3** system and all designing files and scripts are available. You can use the preinstalled tools to **develop, simulate, and [build AEIs](../docs/Register_an_FPGA_image_for_an_OpenCL_project.md)** on the FPGA cloud server.

<a id="sec-3-1" name="sec-3-1"></a>

### 3.1 Applying for an Example

Before using the FAC services, **apply for an example of general-purpose structures with the SDA tool and corresponding license**. For details, visit http://support.huaweicloud.com/usermanual-fpga/zh-cn_topic_0069154765.html.

<a id="sec-3-2" name="sec-3-2"></a>

### 3.2 Initializing Environment Variables

**Note**

Skip this step if you have configured environment variables.

1. Switch to the root directory of the project. The command is as follows: *(The following shows the default directory. You can copy or move a project to another folder.)*

```bash
  $ cd ctyun-fpga/fp1
```

2. Configure user-defined information in the **setup.cfg** file. For details, see "Configuring the License File and Environment Variables" in [fp1 Development Suite Description](../README.md).

3. Run the **setup.sh** command to configure environment variables and project dependencies:

```bash
  $ source setup.sh
```

Each time the `source setup.sh` command is executed, the HDK executes the following steps:

1. Check whether the license files of all tools are configured and whether the tools are installed. (By default, the tools and license are not installed.)
2. Notify users whether the tools are installed.
3. Print version information about all installed tools.

**Note**

If the project is installed for the first time or the version is upgraded, in addition to the preceding three steps, the HDK executes the following steps:

1. OpenCL calls SDX tools and DSA and other compressed packages.
2. OpenCL downloads DSA files and archives in OBS buckets.This process takes about three to five minutes.

<a id="sec-3-3" name="sec-3-3"></a>

#### 3.3 Building an Example

You can develop, simulate, and build a project by following the instructions provided in **README.md** in the **example** directory.

**Notes**

mmult_hls, vadd_cl, and vadd_rtl are examples of general-purpose architectures. For details, see [Introduction to OCL Examples](./sdaccel_design/examples/README.md).

- For details about how to build and simulate the project of mmult_hls (reserved), see [mmult_hls User Guide](./sdaccel_design/examples/mmult_hls/README.md).

- For details about how to build and simulate the project of vadd_cl (reserved), see [vadd_cl User Guide](./sdaccel_design/examples/vadd_cl/README.md).

- For details about how to build and simulate the project of vadd_rtl (reserved), see [vadd_rtl User Guide](./sdaccel_design/examples/vadd_rtl/README.md).

<a id="sec-3-4" name="sec-3-4"></a>

### Customizing Design

If you use SDAccel for development, configure the environment variables, and then run the following commands:

```bash
  $ cd ctyun-fpga/fp1/hardware/sdaccel_design/user
  $ sh create_prj.sh
```

