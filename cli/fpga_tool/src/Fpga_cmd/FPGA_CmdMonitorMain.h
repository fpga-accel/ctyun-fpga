/*-
 *   BSD LICENSE
 *
 *   Copyright(c)  2017-2018 Huawei Technologies Co., Ltd. All rights reserved.
 *
 *   Redistribution and use in source and binary forms, with or without
 *   modification, are permitted provided that the following conditions
 *   are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in
 *       the documentation and/or other materials provided with the
 *       distribution.
 *     * Neither the name of Huawei Technologies Co., Ltd  nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.
 *
 *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef __FPGA_CMDMONITORMAIN_H__
#define __FPGA_CMDMONITORMAIN_H__
#include <stdbool.h>

/************************* Define error code  ************************************/
#define MONITOR_ERROR                            1
#define SDKRTN_MONITOR_SUCCESS                   0
#define SDKRTN_MONITOR_ERROR_BASE                ( SDKRTN_ERR_BASE  +  ( MONITOR_ERROR << 8  ) )
#define SDKRTN_MONITOR_INPUT_ERROR               ( SDKRTN_MONITOR_ERROR_BASE + 0x1 )
#define SDKRTN_MONITOR_MODULE_INIT_ERROR         ( SDKRTN_MONITOR_ERROR_BASE + 0x2 )
#define SDKRTN_MONITOR_MEMSET_ERROR              ( SDKRTN_MONITOR_ERROR_BASE + 0x3 )
#define SDKRTN_MONITOR_VSNPRINTF_ERROR           ( SDKRTN_MONITOR_ERROR_BASE + 0x4 )
#define SDKRTN_MONITOR_OPCODE_ERROR              ( SDKRTN_MONITOR_ERROR_BASE + 0x5 )
#define SDKRTN_MONITOR_OPCODE_FUNC_ERROR         ( SDKRTN_MONITOR_ERROR_BASE + 0x6 )
#define SDKRTN_MONITOR_MALLOC_ERROR              ( SDKRTN_MONITOR_ERROR_BASE + 0x7 )
#define SDKRTN_MONITOR_PR_STATUS_ERROR         ( SDKRTN_MONITOR_ERROR_BASE + 0x8 )
#define SDKRTN_MONITOR_CMD_OPS_ERROR            ( SDKRTN_MONITOR_ERROR_BASE + 0x9 )
#define SDKRTN_MONITOR_LOAD_ERRNAME_ERROR            ( SDKRTN_MONITOR_ERROR_BASE + 0xa )

#define FPGA_INPUT_PARAS_NUM_MIN                     2
#define OPTCODE_LENGTH_MAX                       2
#define LOAD_STATUS_NAME_LEN_MAX                 20
#define LOAD_ERR_NAME_LEN_MAX                    20
#define QUIT_FLAG                                1              
#define PARA_FLAG                                              1
#define MAX_ALM_NUM_PER_MAILBOX              312
#define MAX_REG_NAME_BYTES                        64
#define MAX_ALM_NAME_BYTES                        64
#define MAX_ALM_DESC_BYTES                        256

#define FPGA_OPS_STATUS_MASK                  0xffff0000
#define FPGA_OPS_STATUS_SHIFT                 16
#define FPGA_LOAD_ERROR_MASK                  0xffff

#define BASIC_ALM_CODE_BASE                7000
#define SDX_ALM_CODE_BASE                  5000

/* SF Function: VM fpga_tool Alarm inquiry */
#define MAX_MBOX_BIT_LEN                 (64 * 8)

#define LOGIC_TYPE_BIT                     7
#define CARD_MODEL_BIT                    6
#define SF_LVL_FIRST_BYTE ulReserved[0]
#define SF_LVL_VALUE_BYTE ulReserved[4]

#define SF_TYPE_FIRST_BYTE ulReserved[4]
#define SF_TYPE_VALUE_BYTE ulReserved[8]
#define BOARD_RESET                        1
#define NON_BOARD_RESET                    0

/************************** register code *****************************/
#define REG_CLKM_ERR                    0
#define REG_PARRLT_ERR                  1
#define REG_RSPBD_ERR                   2
#define REG_DMAE_0ERR                   3
#define REG_DMAE_1ERR                   4
#define REG_BDQM_ERR                    5
#define REG_MULQM_ERR0                  6
#define REG_TXQM_STATUS_HISTORY         7
#define REG_PRTY_ERR                    8
#define REG_TXM_ERR                     9
#define REG_TXM_STATUS_HISTORY          10
#define REG_RXQM_ERR                    11
#define RXM_REQ_BUSY                    12
#define REG_BDQM_ERR_3RD                13
#define REG_TRM_FF_ERR                  14
#define REG_HPI_TXFF_ERR                15
#define REG_BAR_ACCESS_ERR              16
#define AXI_FIFO_STATUS                 17
#define AXI_ADDR_ERR                    18
#define CM_STATUS                       19
#define DC_STATUS                       20
#define MAC_STATUS                      21
#define SYS_FIFO_STAT                   22
#define SYS_FLAG                        23
#define TX_FIFO_STAT1                   24
#define TX_FIFO_STAT2                   25
#define BUS_FIFO_STAT1                  26
#define DMA_SOP_EOP_CHK_ERROR           27
#define USR_FIFO_STATUS                 28
#define RX_LEN_UNVLD_CNT                29
#define RX_STAT_UNVLD_CNT               30
#define RX_TAG_UNVLD_CNT                31
#define PLD_TIMEOUT_CNT                 32

/************************** register code *****************************/
#define REG_SYS_ERR                    0
#define REG_DDR0_ECC_STATUS            1
#define REG_DDR1_ECC_STATUS            2
#define FIREWALL_CTRL_STATUS           3
#define FIREWALL_USR_CTRL_STATUS       4
#define FIREWALL_USR_DATA_STATUS       5

#define NORMAL_0                           0
#define NORMAL_1                           1
#define REG_BIT(X)                         X
#define RESERVE                            0
#define LEN_BIT_8 (8)
#define TBL_LEN(a) (sizeof(a)/sizeof(a[0]))

typedef struct {
    UINT32 ulRegBase;           /* register base 32 bit */ 
    UINT32 RegIdx:10;           /* register table length :max 1024 row*/
    UINT32 Bit:6;               /* alarm register bit: max value:63 */
    UINT32 Lvl:3;               /* lvl:max value: 8  */
    UINT32 BoardReset:1;     /* reset board to recover : 0 :no  1:yes */
    UINT32 AlmCode:10;         /* alarm code max: 1024 */
    UINT32 NoAlmValue:1;
    UINT32 Reserve:1;           /* reserve 1 bit: max value 2 */
}FPGA_ALM_REG_INFO;

typedef struct {
    FPGA_ALM_REG_INFO* pstrTbl;
    INT32 lTblLen;
}FPGA_ALM_CONFIG;


typedef struct {
    UINT8 ucBitVal;
    UINT32 ulAlmCodeBase;
    FPGA_ALM_REG_INFO* pstrRegInfo;
}FPGA_ALM_RST;

enum {
    FPGA_LOGIC_OCL_TYPE = 0,
    FPGA_LOGIC_DPDK_TYPE,
    FPGA_LOGIC_NO_TYPE
};

enum {
    FPGA_MODEL_FX600 = 0,
    FPGA_MODEL_FX300
};

enum {
    ALL_LVL = 0,
    LOGGING = 1,
    DEVICE_FAULT = 2,
    LAST_LVL = 8
};

enum {
    FPGA_SF_ALM = 0,
    FPGA_SF_STATS,
    FPGA_SF_CONFIG,
    FPGA_SF_MAX = 16
};

typedef struct tagFPGA_CMD_PARA
{
    UINT32 ulSlotIndex;
    UINT32 ulOpcode;
    INT8    acHfiId[HFI_ID_LEN_MAX];
    bool     bShowInfo;
    UINT8  ulReserved[23];
}FPGA_CMD_PARA;

typedef enum tagUSER_CMD_LIST{
    CMD_HFI_LOAD,
    CMD_HFI_CLEAR,
    CMD_IMAGE_INQUIRE,
    CMD_RESOURSE_INQUIRE,
    CMD_STATUS_INQUIRE,
    CMD_LED_STATUS_INQUIRE,
    CMD_TOOL_VERSION,
    CMD_PARSE_END
}USER_CMD_LIST;

typedef UINT32 (*COMMAND_PROC_FUNC)(void);

extern FPGA_CMD_PARA   g_strFpgaModule;
UINT32 FPGA_MonitorLoadHfi(void);
UINT32 FPGA_MonitorInquireFpgaImageInfo(void);
UINT32 FPGA_MonitorDisplayDevice( void );
UINT32 FPGA_MonitorInquireLEDStatus(void);
UINT32 FPGA_MonitorClearHfi(void);
UINT32 FPGA_MonitorAlmMsgs(void);

#endif
