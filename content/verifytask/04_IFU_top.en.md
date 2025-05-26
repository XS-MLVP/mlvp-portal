---
title: 'UT Practical Session Phase 5: Third Generation Xiangshan (Kunming Lake) Architecture IFU top Module UT Verification'
date: 2025-03-31T10:47:18+08:00
draft: false
fenbao_tags: ["Verification Cases", "IFU", "top", "UT Verification"]
status: "Continuing"
task_closed: false
home_page_show: true
Weight: 11
summary: "Learning Xiangshan IFU Microarchitecture Design Through Verification"
schedule: 2
difficult: 5
---

This verification hands-on task will help in learning the design of the IFU top module in Xiangshan's Kunming Lake architecture. Through hands-on verification, you will gain insights into the design ideas of Xiangshan's instruction fetch module and deepen your understanding of the RISC-V instruction set architecture. We welcome you to sign up for this task (registration questionnaire [here](https://www.wjx.top/vm/mKbmTqL.aspx#), QQ group: **600480230**).

The Instruction Fetch Unit (IFU) is responsible for receiving fetch requests from the Fetch Target Queue (FTQ) and retrieving instruction cache lines from either the ICache or the instruction uncache. It performs multiple functions including instruction fetch, pre-decoding, RVC-to-RVI instruction expansion, and preliminary branch prediction error checking. Ultimately, it outputs preliminary decoded information and instruction codes to the Instruction Buffer (IBuffer), and writes back verification results to the FTQ.

This task is the verification of IFU top module. All tasks will be assigned through <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues" target="_blank">issue of UnityChipForXiangShan</a>.

## Participation

This verification task should be completed based on the <a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan verification framework</a>, and a PR should be submitted to the repository.

### Way to submit

Please fork the UnityChipForXiangShan repository, then complete the verification code and documentation. Once everything is ready, submit a pull request (PR) to contribute your work.

## Bug Reporting

Please use the bug report template to file an issue in the UnityChipForXiangShan repository or click [here](https://github.com/XS-MLVP/UnityChipForXiangShan/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=%5BBUG%5D+).

When submitting a bug, first select the `bug need to confirm` label. Then choose one of the four bug severity labels (`minor`, `normal`, `serious`, or `critical`) that best matches your issue. Finally, select the module where you found the bug. For this verification task focusing on the IFU module, please uniformly apply the `ut_frontend.ifu` label.

## Deliverable Requirements

This verification task should be completed based on the UnityChipForXiangShan verification framework, and a PR should be submitted to the repository. Each subtask requires the following deliverables:

1. **Verification Environment + API**: The verification environment and API are code deliverables that encapsulate the data responsibilities (pins) and behavioral responsibilities (logic) of the DUT. They should provide reusable interfaces, test suites, and definitions for test coverage. Refer to the <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/02_build_env/" target="_blank">Verification Environment Setup Guide</a> and the test coverage documentation ：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/04_cover_line/" target="_blank">Line Coverage</a>、<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/05_cover_func/" target="_blank">Functional Coverage</a>.

2. **Test Cases**: Test cases are code deliverables that define input combinations for testing and their expected outputs. Refer to the <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/03_add_test/" target="_blank">Test Case Guide</a>

3. **Verification Report**: The verification report is a written deliverable that includes an introduction to the environment, test points, and test cases, as well as the environment and commands required to reproduce the code. It should also include metrics such as test coverage. Refer to the <a href="https://open-verify.cc/mlvp/docs/basic/report/" target="_blank">Verification Report Guide</a>.

<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">The UnityChipForXiangShan verification framework</a> provides a preliminary environment for this task, but participants may also set up their own verification environment and refine APIs.

## Task Difficulty

The task difficulty is determined based on a combination of factors such as complexity of understanding and workload. Generally, tasks rated 1 to 3 are considered easy. Tasks rated 4 to 7 are of moderate difficulty—these may involve a larger workload or require some effort to understand hidden details. Tasks rated 8 to 10 are relatively difficult, typically involving both a significant workload and high cognitive complexity.

## Reward Information

Ultimately, based on the difficulty of the task and each participant’s performance, you will receive a corresponding amount of bonus. Additionally, if you discover and report a confirmed bug in the IFU top module, you may be eligible for an extra bonus.

## Task Details

Since this round focuses on verifying the IFU top module, it will not be divided into multiple submodules. Instead, the entire IFU top module needs to be verified as a whole. We will assess the results based on the completeness of testing (e.g., coverage metrics). During the verification process, you are required to define your own test points based on selected functional features. For a detailed description of the functional features, please refer to the [IFU Top Documentation](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/01_ifu/). The full list of features and their corresponding difficulty levels is as follows:


| **Feature ID**         | **Feature Name**               | **Description**                                                                 | **Difficulty** |
|------------------------|-------------------------------|---------------------------------------------------------------------------------|----------------|
| **IFU_RCV_REQ**        | IFU Receives FTQ Fetch Request | Receives fetch requests from the FTQ and sets the ready signal                  | 1/10           |
| **IFU_INFOS**          | IFU Analyzes Request and Fetches Initial Instructions | IFU analyzes the FTQ fetch request and fetches instructions from the ICache     | 2/10           |
| **IFU_PREDECODE**      | Pre-Decoding                   | Pre-decodes the fetched instructions, reconstructs them, and identifies RVC or branch types | 4/10           |
| **IFU_RVC_EXPAND**     | RVC Instruction Expansion      | Verifies and expands RVC instructions into RVI format after reconstruction      | 5/10           |
| **IFU_PREDCHECK**      | Pre-Check                      | Performs early checks for simple branch prediction errors                       | 4/10           |
| **IFU_REDIRECT**       | Misprediction Redirect         | Flushes IFU pipeline based on pre-check results                                 | 3/10           |
| **IFU_CROSS_BLOCK**    | Cross-Prediction-Block Instruction Handling | Handles RVI instructions that span across prediction blocks            | 6/10           |
| **IFU_IBUFFER**        | Output to IBuffer              | Outputs final instruction codes and pre-decoded information to the IBuffer      | 3/10           |
| **IFU_OVERRIDE_FLUSH** | Override-based Pipeline Flush  | Flushes pipeline based on overriding inputs from other modules                  | 3/10           |
| **IFU_WB_FTQ**         | Writeback to FTQ               | Writes back pre-decoded info and pre-check results to the FTQ                   | 3/10           |
| **IFU_MMIO**           | MMIO Request Handling          | Handles requests originating from MMIO space using a separate logic flow        | 8/10           |
| **IFU_FRONTEND_TRIGGER** | IFU Frontend Breakpoint      | Sets frontend breakpoints in the IFU and checks corresponding PCs               | 3/10           |


## Registration Method

Please fill out the [registration form](https://www.wjx.cn/vm/tUcQ4Fs.aspx#) to participate in this mission. You are also welcome to join the official event QQ group: **600480230**.

If you have any questions, you may contact the group owner in the QQ group or reach out to the official email of UnityChip: anxu@bosc.ac.cn.

