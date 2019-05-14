#!/bin/bash
#
#-------------------------------------------------------------------------------
#      Copyright 2018 Huawei Technologies Co., Ltd. All Rights Reserved.
# 
#      This program is free software; you can redistribute it and/or modify
#      it under the terms of the Huawei Software License (the "License").
#      A copy of the License is located in the "LICENSE" file accompanying 
#      this file.
# 
#      This program is distributed in the hope that it will be useful,
#      but WITHOUT ANY WARRANTY; without even the implied warranty of
#      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#      Huawei Software License for more details. 
#-------------------------------------------------------------------------------

# Print animation '.' for processing
function dots_process () {
    seconds=1
    while :
    do
        sleep $seconds
        echo -n '.'
        if [ -f $WORK_DIR/.find_tmp ] ; then
            exit 0
        fi
    done
}

# Print animation '-, \, |, /' for processing
function rotate_process () {
    INTERVAL=0.5
    RCOUNT="0"
    while : ; do
        ((RCOUNT = RCOUNT + 1))
        case $RCOUNT in
            1)  echo -e '-\b\c'
                sleep $INTERVAL
                ;;
            2)  echo -e '\\\b\c'
                sleep $INTERVAL
                ;;
            3)  echo -e '|\b\c'
                sleep $INTERVAL
                ;;
            4)  echo -e '/\b\c'
                sleep $INTERVAL
                ;;
            *) RCOUNT=0
                ;;
        esac
    done
}

function stop_process () {
    if [ ! -f $WORK_DIR/.find_tmp ] ; then
        touch -f $WORK_DIR/.find_tmp
    fi
}

# Check and split software dir
function check_soft_dir () {
    if [ $# -lt 1 ] ; then
        echo ""
    elif [ -d $1 ] ; then
        echo $1
    else
        soft_dir_tmp=(${1//:/ })
        if [ ${#soft_dir_tmp[@]} -lt 1 ] ; then
            echo ""
        else
            echo ${soft_dir_tmp[@]}
        fi
    fi
}

# Check whether more than one software detected
# If more than one software detected, return first result.
function check_more_soft () {
    if [ $# -lt 1 ] ; then
        echo ""
    elif [ ! -f $1 ]; then
        echo $1 | awk {'print $1'}
    else
        echo $1
    fi
}

# Show usage info
function usage () {
    echo  -e "\e[0;35m Usage: source setup.sh / -c / --clean \e[0m"
    echo  -e "\e[0;35m Setup hardware develop environment. \e[0m"
    echo  -e "\e[0;35m example: source setup.sh \e[0m"
    echo  -e "\e[0;35m \e[0m"
    echo  -e "\e[0;35m Parameter: \e[0m"
    echo  -e "\e[0;35m         -h / --help          Print usage info \e[0m"
    echo  -e "\e[0;35m         -c / --clean         Clean all tmp files and simulation library if exists \e[0m"
}

# Touch empty file to stop subprocess
trap "stop_process" 1 2 3 15

# Set environment varible
export WORK_DIR=$(cd $(dirname ${BASH_SOURCE[0]});pwd )

default_cfg="$WORK_DIR/setup.cfg"
setup_cfg=$default_cfg

default_soft_dir="/software"
soft_dir=$default_soft_dir
soft_dir_userdef=0

vivado_ver_req="2017.4.op"

script_name=${BASH_SOURCE[0]}

# Judge which method that scripts run
if [ $script_name == $0 ] ; then
    # using 'sh ./setup.sh' or './setup.sh' 
    script_exec=1
else
    # using 'source ./setup.sh' or '. ./setup.sh' 
    script_exec=0
fi

quit_script=0
user_permit=""
usercfg_file=""
userlic_cfg=""
xilinxuser_req=""
fpga_dev_mode=0
verbose_mode=0

function info_show() {
    if [ $verbose_mode -ne 0 ] ; then
        echo "$1"
    fi
}

function info_show_n() {
    if [ $verbose_mode -ne 0 ] ; then
        echo -n "$1"
    fi
}

function info_show_e() {
    if [ $verbose_mode -ne 0 ] ; then
        echo -e "$1"
    fi
}

# Check whether or not user specified the software installation directory
if [ $# -lt 1 ] ; then
    soft_dir=$default_soft_dir
else

    while [ "$1" != "" ]; do
        case $1 in
            -h | -H | -help | --help ) 
                usage
                quit_script=1
                break
                ;;
            -u | -usercfg | --usercfg )
                shift
                usercfg_file=$1
                ;;
            -s | -su | --su )
                shift
                user_permit=$1
                ;;
            -l | -license | --license )
                shift
                userlic_cfg=$1
                ;;
            -xr | -xilinxreq | --xilinxreq )
                shift
                xilinxuser_req=$1
                ;;
            -x | -usesdx | --usesdx )
                fpga_dev_mode=1
                ;;
            -v | -verbose | --verbose )
                verbose_mode=1
                ;;
            *)
                soft_dir=`check_soft_dir $1`
                if [ "x$soft_dir" == "x" ] ; then
                    echo -e "\e[0;33m Info: Software directory does not ever exist, using $default_soft_dir as default. \e[0m"
                else
                    soft_dir_userdef=1
                fi
                ;;
        esac
        shift
    done
fi

fiscfg=$(readlink -f ~/.fiscfg)
#judge the $fiscfg is exist or not
if [ ! -f "$fiscfg" ];then
    echo "ERROR:Config file of fisclient does not exist "
    echo
    quit_script=1
fi

# If using source xxx, error will not cause quit of shell.
if [ $quit_script == 1 -a $script_exec == 0 ] ; then
    return
elif [ $quit_script == 1 ] ; then
    exit
fi

# Load setup.cfg file
if [ "x$usercfg_file" != "x" ] ; then
    setup_cfg=$userlic_cfg
fi

source $setup_cfg
# Check user permission
if [ "x$user_permit" == "x" -a "x$USER_PERMISSION" == "x" ] ; then
    user_permit="root"
elif [ "x$user_permit" == "x" ] ; then
    user_permit=$USER_PERMISSION
fi

id $user_permit > /dev/null 2>&1
user_exists=`echo $?`
cur_user=`whoami`

if [ $user_exists -eq 1 ] ; then
    echo -e "\e[0;34m Error: User '$cur_user' was not existed. Please check and select a valid user. \e[0m"
    quit_script=1
elif [ $user_permit != $cur_user -a $cur_user != "root" ] ; then
    # If user is root, give user permission no matter what user_permit is.
    echo -e "\e[0;34m Error: User '$cur_user' was not permitted. Only '$user_permit' have permission to run this scripts. \e[0m"
    quit_script=1
fi

# Check user write permission
if [ $quit_script -eq 0 -a -f $WORK_DIR/.test_permit ] ; then
    rm -f $WORK_DIR/.test_permit
    if [ -f $WORK_DIR/.test_permit ] ; then
        echo -e "\e[0;34m Error: Current user '$cur_user' do not have write permission for this  directory. Please add write permission. \e[0m"
        quit_script=1
    fi
fi

if [ $quit_script -eq 0 ] ; then
    touch -f $WORK_DIR/.test_permit
    if [ -f $WORK_DIR/.test_permit ] ; then
        # User have write permission
        rm -f $WORK_DIR/.test_permit
    else
        echo -e "\e[0;34m Error: Current user '$cur_user' do not have write permission for this  directory. Please add write permission. \e[0m"
        quit_script=1
    fi
fi

# If using source xxx, error will not cause quit of shell.
if [ $quit_script == 1 -a $script_exec == 0 ] ; then
    return
elif [ $quit_script == 1 ] ; then
    exit
fi

# Load user license cfg
if [ "x$userlic_cfg" != "x" ] ; then
    vivado_lic=$userlic_cfg
elif [ "x$XILINX_LIC_SETUP" != "x" ] ; then
    vivado_lic=$XILINX_LIC_SETUP
else
    echo -e "\e[0;34m Error: No user-define license find,  sdx can not start, please check the Xilinx license setup. \e[0m"
    quit_script=1
fi

# Load soft_dir
if [ $soft_dir_userdef -eq 1 ] ; then
    # Do nothing
    soft_dir=$soft_dir
elif [ "x$SOFT_INSTALL_DIR" != "x" ] ; then
    if [ -d $SOFT_INSTALL_DIR ] ; then
        soft_dir=$SOFT_INSTALL_DIR
    fi
fi

# Check whether software directory exists
if [ ! -d $soft_dir ] ; then
    echo -e "\e[0;34m Error: No software directory $soft_dir detected, please check the directory. \e[0m"
    quit_script=1
fi

if [ "x$VIVADO_VER_REQ" != "x2017.4.op" -a "x$VIVADO_VER_REQ" != "x" ] ; then
    echo "Error: VIVADO_VER_REQ is not 2017.4.op"
    return
fi
	
# Load Xilinx User Version Request
if [ "x$xilinxuser_req" != "x" ] ; then
    vivado_ver_req=$xilinxuser_req
elif [ "x$VIVADO_VER_REQ" != "x" ] ; then
    vivado_ver_req=$VIVADO_VER_REQ
fi

# If using source xxx, error will not cause quit of shell.
if [ $quit_script == 1 -a $script_exec == 0 ] ; then
    return
elif [ $quit_script == 1 ] ; then
    exit
fi

# Show Fpga Develop Mode
if [ $fpga_dev_mode == 1 -o $FPGA_DEVELOP_MODE == "sdx" ] ; then
    dev_mode_name="sdx"
else
    echo "Error: Fpga develop mode is '$FPGA_DEVELOP_MODE' , The correct configuration is sdx"
    return
fi

echo
echo "---------------------------------------------------"
echo
echo "Fpga develop mode is $dev_mode_name."

# Get software info
echo
echo "---------------------------------------------------"
echo

echo -n "Checking software information."

if [ -f $WORK_DIR/.find_tmp ] ; then
    rm -f $WORK_DIR/.find_tmp
fi

# Using subprocess to aviod usless info
(dots_process &)

# Autoscan can be bypassed by user to avoid searching the directory.
# It is recommonded that user should enable 'SOFT_AUTO_SCAN' to find the software install information if not too many softwares installed
if [ "x$SOFT_AUTO_SCAN" == "xyes" ] ; then
    if [ "x$vivado_ver_req" == "x2017.4.op" ] ; then
        find $soft_dir/ -type f -name "vsim" -o -type f -name "sdx" > $WORK_DIR/.tmp
    fi
else
    # Redirect all software install directory into '.tmp' file
    echo "$VIVADO_INS_DIR" >  $WORK_DIR/.tmp
fi

mv -f $WORK_DIR/.tmp $WORK_DIR/.find_tmp
sleep 1
echo
echo
echo "---------------------------------------------------"
echo

echo -n "Checking software license."
# Get license info
lic_info=(${LM_LICENSE_FILE//:/ })
echo "."
echo
echo "---------------------------------------------------"
echo

# Get sdx directory
echo "Checking sdx information..."
echo

echo "---------------------------------------------------"
echo

info_show_n "Checking whether sdx environment has been set : "
if [ $fpga_dev_mode -eq 1 -o $FPGA_DEVELOP_MODE == "sdx" ] ; then
    vivado_info=`which vivado 2> /dev/null | grep SDx`
    vivado_name="sdx"
fi

if [ "x$vivado_info" == "x" ] ; then
    if [ $fpga_dev_mode -eq 0 -a $FPGA_DEVELOP_MODE == "sdx" ] ; then
        vivado_info=`cat $WORK_DIR/.find_tmp | grep sdx | grep $vivado_ver_req | grep -v unwrapped | grep SDx | sort -r`        
    fi
    info_show_e "\e[0;33m have not been set \e[0m"
    info_show_e "\e[0;32mStart setup sdx environment \e[0m"

    # Check sdx info and add sdx to path
    info_show_n "Checking whether sdx install correctly : "
    if [ "x$vivado_info" != "x" ] ; then
        info_show_e "\e[0;32m ok \e[0m"
        # Check whether more than one sdx software detected
        vivado_info=`check_more_soft $vivado_info`
        vivado_dir=${vivado_info%%/bin*}
        if [ $fpga_dev_mode -eq 1 -o $FPGA_DEVELOP_MODE == "sdx" ] ; then
            vivado_dir=${vivado_dir%%/Vivado}
        fi
        info_show_n "Setup sdx environment : "
        # Config sdx environment
        source $vivado_dir/settings64.sh $vivado_dir > /dev/null
        info_show "sdx installed in $vivado_dir"
        info_show_e "\e[0;32mFinish setup sdx environment \e[0m"
        echo "Setup $vivado_name environment successful"
    else
        info_show_e "\e[0;34m fail \e[0m"
        echo "Error: No $vivado_name software find, please make sure the $vivado_name has install correctly!"
        echo "Setup $vivado_name environment fail"
        quit_script=1
    fi
else
    info_show_e "\e[0;32m have been set  \e[0m"
    info_show "sdx environment has been set correctly, skip"
    echo "Setup $vivado_name environment successful"
fi

# If using source xxx, error will not cause quit of shell.
if [ $quit_script == 1 -a $script_exec == 0 ] ; then
    return
elif [ $quit_script == 1 ] ; then
    exit
fi

# Config sdx license sever
vivado_lic_exist=0
info_show_n "Check whether sdx license has been set : "
for lic in ${lic_info[@]} ; do
    if [ $lic == $vivado_lic ] ; then
        vivado_lic_exist=1
        info_show_e "\e[0;32m has been set \e[0m"
        break
    fi
done

if [ $vivado_lic_exist != 1 ] ; then
    export LM_LICENSE_FILE=$vivado_lic:$LM_LICENSE_FILE
    info_show_e "\e[0;33m no \e[0m"
    info_show "Set sdx license successful."
fi

# Check sdx version
vivado_ver=`vivado -version | grep Vivado | awk {'print $2'}`
if [ $fpga_dev_mode -eq 1 -o $FPGA_DEVELOP_MODE == "sdx" ] ; then
    vivado_ver_req="$vivado_ver_req"
fi
if [ x$vivado_ver != "xv$vivado_ver_req" ] ; then
    echo "Error: sdx version not matched, only support sdx$vivado_ver_req!"
    quit_script=1
fi

# If using source xxxxx, error will not cause quit of shell.
if [ $quit_script == 1 -a $script_exec == 0 ] ; then
    return
elif [ $quit_script == 1 ] ; then
    exit
fi

# Add execute permission for all simulation scripts
rm -f $WORK_DIR/.find_tmp
###################################################################################################
#check gcc and sudo 
###################################################################################################
#check gcc
echo "Check the gcc/sudo information..."
gcc_info=`which gcc 2>/dev/null`
if [ -z "$gcc_info" ]; then
    echo "ERROR: gcc has not been installed."
    quit_script=1
fi
#check sudo
sudo_info=`which sudo 2>/dev/null`
if [ -z "$sudo_info" ]; then
    echo "ERROR: sudo is not in path or not installed. Driver installations will fail "
    echo "To install drivers please add sudo to your path or install sudo by running \"yum install sudo\" as root "
    quit_script=1
fi

echo
echo "---------------------------------------------------"
echo

if [ $quit_script == 1 -a $script_exec == 0 ] ; then
     return
elif [ $quit_script == 1 ] ; then
     exit
fi
###################################################################################################
#check the fpga_tool
###################################################################################################
bonding_log=/var/log/fpga/install_driver.log
mkdir -p ${bonding_log%/*}

export FPGA_TOOL_DIR_LOGIC=$WORK_DIR/../cli/fpga_tool
echo "Checking fpga tool information..."

if [ -f "/usr/lib64/libfpgamgmt.so" -a -f "$FPGA_TOOL_DIR_LOGIC/dist/FpgaCmdEntry" ];then
    echo "Fpgatool had been installed successfully, do not need to reinstall"
else
    cd $FPGA_TOOL_DIR_LOGIC
    sh fpga_tool_setup.sh > /dev/null 2>&1
    RET=$?
    if [ $RET != 0 ];then
        echo "ERROR: Install fpga tool failed."
        quit_script=1
    fi
    if [ $quit_script != 1 ];then
        echo "Install fpga tool successful"
    fi
    cd $WORK_DIR
fi

echo
echo "---------------------------------------------------"
echo
###################################################################################################
#check the driver
###################################################################################################
if [  "$dev_mode_name" == "sdx" ];then
    echo "Check the driver status..."
    sh $WORK_DIR/software/platform_config/sdaccel_cfg/sdaccel_env_cfg.sh > $bonding_log  2>&1 
    if [ $? == 0 ];then
        echo "SDAccel configuration successful!"
    else
        echo "ERROR: SDAccel configuration failed! please check $bonding_log!"
        quit_script=1
    fi
fi

echo
echo "---------------------------------------------------"
echo

if [ $quit_script == 1 -a $script_exec == 0 ] ; then
     return
elif [ $quit_script == 1 ] ; then
     exit
fi

####################################################################################################
#download file from OBS
####################################################################################################
#check the OBS_URL
echo "Check the OBS url..."

OBS_URL=`cat $fiscfg |grep "OS_OBS_ENDPOINT"|tr -d "OS_OBS_ENDPOINT ="`
OS_REGION=`cat $fiscfg |grep "OS_REGION_ID"|tr -d "OS_REGION_ID ="`
if [ -n "$OBS_URL" ];then
    if [ -z "$OS_REGION" ];then
        echo "ERROR:The configuration of $fiscfg is incorrect,please check OS_REGION_ID"
        quit_script=1
    else
        OBS_URL="https://$OBS_URL/ctyun-fpga-$OS_REGION"
    fi
else
    echo "ERROR:The configuration of $fiscfg is incorrect,please check OS_OBS_ENDPOINT"
    quit_script=1
fi

#if the URL is empty,quit the script
if [ $quit_script == 1 -a $script_exec == 0 ] ; then
     return
elif [ $quit_script == 1 ] ; then
     exit
fi
#
obs_shell_dir=$OBS_URL/fp1
#get the obs version and local version
if [  "$dev_mode_name" == "sdx" ];then
    if [ "x$vivado_ver_req" == "x2017.4.op" ] ; then
        declare -a download_file_list=("huawei_vu9p_dynamic_fp1_5_0.tar.gz"
                                        "huawei_vu9p_dynamic_fp1_5_0.sha256"
                                    )
        version_name=version_note_sdaccel.txt
        shell_mode=hardware/sdaccel_design
        local_shell_file=huawei_vu9p_dynamic_fp1_5_0.dsa
        local_shell_dir=$WORK_DIR/hardware/sdaccel_design/lib/platform/huawei_vu9p_dynamic_fp1_5_0
        declare -a local_file_sha256=("`cat $local_shell_dir/huawei_vu9p_dynamic_fp1_5_0.dsa $local_shell_dir/huawei_vu9p_dynamic_fp1_5_0.spfm $local_shell_dir/huawei_vu9p_dynamic_fp1_5_0.xpfm 2>/dev/null|sha256sum|awk '{print $1}'`")
        declare -a download_file_name=("dsa" "pfm")
    fi
fi

obs_version_note=`curl -k -s --retry 3 $obs_shell_dir/hardware/$version_name`
local_version_note=`cat $WORK_DIR/hardware/$version_name 2> /dev/null`
#download the version note Failed
if [ -n "`echo $obs_version_note | grep '<?xml version'`" -o "x$obs_version_note" == "x" ];then
     echo -e "ERROR:Failed to get $version_name from \e[0;36m$obs_shell_dir \e[0m"
     quit_script=1
 fi
#if verion is eq
if [ $quit_script != 1 ];then
    if [ "x$local_version_note" == "x" ];then
        quit_script=1
        echo "ERROR:Your project is Incomplete,please update your Project"
    elif [ "$obs_version_note" != "$local_version_note" ];then
        echo  "Info:your local version is different with the OBS latest version, local version is $local_version_note, OBS latest version is $obs_version_note"
    fi
fi
#If vresion not match , error will not cause quit of shell.
if [ $quit_script == 1 -a $script_exec == 0 ] ; then
    echo
    echo "---------------------------------------------------"
    echo
    return
elif [ $quit_script == 1 ] ; then
    echo
    echo "---------------------------------------------------"
    echo
    exit
fi
#if download?
to_download_file=0
if [ -f "$local_shell_dir/$local_shell_file" ];then
    for ((i=0;i<${#local_file_sha256[*]};i++))
    do
        obs_dcp_sum=`curl -k -s --retry 3 $obs_shell_dir/$shell_mode/$obs_version_note/${download_file_list[(2*$i+1)]}`
        if [ -n "`echo $obs_dcp_sum | grep '<?xml version'`" ];then
            echo -e "ERROR:Failed to get ${download_file_list[(2*$i+1)]} from \e[0;36m$obs_shell_dir/$shell_mode/$obs_version_note/ \e[0m"
            quit_script=1
            break
        fi
        if [ "${local_file_sha256[$i]}" != "$obs_dcp_sum" -a $quit_script != 1 ];then
            to_download_file=1
            break
        fi 
    done
else
    to_download_file=1
fi
#download_file
if [ $to_download_file -eq 1 -a $quit_script != 1 ];then
    echo -e "Download the \e[0;32m ${download_file_name[0]}\e[0m and \e[0;32m ${download_file_name[1]}\e[0m files..."
    cd $local_shell_dir  >/dev/null
    (
    for files in "${download_file_list[@]}"
    do 
        curl -k -s -O --retry 3 $obs_shell_dir/$shell_mode/$obs_version_note/$files &
    done
    wait
    )
    tar zxvf *.tar.gz >/dev/null
    if [ $? != 0 ];then
        echo -e "Failed to download the ${download_file_list[$i]} "
        quit_script=1

    fi
    if [ $quit_script != 1 ];then
        if [ "$dev_mode_name" == "sdx"  ];then
            if [ "x$vivado_ver_req" == "x2017.4.op" ] ; then
                declare -a download_file_sha256=("`cat $local_shell_dir/huawei_vu9p_dynamic_fp1_5_0.dsa $local_shell_dir/huawei_vu9p_dynamic_fp1_5_0.spfm $local_shell_dir/huawei_vu9p_dynamic_fp1_5_0.xpfm 2>/dev/null|sha256sum |awk '{print $1}'`")
            fi
        fi
        for ((i=0;i<${#download_file_sha256[*]};i++))
        do
            obs_dcp_sum=`curl -k -s --retry 3 $obs_shell_dir/$shell_mode/$obs_version_note/${download_file_list[(2*$i+1)]}`
            if [ -n "`echo $obs_dcp_sum | grep '<?xml version'`" ];then
                echo -e "ERROR:Failed to get ${download_file_list[(2*$i+1)]} from \e[0;36m$obs_shell_dir/$shell_mode/$obs_version_note/ \e[0m"
                quit_script=1
                break
            fi
            if [ "${download_file_sha256[$i]}" != "$obs_dcp_sum" -a $quit_script != 1 ];then
                echo "ERROR:Download files is incorrect"
                quit_script=1
                break
            fi 
        done
    fi
    quit_script=0
    if [ "$dev_mode_name" == "sdx" -a $quit_script != 1 ];then
        #info_show "SDA download"
        rm -rf *.tar.gz
    fi
    cd -  >/dev/null
elif [ $quit_script != 1  ];then
    echo -e "Do not need download the \e[0;32m${download_file_name[0]}\e[0m and \e[0;32m${download_file_name[1]}\e[0m files."
fi

echo
echo "---------------------------------------------------"
echo

if [ $quit_script == 1 -a $script_exec == 0 ] ; then
    return
elif [ $quit_script == 1 ] ; then
    exit
fi

####################################################################################################
#end new develop
####################################################################################################

echo "+-----------+--------------------------------------------------------------------------------+"
echo "|   tool    |                          install home directory                                |"
echo "+-----------+--------------------------------------------------------------------------------+"
printf "|   sdx     | %78s |\n" $vivado_dir
echo "+-----------+--------------------------------------------------------------------------------+"
