---
title: "UT实战第七期：第三代香山(昆明湖）架构LSQ模块UT验证实战(进行中)"
date: 2025-04-01T16:00:00+08:00
draft: false
fenbao_tags: ["验证案例", "LSQ", "UT验证"]
#website: "/xs-bpu/"
status: "Continuing"
task_closed: false
home_page_show: true
Weight: 11
summary: "在验证中学习香山LSQ的微架构设计"
schedule: 2
difficult: 5
---

在本期验证任务中，各位朋友将走近香山昆明湖架构的 LSQ 模块，在验证实战中体会香山访存模块的设计思路，加深对 RISCV 指令集架构的理解。欢迎各位报名参加（报名填写[这里](https://www.wjx.top/vm/mB3EmwR.aspx)，qq 群：**902630176**。）！

LSQ（Load Store Queue）即访存队列，是现代处理器中管理内存操作的关键结构，主要用于支持乱序执行并确保内存访问的正确性。其核心功能包括：跟踪未完成的load和存储store操作，检测和解决内存依赖（如RAW、WAR违例），实现存储转发（Store Forwarding）以提高效率，维护多核环境下的内存一致性，并协调与缓存子系统的交互。通过智能调度内存访问顺序，访存队列在保证程序正确性的同时，最大化指令级并行性，提升处理器性能。

本期任务中，合计发布 6 个子任务，涵盖 LSQ 的 6 个子模块（LoadQueueRAR、LoadQueueRAW、LoadQueueReplay、LoadQueueUncache、VirtualLoadQueue、StoreQueue），所有的任务都将通过<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues" target="_blank">万众一芯之香山处理器的 issue</a>分配。

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

以上是参与任务的流程环节，根据您选择的任务难度及完成情况，将会获得数额不等的奖金，您的努力将会获得回报。此外，如果您在验证过程中首次找到了 bug 并联系我们确认后，根据 bug 实际情况，还会获得额外的奖金 💴

请填写[报名问卷](https://www.wjx.top/vm/mB3EmwR.aspx)参与本期任务，也欢迎加入活动官方 qq 群：**600480230**。

本次验证任务请基于 UnityChipForXiangShan 提供的<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">验证框架</a>完成验证工作并向该仓库提交 PR。

## 任务详情

任务难度是根据理解难度、工作量等因素综合得出的，一般来说难度 1 ～ 3 的任务是简单的任务，4 ～ 7 的任务难度一般，或许工作量较大，或许需要花费一定时间理解任务隐藏信息，8 ～ 10 的任务较为困难，一般同时具有较大的工作量和较高的理解难度。

以下是本期各个子任务的详细介绍：

### 任务 1：LoadQueueRAR 子模块

LoadQueueRAR用于保存已经完成的load指令的用于load to load违例检测的信息。当load指令处于load流水线s2栈时，查询并分配空闲项将信息保存入LQRAR，在流水线s3栈时得到load to load违例检查的结果 ，如果出现违例则需要刷新流水线，给RedirectGenerator部件发送重定向请求, 冲刷违例的load之后的所有指令。

预期任务难度：5/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/01_lsq/01_loadqueuerar/" target="_blank">LoadQueueRAR 功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/131">LoadQueueRAR issue</a>

### 任务 2：LoadQueueRAW 子模块

LoadQueueRAW是用于处理store-load违例的。由于load和store在流水线中都是乱序执行，会经常出现load越过了更老的相同地址的store，即这条load本应该前递store的数据，但是由于store地址或者数据没有准备好，导致这条load没有前递到store的数据就已经提交，后续使用这条load结果的指令也都发生了错误，于是产生store to load forwarding违例。

当store address通过STA保留站发射出来进入store流水线时，会去查询LQRAW中在这条store后面的所有已经完成访存的相同地址的load，以及load流水线中正在进行的在该条store之后的相同地址的load，一旦发现有，就发生了store to load forwarding违例，可能有多个load发生了违例，需要找到离store最近的load，也就是最老的违例的load，然后给RedirectGenerator部件发送重定向请求，冲刷最老的违例的load及之后的所有指令。

预期任务难度：5/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/01_lsq/02_loadqueueraw/" target="_blank">LoadQueueRAW 功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/132">LoadQueueRAW issue</a>

### 任务 3：LoadQueueReplay 子模块

LoadQueueReplay 模块是现代处理器架构中用于处理 Load 指令重发的重要组成部分。它负责管理因各种原因而需要重发的 Load 指令，确保指令执行的正确性和高效性。

预期任务难度：8/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/01_lsq/03_loadqueuereplay/" target="_blank">LoadQueueReplay 功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/133">LoadQueueReplay issue</a>

### 任务 4：LoadQueueUncache 子模块验证

LoadQueueUncache 和 Uncache 模块，对于 uncache load 访问请求来说，起到一个从 LoadUnit 流水线到总线访问的中间站作用。其中 Uncache 模块，作为靠近总线的一方，主要用于处理 uncache 访问到总线的请求和响应。LoadQueueUncache 作为靠近流水线的一方，需要承担以下责任：

1. 接收 LoadUnit 流水线传过来的 uncache load 请求。

2. 选择已准备好 uncache 访问的 uncache load 请求 发送到 Uncache Buffer。

3. 接收来自 Uncache Buffer 的处理完的 uncache load 请求。

4. 将处理完的 uncache load 请求 返回给 LoadUnit。

LoadQueueUncache 结构上，目前有 4 项（项数可配）UncacheEntry，每一项独立负责一个请求并利用一组状态寄存器控制其具体处理流程；有一个 FreeList，管理各项分配和回收的情况。而 LoadQueueUncache 主要是协同 4 项的新项分配、请求选择、响应分派、出队等统筹逻辑。

预期任务难度：7/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/01_lsq/04_loadqueueuncache/" target="_blank">LoadQueueUncache 功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/134">LoadQueueUncache issue</a>

### 任务 5：VirtualLoadQueue 子模块验证

Virtualloadqueue是一个队列，用于存储所有load指令的微操作(MicroOp)，并维护这些load指令之间的顺序，它的功能类似于重排序缓冲区（Reorder Buffer, ROB），但专注于load指令的管理。其主要功能是跟踪Load指令执行状态，以确保在并发执行的环境中，加载操作能够正确、有序地完成。

预期任务难度：5/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/01_lsq/05_virtualloadqueue/" target="_blank">VirtualLoadQueue 功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/135">VirtualLoadQueue issue</a>

### 任务 6：StoreQueue 子模块验证

StoreQueue是一个队列，用来装所有的 store 指令，功能如下：

- 在跟踪 store 指令的执行状态

- 存储 store 的数据，跟踪数据的状态（是否到达）

- 为load提供查询接口，让load可以forward相同地址的store

- 负责 MMIO store和NonCacheable store的执行

- 将被 ROB 提交的 store 写到 sbuffer 中

- 维护地址和数据就绪指针，用于LoadQueueRAW的释放和LoadQueueReplay的唤醒

store进行了地址与数据分离发射的优化，即 StoreUnit 是 store 的地址发射出来走的流水线，StdExeUnit 是 store 的数据发射出来走的流水线，是两个不同的保留站，store 的数据就绪了就可以发射到 StdExeUnit，store 的地址就绪了就可以发射到 StoreUnit。

预期任务难度：7/10

功能文档参考：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/01_lsq/06_storequeue/" target="_blank">StoreQueue 功能</a>

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/136">StoreQueue issue</a>

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
