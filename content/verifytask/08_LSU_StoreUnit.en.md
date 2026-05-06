---
title: 'UT Practice Session 9: Third-Generation XiangShan (Kunming Lake) Architecture LSU-StoreUnit Module UT Verification Practice (Completed)'
date: 2025-09-18T10:17:00+08:00
draft: false
fenbao_tags: ["Verification Case", "LSU", "StoreUnit", "UT Verification"]
status: "Completed"
task_closed: true
home_page_show: true
Weight: 11
summary: "Learn XiangShan LSU-StoreUnit microarchitecture design through verification"
schedule: 4
difficult: 5
image: "/images/UTyanzheng.png"
---
In this verification task, you will get close to the StoreUnit module of the XiangShan Kunming Lake architecture, understand the design philosophy of XiangShan's memory address execution unit, and deepen your understanding of the RISC-V instruction set architecture. Welcome to participate!
(Sign-up link [here](https://www.wjx.top/vm/wFtuJS6.aspx), QQ group: **600480230**).

StoreUnit is used for address generation and processing of Store-type instructions. It is a key component of the Load/Store pipeline and, together with LoadUnit, forms the LSU (Load Store Unit) memory access pipeline. In terms of functionality, LSU is responsible for the specific execution flow of memory-access instructions, including normal memory address space and peripheral-related MMIO address space, as well as atomic instruction execution. In terms of flow, LSU receives instructions issued from the reservation station. According to the type of memory access instruction, it goes through different instruction pipelines, obtains instruction execution results, writes back to ROB, notifies the forward bypass network, wakes up subsequent related instructions, and forwards data.
	
## Task Introduction
This verification task is to verify the functional points of the StoreUnit module, with a total of 18 micro-tasks released. Participants can choose the tasks they are interested in and complete one or more.

Micro-tasks are functional breakdowns of the module under verification. Each functional point corresponds to a packaged function. As a participant, you only need to complete the corresponding function to proceed with verification. **Each micro-task provides a function template. You only need to select the provided corresponding function, write test cases to verify the corresponding functionality, and complete the verification report.** Excluding preliminary learning time, each micro-task takes approximately 2-5 hours to verify.
Each micro-task has a cash reward. We will issue cash rewards to the first five people who successfully complete the task. In addition, if you find a bug for the first time during the verification process and contact us to confirm it, you will receive an additional bonus 💴

The task participation process is as follows:
<div>			
    <center>	
    <img src="/crowdsourcing/activity_process.png"
         alt="Task Process"
         style="zoom:26%"/>
    <br>		
    Task Process	
    </center>
</div>
All tasks will be assigned through <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues" target="_blank">XS-MLVP XiangShan Processor Issues</a>.


## Recommended Completion Time

The recommended completion time is comprehensively calculated based on factors such as difficulty of understanding and workload. Generally, tasks requiring 1-2h are easy, tasks requiring 3-4h are of moderate difficulty, possibly with large workload or requiring certain time to understand hidden task information, and tasks taking 5h or more are difficult, generally with both large workload and high difficulty of understanding. The recommended time does not include time needed for learning and environment installation and configuration.
<br><br>

**LSU-StoreUnit Detailed Verification Document: [StoreUnit Verification Document](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/)**



## Task List
All micro-tasks are shown below. You can choose to complete one or more. In each micro-task, the first five students who submit results and pass review will receive the task reward.
| Functional Point |  Difficulty |  Recommended Time   | Reward  |  Details
| ---- |----|----|----|----|
| 1. Scalar Instruction Dispatch  |   ★ ★ ☆ ☆ ☆  | 2 hours  | 100 CNY| [test_scalar_dispatch function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L4) <br>[Memory Instruction Dispatch Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#内存指令派发)|
| 2. Vector Instruction Dispatch  |   ★ ★ ★ ☆ ☆  | 3 hours  | 150 CNY| [test_vector_dispatch function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L12) <br>[Memory Instruction Dispatch Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#内存指令派发)|
| 3. Address Pipeline S0 Stage  |   ★ ★ ★ ☆ ☆  | 3 hours  | 150 CNY| [test_s0_address_calc function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L20) <br>[Address Pipeline Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#存储指令执行)|
| 4. Address Pipeline S1 Stage |   ★ ★ ★ ★ ☆  | 4 hours  | 200 CNY| [test_s1_raw_check function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L28) <br>[Address Pipeline Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#存储指令执行)|
| 5. Address Pipeline S2 Stage |   ★ ☆ ☆ ☆ ☆  | 1.5 hours  | 80 CNY| [test_ s2_sq_mark_ready function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L36) <br>[Address Pipeline Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#存储指令执行)|
| 6. Vector Instruction Split  |   ★ ★ ★ ☆ ☆  | 3 hours  | 150 CNY| [test_split function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L44) <br>[Vector Store Instruction Execution Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#向量存储指令执行)|
| 7. Vector Element Offset Address Calculation  |   ★ ★ ☆ ☆ ☆  | 2 hours  | 100 CNY| [test_offset function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L52) <br>[Vector Store Instruction Execution Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#向量存储指令执行)|
| 8. TLB Miss  |   ★ ★ ★ ☆ ☆  |3 hours  | 150 CNY| [test_tlb_miss function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L60) <br>[Re-execution Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#重执行)||
| 9. RAW Violation Detection  |   ★ ★ ★ ☆ ☆  | 3 hours  | 150 CNY| [test_violation function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L68) <br>[RAW Processing Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#raw处理)|
| 10. RAW Violation Recovery  |   ★ ★ ★ ★ ★  |5.5 hours  | 270 CNY| [test_recovery_mech function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L76) <br>[RAW Processing Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#raw处理)|
| 11. SBuffer Merge  |   ★ ★ ★ ☆ ☆  | 3 hours  | 150 CNY| [test_write_merge function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L84) <br>[SBuffer Optimization Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#sbuffer优化)|
| 12. SBuffer Replacement  |   ★ ★ ★ ☆ ☆  | 3 hours  | 150 CNY| [test_plru_replace function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L92) <br>[SBuffer Optimization Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#sbuffer优化)|
| 13. MMIO Instruction Execution Order  |   ★ ★ ★ ☆ ☆  | 3 hours  | 150 CNY| [test_order function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L100) <br>[MMIO Processing Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#mmio处理)|
| 14. MMIO Exception |   ★ ★ ★ ★ ☆  | 4 hours  | 200 CNY| [test_exception function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L108) <br>[MMIO Processing Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#mmio处理)|
| 15. NC Out-of-Order Execution  |   ★ ★ ☆ ☆ ☆  | 2 hours  | 100 CNY| [test_exec function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L116) <br>[Uncache Instruction Execution Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#Uncache指令执行)|
| 16. Uncache Forwarding  |   ★ ★ ★ ☆ ☆  | 3 hours  | 150 CNY| [test_forward function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L124) <br>[Uncache Instruction Execution Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#Uncache指令执行)|
| 17. Scalar Unaligned Instruction Split |   ★ ★ ★ ☆ ☆  | 3 hours  | 150 CNY| [test_scalar_split function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L132) <br>[Unaligned Memory Access Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#非对齐存储指令执行)|
| 18. Unaligned Access Exception  |   ★ ★ ★ ★ ☆  | 4 hours  | 200 CNY| [test_exception function](https://github.com/XS-MLVP/UnityChipForXiangShan/blob/main/ut_mem_block/lsu/storeunit/test_storeunit.py#L140) <br>[Unaligned Memory Access Function](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/01_storeunit/#非对齐存储指令执行)|



## Deliverable Requirements

1. Test Cases: Test cases are code deliverables that define input combinations used for testing and expected output combinations.
2. Verification Report: The verification report is a text deliverable, requiring no less than 500 words, including functionality, input and output results, and boundary condition analysis. Report reference format: [Micro-report Template](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/03_lsu/00_template/) 
3. Other Notes: If your project requires other dependencies to run, you can explain them in the test report or PR.

## Participation and Submission

For this verification task, please complete the verification work and submit a PR to the <a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">Verification Framework</a> repository provided by UnityChipForXiangShan.

Please fork the above UnityChipForXiangShan repository, complete the verification code and documentation, and then submit a PR when your deliverables are ready.

## Reward Information
In the end, according to the difficulty of the tasks and everyone's completion, you will receive varying amounts of cash rewards. In addition, if you find and report a bug for the LSU StoreUnit module and it is confirmed, you have the opportunity to receive more rewards.


## Bug Report
Please directly submit an issue using the bug report template in the UnityChipForXiangShan repository.

When submitting a bug, please first select the "bug need to confirm" label. Then choose the label that best matches your assessment from the four bug severity levels (minor, normal, serious, critical) provided by the labels. Finally, please select the module where you discovered the bug. This verification is for the memory storeunit module, so you can uniformly apply the ut_mem_block.storeunit label.
