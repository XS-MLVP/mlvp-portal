---
title: 'UT Practice Session 8: Third-Generation XiangShan (Kunming Lake) Architecture L2TLB-bitmap Module UT Verification Practice (Completed)'
date: 2025-08-22T10:13:22+08:00
draft: false
fenbao_tags: ["Verification Case", "L2TLB", "bitmap", "UT Verification"]
status: "Completed"
task_closed: true
home_page_show: true
weight: 11
summary: "Learn the microarchitecture design of XiangShan's L2TLB-bitmap through verification"
schedule: 4
difficult: 5
image: "/images/UTyanzheng.png"
---

This verification task will further explore the L2TLB-bitmap module, experience the memory isolation design philosophy through verification practice, and deepen the understanding of TLB and RISC-V instruction set architecture. You are welcome to sign up (registration form [here](https://www.wjx.top/vm/hJJAnOJ.aspx#), QQ group: **600480230**)!

Bitmap is responsible for dynamic memory isolation in M-mode, to protect the confidentiality and integrity of data currently in use. The bitmap module is coupled with L2TLB. After L2TLB performs address translation to obtain the physical address, it obtains the permissions of that physical address to determine whether isolation is needed. This task only requires verifying the interaction between bitmap and L2TLB, as well as the bitmap itself. The L2TLB module itself has been fully verified and can be considered reliable. The new bitmap portion is marked with the TAG "HasBitmapCheck" in the Chisel source code.

The Chisel files involved in this verification include:
+ cache/mmu/L2TLB.scala
+ cache/mmu/BitmapCheck.scala
+ cache/mmu/PageTableWalker.scala
+ cache/mmu/PageTableCache.scala
+ cache/mmu/MMUBundle.scala
+ cache/mmu/MMUConst.scala
+ backend/fu/NewCSR/NewCSR.scala

The assigned task is verification of the Bitmap module. All tasks will be assigned through <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues" target="_blank">issues on XS-MLVP/XiangShan Processor</a>.

## Participation

Please complete the verification work based on the <a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">verification framework</a> provided by UnityChipForXiangShan and submit a PR to that repository.

### Submitting Results

Please fork the UnityChipForXiangShan repository above, complete the verification code and documentation, and submit a PR when ready.

### Bug Reports

Please directly use the bug report template to file an issue under the UnityChipForXiangShan repository, or click <a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=%5BBUG%5D+" target="_blank">here</a> for a quick shortcut.

When submitting a bug, please select the "bug need to confirm" label first. Then choose the label that best matches your assessment from the four bug severity levels (minor, normal, serious, critical) provided by the label. Finally, select the module where you found the bug. Since this verification is for the bitmap module in memblock's L2TLB, you can uniformly apply the ut\_memblock\.bitmap label.

## Deliverable Requirements

Each subtask requires submission of the following:
1. Verification environment + API: The verification environment and API are code deliverables that encapsulate the data responsibilities (pins) and behavioral responsibilities (logic) of the Design Under Test (DUT). They need to provide specific reusable interfaces, test suites, test coverage definitions, etc. For setting up the verification environment, please refer to the <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/02_build_env/" target="_blank">Verification Environment Setup Tutorial</a>. For documentation related to test coverage, please refer to these two articles: <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/04_cover_line/" target="_blank">Line Coverage</a>, <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/05_cover_func/" target="_blank">Functional Coverage</a>.
2. Test cases: Test cases are code deliverables that define the input combinations used for testing and the expected output combinations. For building test cases, please refer to the <a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/03_add_test/" target="_blank">Test Case Addition Tutorial</a>
3. Verification report: The verification report is a written deliverable that includes introductions to the environment, test points, and test cases, the environment and instructions required to reproduce the code, and reports on metrics such as test coverage.
- For writing the verification report, please refer to this tutorial: <a href="https://open-verify.cc/mlvp/docs/basic/report/" target="_blank">Verification Report Tutorial</a>
4. Other notes: If your project requires additional dependencies, please note them in the test report or PR

This session's task has already provided an initial environment in the <a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan verification framework</a>. Everyone is also welcome to build their own verification environment and refine the APIs.

## Task Difficulty

Task difficulty is comprehensively determined based on factors such as comprehension difficulty and workload. Generally, tasks with difficulty 1-3 are simple tasks, tasks with difficulty 4-7 are of moderate difficulty, possibly with large workloads or requiring a certain amount of time to understand hidden task information, and tasks with difficulty 8-10 are more difficult, generally with both large workloads and high comprehension difficulty.

## Reward Information

Ultimately, based on the difficulty of the tasks and everyone's completion status, you will be able to receive varying amounts of bonus payments. Additionally, if you find and confirm a bug in the Bitmap module, you have the opportunity to receive more bonus payments.

## Task Details

Since the module verified in this session is coupled with L2TLB and contains a large number of interactive parts, dividing it into multiple submodules has no practical significance. Therefore, it is necessary to build a verification environment for the entire Bitmap and L2TLB module. We will grade based on test completeness (coverage, etc.). During the verification process, you will need to divide test points based on self-selected functional points. For detailed functional point descriptions, please refer to [L2TLB-Bitmap Documentation](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/02_bitmap/). Functional points involving the bitmap module itself and those involving L2TLB interaction will be marked separately. The bitmap module's functional points are relatively independent, and priority verification is recommended. All functional points and their corresponding difficulties are as follows:

### Bitmap-Related Functional Verification

| **Function Identifier** | **Functional Point** | **Description** | **Difficulty** |
|---------------------|--------------------|-----------------------------------------------------------------------|-----|
| BITMAP_001 | Bitmap Cache hit/miss scenario verification | Design test cases covering hit and miss scenarios <br />**Combination**: Cross bitmap cache line, i.e., both miss and hit occur |1/10|
| BITMAP_002 | Bitmap check function verification | Verify the correctness of bitmap check <br />**Combination**: Cross 256K physical address space, i.e., always miss |1/10|
| BITMAP_003 | Cross bitmap cache line scenario verification | Test the access behavior across cache lines <br />**Combination**: Cross bitmap cache line + cross 256K physical address space |1/10|
| BITMAP_004 | BITMAP flush | Test whether csr.mbmc.BCLEAR works correctly |1/10|

### TLB-Related Functional Verification
| Function Identifier | Functional Point | Coverage Method Description | Combination Description | **Difficulty** |
| --- | --- | --- | --- |  --- |
| TLB_001 | ITLB hit/miss scenario verification | Design test cases covering ITLB hit and miss | 4K/2M/1G/512G page sizes  |3/10|
| TLB_002 | DTLB hit/miss scenario verification | Design test cases covering DTLB hit and miss | 4K/2M/1G/512G page sizes |3/10|
| TLB_003 | L2TLB hit/miss scenario verification | Design test cases covering L2TLB hit and replacement | 4K/2M/1G/512G page sizes |3/10|
| TLB_004 | L2TLB compression function verification<br/>Note: Only supports first-stage address translation compression, up to 8 entries | Test whether Bitmap query results are correct under TLB compression scenarios | TLB compression enabled + 4K page size  |4/10|

### Bitmap Cache and TLB Combination-Related Functional Verification
| Function Identifier | Functional Point | Coverage Method Description | Combination Description | **Difficulty** |
| --- | --- | --- | --- |  --- |
|  TLB_BITMAP_001  | Bitmap and TLB mixed hit scenario verification | Combine Bitmap hit with TLB hits at all levels to verify multi-level cache coordination | Bitmap hit + ITLB/DTLB/L2TLB all hit  |3/10|
|  TLB_BITMAP_002  | Full miss extreme scenario verification | Design full miss test cases for first access after cold start or cache flush | Bitmap miss + ITLB/DTLB/L2TLB all miss + trigger page table walk|3/10|
|   TLB_BITMAP_003  | Bitmap cross-line and TLB replacement scenario verification | Force Bitmap cross-cache-line access and trigger TLB replacement (such as duplicate access or page table update) | Bitmap cross-line + DTLB miss + L2TLB replacement |3/10|
|  TLB_BITMAP_004  | Repeated access and Cache/TLB interaction verification | Verify Bitmap/TLB repeated access optimization through repeated access to the same address | Bitmap repeated hit + ITLB repeated hit + no replacement<br/>Bitmap repeated Miss + ITLB repeated Miss + replacement |4/10|

---

### Page Table Walk (PTW) Related Functional Verification
| Function Identifier | Functional Point | Coverage Method Description | Combination Description | **Difficulty** |
| --- | --- | --- | --- |  --- |
| PTW_001 | PTW/HPTW/LLPTW priority verification | Test the priority of multi-level page table walks | PTW + HPTW concurrent  |4/10|
| PTW_002 | PTW return exception (access fault) verification | Simulate scenarios where PTW returns an exception | PTW return af + cross Page |4/10|
| PTW_003 | PTE legality verification | Test the handling of illegal PTEs | Illegal PTE + PMP check |4/10|

---

### Exception and Replay Function Verification
| Function Identifier | Functional Point | Coverage Method Description | Combination Description | **Difficulty** |
| --- | --- | --- | --- |  --- |
| REPLAY_001 | Scalar replay scenario verification | Test the replay behavior of scalar instructions | Scalar replay + access fault |5/10|
| REPLAY_002 | Vector memory access replay scenario verification | Test the replay behavior of vector instructions | Vector replay + cross MMO |5/10|
| EXCEPT_001 | Exception priority verification (access/page fault/guest page fault) | Verify the priority of exception triggering | page fault/guest page fault<br/>PMP/bitmap detection failure during page table walk<br/>PMP detection failure on translated physical address |5/10|

---

### Privilege Level and Extension Function Verification
| Function Identifier | Functional Point | Coverage Method Description | Combination Description | **Difficulty** |
| --- | --- | --- | --- |  --- |
| PRIV_001 | U/S/M privilege level switch verification | Test access permissions under different privilege levels | U/S/M + 4K/2M page sizes |4/10|
| EXT_001 | H-extension function verification | Test H-extension enable and disable scenarios | H-extension + cross tlb entry |4/10|
| PMP_001 | PMP check function verification | Test PMP permission check within bitmap | PMP Y/N + cross Page |4/10|

---

### Fence Verification
| Function Identifier | Functional Point | Coverage Method Description | Combination Description | **Difficulty** |
| --- | --- | --- | --- |  --- |
| MISC_001 | Fence operation verification | Test the synchronization effect of fence instructions | Fence + switch Cmode |3/10|

## Registration

Please fill out the [registration form](https://www.wjx.top/vm/hJJAnOJ.aspx#) to participate in this session's task. You are also welcome to join the official QQ group: **600480230**.

If you have any questions, you can contact the group owner in the QQ group, or contact the UnityChip official email: unitychip@bosc.ac.cn.
