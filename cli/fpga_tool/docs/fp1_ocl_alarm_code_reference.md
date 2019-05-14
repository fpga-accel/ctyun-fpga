| 错误码 |寄存器名称|寄存器基址|寄存器说明|寄存器偏移|告警名称|描述|
| ----- | ------- :  | ------- :  | : ----------------  : | : ---------------- : | :------: | :------: |
| 5086 | reg_sys_err | 0x390000 | 系统综合告警寄存器 | 9 | Flash crc err | flash 文件读取 CRC校验错误告警，1表示CRC校验正常，0表示CRC校验失败 |
| 5092 | reg_sys_err | 0x390000 | 系统综合告警寄存器 | 3 | ddr_calib_err | ddr自检未通过告警，1表示calib正常，0表示失败 |
| 5093 | reg_sys_err | 0x390000 | 系统综合告警寄存器 | 2 | sys_clk_err | 系统时钟丢失告警，1表示检测正常，0表示失败 |
| 5107 | firewall_ctrl_status | 0xd0000 | 管理控制通道防火墙错误状态寄存器 | 20 | ERRS_BRESP | BRESP错误 |
| 5108 | firewall_ctrl_status | 0xd0000 | 管理控制通道防火墙错误状态寄存器 | 19 | RECS_WRITE_TO_BVALID_MAX_WAIT | 接收通道发生write到bvalid超时错误 |
| 5109 | firewall_ctrl_status | 0xd0000 | 管理控制通道防火墙错误状态寄存器 | 18 | RECS_WREADY_MAX_WAIT | 接收通道发生wready超时错误 |
| 5110 | firewall_ctrl_status | 0xd0000 | 管理控制通道防火墙错误状态寄存器 | 17 | RECS_AWREADY_MAX_WAIT | 接收通道发生awready超时错误 |
| 5111 | firewall_ctrl_status | 0xd0000 | 管理控制通道防火墙错误状态寄存器 | 16 | WRITE_RESPONSE_BUSY | 写响应忙 |
| 5123 | firewall_ctrl_status | 0xd0000 | 管理控制通道防火墙错误状态寄存器 | 4 | ERRS_RID | RID错误 |
| 5124 | firewall_ctrl_status | 0xd0000 | 管理控制通道防火墙错误状态寄存器 | 3 | ERRS_RDATA_NUM | rdata个数错误 |
| 5125 | firewall_ctrl_status | 0xd0000 | 管理控制通道防火墙错误状态寄存器 | 2 | RECS_CONTINUOUS_RTRANSFERS_MAX_WAIT | 接收通道连续接收传输超时错误 |
| 5126 | firewall_ctrl_status | 0xd0000 | 管理控制通道防火墙错误状态寄存器 | 1 | RECS_ARREADY_MAX_WAIT | 接收通道ARREADY超时错误 |
| 5127 | firewall_ctrl_status | 0xd0000 | 管理控制通道防火墙错误状态寄存器 | 0 | READ_RESPONSE_BUSY | 读响应忙 |
| 5139 | firewall_usr_ctrl_status | 0xe0000 | 用户控制通道防火墙错误状态寄存器 | 20 | ERRS_BRESP | BRESP错误 |
| 5140 | firewall_usr_ctrl_status | 0xe0000 | 用户控制通道防火墙错误状态寄存器 | 19 | RECS_WRITE_TO_BVALID_MAX_WAIT | 接收通道发生write到bvalid超时错误 |
| 5141 | firewall_usr_ctrl_status | 0xe0000 | 用户控制通道防火墙错误状态寄存器 | 18 | RECS_WREADY_MAX_WAIT | 接收通道发生wready超时错误 |
| 5142 | firewall_usr_ctrl_status | 0xe0000 | 用户控制通道防火墙错误状态寄存器 | 17 | RECS_AWREADY_MAX_WAIT | 接收通道发生awready超时错误 |
| 5143 | firewall_usr_ctrl_status | 0xe0000 | 用户控制通道防火墙错误状态寄存器 | 16 | WRITE_RESPONSE_BUSY | 写响应忙 |
| 5155 | firewall_usr_ctrl_status | 0xe0000 | 用户控制通道防火墙错误状态寄存器 | 4 | ERRS_RID | RID错误 |
| 5156 | firewall_usr_ctrl_status | 0xe0000 | 用户控制通道防火墙错误状态寄存器 | 3 | ERRS_RDATA_NUM | rdata个数错误 |
| 5157 | firewall_usr_ctrl_status | 0xe0000 | 用户控制通道防火墙错误状态寄存器 | 2 | RECS_CONTINUOUS_RTRANSFERS_MAX_WAIT | 接收通道连续接收传输超时错误 |
| 5158 | firewall_usr_ctrl_status | 0xe0000 | 用户控制通道防火墙错误状态寄存器 | 1 | RECS_ARREADY_MAX_WAIT | 接收通道ARREADY超时错误 |
| 5159 | firewall_usr_ctrl_status | 0xe0000 | 用户控制通道防火墙错误状态寄存器 | 0 | READ_RESPONSE_BUSY | 读响应忙 |
| 5171 | firewall_usr_data_status | 0xf0000 | 用户数据通道防火墙错误状态寄存器 | 20 | ERRS_BRESP | BRESP错误 |
| 5172 | firewall_usr_data_status | 0xf0000 | 用户数据通道防火墙错误状态寄存器 | 19 | RECS_WRITE_TO_BVALID_MAX_WAIT | 接收通道发生write到bvalid超时错误 |
| 5173 | firewall_usr_data_status | 0xf0000 | 用户数据通道防火墙错误状态寄存器 | 18 | RECS_WREADY_MAX_WAIT | 接收通道发生wready超时错误 |
| 5174 | firewall_usr_data_status | 0xf0000 | 用户数据通道防火墙错误状态寄存器 | 17 | RECS_AWREADY_MAX_WAIT | 接收通道发生awready超时错误 |
| 5175 | firewall_usr_data_status | 0xf0000 | 用户数据通道防火墙错误状态寄存器 | 16 | WRITE_RESPONSE_BUSY | 写响应忙 |
| 5187 | firewall_usr_data_status | 0xf0000 | 用户数据通道防火墙错误状态寄存器 | 4 | ERRS_RID | RID错误 |
| 5188 | firewall_usr_data_status | 0xf0000 | 用户数据通道防火墙错误状态寄存器 | 3 | ERRS_RDATA_NUM | rdata个数错误 |
| 5189 | firewall_usr_data_status | 0xf0000 | 用户数据通道防火墙错误状态寄存器 | 2 | RECS_CONTINUOUS_RTRANSFERS_MAX_WAIT | 接收通道连续接收传输超时错误 |
| 5190 | firewall_usr_data_status | 0xf0000 | 用户数据通道防火墙错误状态寄存器 | 1 | RECS_ARREADY_MAX_WAIT | 接收通道ARREADY超时错误 |
| 5191 | firewall_usr_data_status | 0xf0000 | 用户数据通道防火墙错误状态寄存器 | 0 | READ_RESPONSE_BUSY | 读响应忙 |
