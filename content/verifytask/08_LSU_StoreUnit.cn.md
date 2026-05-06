---
title: 'UT实战第九期：第三代香山(昆明湖）架构 LSU-StoreUnit 模块UT验证实战(已完成)'
date: 2025-09-18T10:17:00+08:00
draft: false
fenbao_tags: ["验证案例", "LSU", "StoreUnit", "UT验证"]
status: "Completed"
task_closed: true
home_page_show: true
Weight: 11
summary: "在验证中学习香山LSU-StoreUnit的微架构设计"
schedule: 4
difficult: 5
image: "/images/UTyanzheng.png"
---
在本期验证任务中，各位朋友将走近香山昆明湖架构的StoreUnit模块，了解香山存储地址执行单元的设计思路，加深对RISCV指令集架构的理解。欢迎各位报名参加！
（报名链接点[这里](https://www.wjx.top/vm/wFtuJS6.aspx)，qq群：**600480230**）。

StoreUnit 用于执行Store类指令的地址生成与处理，是Load/Store流水线中的关键组成部分，与LoadUnit共同构成了LSU（Load Store Unit）访存流水线。从功能来说，LSU负责访存类型指令的具体执行流程，包括正常的访存地址空间以及外设相关的MMIO地址空间，同时负责原子指令执行。从流程来说，LSU接受保留站发射的指令，根据访存指令的类型，经过不同指令的流水线，得到指令执行结果，写回到ROB中，并通知前递旁路网络，唤醒后续相关指令以及数据前递。
	
## 任务介绍
本期验证任务是对StoreUnit模块的功能点进行验证，合计发布18个微任务，参与者可自行挑选感兴趣的任务，完成1个或多个。

微任务是本次验证模块的功能拆解成需要验证的功能点，每个功能点对应对应一个已封装的函数，作为参与者只需完成对应函数即可进行验证。**每个微任务均给出了函数模板，你仅需选择已提供的对应函数，编写测试用例验证对应功能，并完成验证报告的编写。** 除去前期的学习时间，每个微任务的验证时间约在2-5小时不等。
每个微任务均有奖金，我们将给成功完成该任务的前五人，发放现金奖励。此外，如果您在验证过程中首次找到了 bug 并联系我们确认后，根据 bug 实际情况，还会获得额外的奖金 💴

任务参与流程如下：
<div>			
    <center>	
    <img src="/crowdsourcing/activity_process.png"
         alt="任务流程"
         style="zoom:26%"/>
    <br>		
    任务流程	
    </center>
</div>
所有的任务都将通过<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues" target="_blank">万众一芯之香山处理器的issue</a>分配。


## 推荐完成时间

推荐完成时间是根据理解难度、工作量等因素综合得出的，一般来说需要1～2h的任务是简单的任务，3～4h的任务难度一般，或许工作量较大，或许需要花费一定时间理解任务隐藏信息，5h以上的任务较为困难，一般同时具有较大的工作量和较高的理解难度。推荐时间不包含学习、环境安装配置所需时间。
<br><br>

**LSU-StoreUnit详细验证文档： [StoreUnit验证文档](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/)**



## 任务列表
所有微任务如下所示，你可以选择完成1个或多个。每个微任务中，前五名提交成果并通过审核的同学，将获得任务奖金。
| 功能点 |  难度 |  推荐完成时间   | 奖金  |  详情
| ---- |----|----|----|----|
| 1.标量指令派发  |   ★ ★ ☆ ☆ ☆  | 2小时  | 100元| [test_scalar_dispatch 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L4) <br>[内存指令派发功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#内存指令派发)|
| 2.向量指令派发  |   ★ ★ ★ ☆ ☆  | 3小时  | 150元| [test_vector_dispatch 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L12) <br>[内存指令派发功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#内存指令派发)|
| 3.地址流水线S0阶段  |   ★ ★ ★ ☆ ☆  | 3小时  | 150元| [test_s0_address_calc 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L20) <br>[地址流水线功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#存储指令执行)|
| 4.地址流水线S1阶段 |   ★ ★ ★ ★ ☆  | 4小时  | 200元| [test_s1_raw_check 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L28) <br>[地址流水线功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#存储指令执行)|
| 5.地址流水线S2阶段 |   ★ ☆ ☆ ☆ ☆  | 1.5小时  | 80元| [test_ s2_sq_mark_ready 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L36) <br>[地址流水线功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#存储指令执行)|
| 6.向量指令拆分  |   ★ ★ ★ ☆ ☆  | 3小时  | 150元| [test_split 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L44) <br>[向量存储指令执行功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#向量存储指令执行)|
| 7.向量元素偏移地址计算  |   ★ ★ ☆ ☆ ☆  | 2小时  | 100元| [test_offset 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L52) <br>[向量存储指令执行功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#向量存储指令执行)|
| 8.Tlb缺失  |   ★ ★ ★ ☆ ☆  |3小时  | 150元| [test_tlb_miss 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L60) <br>[重执行功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#重执行)||
| 9.Raw违例检测  |   ★ ★ ★ ☆ ☆  | 3小时  | 150元| [test_violation 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L68) <br>[RAW处理功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#raw处理)|
| 10.Raw违例恢复  |   ★ ★ ★ ★ ★  |5.5小时  | 270元| [test_recovery_mech 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L76) <br>[RAW处理功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#raw处理)|
| 11.SBuffer合并  |   ★ ★ ★ ☆ ☆  | 3小时  | 150元| [test_write_merge 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L84) <br>[SBuffer优化功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#sbuffer优化)|
| 12.Sbuffer替换  |   ★ ★ ★ ☆ ☆  | 3小时  | 150元| [test_plru_replace 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L92) <br>[SBuffer优化功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#sbuffer优化)|
| 13.mmio指令执行顺序  |   ★ ★ ★ ☆ ☆  | 3小时  | 150元| [test_order 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L100) <br>[MMIO处理功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#mmio处理)|
| 14.mmio异常 |   ★ ★ ★ ★ ☆  | 4小时  | 200元| [test_exception 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L108) <br>[MMIO处理功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#mmio处理)|
| 15.NC乱序执行  |   ★ ★ ☆ ☆ ☆  | 2小时  | 100元| [test_exec 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L116) <br>[Uncache指令执行功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#Uncache指令执行)|
| 16.Uncache转发  |   ★ ★ ★ ☆ ☆  | 3小时  | 150元| [test_forward 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L124) <br>[Uncache指令执行功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#Uncache指令执行)|
| 17.标量非对齐指令拆分 |   ★ ★ ★ ☆ ☆  | 3小时  | 150元| [test_scalar_split 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L132) <br>[非对齐内存访问功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#非对齐存储指令执行)|
| 18.非对齐访问异常  |   ★ ★ ★ ★ ☆  | 4小时  | 200元| [test_exception 函数](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L140) <br>[非对齐内存访问功能](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#非对齐存储指令执行)|



## 成果需求

1. 测试用例：测试用例是代码成果，定义了用于测试的输入组合，以及预期的输出组合。
2. 验证报告：验证报告是文字成果，要求不少于500字，包括功能、输入和输出结果，以及边界条件分析。报告参考格式： [微报告模板](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/00_template/) 
3. 其他说明：如果运行您的项目需要其他的依赖，可在测试报告或PR中说明

## 参与与提交

本次验证任务请基于UnityChipForXiangShan提供的<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">验证框架</a>完成验证工作并向该仓库提交PR。

请fork上述UnityChipForXiangShan仓库之后完成验证代码和文档的编写，成果齐备后，请发起PR以提交。

## 奖励信息
最终,根据任务的难度和各位的完成情况，各位将能获得数额不等的奖金。此外，如果为LSU StoreUnit模块找出bug并反馈确认后，有机会得到更多奖金。


## bug报告
请直接在UnityChipForXiangShan的仓库下使用bug report模板提issue。

提交bug时，请先在label中选择bug need to confirm标签。然后从label提供的四种bug分级（minor、normal、serious、critical）中选择您认为最符合的一种标签。最后，请选择您发现bug的模块，本次验证的是内存的storeunit模块，可以统一打上ut_mem_block.storeunit标签。
