---
title: 'UT实战第五期：第三代香山(昆明湖）架构IFU top模块UT验证实战(进行中)'
date: 2024-12-11T10:47:18+08:00
draft: false
fenbao_tags: ["验证案例", "IFU", "top", "UT验证"]
status: "Continuing"
task_closed: false
home_page_show: true
Weight: 11
summary: "在验证中学习香山IFU的微架构设计"
---

本期验证任务将会进一步了解IFUtop模块的设计思路，在验证实战中体会香山取指模块的设计思路，加深对RISCV指令集架构的理解。欢迎各位报名参加（报名填写[这里](https://www.wjx.top/vm/mKbmTqL.aspx#)，qq群：**600480230**。）！

IFU（Instuction Fetch Unit）即取指单元，负责接收FTQ的请求并从ICache或Instr Uncache获取指令缓存行作为输入，以完成取指、预译码、RVC指令扩展为RVI指令、BPU预测错误预检等多项功能，最终向IBuffer输出初步译码信息和指令码，向FTQ写回检查结果。 

本次分配的任务是对IFUtop模块的验证，所有的任务都将通过<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues" target="_blank">万众一芯之香山处理器的issue</a>分配。 

## 参与

本次验证任务请基于UnityChipForXiangShan提供的<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">验证框架</a>完成验证工作并向该仓库提交PR。

### 成果提交

请fork上述UnityChipForXiangShan仓库之后完成验证代码和文档的编写，成果齐备后，请发起PR以提交。

### bug报告

请直接在UnityChipForXiangShan的仓库下使用bug report模板提issue，或者快捷点击[这里](https://github.com/XS-MLVP/UnityChipForXiangShan/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=%5BBUG%5D+)。

提交bug时，请先在label中选择bug need to confirm标签。然后从label提供的四种bug分级（minor、normal、serious、critical）中选择您认为最符合的一种标签。最后，请选择您发现bug的模块，本次验证的是前端的ifu模块，可以统一打上ut\_frontend\.ifu标签。

## 成果需求

每个子任务需要提交以下成果：
1. 验证环境+API：验证环境和API是代码成果，是针对待验证对象（DUT）的数据职责（引脚）和行为职责（逻辑）的封装，需要提供特定的可复用的接口、
测试套件、测试覆盖率等的定义。其中，搭建验证环境可以参考<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/02_build_env/" target="_blank">验证环境搭建教程</a>，测试覆盖率相关的文档可以参考这两篇：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/04_cover_line/" target="_blank">行覆盖率</a>、<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/05_cover_func/" target="_blank">功能覆盖率</a>。
2. 测试用例：测试用例是代码成果，定义了用于测试的输入组合，以及预期的输出组合。构建测试用例可以参考<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/03_add_test/" target="_blank">测试用例添加教程</a>
3. 验证报告：验证报告是文字成果，包括对环境、测试点和测试用例的介绍，复现代码所需的环境和指令，以及对测试覆盖率等衡量指标的报告。
验证报告的书写可以参考这篇教程：<a href="https://open-verify.cc/mlvp/docs/basic/report/" target="_blank">验证报告教程</a>
4. 其他说明：如果运行您的项目需要其他的依赖，可在测试报告或PR中说明

本期任务在<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan验证框架</a>中已经提供了初步的环境，各位也可以自行搭建验证环境和提炼API。

## 任务难度

任务难度是根据理解难度、工作量等因素综合得出的，一般来说难度1～3的任务是简单的任务，4～7的任务难度一般，或许工作量较大，或许需要花费一定时间理解任务隐藏信息，8～10的任务较为困难，一般同时具有较大的工作量和较高的理解难度。

## 奖励信息

最终,根据任务的难度和各位的完成情况，各位将能获得数额不等的奖金。此外，如果为IFU top模块找出bug并反馈确认后，有机会得到更多奖金。

## 任务详情

由于本期验证的是IFU的top模块，因此不会再划分为多个子模块，而是需要验证完整的IFU top模块。我们将通过测试完整度（覆盖率等）进行分级，在验证过程中，您将需要按自选的功能点自行划分测试点进行测试，功能点详细描述请参考 [IFU top 文档](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/01_ifu/)。所有功能点及对应难度如下：

| **功能标识符** | **功能点** | **描述** | **难度** |
|---------------------|--------------------|-----------------------------------------------------------------------|-----|
| **IFU_RCV_REQ**         | IFU接收FTQ取指令请求         | 接收来自FTQ的取指请求，设置ready                     |1/10|
| **IFU_INFOS** | IFU分析请求和获取初始指令码     | IFU初步分析获取的FTQ取指请求，从ICache          |2/10|
|   **IFU_PREDECODE**  | 预译码     | 对获取的指令进行预译码，拼接指令并分析其是否为RVC指令、跳转指令类型等 |4/10|
| **IFU_RVC_EXPAND**    | 扩展RVC指令    |  对拼接后的每条指令，若其为RVC指令，校验合法性并扩展为RVI指令            | 5/10|
| **IFU_PREDCHECK** | 预检查       | 提前检查某些简单的预测错误 |4/10|
|  **IFU_REDIRECT**  | 预测错误重定向 | 根据预检查的结果，对IFU内部流水线进行冲刷 | 3/10|
| **IFU_CROSS_BLOCK** | 跨预测块指令处理 | 对于跨越预测块的RVI指令进行分析处理  | 6/10|
| **IFU_IBUFFER**   | 向IBuffer写指令码和前端信息 |  输出最终的指令码和预译码信息等 |3/10|
| **IFU_OVERRIDE_FLUSH**  | 分支预测overriding冲刷流水线 | 根据其他模块的输入决定是否冲刷流水线 | 3/10|
|  **IFU_WB_FTQ**  | 写回FTQ  | 将预译码信息和预检查结果写回FTQ |3/10|
|  **IFU_MMIO**  | MMIO空间请求处理 | IFU对于来自MMIO空间的请求，有另一套处理逻辑 | 8/10|
| **IFU_FRONTEND_TRIGGER**         | IFU前端断点  | 在IFU中设置前端断点并对相应PC进行检查  |3/10|

## 报名方式

请填写[报名问卷](https://www.wjx.top/vm/mKbmTqL.aspx#)参与本期任务，也欢迎加入活动官方qq群：**600480230**。

如有疑问可在qq群中联系群主，或联系万众一芯官方邮箱：anxu@bosc.ac.cn。
