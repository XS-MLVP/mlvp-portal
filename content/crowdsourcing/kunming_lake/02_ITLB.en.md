---
title: 'UT Practical Session 3: UT Verification Practice for 3rd-gen Xiangshan (Kunminghu) Architecture ITLB Module (In Progress)'
date: 2025-02-19T10:47:15+08:00
draft: false
fenbao_tags: ["Verification Case", "ITLB", "UT Verification"]
#website: "/xs-bpu/"
status: "Continuing"
task_closed: false
home_page_show: true
Weight: 11
summary: "Learning Xiangshan ITLB's Microarchitecture Design Through Verification"
---

This verification practice session will help participants learn the TLB module design in Xiangshan Kunminghu architecture and explore other components of the MMU module, while understanding general RISC-V instruction architecture design principles. [Click here to register](https://www.wjx.top/vm/P4mhRDX.aspx# ) and join the QQ group (Group ID: <b>976081653</b>) after submission for further communication.

The TLB (Translation Lookaside Buffer) module, part of the MMU (Memory Management Unit), handles virtual-to-physical address translation through multi-level page tables stored in memory. As a hardware accelerator, TLB caches frequently used page table entries to optimize memory access. For details, refer to [ITLB Documentation](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/02_itlb/).

### Participation Guidelines

Complete verification tasks using the [verification framework](https://github.com/XS-MLVP/UnityChipForXiangShan) from the UnityChipForXiangShan repository. Submit your work via PR after completion.

This ITLB verification requires full-module validation. Tasks will be graded by coverage metrics. Participants should self-select functional points for testing using the following difficulty matrix:

| **Category**         | **Function Point**  | **Description**                                                                 | **Difficulty** |
|-----------------------|---------------------|---------------------------------------------------------------------------------|----------------|
| **Request Handling**  | TLB Request Receiving | Process virtual address translation requests (read/write/execute)               | 2              |
| **Hit/Miss Handling** | TLB Miss Handling    | Trigger page table walk on missing entries, reload TLB, and retry               | 3              |
|                       | TLB Hit Handling     | Return physical address and permissions directly                                | 2              |
| **Cache Management**  | Replacement Policy   | Implement PLRU algorithm for entry eviction                                     | 5              |
|                       | TLB Capacity         | Support maximum entry count (impacts hit rate/hardware cost)                    | 3              |
|                       | TLB Compression      | Merge adjacent entries/encoding optimization                                    | 3              |
| **Maintenance**       | Flush Operations     | Full/partial TLB flush via ASID switching/INVTLB instructions                   | 3              |
|                       | Reset                | Clear entries and reset state on power-up                                       | 1              |
| **Security & Exceptions** | Permission Check  | Validate access permissions (R/W/Execute) against page table attributes         | 4              |
|                       | Exception Handling   | Handle Page Faults (permission violations/page misses) and TLB exceptions       | 3              |
|                       | Isolation            | ASID-based isolation for process/VM TLB entries                                 | 3              |
| **Performance**       | Parallel Access      | Fully associative structure supports concurrent lookups                         | 2              |
|                       | Multi-page Support   | Mixed page sizes (4KB/2MB/1GB) to reduce coverage bottlenecks                    | 4              |
| **Physical Design**   | Timing Constraints   | Meet pipeline timing requirements (1-3 cycle latency)                           | 2              |

Note: Supplementary functional points are allowed.

### Bug Reporting

Report bugs via GitHub issues using the BUG REPORT template. Label issues with `bug need to confirm` and appropriate severity (`minor/normal/serious/critical`). Use `ut_fronted.mmu.itlb` tag. Alternatively, report in QQ group (976081653). First valid bug reports may receive additional rewards.

### Submission Requirements

Submit the following packaged as:

```
Name_ut_fronted_mmu_itlb/
│
├── code/
│     ├── link.md
│     └── code.zip
│
├── cases/
│     ├── Function_Point/
│     │      └── Test_Case_Description.md
│     └── Function_Point/
│
└── report/
      └── file.pdf
```

Include:
1. Code repository link/zip with executable tests and README
2. Test case documentation
3. Verification report

### Rewards

Compensation will be awarded based on task difficulty and completion quality. Additional bonuses granted for first-confirmed bug reports. Intellectual property rights strictly protected.
