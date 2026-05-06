---
title: "UT实战第六期：第三代香山(昆明湖）架构ICache模块UT验证实战(已完成)"
date: 2025-04-01T16:00:00+08:00
draft: false
fenbao_tags: ["验证案例", "ICache", "UT验证"]
#website: "/xs-bpu/"
status: "Completed"
task_closed: true
home_page_show: true
Weight: 11
summary: "在验证中学习香山ICache的微架构设计"
schedule: 4
difficult: 5
image: "/images/UTyanzheng.png"
---

在本期验证任务中，各位朋友将走近香山昆明湖架构的 ICache 模块，在验证实战中体会香山指令缓存模块的设计思路，加深对 RISCV 指令集架构的理解。欢迎各位报名参加（报名填写[这里](https://www.wjx.top/vm/e1nEX25.aspx#)，qq 群：**600480230**。）！

ICache（Instruction Cache）即指令缓存，负责接收 FTQ 的取指和预取请求并从向 ITLB 获取物理地址和通过 Tilelink 获取指令数据，最终将指令数据或者异常数据发送给 IFU。

本期任务中，合计发布 6 个子任务，涵盖 ICache 的 7 个子模块（IPrefetchPipe、MainPipe、WayLookup、FIFO、MissUnit、CtrlUnit 和 ICache），所有的任务都将通过<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues" target="_blank">万众一芯之香山处理器的 issue</a>分配。

## 报名参与

<div>			
    <center>	
    <img src="/crowdsourcing/activity_process.png"
         alt="任务流程"
         style="zoom:26%"/>
    <br>		
    任务流程	
    </center>
</div>

以上是参与任务的流程环节，根据您选择的任务难度及完成情况，将会获得数额不等的奖金（本期奖金池 7000），您的努力将会获得回报。此外，如果您在验证过程中首次找到了 bug 并联系我们确认后，根据 bug 实际情况，还会获得额外的奖金 💴

请填写[报名问卷](https://www.wjx.top/vm/e1nEX25.aspx#)参与本期任务，也欢迎加入活动官方 qq 群：**600480230**。

本次验证任务请基于 UnityChipForXiangShan 提供的<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">验证框架</a>完成验证工作并向该仓库提交 PR。

## 任务详情

任务难度是根据理解难度、工作量等因素综合得出的，一般来说难度 1 ～ 3 的任务是简单的任务，4 ～ 7 的任务难度一般，或许工作量较大，或许需要花费一定时间理解任务隐藏信息，8 ～ 10 的任务较为困难，一般同时具有较大的工作量和较高的理解难度。

以下是本期各个子任务的详细介绍：

### 任务 1：IPrefetchPipe 子模块

IPrefetchPipe 子模块负责预取请求过滤。
接收 FTQ 的预取请求，通过 ITLB 进行地址转换和 PMP 检查，之后对 MetaArray 进行查询，将元数据（在哪一路命中、ECC 校验码、是否发生异常等）存储到 WayLookup 中，如果该请求缺失，就发送至 MissUnit 进行预取。

预期任务难度：7/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/04_icache/01_iprefetchpipe/" target="_blank">IPrefetchPipe 功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/112">IPrefetchPipe issue</a>

### 任务 2：MainPipe 子模块

MainPipe 为 ICache 的主流水，为三级流水设计，负责从 DataArray 中读取数据，pmp 检查，缺失处理，并且将结果返回给 IFU。

预期任务难度：7/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/04_icache/02_mainpipe/" target="_blank">MainPipe 功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/113">MainPipe issue</a>

### 任务 3：WaylookUp 模块

内部是 FIFO 环形队列结构。暂存 IPrefetchPipe 查询 MetaArray 和 ITLB 得到的元数据，以备 MainPipe 使用。同时监听 MSHR 写入 SRAM 的 cacheline，对命中信息进行更新。

预期任务难度：5/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/04_icache/03_waylookup/" target="_blank">WayLookup 功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/114">WayLookup issue</a>

### 任务 4：FIFO 和 MissUnit 子模块验证

FIFO 为一个循环队列。
MissUnit 用于管理 Miss 请求和 MSHR，通过 TileLink 协议与 L2 缓存进行通信，发送获取缓存块的请求（mem_acquire），并接收 L2 缓存的响应（mem_grant）。还有处理特殊情况（如 flush、fencei、数据损坏等）。

预期任务难度：6/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/04_icache/04_missunit/" target="_blank">MissUnit 功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/115">MissUnit issue</a>

### 任务 5：CtrlUnit 子模块验证

目前 CtrlUnit 主要负责 ECC 校验使能/错误注入等功能。

预期任务难度：5/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/04_icache/05_ctrlunit/" target="_blank">CtrlUnit 功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/116">CtrlUnit issue</a>

### 任务 6：ICache 顶层模块验证

ICache 顶层模块，主要负责处理预取，取指请求，更新 Replacer,读写 MetaArray 和 DataArray，以及处理异常。

预期任务难度：8/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/04_icache/06_icache/" target="_blank">ICache 顶层功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/117">ICacheTop issue</a>

## 成果需求

本次验证任务请基于 UnityChipForXiangShan 提供的验证框架完成验证工作，并向该仓库提交 PR。
每个子任务需要提交以下成果：

1. 验证环境+API：验证环境和 API 是代码成果，是针对待验证对象（DUT）的数据职责（引脚）和行为职责（逻辑）的封装，需要提供特定的可复用的接口、
   测试套件、测试覆盖率等的定义。其中，搭建验证环境可以参考<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/02_build_env/" target="_blank">验证环境搭建教程</a>，测试覆盖率相关的文档可以参考这两篇：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/04_cover_line/" target="_blank">行覆盖率</a>、<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/05_cover_func/" target="_blank">功能覆盖率</a>。
2. 测试用例：测试用例是代码成果，定义了用于测试的输入组合，以及预期的输出组合。构建测试用例可以参考<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/03_add_test/" target="_blank">测试用例添加教程</a>
3. 验证报告：验证报告是文字成果，包括对环境、测试点和测试用例的介绍，复现代码所需的环境和指令，以及对测试覆盖率等衡量指标的报告。
   验证报告的书写可以参考这篇教程：<a href="https://open-verify.cc/mlvp/docs/basic/report/" target="_blank">验证报告教程</a>

本期任务在<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan 验证框架</a>中已经提供了初步的环境，各位也可以自行搭建验证环境和提炼 API。

## bug 报告

请直接在 UnityChipForXiangShan 的仓库下使用 bug report 模板提 issue，或者快捷点击[这里](https://github.com/XS-MLVP/UnityChipForXiangShan/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=%5BBUG%5D+)。

提交 bug 时，请先在 label 中选择 bug need to confirm 标签。然后从 label 提供的四种 bug 分级（minor、normal、serious、critical）中选择您认为最符合的一种标签。最后，请选择您发现 bug 的模块，本次验证的是前端的 icache 模块，可以统一打上 ut_frontend\.icache 标签。
