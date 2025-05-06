---
title: 'UT Practical Session Phase 4: Third Generation Xiangshan (Kunming Lake) Architecture FTQ Module UT Verification'
date: 2025-03-18T14:57:18+08:00
draft: false
fenbao_tags: ["Verification Cases", "FTQ", "UT Verification"]
#website: "/xs-bpu/"
status: "Continuing"
task_closed: false
home_page_show: true
Weight: 11
summary: "Learning Xiangshan FTQ Microarchitecture Design Through Verification"
---

This verification hands-on task will help in learning the design of the FTQ module in Xiangshan's Kunming Lake architecture. FTQ (Fetch Target Queue) plays a critical role in processor front-end design, responsible for the interaction between the front-end Branch Prediction Unit (BPU) and Instruction Fetch Unit (IFU), as well as the interaction between the front-end and back-end.

Through this task, you will gain understanding of the FTQ design, while also learning relevant content involved in the IFU and BPU modules, as well as how to use our provided verification framework for processor verification work - making this a comprehensive task that combines knowledge with practice.

[FTQ Verification Documentation: Provides more detailed introduction about FTQ](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/03_ftq/)

# Participation

For this verification task, please complete the verification work based on the [verification framework](https://github.com/XS-MLVP/UnityChipForXiangShan) provided by UnityChipForXiangShan and submit a PR to this repository.

## Deliverable Submission

Please fork the aforementioned UnityChipForXiangShan repository, complete the verification code and documentation work, and initiate a PR to the main repository when all deliverables are ready.

## Bug Report

Please directly use the bug report template to file an issue under the UnityChipForXiangShan repository, or quickly click [here](https://github.com/XS-MLVP/UnityChipForXiangShan/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=%5BBUG%5D+).

When submitting a bug, please first select the `bug need to confirm` label from the available labels. Then choose one of the four bug severity labels provided (`minor`, `normal`, `serious`, or `critical`) that best matches your issue. Finally, please select the module where you found the bug. For this verification task focusing on the front-end FTQ module, please uniformly apply the `ut_frontend.ftq` label.

## Deliverable Requirements

Deliverables Required for Each Subtask:

1. **Verification Code**: Please follow the [specification](https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/) when writing code to facilitate testing and unified maintenance. Your code may involve the following components, all of which have defined formats in the specification:

    - **Compilation scripts**: Basic compilation scripts are provided, but you may define your own
    
    - **Test environment**: You can provide verification environments for both `classic` and `toffee` versions
    
    - **Test cases**: You need to include instructions in `README.md` explaining how to execute your test cases

2. **Verification Report**: Should include:  
    - Introduction to the environment, test points and test cases  
    - Environment setup and commands required to reproduce the code  
    - Metrics report including test coverage  
    Reference tutorial: [Verification Report Guide](https://open-verify.cc/mlvp/docs/basic/report/)

The current task has provided preliminary environment setup in the [UnityChipForXiangShan verification framework](https://github.com/XS-MLVP/UnityChipForXiangShan), including:
- Compilation scripts for both FTQ sub-queues and top-level
- A random testing example for FTQ sub-queues

For details, please refer to the "Verification Environment" section in the FTQ documentation.


# Task

## Reward Information

Participants will receive varying monetary awards based on task difficulty and completion quality. Additionally, those who identify and report confirmed bugs in the FTQ module will qualify for extra bonuses.

## Task Details

### Task 1: FTQ Sub-queues

*The FTQ queue is composed of multiple sub-queues, where some sub-queues maintain one category of information while others maintain different categories of information. Sub-queue entries sharing the same ftqIdx collectively constitute a complete FTQ entry.*

In this task, you need to verify several critical sub-queues of the FTQ, primarily testing their read/write functionality for correct operation.

| Task                     | Function Point               | Description                                                                 |
|--------------------------|-----------------------------|-----------------------------------------------------------------------------|
| FTQ Sub-queue Read/Write | Fetch Target Sub-queue Read/Write | ftq_pc_mem stores fetch targets from branch prediction results             |
|                          | Redirection Storage Sub-queue Read/Write | ftq_redirect_mem stores redirection information from branch prediction  |
|                          | Pre-decode Storage Sub-queue Read/Write | ftq_pd_mem stores pre-decoded instruction block information from IFU    |
|                          | FTB Entry Storage Sub-queue Read/Write | ftb_entry_mem stores FTB entries from branch prediction results        |

Expected task difficulty：3/10

### Task 2: FTQ Branch Prediction Interface

*The FTQ receives branch prediction results from the BPU and stores them in corresponding sub-queues.*

| Task                          | Function Point       | Description                                                                 |
|-------------------------------|----------------------|-----------------------------------------------------------------------------|
| FTQ Receives BPU Predictions  | BPU Enqueue Condition | New FTQ entries are written only when BPU enqueue conditions are satisfied  |
|                               | Write FTQ Entry       | Stores branch prediction results in FTQ sub-queues and status queues        |
|                               | Redirect Misprediction| Forwards redirection signals to IFU when BPU predictions are incorrect      |
|                               | Update FTQ Pointers   | Modifies BPU/IFU pointers during prediction enqueue or redirection events  |

Expected task difficulty：6/10

### Task 3: FTQ-to-IFU Fetch Target Delivery

*The FTQ sends fetch targets to the IFU for pre-decoding.*

| Task                     | Function Point            | Description                                                                 |
|--------------------------|---------------------------|-----------------------------------------------------------------------------|
| FTQ Sends FTQ Entry to IFU | Sends Fetch Target to ICache | FTQ delivers fetch targets to ICache                                      |
|                          | Sends Fetch Target to Prefetch | FTQ provides fetch targets to Prefetch for speculative fetching          |
|                          | Sends Fetch Target to IFU    | FTQ transmits fetch targets to IFU                                       |
|                          | Updates Hit Status Queue    | On fallTruError, FTQ sets status queue to 'false hit'                   |
|                          | Instruction Flush          | Prediction redirection may flush pending IFU requests                    |
|                          | Updates Send Status Queue  | Upon successful IFU dispatch, FTQ sets status queue to 'sent'           |

Expected task difficulty：6/10

### Task 4: IFU to FTQ Pre-decode Information Writeback

*The IFU writes back pre-decoded instruction information to the FTQ's pre-decode storage queue.*

| Task                          | Function Point          | Description                                                                 |
|-------------------------------|-------------------------|-----------------------------------------------------------------------------|
| IFU Writes Back Predecode Info | Write to ftq_pd_mem     | IFU predecode results will be written to FTQ's pre-decode sub-queue         |
|                               | Update Commit Status Queue | Updates commit status queue based on instruction validity in writeback data |
|                               | Comprehensive Errors     | Error information from predecode results and mismatch with prediction data   |

Expected task difficulty：5/10

### Task 5: FTQ Backend Redirection Handling

*The backend refers to the actual instruction execution modules that send redirection signals to the FTQ to correct errors based on runtime execution results.*

| Task                     | Function Point        | Description                                   |
|--------------------------|----------------------|-----------------------------------------------|
| FTQ Receives Backend Redirect | Sends Fetch Target to Backend | Backend needs to store information from FTQ |
|                          | Sends Latest FTQ Entry Info | Transmits the newest FTQ entry information     |

Expected task difficulty：5/10

### Task 6: FTQ IFU Redirection Handling

*In addition to the backend, the IFU also generates redirection signals. Unlike backend redirections, IFU's redirect messages originate from pre-decode writeback information.*

| Task                  | Function Point       | Description                                                                 |
|-----------------------|----------------------|-----------------------------------------------------------------------------|
| FTQ Receives IFU Redirect | Generates IFU Redirect Signals | The IFU generates redirect signals based on pre-decode results and forwards them |
|                       | Generates IFU Flush Signals   | IFU redirections will produce pipeline flush signals                         |

Expected task difficulty：4/10

### Task 7: FTQ to Backend Fetch Target Deliver

*The fetch target PC will be sent to the backend's PC memory (pc_mem) for storage, enabling local PC access.*

| Task                      | Function Point        | Description                                   |
|---------------------------|----------------------|-----------------------------------------------|
| FTQ Sends Fetch Target to Backend | Delivers Fetch Target to Backend | Backend needs to store fetch target information from FTQ |
|                           | Sends Latest FTQ Entry Info | Transmits the most recent FTQ entry information |

Expected task difficulty：2/10

### Task 8: Execution Unit Modifies FTQ Status Queue

*All writeback information from the backend - including both redirection signals and update notifications - is generated post-execution by the actual execution units based on their operational results.*

| Task                          | Function Point        | Description                                                                 |
|-------------------------------|----------------------|-----------------------------------------------------------------------------|
| Execution Unit Modifies FTQ Status Queue | Updates Status Queue | Modifies FTQ status queue based on actual backend execution results        |
|                               | Backend Redirect Has Higher Priority | IFU redirect writeback also modifies status queue, but backend redirect has higher priority |

Expected task difficulty：2/10

### Task 9: FTQ Pointer and Status Queue Flush

*Redirections triggered by either the backend or IFU require recovery of all FtqPtr types used to index FTQ entries. When the redirection is initiated by the backend, it additionally modifies the commit status queue to indicate the instruction has been executed.*

| Task                      | Function Point | Description                                                                 |
|---------------------------|----------------|-----------------------------------------------------------------------------|
| Flush FTQ Pointers and Status Queue | Flush FTQ Pointers | Redirection signals from either backend or IFU will trigger FTQ pointer flush |
|                           | ROB Commit      | Modifies FTQ commit status queue using ROB commit information               |

Expected task difficulty：3/10

### Task 10: FTQ-to-BPU Update and Redirection

*FTQ将已提交指令的更新信息发往BPU进行训练，同时转发重定向信号。*

| 任务                | 功能点       | 描述                      |
| ----------------- | --------- | ----------------------- |
| FTQ向BPU发送更新和重定向信息 | 转发重定向信息   | 转发来自IFU或者后端的重定向信号       |
|                   | 提交指令块     | 判断指令块是否能够提交             |
|                   | 发送BPU更新信息 | FTQ需要向BPU发送更新信息，对其进行训练  |
|                   | 更新FTB表项   | FTQ需要对旧的FTB表项更新，转发到更新接口 |

Expected task difficulty：8/10

### 报名方式

请填写报名问卷参与本期任务，也欢迎加入活动官方qq群：600480230。
如有疑问可在qq群中联系群主，或联系万众一芯官方邮箱：anxu@bosc.ac.cn。