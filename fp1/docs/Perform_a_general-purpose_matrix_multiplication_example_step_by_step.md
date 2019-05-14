# Operating a General-Purpose Matrix Multiplication Instance


# 1 Preparations

See chapter 3 in the user guide to download the development suite and install and configure the image. User guide download link:

```bash
https://static.huaweicloud.com/upload/files/pdf/20170825/20170825094528_15473.pdf
```

# 2 Matrix Multiplication Instance HDK Operation Process

##### Note:

The following uses the `ctyun-fpga/fp1/` directory as an example. The Xilinx software license provided by ctyun can be used by only the *root* account.

## 2.1 Modifying the `setup.cfg` File

Open the `setup.cfg` file in `ctyun-fpga/fp1/` and set the following parameters:

```bash
FPGA_DEVELOP_MODE="sdx"  
VIVADO_VER_REQ="2017.4.op" 
Northern China: XILINX_LIC_SETUP="2100@100.125.1.240:2100@100.125.1.245"
South China: XILINX_LIC_SETUP="2100@100.125.16.137:2100@100.125.16.138"
East China: XILINX_LIC_SETUP="2100@100.125.17.108:2100@100.125.17.109"
```

##### Note:

The `XILINX_LIC_SETUP` parameter must be set based on the location of the VM that the user applies for.

## 2.2 Making the Configuration Take Effect

Run the `ctyun-fpga/fp1/setup.sh` script for the configured development environment to take effect.

```bash
cd ctyun-fpga/fp1
export HW_FPGA_DIR=$(pwd)
source $HW_FPGA_DIR/setup.sh
```

## 2.3 Compiling the Matrix Multiplication Instance to Generate the xclbin File

```bash
cd $HW_FPGA_DIR/hardware/sdaccel_design/examples/mmult_hls/scripts
sh compile.sh hw
```
##### Note:

Skip 2.4 and 2.5 if the simulation test is not required.

## 2.4 Performing CPU Simulation for a Matrix Multiplication Instance

```bash
cd $HW_FPGA_DIR/hardware/sdaccel_design/examples/mmult_hls/scripts
sh run.sh emu ../prj/bin/mmult ../prj/bin/bin_mmult_cpu_emu.xclbin
```

## 2.5 Performing Hardware Simulation for a Matrix Multiplication Instance

```bash
cd $HW_FPGA_DIR/hardware/sdaccel_design/examples/mmult_hls/scripts
sh run.sh emu ../prj/bin/mmult ../prj/bin/bin_mmult_hw_emu.xclbin
```


# 3 Matrix Multiplication Instance SDK Operation Process


## 3.1 Registering the AEI

```bash
cd $HW_FPGA_DIR/hardware/sdaccel_design/examples/mmult_hls/scripts
sh AEI_Register.sh -p "obs_path" -o "obs_dir" -n "ocl-test" -d "ocl-desc"
```

## 3.2 Compiling the Host

```bash
cd $HW_FPGA_DIR/software/app/sdaccel_app/mmult_hls
make
```

## 3.3 Performing a Hardware Test

```bash
sh run.sh mmult $HW_FPGA_DIR/hardware/sdaccel_design/examples/mmult_hls/prj/bin/sdk_aeiid.xclbin 0
```

##### Note:

The `run.sh` script contains the file loading and hardware test operations. Therefore, you do not need to load the file manually.