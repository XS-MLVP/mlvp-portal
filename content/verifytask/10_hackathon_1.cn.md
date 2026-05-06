---
title: "万众一芯黑客马拉松第一期：热身赛题(已完成)"
date: 2025-11-18T10:56:05+08:00
draft: false
fenbao_tags: [ "YunSuan", "UCAgent", "hackathon"]
status: "Completed"
task_closed: true
home_page_show: true
Weight: 11
summary: "用UCAgent验证参与黑客松，实战赢奖金"
schedule: 4
difficult: 5
image: "/images/malasong.png"
---

## 活动简介

欢迎参加本次黑客马拉松活动！本次黑客马拉松以“AI驱动开源芯片验证”为主题，聚焦基于大语言模型的硬件验证智能体UCAgent的实际应用。各位将在限定时间内，利用UCAgent人机协同进行UT模块验证，分析Fail test cases，找出赛题中隐藏的Bug。通过参与，您不仅能体验UCAgent工具在开源验证中的便利，还能作为开发者参与到开源芯片验证的生态中。

本次活动提供了15个人工注入的Bug供大家进行发现和分析，共有两个赛道：找Bug赛道和Token效率赛道。

- **Bug分级：** 每个模块含有注入5个bug，分别对应5个RTL原文件，简单难度2个、中等难度1个、困难难度2个。
- **Bug积分：** 简单难度 100分/个，中等难度300分/个, 困难500分/个。
- **Token效率：** 效率 `E = Bug个数/消耗总Token`


### 赛道介绍

- **找Bug赛道**： 对参赛队伍按获得的Bug积分进行排名（bug数需要大于5个），前三名将获得`证书 + 现金奖励`，其他名次将获得`证书`。
- **效率赛道**：利用UCAgent API模式分析Bug，按Token效率进行排名(bug数需不少于12个)，前三名将获得`证书 + 现金奖励`，其他名次将获得`证书`。
- **额外奖励**：首位发现Origin版本中的非人工注入Bug，获得现金奖励：`500-1000元/个 + 证书`。具体金额由UT设计者给出的Bug等级来定。

注：除了效率赛道外，其他赛道可用您任何擅长的工具或者方法，不仅限于UCAgent技术路线。

## 热身演示

### 第一步 使用UCAgent快速寻找Fail case

详细使用方法请参考[UCAgent使用手册](https://open-verify.cc/mlvp/docs/ucagent)。
提示：建议先熟悉UCAgent的基本操作，再开始正式任务。
### 第二步 基于Fail case进行bug分析

UCAgent会在`output/unity_test/tests`目录下生成一份`VectorIdiv_bug_analysis.md` 文档，列出所有检测到的bug并提供详细分析。例如：

```markdown
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

**注意**：bug报告中可能包含假阳性bug（即测试用例不符合要求导致的非源码类报错），因此需要结合阅读Spec文档分析失败的测试用例，以识别真正的bug。
例如：

- 第一个疑似bug（-128除以-1）分析：通过阅读Spec文档发现，这是由于结果超出RISC-V向量规范导致的报错，并非源码bug，可忽略。<br>
- 第二个疑似bug（除零异常）分析：通过分析Spec文档（[第12.2节 Risc-v M扩展整数除法章节：https://docs.riscv.org/reference/isa/unpriv/m-st-ext.html#division-operations](https://docs.riscv.org/reference/isa/unpriv/m-st-ext.html#division-operations)）确认：整数除法在除零时应返回定义值（商为全1，余数为被除数），而不应触发硬件异常。但测试中io_d_zero信号未置位，这表明是真正的源码bug。



### 第三步 提交结果

找到Bug后，请提交以下内容：

<table style="width: 100%; min-width: auto;">
  <tr>
    <th style="width: 25%;">所在文件名</th>
    <th style="width: 25%;">Bug说明</th>
    <th style="width: 25%;">Fail case文件相关</th>
    <th style="width: 25%;">Spec不一致的章节内容</th>
  </tr>
  <tr>
    <td>例如VectorIdiv_bug_1.v</td>
    <td> 说明触发bug的fail case、原因 </td>
    <td>output文件夹打包</td>
    <td>该Bug对应Spec当中要求不符的章节与内容</td>
  </tr>
</table>

将以上文件上传到指定平台即可完成提交。（提交地址暂未开放）



## 热身学习资源

为了帮助您快速上手，我们提供了以下资源：

#### **黑客马拉松仓库：[https://github.com/XS-MLVP/hackathon2512](https://github.com/XS-MLVP/hackathon2512)**

**无bug版本rtl：**
- **VectorFloatFMA_origin.v：[点击打开](https://github.com/XS-MLVP/hackathon2512/blob/main/origin_file/VectorFloatFMA_origin.v)**
- **VectorFloatAdder_origin.v：[点击打开](https://github.com/XS-MLVP/hackathon2512/blob/main/origin_file/VectorFloatAdder_origin.v)**
- **VectorIdiv_origin.v：[点击打开](https://github.com/XS-MLVP/hackathon2512/blob/main/origin_file/VectorIdiv_origin.v)**

**有bug版本rtl：**
- **VectorIdiv_bug_1.v：[点击打开](https://github.com/XS-MLVP/hackathon2512/blob/main/bug_file/VectorIdiv_bug_1.v)**

**Spec链接：**

**RISC-V官方V扩展Spec：[点击打开](https://github.com/riscv/riscv-v-spec/blob/master/v1.0.0/v1.0.0.pdf)**

**UCAgent仓库：[https://github.com/XS-MLVP/UCAgent](https://github.com/XS-MLVP/UCAgent)**

**UCAgent使用手册：[https://open-verify.cc/mlvp/docs/ucagent](https://open-verify.cc/mlvp/docs/ucagent)**

