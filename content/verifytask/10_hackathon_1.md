---
title: "万众一芯黑客马拉松第一期：热身赛题(进行中)"
date: 2025-11-18T10:56:05+08:00
draft: false
fenbao_tags: [ "YunSuan", "UCAgent", "hackathon"]
status: "Continuing"
task_closed: false
home_page_show: true
Weight: 11
summary: "用UCAgent验证参与黑客松，实战赢奖金"
schedule: 2
difficult: 5
---

## 赛题简介

本次黑客马拉松以“AI驱动开源芯片验证”为主题，聚焦基于大语言模型的硬件验证智能体UCAgent的实际应用。各位将在限定时间内，利用UCAgent人机协同进行模块验证，分析生成file case，找出题目当中的BUG/提升token效率。希望让大家能体验到使用 UCAgent 工具在开源验证中的便利，同时作为开发者参与到开源芯片验证的生态当中。

本次黑客马拉松比赛分为两个排名赛道，找bug赛道和token效率赛道，

本期赛题均选自香山昆明湖架构的YunSuan运算功能单元三个向量计算模块：向量浮点融合乘加器、向量浮点加法器和向量整数除法器。每个模块含有五道题，分为**1、2题为简单难度；3题为中等难度；4、5题困难难度**，共15道题。各组需要至少找到一共5个Bug才能获得排名资格。

这里给出三个模块供各位参赛者熟悉UCAgent验证流程：
[VectorFMA无bug版本](hackathon/VectorFMA.v)
[VectorFAdd无bug版本](hackathon/VectorFAdd.v)
[VectorIdiv无bug版本](hackathon/VectorIdiv.v)


## YunSuan介绍

YunSuan模块是开源高性能RISC-V处理器项目XiangShan（香山）的核心组成部分，专门负责实现处理器的各种算术和逻辑运算功能，包括整数运算单元、浮点运算单元、向量处理单元等。YunSuan模块与XiangShan处理器的流水线紧密集成，为RISC-V指令集提供完整的运算支持。

## 热身赛题

VectorIdiv第一道题：[VectorIdiv_BUG1.v](hackathon/VectorIdiv_BUG1.v)

**下面将以VectorIdiv模块的第一道题为例展示完成一个找BUG的全流程：**

VectorIdiv 是一个支持多种数据位宽的向量整数除法器模块。它通过并行实例化多个不同位宽的除法子模块来处理向量数据，采用状态机控制除法流程，最终输出商、余数向量和除零标志。该设计实现了高效的向量化整数除法运算。

### UCAgent下载与初始化

在对UCAgent进行下载后，通过<!-- ` - Single backtick --> make init <!-- ` - Single backtick -->完成环境配置，在<!-- ` - Single backtick --> UCAgent/examples <!-- ` - Single backtick -->文件夹下创建<!-- ` - Single backtick --> VectorIdiv <!-- ` - Single backtick -->文件夹，放入题目1给出的verilog文件，并用Spec链接完成README.md文件的编写，最后通过<!-- ` - Single backtick --> make init_VectorIdiv <!-- ` - Single backtick -->完成UCAgent的初始化。

### UCAgent使用

UCAgent提供了两种方式与LLM进行交互。一种通过标准化API与大语言模型进行直接交互，另一种则是通过MCP协议与通用Code Agent进行深度协同。**（需要注意的是，token效率赛道需要使用API模式，并对UCAgent进行自定义配置，从而达到更好的效率）**
以MCP模式为例，通过<!-- ` - Single backtick --> make mcp_VectorIdiv <!-- ` - Single backtick -->即可启动该模式的tui界面。然后在<!-- ` - Single backtick --> UCAgent/output <!-- ` - Single backtick -->文件夹下，在所用Code Agent的CLI界面中输入提示词<!-- ` - Single backtick --> 请通过工具RoleInfo获取你的角色信息和基本指导，然后完成任务。请使用工具ReadTextFile读取文件。你需要在当前工作目录进行文件操作，不要超出该目录。 <!-- ` - Single backtick -->即可开启验证。

若Code Agent中途中断，可输入<!-- ` - Single backtick --> 继续，请通过工具Check和Complete判断是否完成所有任务 <!-- ` - Single backtick -->提示词继续验证。

验证生成的文件可在<!-- ` - Single backtick --> output <!-- ` - Single backtick -->文件夹中查看。

### 找BUG1:d_zero标记位未被设置为高电平状态

在<!-- ` - Single backtick --> VectorIdiv_bug_analysis.md <!-- ` - Single backtick -->文档中给出了本次验证所跑出的所有bug，并给出了详细的bug分析：

```
## VectorIdiv 缺陷分析

### 边界与异常处理

<FG-BOUNDARY_EXCEPTION>

#### 边界值测试: <FC-BOUNDARY>
- <CK-DIV_BY_NEG_ONE> 检测点：有符号数除以-1
  - <BG-DIV_BY_NEG_ONE-0> 当一个有符号数的最小负值（例如，对于8位整数是-128）除以-1时，预期的结果应该是该数的绝对值（128），但这超出了8位有符号数的表示范围（-128到127）。根据RISC-V向量规范，这种情况下商应保持为被除数（-128），余数应为0。然而，DUT的实现似乎未能正确处理此溢出情况。
    - <TC-test_VectorIdiv_templates.py::test_boundary_conditions>
  - **根因分析**:
    在 `VectorIdiv_BUG1.v` 的 `I8DivNr4` 模块中，对于商的计算没有特殊处理溢出情况。
    ```verilog
    // VectorIdiv_BUG1.v
    150: assign io_div_out_q = Lkm7UANb3k7urrE;
    ```
    `Lkm7UANb3k7urrE` 的计算逻辑未能考虑到 `-128 / -1` 的溢出。
  - **修复建议**:
    应在计算商的逻辑中增加一个检查，如果是有符号运算且除数为-1，并且被除数是最小负值，则商应等于被除数本身。

#### 异常处理: <FC-EXCEPTION>
- <CK-DIV_BY_ZERO> 检测点：除零异常
  - <BG-DIV_BY_ZERO-0> 当除数为零时，DUT应产生一个除零异常。根据 `VectorIdiv_function_coverage_def.py` 中的定义，这要求 `io_d_zero` 信号不为零。然而，在测试中发现，即使除数为零，`io_d_zero` 信号仍然为零，表明异常没有被正确触发。
    - <TC-test_VectorIdiv_templates.py::test_boundary_conditions>
  - **根因分析**:
    在 `VectorIdiv_BUG1.v` 的 `I8DivNr4` 模块中，`YOzhvk` 信号正确地识别了除数为零的情况 (`bO1Bf == 8'h0`)。但是，这个状态没有被用来驱动 `io_d_zero` 输出。
    ```verilog
    // VectorIdiv_BUG1.v
    90: wire       YOzhvk = bO1Bf == 8'h0;
    ```
    `io_d_zero` 信号没有在 `I8DivNr4` 模块中被赋值，因此它保持默认值0。
  - **修复建议**:
    应将 `YOzhvk` 信号连接到 `io_d_zero` 输出，或者使用 `YOzhvk` 来设置一个在除零时会置位的寄存器，并最终驱动 `io_d_zero`。
```

由于bug中包含假阳性bug，即测试用例不符合要求等原因导致的非源码类报错，因此需要通过阅读文档分析file case，结合，分析出真正的bug：

第一个bug由于-128除以-1得到的128超出了RISC-V向量规范导致的报错，并非源码类bug，因此忽略。

第二个bug经过复查可以发现为io_d_zero信号本身的问题。

因此我们可以发现本次bug为io_d_zero标记位未被设置为高电平状态，即除数为0时，io_d_zero未被设置为高电平状态。

### 结果提交

在找到了Bug后，参赛小组需要给出：

1. Bug文档：说明Bug的除法原因与分析，包括该Bug所在Spec链接当中的章节与行数；

2. 触发 Bug 的波形文件

将以上文件进行打包上传，提交到指定平台。



## 热身学习资源
**SPEC链接：**

[向量整数除法指令](https://docs.riscv.org/reference/isa/unpriv/v-st-ext.html#vector-integer-divide-instructions)

[向量浮点指令](https://docs.riscv.org/reference/isa/unpriv/v-st-ext.html#sec-vector-float)

**UCAgent链接：https://github.com/XS-MLVP/UCAgent**

**UCAgent使用手册：https://open-verify.cc/mlvp/docs/ucagent**

