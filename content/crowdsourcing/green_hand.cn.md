---
title: '新手入门任务'
date: 2025-01-02T08:50:39+08:00
draft: false
resource_tags: ["文档", "学习资料"]
status: "seeding"
summary: "万众一芯活动的新手任务，了解基于万众一芯的框架和工具完成验证的全流程"
weight: 99
task_closed: false
home_page_show: true
---

在这次新手任务中，您将：

——基本了解和使用“万众一芯”验证的工具

——了解硬件验证的全流程基础知识

——了解基于万众一芯框架的环境搭建和测试用例编写

——参与实战：亲手尝试验证果壳Cache模块

## 学习任务1：基础概念和工具使用

在这一期任务中，您将会通过对验证基础理论的阅读学习建立起硬件验证的世界观和对硬件验证的基本理解，以便更好地参与到万众一芯的验证活动中。

同时，您将会学习万众一芯提供的强大工具picker的基本使用方法。这一工具支持将硬件语言的DUT转换为常用的软件语言并暴露基本调用方法，从而使纯软件语言的验证方式成为可能。

### 基础概念

对于参与“万众一芯”开放验证活动的朋友们来说，或许各位有一定的硬件验证经验，或许只有软件测试的经验，或许只是对香山的开源验证感兴趣。为此，或许各位会有一些疑问，比如：

为什么需要硬件验证？

为什么香山可以进行开源的硬件验证？

硬件验证和软件验证有何区别？

……

因此，在本部分中，各位会通过对硬件验证基础理论，包括芯片验证的背景、数字电路的基础知识和硬件验证的流程等进行初步的学习，建立起硬件验证的世界观，从而更好地理解“万众一芯”工作的目的和重要性。

本部分的学习任务分为以下几个部分：

**芯片验证的基础知识**：了解芯片验证的概念、流程、指标、管理方式、现状，以及“万众一芯”项目分包验证的可行性基础等（<a href="/mlvp/docs/basic/ic_verify/" target="_blank">教程链接</a>）。

**数字电路**：了解数字电路的基本概念、数字电路学习的必要性、常用的硬件描述语言等（<a href="/mlvp/docs/basic/ic_base/" target="_blank">教程链接</a>）。

**创建DUT**：了解DUT的概念、chisel转换verilog的方法、verilog编译的方式（<a href="/mlvp/docs/basic/create_dut/" target="_blank">教程链接</a>）。

**DUT验证**：了解DUT验证的步骤，亲自上手完成一个简单样例——果壳Cache的验证（教程链接：<a href="/mlvp/docs/basic/test_dut/" target="_blank">教程链接</a>）。涉及到的picker工具相关的内容可以先跳过，后续再来学习。

**验证报告**：了解验证报告的写作内容（<a href="/mlvp/docs/basic/report/" target="_blank"> 教程链接 </a>）。

### 基本工具

俗话说，“工欲善其事，必先利其器”，考虑到硬件验证的入门门槛，万众一芯为各位同学准备了picker——一种将硬件语言的DUT转化成软件语言DUT的工具——和相关的配套教程，如下所示：

**picker介绍**：学习picker的原理、使用picker将待测模块转化为python模块的方法、基本的数据结构定义等（<a href="/mlvp/docs/env_usage/picker_usage/" target="_blank"> 教程链接 </a>）。

**波形生成**：学习picker生成波形和后处理的方法，有条件的可以查看本节中生成的波形图（<a href="/mlvp/docs/env_usage/wave/" target="_blank">教程链接</a>）。

**多文件输入**：学习使用picker处理多文件输入的场景，从而可以转化有多个依赖的模块（<a href="/mlvp/docs/env_usage/multifile/" target="_blank">教程链接</a>）。

**覆盖率统计**：了解使用picker基于verilator仿真生成测试覆盖率的方法（<a href="/mlvp/docs/env_usage/coverage/" target="_blank">教程链接</a>）。

**测试框架集成**：了解picker和现有测试框架（包括pytest和hypothesis）集成的方法（<a href="/mlvp/docs/env_usage/frameworks/" target="_blank">教程链接</a>）。

## 学习任务2：验证环境和dut封装

除了直接操作DUT进行验证，万众一芯还提供了一套基于pytest的验证框架toffee，按照本任务的学习安排，您将先了解一般性的环境配置方法和使用常规方法完成测试的案例，包含加法器、随机数生成器和用两种方式测试的双端口栈，这之后，课程将介绍如何安装toffee框架，以及基于toffee框架完成验证环境搭建的过程。

### 案例演示

为进一步展示使用软件语言验证硬件的方式，本节将展示4个简单案例，包含加法器、随机数生成器和双端口栈三种DUT。其中对于双端口栈，将展示协程和回调两种验证方式。

**环境准备**：为进行验证，需要先在环境中配置picker支持，具体可以参考<a href="/mlvp/docs/quick-start/installer/" target="_blank">这篇教程</a>。

**加法器**：本案例给出了一个极简加法器，并将利用picker对此进行测试，以此完整地展示使用picker完成模块验证的流程。点击<a href="/mlvp/docs/quick-start/eg-adder/" target="_blank">这里</a>阅读完整教程。

**随机数生成器**：上一案例的加法器是一个简单的组合逻辑电路，接下来，课程将通过对随机数生成器案例的验证展示如何使用picker验证一个时序逻辑电路。点击<a href="/mlvp/docs/quick-start/eg-rmg/" target="_blank">这里</a>阅读完整教程。

**基于回调的双端口栈验证**：前述的两个案例规模都较小，而且较为线性，不涉及到并发问题，然而，这之后，课程将展示一个并发的案例：双端口栈，并给出两种验证的方式：回调函数和协程。基于回调函数的验证方式通过注册回调函数和模拟状态机的方式驱动DUT。但是，回调驱动的方式将DUT的逻辑拆分为了多个状态和函数调用，大大增加了复杂性，对代码的编写和调试也提出了要求。点击<a href="/mlvp/docs/quick-start/eg-stack-callback/" target="_blank">这里</a>阅读完整教程。

**基于协程的双端口栈验证**：除了基于回调函数的方式，双端口栈还可以基于协程完成验证，能够更好地保留独立的执行流，但是协程之间的同步和管理也存在相当的困难。这也正是万众一芯开发toffee测试框架的原因之一。点击<a href="/mlvp/docs/quick-start/eg-stack-async/" target="_blank">这里</a>阅读完整的双端口栈协程验证教程。

### toffee工具安装

接下来，课程将介绍万众一芯为python语言开发的一套测试框架：toffee（以及配套的toffee\-test）。这套框架基于picker打包的dut，进一步构建了对数据职责和功能职责的封装，并封装了复杂的硬件周期逻辑，使开发人员的代码编写得以进一步简化。

要使用这一工具，首先自然是需要配置好toffee。toffee的安装依赖于3.6.8以上的python和0.9.0以上的picker。配置完成依赖后，可以通过pip或者直接从git仓库下载toffee并本地安装。详细的安装教程请参照<a href="/mlvp/docs/mlvp/quick-start/" target="_blank">这里</a>。

### 规范的验证环境

toffee一个较为核心的目的是对验证环境进行规范，因此toffee着眼于测试用例的可复用性，封装DUT的数据职责为Bundle；同样是基于可复用性的考虑，toffee将DUT的行为职责拆分为多个Agent。最后，为了更好地进行结果的比对，toffee提供了参考模型机制，让框架使用测试者的参考模型代码进行验证。详细的验证环境规范和toffee设计思路请参考<a href="/mlvp/docs/mlvp/canonical_env/" target="_blank">这篇文档</a>。

### 使用toffee框架搭建验证代码

这一节将展示一个实例，演示如何使用toffee为一个复杂的DUT搭建测试环境，支持搭建一套封装了数据职责和行为职责的环境，异步测试一个DUT。

以下是按照搭建环境的步骤给出的<a href="/mlvp/docs/mlvp/env/" target="_blank">教程</a>简介。

1\. toffee 内置了python的协程机制以构建异步环境，因此需要对toffee的异步和时钟机制有一个基本的了解。请阅读<a href="/mlvp/docs/mlvp/env/start_test" target="_blank">这篇教程</a>建立基本的概念。

2\. toffee希望对DUT的数据职责进行封装，从而提高测试用例的可复用性，因此，Bundle机制应运而生，请您阅读<a href="/mlvp/docs/mlvp/env/bundle" target="_blank">这篇教程</a>，了解书写Bundle的方法。

3\. toffee完成了对一类Bundle中信号处理逻辑的高层封装，使得上层可以在不关心具体信号赋值的情况下，完成对Bundle中信号的驱动和监测，这就是Agent。请阅读<a href="/mlvp/docs/mlvp/env/agent" target="_blank">这篇教程</a>了解Agent书写方式。

4\. toffee进一步地提供了对整个验证环境打包的支持，用来将上一步中定义的agent完成实例化，这是由Env完成的。请阅读<a href="/mlvp/docs/mlvp/env/build_env" target="_blank">这篇教程</a>，了解相关的内容。

5\. 在输出并不明确可知的情况下，测试者需要书写参考模型。toffee框架提供了两种参考模型写法：函数调用方式的和独立执行流方式的。这两种参考模型都能在执行过程中完成对执行结果的校验。请阅读<a href="/mlvp/docs/mlvp/env/ref_model" target="_blank">这篇教程</a>学习参考模型的写法。

## 学习任务3：测试用例编写

环境搭建完毕后，就可以开始着手编写测试用例了，在本学习任务中，课程希望您了解以下知识：

**使用测试环境接口进行驱动**：如果只有一个驱动函数，那么直接调用即可，然而如果有多个驱动函数呢？toffee提供了异步执行器以使用户更便捷地进行多驱动的方法调用。请阅读<a href="/mlvp/docs/mlvp/cases/executor/" target="_blank">这篇教程</a>以了解详情。

**使用pytest管理测试用例**：toffee使用pytest对测试用例和测试套件进行有效管理，可以通过<a href="/mlvp/docs/mlvp/cases/pytest/" target="_blank">这篇教程</a>来了解详情。

**功能检查点**：怎么判断一个测试的好坏呢？**测试覆盖率**是一个常用的衡量测试质量的指标。这其中，行覆盖率可以自动分析，但是功能覆盖率需要手动添加检查点进行判定。因此，toffee提供了一套检查点机制，请阅读<a href="/mlvp/docs/mlvp/cases/cov/" target="_blank">这篇教程</a>了解更多。

## 学习任务4：果壳Cache实战

在学习了前述的知识后，相信你已经对硬件验证的方法有了一定的概念，请进行一次实战吧！请你在已完成验证的果壳Cache进行验证，撰写验证代码和测试报告，并在UnityChipForXiangShan的<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/discussions/13" target="_blank">github讨论板块</a>提交验证报告和代码。报告内容应当包含功能梳理、测试点分解、测试用例编写、验证结果分析和验证结论等。

验证报告的格式可以参考先前的<a href="https://github.com/XS-MLVP/Example-NutShellCache/blob/master/nutshell_cache_report_demo.pdf" target="_blank">果壳Cache验证案例</a>完成您的验证。

## 其他注意事项

当您参与“万众一芯”组织的任意活动时，只要能够为香山处理器找出bug，根据bug情况可以获得1000元左右的奖励。

## 报名链接
[点击此处](https://www.wjx.top/vm/YEbqmTM.aspx)填写报名表即可报名。报名完成后可加入QQ群（群号：<b>1033196714</b>）以便联系我们。