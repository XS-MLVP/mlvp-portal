---  
title: 'UT Practical Session Phase 3: UT Verification Practice for the ITLB Module of the 3rd-Generation Xiangshan (Kunminghu) Architecture (Ongoing)'  
date: 2025-02-19T10:47:39+08:00  
draft: false  
fenbao_tags: ["Verification Case", "ITLB", "UT Verification"]  
#website: "/xs-bpu/"  
status: "Continuing"  
task_closed: false  
home_page_show: true  
Weight: 11  
summary: "Learn the Microarchitecture Design of Xiangshan’s ITLB Through Verification"  

---  

This practical verification task will help you study the design of the TLB module in the Kunminghu architecture of Xiangshan and explore other components of the MMU module beyond the TLB. You will gain insights into the general approach for designing modules using the RISC-V instruction set architecture. [Click here to register](https://www.wjx.top/vm/P4mhRDX.aspx#) and submit the form. After registration, join the QQ group (Group ID: **976081653**) for further communication.  

The TLB (Translation Lookaside Buffer) module is part of the MMU (Memory Management Unit), responsible for mapping virtual memory addresses to physical memory addresses. This mapping is stored in multi-level page tables in memory, and the TLB acts as a hardware accelerator for accessing these tables by caching frequently used page table entries. During operation, the TLB receives and temporarily stores page table mappings, enabling rapid results upon subsequent accesses. For details, refer to the [ITLB Documentation](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/01_frontend/02_itlb/).  

### Participate in Verification  
This verification task uses the [verification framework](https://github.com/XS-MLVP/UnityChipForXiangShan) provided by the UnityChipForXiangShan repository. After verification, submit a Pull Request (PR) to the repository.  

For this ITLB verification task, since the ITLB is a submodule of the MMU, the entire ITLB module will be verified as a whole. Grading will be based on testing completeness (e.g., coverage metrics). During verification, you will need to define test points based on self-selected functional areas. Functional points and their difficulty levels are as follows:  

| **Functional Category** | **Feature** | **Description** | **Difficulty** |  
|-------------------------|---------------------|-----------------------------------------------------------------------|-----|  
| **Request Handling**     | TLB Request Reception | Receive virtual address translation requests from the CPU; parse request types (read/write/execute) | 2/10 |  
| **Hit/Miss Handling**    | TLB Miss Handling    | Trigger Page Table Walk (PTW) on miss; load missing entries and retry translation | 4/10 |  
|                          | TLB Hit Handling     | Return physical address and permissions directly on hit | 4/10 |  
| **Cache Management**     | Replacement Policy   | Use PLRU algorithm to evict old entries and make space for new ones | 8/10 |  
|                          | TLB Cache Size       | Maximum number of entries supported, impacting hit rate and hardware cost | 6/10 |  
|                          | TLB Compression      | Merge adjacent entries or optimize encoding to improve space efficiency | 4/10 |  
| **Maintenance Operations** | Flush              | Support full TLB flush (e.g., ASID switch) or selective entry invalidation (via INVTLB instruction) | 5/10 |  
|                          | Reset               | Clear all entries and reset state on power-up or reset | 1/10 |  
| **Security & Exceptions** | Permission Checks   | Verify if request type (read/write/execute) aligns with page table entry permissions | 6/10 |  
|                          | Exception Handling   | Trigger Page Fault (permission violation/missing page) or TLB exceptions (invalid entry); forward to exception handler | 3/10 |  
|                          | Isolation            | Use ASID (Address Space Identifier) to isolate entries across processes/VMs, preventing leaks | 5/10 |  
| **Performance Optimization** | Parallel Access    | Fully associative structure supports concurrent lookups to reduce latency | 3/10 |  
|                          | Mixed Page Sizes     | Support hybrid page sizes (e.g., 4KB/2MB/1GB) to mitigate TLB coverage bottlenecks | 4/10 |  
| **Physical Design**      | Timing               | Meet pipeline timing requirements; design for 1-3 cycle latency to balance critical path and clock frequency | 3/10 |  

*Note: You may propose additional functional points.*  

### Bug Reporting  
If you identify bugs during verification, report them via the BUG REPORT template in the UnityChipForXiangShan repository by submitting an issue. Label the issue with `bug need to confirm` and select a severity level (`minor`, `normal`, `serious`, or `critical`) along with the `ut_fronted.mmu.itlb` tag. For GitHub usage issues, raise concerns directly in the QQ group (ID: 976081653). We protect intellectual property rights—only the first-reported bug is valid. Additional rewards may be granted upon confirmation.  

### Submission Guidelines  
After verification, submit a PR to the UnityChip repository and provide the following:  

1. **Code Repository Link/Archive**: Host code on GitHub (preferred) or submit a ZIP. Ensure code runs correctly and include a `README.md` with execution instructions. Specify the version if using GitHub.  
2. **Test Cases & Documentation**: Describe each test case concisely.  
3. **Verification Report**.  
4. **Test Point Table**: Maintain a table (example in QQ group files) tracking test points.  

Package all items and email to `bidingjun21@mails.ucas.ac.cn` with the directory structure:  

```  
Name_ut_fronted_mmu_itlb/  
│  
├── code/  
│     ├── link.md  
│     └── code.zip  
│  
├── cases/  
│     ├── Feature_Name/  
│     │      └── Test_Case_Description.md  
│     └── ...  
│  
└── report/  
      └── report.pdf  
      └── Test_Point_Table.xlsx  
```  

### Rewards  
Rewards will be allocated based on task difficulty and completion quality. Confirmed first-reported bugs may earn additional bonuses.