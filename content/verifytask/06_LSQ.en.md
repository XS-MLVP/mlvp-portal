---
title: "UT Practice Session 7: UT Verification of the LSQ Module in the 3rd Generation XiangShan (Kunming Lake) Architecture (Completed)"
date: 2025-04-01T16:00:00+08:00
draft: false
fenbao_tags: ["Verification Case", "LSQ", "UT Verification"]
#website: "/xs-bpu/"
status: "Completed"
task_closed: true
home_page_show: true
Weight: 11
summary: "Learn the microarchitecture design of XiangShan LSQ through verification"
schedule: 4
difficult: 5
image: "/images/UTyanzheng.png"
---

In this verification task, you will get close to the LSQ module of the XiangShan Kunming Lake architecture, experience the design philosophy of XiangShan's memory access module through verification practice, and deepen your understanding of the RISC-V instruction set architecture. Welcome to sign up (registration form [here](https://www.wjx.top/vm/mB3EmwR.aspx), QQ group: **902630176**)!

LSQ (Load Store Queue) is a critical structure in modern processors that manages memory operations, mainly used to support out-of-order execution and ensure the correctness of memory accesses. Its core functions include: tracking outstanding load and store operations, detecting and resolving memory dependencies (such as RAW and WAR violations), implementing store forwarding to improve efficiency, maintaining memory consistency in multi-core environments, and coordinating with the cache subsystem. Through intelligent scheduling of memory access order, the LSQ ensures program correctness while maximizing instruction-level parallelism and improving processor performance.

In this task, a total of 6 subtasks are released, covering 6 submodules of LSQ (LoadQueueRAR, LoadQueueRAW, LoadQueueReplay, LoadQueueUncache, VirtualLoadQueue, StoreQueue). All tasks will be assigned via the <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues" target="_blank">XS-MLVP XiangShan Processor issue</a>.

## Registration

<div>			
    <center>	
    <img src="/crowdsourcing/activity_process.png"
         alt="Task Process"
         style="zoom:26%"/>
    <br>		
    Task Process	
    </center>
</div>

The above shows the process for participating in tasks. Depending on the difficulty level you choose and your completion status, you will receive a corresponding bonus. Your efforts will be rewarded. In addition, if you find a bug for the first time during the verification process and contact us to confirm it, you will receive an additional bonus 💴 based on the actual bug situation.

Please fill in the [registration form](https://www.wjx.top/vm/mB3EmwR.aspx) to participate in this session, and also feel free to join the official QQ group: **600480230**.

This verification task should be completed based on the <a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">verification framework</a> provided by UnityChipForXiangShan and submit a PR to that repository.

## Task Details

Task difficulty is comprehensively evaluated based on factors such as comprehension difficulty and workload. Generally, tasks with difficulty 1–3 are simple tasks, tasks with difficulty 4–7 are of moderate difficulty, which may involve substantial work or require some time to understand hidden task information, and tasks with difficulty 8–10 are more difficult, generally with both substantial workload and high comprehension difficulty.

Below is a detailed introduction to each subtask in this session:

### Task 1: LoadQueueRAR Submodule

LoadQueueRAR is used to store information from completed load instructions for load-to-load violation detection. When a load instruction is at pipeline stage s2, it queries and allocates a free entry to save information into LQRAR. At pipeline stage s3, it receives the result of the load-to-load violation check. If a violation occurs, the pipeline needs to be flushed, and a redirect request is sent to the RedirectGenerator component to flush all instructions after the violating load.

Expected task difficulty: 5/10

Functional documentation reference: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/01_lsq/01_loadqueuerar/" target="_blank">LoadQueueRAR Function</a>

issue link: <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/131">LoadQueueRAR issue</a>

### Task 2: LoadQueueRAW Submodule

LoadQueueRAW is used to handle store-load violations. Since both loads and stores execute out-of-order in the pipeline, it is common for a load to overtake an older store to the same address. That is, this load should have received forwarded data from the store, but because the store address or data was not ready, this load was committed without receiving the forwarded store data, and subsequent instructions using the result of this load also errored, thus causing a store-to-load forwarding violation.

When a store address is issued from the STA reservation station into the store pipeline, it queries all completed loads to the same address in LQRAW that are after this store, as well as loads currently in the load pipeline to the same address that are after this store. If any are found, a store-to-load forwarding violation has occurred. There may be multiple loads that violated. The load closest to (oldest after) the store must be found, i.e., the oldest violating load, and then a redirect request is sent to the RedirectGenerator component to flush the oldest violating load and all instructions after it.

Expected task difficulty: 5/10

Functional documentation reference: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/01_lsq/02_loadqueueraw/" target="_blank">LoadQueueRAW Function</a>

issue link: <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/132">LoadQueueRAW issue</a>

### Task 3: LoadQueueReplay Submodule

The LoadQueueReplay module is an important component in modern processor architectures for handling load instruction replay. It is responsible for managing load instructions that need to be replayed for various reasons, ensuring the correctness and efficiency of instruction execution.

Expected task difficulty: 8/10

Functional documentation reference: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/01_lsq/03_loadqueuereplay/" target="_blank">LoadQueueReplay Function</a>

issue link: <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/133">LoadQueueReplay issue</a>

### Task 4: LoadQueueUncache Submodule Verification

For uncache load access requests, LoadQueueUncache and the Uncache module serve as an intermediate station between the LoadUnit pipeline and the bus access. The Uncache module, being closer to the bus, is mainly responsible for handling uncache access requests and responses to/from the bus. LoadQueueUncache, being closer to the pipeline, needs to assume the following responsibilities:

1. Receive uncache load requests from the LoadUnit pipeline.

2. Select ready uncache load requests to send to the Uncache Buffer.

3. Receive processed uncache load requests from the Uncache Buffer.

4. Return processed uncache load requests to the LoadUnit.

In terms of structure, LoadQueueUncache currently has 4 entries (configurable) of UncacheEntry. Each entry independently handles one request and uses a set of state registers to control its specific processing flow. There is also a FreeList to manage the allocation and recovery of entries. LoadQueueUncache mainly coordinates the overall logic for new entry allocation, request selection, response dispatch, and dequeue for the 4 entries.

Expected task difficulty: 7/10

Functional documentation reference: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/01_lsq/04_loadqueueuncache/" target="_blank">LoadQueueUncache Function</a>

issue link: <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/134">LoadQueueUncache issue</a>

### Task 5: VirtualLoadQueue Submodule Verification

VirtualLoadQueue is a queue used to store micro-operations (MicroOps) of all load instructions and maintain the order among these load instructions. Its function is similar to the Reorder Buffer (ROB), but focused on load instruction management. Its main function is to track the execution status of load instructions to ensure that load operations can complete correctly and orderly in a concurrent execution environment.

Expected task difficulty: 5/10

Functional documentation reference: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/01_lsq/05_virtualloadqueue/" target="_blank">VirtualLoadQueue Function</a>

issue link: <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/135">VirtualLoadQueue issue</a>

### Task 6: StoreQueue Submodule Verification

StoreQueue is a queue used to hold all store instructions, with the following functions:

- Tracking the execution status of store instructions

- Storing store data and tracking data status (whether it has arrived)

- Providing a query interface for loads, allowing loads to forward from stores to the same address

- Responsible for MMIO store and NonCacheable store execution

- Writing stores submitted by the ROB to the sbuffer

- Maintaining address and data ready pointers for LoadQueueRAW release and LoadQueueReplay wakeup

Stores undergo address-data separated issue optimization. That is, StoreUnit is where the store address is issued and goes through one pipeline, while StdExeUnit is where the store data is issued and goes through another pipeline. They are two different reservation stations. When store data is ready, it can be issued to StdExeUnit. When store address is ready, it can be issued to StoreUnit.

Expected task difficulty: 7/10

Functional documentation reference: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/01_lsq/06_storequeue/" target="_blank">StoreQueue Function</a>

issue link: <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/136">StoreQueue issue</a>

## Deliverable Requirements

This verification task should be completed based on the verification framework provided by UnityChipForXiangShan, and a PR should be submitted to that repository.
Each subtask needs to submit the following deliverables:

1. Verification environment + API: The verification environment and API are code deliverables, encapsulating the data responsibilities (pins) and behavioral responsibilities (logic) of the Design Under Test (DUT). They need to provide specific reusable interfaces, test suite definitions, test coverage definitions, etc. For building the verification environment, you can refer to the <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/02_build_env/" target="_blank">Verification Environment Building Tutorial</a>. For documentation related to test coverage, please refer to these two articles: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/04_cover_line/" target="_blank">Line Coverage</a> and <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/05_cover_func/" target="_blank">Functional Coverage</a>.
2. Test cases: Test cases are code deliverables that define input combinations used for testing and expected output combinations. For building test cases, you can refer to the <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/03_add_test/" target="_blank">Test Case Addition Tutorial</a>
3. Verification report: The verification report is a written deliverable, including an introduction to the environment, test points, and test cases, the environment and commands required to reproduce the code, and a report on metrics such as test coverage.
   For writing the verification report, you can refer to this tutorial: <a href="https://open-verify.cc/mlvp/docs/basic/report/" target="_blank">Verification Report Tutorial</a>

This session has provided a preliminary environment in the <a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan Verification Framework</a>. You may also build your own verification environment and refine the APIs.

## Bug Report

Please directly submit an issue using the bug report template in the UnityChipForXiangShan repository, or click <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=%5BBUG%5D+">here</a> for a quick shortcut.

When submitting a bug, please first select the bug need to confirm label. Then choose the label that best fits from the four bug severity levels provided by the labels (minor, normal, serious, critical). Finally, please select the module where you found the bug. This verification is for the frontend icache module, so you can uniformly label it with ut_frontend\.icache.
