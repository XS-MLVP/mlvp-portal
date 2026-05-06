---
title: "UT Practice Session 10: AI Vector Processor — Floating-Point Fused Add Module Verification (Completed)"
date: 2025-10-22T13:56:05+08:00
draft: false
fenbao_tags: ["Verification Case", "RACE", "Vector", "FloatAdd", "UT Verification"]
status: "Completed"
task_closed: true
home_page_show: true
Weight: 11
summary: "Take on the RISC-V Vector Extension practice challenge and verify an AI chip module firsthand"
schedule: 4
difficult: 5
image: "/images/UTyanzheng.png"
---

## Task Introduction

This verification task requires participants to complete the functional verification of a **vector floating-point fused add module (LaneFAdd)** implemented based on the RISC-V "V" extension, deepening the understanding of RISC-V Vector extension through hands-on practice.

The RISC-V "V" (Vector) extension aims to significantly improve processor performance in scientific computing, machine learning, and multimedia processing through Single Instruction Multiple Data (SIMD) parallel processing. The core idea of a vector processor is to use a single instruction to perform the same operation on all elements in a set of data (i.e., a "vector").

To achieve high parallelism, the execution modules of a vector processor are typically divided into multiple parallel "lanes" (**Lane**). Each Lane contains a set of dedicated execution units. When executing a vector instruction, the entire vector is split across all Lanes, with each Lane's execution units processing their respective data slices in parallel.

The verification target, LaneFAdd, is such an execution unit located within a Lane, specifically responsible for floating-point addition operations. It supports floating-point addition/subtraction and floating-point comparison instructions in the "V" extension, and additionally supports the BF16 floating-point format required for AI.

This task will provide Verilog code generated via Chisel conversion (**the original Chisel design source code will not be provided**).

Welcome everyone to participate. Please fill out the [registration form](https://www.wjx.top/vm/wFU6suy.aspx#) and join the discussion group:

1. Wanzhong Yixin Verification Exchange Group (QQ): 600480230
2. LaneFAdd Verification Exchange Group (QQ): 1028824516

## How to Participate

To participate in this verification task, you need to complete the following steps:

1. **Fill out the [registration form](https://www.wjx.top/vm/wFU6suy.aspx#)**
2. **Join the LaneFAdd Verification Exchange Group (WeChat group above)**
3. **Complete the verification work**: Conduct verification using the verification environment provided by the [ut-vector-fadd](https://github.com/RACE-org/ut-vector-fadd) repository
4. **Submit a PR**: Submit your verification results to that repository via Pull Request

### Submission of Results

Please submit your verification results via the following process:

1. **Fork the repository**: First, fork the repository [ut-vector-fadd](https://github.com/RACE-org/ut-vector-fadd)
2. **Complete development**: Implement verification code and write the verification report in your forked repository
3. **Submit a PR**: Once your work is ready, initiate a Pull Request to the original repository to submit your verification results

### Bug Reports

Please report bugs directly as issues in the repository. When submitting a bug, please select the bug label.

## Deliverable Requirements

The task requires the following deliverables:

1. Verification environment + API: The verification environment and API are code deliverables, encapsulating the data responsibilities (pins) and behavioral responsibilities (logic) of the Design Under Test (DUT). You need to provide specific reusable interfaces, test suites, test coverage definitions, etc. For reference on building the verification environment, see the <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/02_build_env/" target="_blank">verification environment setup tutorial</a>. For documentation on test coverage, refer to these two articles: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/04_cover_line/" target="_blank">line coverage</a> and <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/05_cover_func/" target="_blank">functional coverage</a>.
2. Test cases: Test cases are code deliverables that define the input combinations used for testing along with the expected output combinations. For reference on building test cases, see the <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/03_add_test/" target="_blank">test case addition tutorial</a>.
3. Verification report: The verification report is a written deliverable that includes introductions to the environment, test points, and test cases, the environment and commands required to reproduce the code, and reports on metrics such as test coverage.
   - For reference on writing verification reports, see this tutorial: <a href="https://open-verify.cc/mlvp/docs/basic/report/" target="_blank">verification report tutorial</a>
4. Other notes: If your project requires additional dependencies, please specify them in the test report or PR

This session requires participants to set up the verification environment independently.

> [!TIP]
> Participants can also use the AI-driven [UCAgent](https://github.com/XS-MLVP/UCAgent) to automatically build verification environments and generate test cases, and then further develop and refine on top of that.

## Reward Information

This verification task will be conducted as an online internship, with **limited spots**. Upon successful task completion, you will receive a base reward of 2000 yuan.

Additionally, there will be extra rewards for **finding and confirming bugs** in the LaneFAdd module.

## Task Details

For detailed information, please refer to the [verification_spec.md](https://github.com/RACE-org/ut-vector-fadd/blob/main/verification_spec.md) in the repository.

## Registration

Please fill out the [registration form](https://www.wjx.top/vm/wFU6suy.aspx#) to participate in this session. You are also welcome to join the Wanzhong Yixin official QQ group: **600480230**.

If you have any questions, you can contact the group admin in the WeChat or QQ group, or reach out to the Wanzhong Yixin official email: unitychip@bosc.ac.cn.