---
title: "UnityChip Hackathon Season 1: Warm-up Challenge (Completed)"
date: 2025-11-18T10:56:05+08:00
draft: false
fenbao_tags: [ "YunSuan", "UCAgent", "hackathon"]
status: "Completed"
task_closed: true
home_page_show: true
weight: 11
summary: "Use UCAgent to participate in the hackathon and win prizes through practical combat"
schedule: 4
difficult: 5
image: "/images/malasong.png"
---

## Event Overview

Welcome to this Hackathon event! Themed "AI-Driven Open-Source Chip Verification", this hackathon focuses on the practical application of the large language model-based hardware verification agent UCAgent. Within a limited time, participants will use UCAgent for human-machine collaborative UT module verification, analyzing Fail test cases to identify hidden bugs in the challenges. By participating, you will not only experience the convenience of UCAgent tools in open-source verification but also contribute as a developer to the open-source chip verification ecosystem.

This event provides 15 artificially injected bugs for discovery and analysis, with two tracks: the Bug Hunt Track and the Token Efficiency Track.

- **Bug Classification:** Each module contains 5 injected bugs, corresponding to 5 RTL source files respectively: 2 easy, 1 medium, and 2 hard difficulty.
- **Bug Scoring:** Easy difficulty 100 points/bug, medium difficulty 300 points/bug, hard difficulty 500 points/bug.
- **Token Efficiency:** Efficiency `E = Number of Bugs / Total Tokens Consumed`


### Track Introduction

- **Bug Hunt Track**: Teams are ranked by bug points earned (minimum 5 bugs required). Top 3 teams receive `Certificate + Cash Reward`, other rankings receive `Certificate`.
- **Efficiency Track**: Analyze bugs using UCAgent API mode, ranked by Token efficiency (minimum 12 bugs required). Top 3 teams receive `Certificate + Cash Reward`, other rankings receive `Certificate`.
- **Extra Reward**: The first to discover non-artificially injected bugs in the Origin version receives a cash reward: `500-1000 CNY/bug + Certificate`. The specific amount is determined by the bug severity given by the UT designer.

Note: Except for the Efficiency Track, other tracks can use any tools or methods you are proficient in, not limited to the UCAgent technical approach.

## Warm-up Demo

### Step 1: Use UCAgent to Quickly Find Fail Cases

For detailed usage instructions, please refer to the [UCAgent User Manual](https://open-verify.cc/mlvp/docs/ucagent).
Tip: It is recommended to familiarize yourself with UCAgent's basic operations before starting the official task.

### Step 2: Bug Analysis Based on Fail Cases

UCAgent will generate a `VectorIdiv_bug_analysis.md` document in the `output/unity_test/tests` directory, listing all detected bugs with detailed analysis. For example:

```markdown
## VectorIdiv Defect Analysis

### Boundary and Exception Handling

<FG-BOUNDARY_EXCEPTION>

#### Boundary Value Test: <FC-BOUNDARY>
- <CK-DIV_BY_NEG_ONE> Detection Point: Signed number divided by -1
  - <BG-DIV_BY_NEG_ONE-0> When a signed number's minimum negative value (for example, -128 for an 8-bit integer) is divided by -1, the expected result should be the absolute value of that number (128), but this exceeds the representable range of 8-bit signed numbers (-128 to 127). According to the RISC-V vector specification, in this case the quotient should remain as the dividend (-128), and the remainder should be 0. However, the DUT implementation does not appear to correctly handle this overflow situation.
    - <TC-test_VectorIdiv_templates.py::test_boundary_conditions>
  - **Root Cause Analysis**:
    In the `I8DivNr4` module of `VectorIdiv_BUG1.v`, there is no special handling for overflow in the quotient calculation.
    ```verilog
    // VectorIdiv_BUG1.v
    150: assign io_div_out_q = Lkm7UANb3k7urrE;
    ```
    The calculation logic of `Lkm7UANb3k7urrE` does not account for the overflow of `-128 / -1`.
  - **Fix Suggestion**:
    A check should be added to the quotient calculation logic: if it is a signed operation, the divisor is -1, and the dividend is the minimum negative value, then the quotient should equal the dividend itself.

#### Exception Handling: <FC-EXCEPTION>
- <CK-DIV_BY_ZERO> Detection Point: Division by zero exception
  - <BG-DIV_BY_ZERO-0> When the divisor is zero, the DUT should generate a division by zero exception. According to the definition in `VectorIdiv_function_coverage_def.py`, this requires the `io_d_zero` signal to be non-zero. However, during testing, it was found that even when the divisor is zero, the `io_d_zero` signal remains zero, indicating that the exception was not correctly triggered.
    - <TC-test_VectorIdiv_templates.py::test_boundary_conditions>
  - **Root Cause Analysis**:
    In the `I8DivNr4` module of `VectorIdiv_BUG1.v`, the `YOzhvk` signal correctly identifies when the divisor is zero (`bO1Bf == 8'h0`). However, this state is not used to drive the `io_d_zero` output.
    ```verilog
    // VectorIdiv_BUG1.v
    90: wire       YOzhvk = bO1Bf == 8'h0;
    ```
    The `io_d_zero` signal is not assigned in the `I8DivNr4` module, so it remains at its default value of 0.
  - **Fix Suggestion**:
    The `YOzhvk` signal should be connected to the `io_d_zero` output, or use `YOzhvk` to set a register that is asserted during division by zero and ultimately drives `io_d_zero`.
```

**Note**: Bug reports may contain false positive bugs (i.e., non-source-code errors caused by test cases not meeting requirements), so it is necessary to analyze failed test cases in conjunction with reading the Spec document to identify real bugs.
For example:

- First suspected bug (-128 divided by -1) analysis: Through reading the Spec document, it was found that this is an error caused by the result exceeding the RISC-V vector specification, not a source code bug, and can be ignored.<br>
- Second suspected bug (division by zero exception) analysis: By analyzing the Spec document ([Section 12.2 RISC-V M Extension Integer Division Chapter: https://docs.riscv.org/reference/isa/unpriv/m-st-ext.html#division-operations](https://docs.riscv.org/reference/isa/unpriv/m-st-ext.html#division-operations)), it is confirmed: integer division should return a defined value when dividing by zero (quotient is all 1s, remainder is the dividend), and should not trigger a hardware exception. However, the `io_d_zero` signal was not asserted in the test, indicating this is a real source code bug.



### Step 3: Submit Results

After finding bugs, please submit the following:

<table style="width: 100%; min-width: auto;">
  <tr>
    <th style="width: 25%;">Source File Name</th>
    <th style="width: 25%;">Bug Description</th>
    <th style="width: 25%;">Related Fail Case Files</th>
    <th style="width: 25%;">Spec Inconsistency Section Content</th>
  </tr>
  <tr>
    <td>Example: VectorIdiv_bug_1.v</td>
    <td> Describe the fail case that triggers the bug and the cause </td>
    <td>Package the output folder</td>
    <td>The section and content in the Spec that does not match this bug</td>
  </tr>
</table>

Upload the above files to the designated platform to complete submission. (Submission address not yet open)



## Warm-up Learning Resources

To help you get started quickly, we provide the following resources:

#### **Hackathon Repository: [https://github.com/XS-MLVP/hackathon2512](https://github.com/XS-MLVP/hackathon2512)**

**Bug-free RTL versions:**
- **VectorFloatFMA_origin.v: [Click to open](https://github.com/XS-MLVP/hackathon2512/blob/main/origin_file/VectorFloatFMA_origin.v)**
- **VectorFloatAdder_origin.v: [Click to open](https://github.com/XS-MLVP/hackathon2512/blob/main/origin_file/VectorFloatAdder_origin.v)**
- **VectorIdiv_origin.v: [Click to open](https://github.com/XS-MLVP/hackathon2512/blob/main/origin_file/VectorIdiv_origin.v)**

**Buggy RTL versions:**
- **VectorIdiv_bug_1.v: [Click to open](https://github.com/XS-MLVP/hackathon2512/blob/main/bug_file/VectorIdiv_bug_1.v)**

**Spec Links:**

**RISC-V Official V Extension Spec: [Click to open](https://github.com/riscv/riscv-v-spec/blob/master/v1.0.0/v1.0.0.pdf)**

**UCAgent Repository: [https://github.com/XS-MLVP/UCAgent](https://github.com/XS-MLVP/UCAgent)**

**UCAgent User Manual: [https://open-verify.cc/mlvp/docs/ucagent](https://open-verify.cc/mlvp/docs/ucagent)**
