---
title: '第二期：昆明湖IFU模块UT验证实战(进行中)'
date: 2024-01-11T08:47:18+08:00
draft: false
fenbao_tags: ["验证案例", "IFU", "UT验证"]
#website: "/xs-bpu/"
status: "Continuing"
task_closed: false
home_page_show: true
summary: "在验证中学习香山IFU的微架构设计"
---

在本期验证任务中，各位朋友将走近香山昆明湖架构的IFU模块，在验证实战中体会香山取指模块的设计思路，加深对RISCV指令集架构的理解。欢迎各位报名参加（报名填写[这里](https://www.wjx.cn/vm/tUcQ4Fs.aspx#)，qq群：**600480230**。）！

IFU（Instuction Fetch Unit）即取指单元，负责接收FTQ的请求并从ICache或Instr Uncache获取指令缓存行作为输入，以完成取指、预译码、RVC指令扩展为RVI指令、BPU预测错误预检等多项功能，最终向IBuffer输出初步译码信息和指令码，向FTQ写回检查结果。 

本期任务中，合计发布4个子任务，涵盖IFU的5个子模块（PreDecode、F3Predecoder、RVCExpander、PredChecker和FrontendTrigger），所有的任务都将通过<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues" target="_blank">万众一芯之香山处理器的issue</a>分配。 

## 参与验证

本次验证任务请基于UnityChipForXiangShan提供的<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">验证框架</a>完成验证工作并向该仓库提交PR。

### 成果提交

请fork上述UnityChipForXiangShan仓库之后完成验证代码和文档的编写，成果齐备后，请发起PR以提交。

### bug报告

请直接在UnityChipForXiangShan的仓库下使用bug report模板提issue，或者快捷点击[这里](https://github.com/XS-MLVP/UnityChipForXiangShan/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=%5BBUG%5D+)。

提交bug时，请先在label中选择bug need to confirm标签。然后从label提供的四种bug分级（minor、normal、serious、critical）中选择您认为最符合的一种标签。最后，请选择您发现bug的模块，本次验证的是前端的ifu模块，可以统一打上ut\_frontend\.ifu标签。

## 成果需求

每个子任务需要提交以下成果：
1. 验证环境+API：验证环境和API是代码成果，是针对待验证对象（DUT）的数据职责（引脚）和行为职责（逻辑）的封装，需要提供特定的可复用的接口、
测试套件、测试覆盖率等的定义。其中，搭建验证环境可以参考<a href="https://xs-mlvp.github.io/UnityChipForXiangShan/docs/03_add_test/02_build_env/" target="_blank">验证环境搭建教程</a>，测试覆盖率相关的文档可以参考这两篇：<a href="https://xs-mlvp.github.io/UnityChipForXiangShan/docs/03_add_test/04_cover_line/" target="_blank">行覆盖率</a>、<a href="https://xs-mlvp.github.io/UnityChipForXiangShan/docs/03_add_test/05_cover_func/" target="_blank">功能覆盖率</a>。
2. 测试用例：测试用例是代码成果，定义了用于测试的输入组合，以及预期的输出组合。构建测试用例可以参考<a href="https://xs-mlvp.github.io/UnityChipForXiangShan/docs/03_add_test/03_add_test/" target="_blank">测试用例添加教程</a>
3. 验证报告：验证报告是文字成果，包括对环境、测试点和测试用例的介绍，复现代码所需的环境和指令，以及对测试覆盖率等衡量指标的报告。
验证报告的书写可以参考这篇教程：<a href="https://open-verify.cc/mlvp/docs/basic/report/" target="_blank">验证报告教程</a>

本期任务在<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan验证框架</a>中已经提供了初步的环境，各位也可以自行搭建验证环境和提炼API。

## 任务难度

任务难度是根据理解难度、工作量等因素综合得出的，一般来说难度1～3的任务是简单的任务，4～7的任务难度一般，或许工作量较大，或许需要花费一定时间理解任务隐藏信息，8～10的任务较为困难，一般同时具有较大的工作量和较高的理解难度。

## 奖励信息

最终,根据任务的难度和各位的完成情况，各位将能获得数额不等的奖金。此外，如果为IFU模块找出bug并反馈确认后，有机会得到更多奖金。

## 任务详情

以下是本期各个子任务的详细介绍：

### 任务 2.1：PreDecode、F3Predecoder子模块

PreDecode即预译码模块，负责对初始指令码进行拼接并对拼接后的每条指令提取预译码信息，该模块时序优化出了PreDecode和F3Predecoder两个子模块。

PreDecode模块负责针对输入的17x2B初始指令码，完成指令拼接，转移地址计算等功能，返回拼接指令码和预译码信息。

F3Predecoder模块是PreDecode子模块的时序优化部分，负责CFI指令的识别和判定。

预期任务难度：4/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/01_ifu/01_predecode/" target="_blank">PreDecode功能</a>、<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/01_ifu/02_f3predecoder/" target="_blank">F3Predecoder功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/9">PreDecode issue</a>

### 任务2.2：RVCExpander子模块

该模块负责针对输入的4B指令码，进行指令扩展和非法指令判定。

预期任务难度：5/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/01_ifu/03_ifu_rvc_exp/" target="_blank">RVCExpander功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/10">RVCExpander issue</a>

### 任务2.3：PredChecker模块：

该模块负责针对输入的指令码和预译码信息，检出预测错误并修正预测结果。

预期任务难度：4/10
    
功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/01_ifu/04_pred_checker/" target="_blank">PredChecker功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/11">PredChecker issue</a>

备注：已有环境和API，需自行添加覆盖率和测试用例，可以对API作出调整     

### 验证任务2.4：FrontendTrigger子模块验证

该模块负责根据输入信息设置和判定前端断点触发。

预期任务难度：6/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/01_ifu/05_frontend_trigger/" target="_blank">FrontendTrigger功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/12">FrontendTrigger issue</a>

## 报名方式

请填写[报名问卷](https://www.wjx.cn/vm/tUcQ4Fs.aspx#)参与本期任务，也欢迎加入活动官方qq群：**600480230**。

如有疑问可在qq群中联系群主，或联系万众一芯官方邮箱：anxu@bosc.ac.cn。
