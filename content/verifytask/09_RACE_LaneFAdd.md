---
title: "UT实战第十期：AI 向量处理器—浮点混合加法模块验证实战 (已完成)"
date: 2025-10-22T13:56:05+08:00
draft: false
fenbao_tags: ["验证案例", "RACE", "Vector", "FloatAdd", "UT验证"]
status: "Completed"
task_closed: true
home_page_show: true
Weight: 11
summary: "挑战RISC-V向量扩展实战，亲手验证AI芯片模块"
schedule: 2
difficult: 5
---

## 任务介绍

本期验证任务要求参与者完成基于 RISC-V "V" 扩展实现的 **向量浮点混合加法模块(LaneFAdd)** 的功能验证，通过在实战中加深对 RISC-V 向量扩展的理解。

RISC-V "V" (Vector) 扩展旨在通过单指令多数据（SIMD）并行处理模式，显著提升处理器在科学计算、机器学习、多媒体处理等领域的性能。向量处理器的核心思想是使用一条指令，对一组数据（即"向量"）中的所有元素执行相同的操作。

为实现高并行度，向量处理器的执行模块通常被划分为多个并行的"通道"（**Lane**）。每个 Lane 包含一组专用的执行单元。当执行一条向量指令时，整个向量被拆分到各个 Lane 中，由每个 Lane 的执行单元并行处理各自的数据分片。

本次验证的对象 LaneFAdd 就是这样一个位于 Lane 内部、专门负责浮点加法相关的执行单元，支持“V”拓展中的浮点加减法及浮点比较等指令，并且额外支持 AI 所需的BF16浮点格式。

本次任务将提供经 Chisel 转换生成的 Verilog 代码（**原始 Chisel 设计源代码不予提供**）。

欢迎各位报名参加，请填写[报名问卷](https://www.wjx.top/vm/wFU6suy.aspx#)并加入交流群:

1. 万众一芯验证交流群(QQ)：600480230
2. LaneFAdd 验证交流群(QQ)：1028824516

## 如何参与

参与本次验证任务需要完成以下步骤：

1. **填写[报名问卷](https://www.wjx.top/vm/wFU6suy.aspx#)**
2. **加入 LaneFAdd 验证交流群(上方的微信群)**
3. **完成验证工作**：基于 [ut-vector-fadd](https://github.com/RACE-org/ut-vector-fadd) 仓库提供的验证环境开展验证
4. **提交PR**：将验证结果通过Pull Request方式提交至该仓库

### 成果提交

请按以下流程提交您的验证成果：

1. **Fork仓库**：首先fork仓库 [ut-vector-fadd](https://github.com/RACE-org/ut-vector-fadd)
2. **完成开发**：在fork的仓库中完成验证代码的实现和验证报告的编写
3. **提交PR**：成果准备就绪后，请向原仓库发起Pull Request，提交您的验证成果

### Bug 报告

请直接在仓库中的issue反馈 bug。提交bug时，请在label中选择bug标签。

## 成果需求

任务需要提交以下成果：

1. 验证环境+API：验证环境和API是代码成果，是针对待验证对象（DUT）的数据职责（引脚）和行为职责（逻辑）的封装，需要提供特定的可复用的接口、测试套件、测试覆盖率等的定义。其中，搭建验证环境可以参考<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/02_build_env/" target="_blank">验证环境搭建教程</a>，测试覆盖率相关的文档可以参考这两篇：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/04_cover_line/" target="_blank">行覆盖率</a>、<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/05_cover_func/" target="_blank">功能覆盖率</a>。
2. 测试用例：测试用例是代码成果，定义了用于测试的输入组合，以及预期的输出组合。构建测试用例可以参考<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/03_add_test/" target="_blank">测试用例添加教程</a>
3. 验证报告：验证报告是文字成果，包括对环境、测试点和测试用例的介绍，复现代码所需的环境和指令，以及对测试覆盖率等衡量指标的报告。
   - 验证报告的书写可以参考这篇教程：<a href="https://open-verify.cc/mlvp/docs/basic/report/" target="_blank">验证报告教程</a>
4. 其他说明：如果运行您的项目需要其他的依赖，可在测试报告或PR中说明

本期任务需要参与者自行搭建验证环境。

> [!TIP]
> 参与者也可以通过 AI 驱动的 [UCAgent](https://github.com/XS-MLVP/UCAgent) 自动构建验证环境并生成测试用例，随后在此基础之上进行深入的开发和完善。

## 奖励信息

本次验证任务将以线上实习的方式进行，**名额有限**，任务完成后将得到2000元的基础奖金。

此外，如果为 LaneFAdd 模块**找出 bug 并反馈确认后**，还会有额外奖金。

## 任务详情

详情请查阅仓库中的 [verification_spec.md](https://github.com/RACE-org/ut-vector-fadd/blob/main/verification_spec.md)。

## 报名方式

请填写[报名问卷](https://www.wjx.top/vm/wFU6suy.aspx#)参与本期任务，也欢迎加入万众一芯官方qq群：**600480230**。

如有疑问可在微信群或qq群中联系群主，或联系万众一芯官方邮箱：unitychip@bosc.ac.cn。
