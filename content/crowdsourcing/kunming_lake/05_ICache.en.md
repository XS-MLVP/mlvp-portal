---
title: "UT Practical Session Phase 6: Third Generation Xiangshan (Kunming Lake) Architecture ICache Module UT Verification (Ongoing)"
date: 2025-04-01T16:00:00+08:00
draft: false
fenbao_tags: ["Verification Cases", "ICache", "UT Verification"]
#website: "/xs-icache/"
status: "Continuing"
task_closed: false
home_page_show: true
Weight: 11
summary: "Learning Xiangshan ICache Microarchitecture Design Through Verification"
---

In this verification task, participants will explore the ICache module of the Xiangshan Kunming Lake architecture. Through hands-on verification, you will gain insights into the design ideas of Xiangshan's instruction cache module and deepen your understanding of the RISC-V instruction set architecture. We welcome you to sign up for this task (registration questionnaire [here](https://www.wjx.top/vm/e1nEX25.aspx#), QQ group: **600480230**).

ICache (Instruction Cache) is responsible for handling fetch and prefetch requests from the FTQ, obtaining physical addresses from the ITLB, and fetching instruction data via Tilelink. It then sends the instruction data or exception data to the IFU.

This task includes six subtasks and covers seven submodules of the ICache (IPrefetchPipe, MainPipe, WayLookup, FIFO, MissUnit, CtrlUnit, and ICache). All tasks will be assigned through <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues" target="_blank">issue of UnityChipForXiangShan</a>.

## Participation

<div>			
    <center>	
    <img src="/crowdsourcing/activity_process.png"
         alt="Task Process"
         style="zoom:26%"/>
    <br>		
    Task Process	
    </center>
</div>

The above outlines the task participation process. Based on the difficulty and quality of your completed tasks, you will receive monetary rewards (this session's prize pool is 7,000). Your efforts will be rewarded. Additionally, if you identify a bug during verification and confirm it with us, you will receive an extra bonus 💴 based on the bug's severity.

Please fill out the [registration questionnaire](https://www.wjx.top/vm/e1nEX25.aspx#) to participate in this task. You are also welcome to join the official QQ group: **600480230**.

This verification task should be completed based on the <a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan verification framework</a>, and a PR should be submitted to the repository.

## Task Details

Task difficulty is determined based on factors such as comprehensive difficulty and workload. Generally, tasks with difficulty levels of 1–3 are simple, 4–7 are moderate (either due to workload or hidden information requiring time to understand), and 8–10 are challenging, often involving both high workload and comprehensive difficulty.

Below are the details of each subtask for this session:

### Task 1: IPrefetchPipe Submodule

The IPrefetchPipe submodule is responsible for filtering prefetch requests.  
It receives prefetch requests from the FTQ, performs address translation and PMP checks via the ITLB, queries the MetaArray for metadata (e.g., hit way, ECC checksum, exceptions), and stores the metadata in WayLookup. If the request misses, it sends the request to the MissUnit for prefetching.

Expected task difficulty: 7/10

Reference documentation: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/04_icache/01_iprefetchpipe/" target="_blank">IPrefetchPipe Functionality</a>

Issue link: <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/112">IPrefetchPipe issue</a>

### Task 2: MainPipe Submodule

MainPipe is the main pipeline of the ICache, designed as a three-stage pipeline. It is responsible for reading data from the DataArray, performing PMP checks, handling misses, and returning results to the IFU.

Expected task difficulty: 7/10

Reference documentation: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/04_icache/02_mainpipe/" target="_blank">MainPipe Functionality</a>

Issue link: <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/113">MainPipe issue</a>

### Task 3: WayLookup Module

WayLookup is implemented as a FIFO circular queue. It temporarily stores metadata obtained from the MetaArray and ITLB by the IPrefetchPipe for use by the MainPipe. It also monitors MSHR writes to the SRAM cacheline and updates hit information.

Expected task difficulty: 5/10

Reference documentation: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/04_icache/03_waylookup/" target="_blank">WayLookup Functionality</a>

Issue link: <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/114">WayLookup issue</a>

### Task 4: FIFO and MissUnit Submodules

FIFO is a circular queue.  
MissUnit manages miss requests and MSHR, communicates with the L2 cache via the TileLink protocol, sends requests to fetch cache blocks (`mem_acquire`), and receives responses from the L2 cache (`mem_grant`). It also handles special cases (e.g., flush, fencei, data corruption).

Expected task difficulty: 6/10

Reference documentation: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/04_icache/04_missunit/" target="_blank">MissUnit Functionality</a>


Issue link: <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/115">MissUnit issue</a>

### Task 5: CtrlUnit Submodule

The CtrlUnit currently handles ECC checksum enablement/error injection and other functionalities.

Expected task difficulty: 5/10

Reference documentation: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/04_icache/05_ctrlunit/" target="_blank">CtrlUnit Functionality</a>


Issue link: <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/116">CtrlUnit issue</a>

### Task 6: ICache Top-Level Module

The ICache top-level module handles prefetching, fetching requests, updating the replacer, reading/writing the MetaArray and DataArray, and handling exceptions.

Expected task difficulty: 8/10

Reference documentation: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/04_icache/06_icache/" target="_blank">ICache Top-level Functionality</a>

Issue link: <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/117">ICacheTop issue</a>

## Deliverable Requirements

This verification task should be completed based on the UnityChipForXiangShan verification framework, and a PR should be submitted to the repository. Each subtask requires the following deliverables:

1. **Verification Environment + API**: The verification environment and API are code deliverables that encapsulate the data responsibilities (pins) and behavioral responsibilities (logic) of the DUT. They should provide reusable interfaces, test suites, and definitions for test coverage. Refer to the <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/02_build_env/" target="_blank">Verification Environment Setup Guide</a> and the test coverage documentation ：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/04_cover_line/" target="_blank">Line Coverage</a>、<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/05_cover_func/" target="_blank">Functional Coverage</a>.

2. **Test Cases**: Test cases are code deliverables that define input combinations for testing and their expected outputs. Refer to the <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/03_add_test/" target="_blank">Test Case Guide</a>

3. **Verification Report**: The verification report is a written deliverable that includes an introduction to the environment, test points, and test cases, as well as the environment and commands required to reproduce the code. It should also include metrics such as test coverage. Refer to the <a href="https://open-verify.cc/mlvp/docs/basic/report/" target="_blank">Verification Report Guide</a>.

<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">The UnityChipForXiangShan verification framework</a> provides a preliminary environment for this task, but participants may also set up their own verification environment and refine APIs.

## Bug Reporting

Please use the bug report template to file an issue in the UnityChipForXiangShan repository or click [here](https://github.com/XS-MLVP/UnityChipForXiangShan/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=%5BBUG%5D+).

When submitting a bug, first select the `bug need to confirm` label. Then choose one of the four bug severity labels (`minor`, `normal`, `serious`, or `critical`) that best matches your issue. Finally, select the module where you found the bug. For this verification task focusing on the ICache module, please uniformly apply the `ut_frontend.icache` label.
