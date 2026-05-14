---
title: 'UT Practical Training Phase 2: Third Generation Xiangshan (Kunming Lake) Architecture IFU Module UT Verification Practice (In Progress)'
date: 2024-12-11T10:47:18+08:00
draft: false
fenbao_tags: ["Verification Cases", "IFU", "UT Verification"]
#website: "/xs-bpu/"
status: "Completed"
task_closed: true
home_page_show: true
Weight: 11
summary: "Learning the microarchitecture design of Xiangshan IFU during verification."
image: "/images/UTyanzheng.png"
---

In this verification task, participants will get close to the IFU module of the Xiangshan Kunming Lake architecture. Through practical verification, you will experience the design concepts of the Xiangshan instruction fetching module and deepen your understanding of the RISC-V instruction set architecture. Everyone is welcome to sign up (please fill out the registration here, QQ group: 600480230)!

The IFU (Instruction Fetch Unit) is responsible for receiving requests from the FTQ and fetching instruction cache lines from the ICache or Instruction Uncache as input. It performs multiple functions, including instruction fetching, pre-decoding, RVC instruction expansion to RVI instructions, and BPU prediction error pre-checking. Ultimately, it outputs preliminary decoding information and instruction codes to the IBuffer and writes back the results to the FTQ.

In this task, a total of 4 sub-tasks will be released, covering 5 sub-modules of the IFU (PreDecode, F3Predecoder, RVCExpander, PredChecker, and FrontendTrigger). All tasks will be assigned through the <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues" target="_blank">issues of the UnityChip for Xiangshan processor</a>.

## Participate in Verification

For this verification task, please complete the verification work based on the <a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">verification framework</a> provided by UnityChipForXiangShan and submit a PR to the repository.

### Submission of Results

Please fork the above UnityChipForXiangShan repository, complete the verification code and documentation, and once everything is ready, initiate a PR to submit your results.

### Bug Report

Please use the bug report template to create an issue directly in the UnityChipForXiangShan repository, or quickly click [here].(https://github.com/XS-MLVP/UnityChipForXiangShan/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=%5BBUG%5D+)。

When submitting a bug, please first select the "bug need to confirm" label. Then, choose one of the four bug severity levels (minor, normal, serious, critical) that you think is most appropriate. Finally, select the module where you found the bug; for this verification, the focus is on the frontend ifu module, so you should apply the ut_frontend.ifu label.

## Result Requirements

Each subtask requires the following deliverables:
1. Verification Environment + API: The verification environment and API are the code deliverables that encapsulate the data responsibilities (pins) and behavioral responsibilities (logic) of the device under test (DUT). They must provide specific reusable interfaces, test suites, and definitions of test coverage, among other things. For setting up the verification environment, you can refer to the <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/02_build_env/" target="_blank">Verification Environment Setup Tutorial</a>, and for documentation related to test coverage, refer to these two articles: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/04_cover_line/" target="_blank">Line Coverage</a> and <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/05_cover_func/" target="_blank">Functional Coverage</a>.
2. Test Cases: Test cases are code deliverables that define the input combinations used for testing, as well as the expected output combinations. For building test cases, you can refer to the <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/03_add_test/" target="_blank">Test Case Addition Tutorial</a>.
3. Verification Report: The verification report is a textual deliverable that includes an introduction to the environment, test points, and test cases, the environment and instructions needed to reproduce the code, as well as a report on metrics such as test coverage. You can refer to this tutorial for writing the verification report: <a href="https://open-verify.cc/mlvp/docs/basic/report/" target="_blank">Verification Report Tutorial</a>.

This task has already provided an initial environment in the <a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan Verification Framework</a>. You can also set up the verification environment and refine the APIs on your own.

## Task Difficulty

Task difficulty is determined by a combination of factors such as comprehension difficulty and workload. Generally, tasks rated 1 to 3 are considered simple, tasks rated 4 to 7 have an average difficulty, which may involve a larger workload or require some time to understand hidden information. Tasks rated 8 to 10 are more challenging, typically involving both a significant workload and a high level of comprehension difficulty.

## Reward Information

Finally, based on the difficulty of the tasks and each individual's performance, participants will be eligible to receive varying amounts of bonuses. Additionally, if you identify bugs in the IFU module and provide feedback for confirmation, there will be an opportunity to receive additional bonuses.

## Task Details

The following is a detailed introduction to each sub-task for this period:

### Task 2.1: PreDecode and F3Predecoder Submodules

PreDecode is the pre-decoding module responsible for concatenating the initial instruction codes and extracting pre-decode information from each concatenated instruction. This module has been optimized in terms of timing to include two submodules: PreDecode and F3Predecoder.

The PreDecode module is responsible for completing tasks such as instruction concatenation and address calculation for the input 17x2B initial instruction codes. It returns the concatenated instruction codes and pre-decode information.

The F3Predecoder module is the timing optimization part of the PreDecode submodule, responsible for identifying and determining CFI instructions.

Expected task difficulty: 4/10

Function documentation references: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/01_ifu/01_predecode/" target="_blank">PreDecode Function</a> and <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/01_ifu/02_f3predecoder/" target="_blank">F3Predecoder Function</a>.

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/9">PreDecode issue</a>

### Task 2.2: RVCExpander Submodule

This module is responsible for instruction expansion and illegal instruction determination for the input 4B instruction code.

Expected task difficulty: 5/10

Function documentation reference: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/01_ifu/03_ifu_rvc_exp/" target="_blank">RVCExpander Function</a>.

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/10">RVCExpander issue</a>

### Task 2.3: PredChecker Module

This module is responsible for detecting prediction errors and correcting prediction results based on the input instruction code and pre-decode information.

Expected task difficulty: 4/10
    
Function documentation reference: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/01_ifu/04_pred_checker/" target="_blank">PredChecker Function</a>.

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/11">PredChecker issue</a>

Note: The existing environment and API are provided; you need to add coverage and test cases on your own, and adjustments to the API can be made.

### Task 2.4: FrontendTrigger Submodule Verification

This module is responsible for setting and determining frontend breakpoint triggers based on the input information.

Expected task difficulty: 6/10

Function documentation reference: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/01_ifu/05_frontend_trigger/" target="_blank">FrontendTrigger Function</a>.

issue link：<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/12">FrontendTrigger issue</a>

## Registration Method

Please fill out the [registration form](https://www.wjx.cn/vm/tUcQ4Fs.aspx#) to participate in this mission. You are also welcome to join the official event QQ group: **600480230**.

If you have any questions, you may contact the group owner in the QQ group or reach out to the official email of UnityChip: anxu@bosc.ac.cn.
