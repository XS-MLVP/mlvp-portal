---
title: 'UT实战第八期：第三代香山(昆明湖）架构 L2TLB-bitmap 模块UT验证实战(进行中)'
date: 2025-08-22T10:13:22+08:00
draft: false
fenbao_tags: ["验证案例", "L2TLB", "bitmap", "UT验证"]
status: "Completed"
task_closed: false
home_page_show: true
Weight: 11
summary: "在验证中学习香山L2TLB-bitmap的微架构设计"
schedule: 2
difficult: 5
---

本期验证任务将会进一步了解L2TLB-bitmap模块，在验证实战中体会内存隔离的设计思路，加深对TLB和RISCV指令集架构的理解。欢迎各位报名参加（报名填写[这里](https://www.wjx.top/vm/hJJAnOJ.aspx#)，qq群：**600480230**。）！

Bitmap 负责在M模式对内存进行动态隔离，用来保护正在使用中的数据的机密性和完整性。bitmap 模块与L2TLB耦合。在L2TLB进行地址翻译获得物理地址后，取得该物理地址的权限，从而判断是否需要隔离。本次任务仅需验证bitmap与L2TLB交互的部分和bitmap本身。L2TLB模块本身已经经过充分验证，可以被认为是可靠的。新增的bitmap部分在Chisel 源码中使用TAG “HasBitmapCheck” 进行标记。
本次验证的Chisel 文件涉及：
+ cache/mmu/L2TLB.scala 
+ cache/mmu/BitmapCheck.scala
+ cache/mmu/PageTableWalker.scala
+ cache/mmu/PageTableCache.scala
+ cache/mmu/MMUBundle.scala
+ cache/mmu/MMUConst.scala
+ backend/fu/NewCSR/NewCSR.scala

本次分配的任务是对Bitmap模块的验证，所有的任务都将通过<a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues" target="_blank">万众一芯之香山处理器的issue</a>分配。 

## 参与

本次验证任务请基于UnityChipForXiangShan提供的<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">验证框架</a>完成验证工作并向该仓库提交PR。

### 成果提交

请fork上述UnityChipForXiangShan仓库之后完成验证代码和文档的编写，成果齐备后，请发起PR以提交。

### bug报告

请直接在UnityChipForXiangShan的仓库下使用bug report模板提issue，或者快捷点击[这里](https://github.com/XS-MLVP/UnityChipForXiangShan/issues/new?assignees=&labels=&projects=&template=bug_report.md&title=%5BBUG%5D+)。

提交bug时，请先在label中选择bug need to confirm标签。然后从label提供的四种bug分级（minor、normal、serious、critical）中选择您认为最符合的一种标签。最后，请选择您发现bug的模块，本次验证的是memblock中L2TLB的bitmap模块，可以统一打上ut\_memblock\.bitmap标签。

## 成果需求

每个子任务需要提交以下成果：
1. 验证环境+API：验证环境和API是代码成果，是针对待验证对象（DUT）的数据职责（引脚）和行为职责（逻辑）的封装，需要提供特定的可复用的接口、
测试套件、测试覆盖率等的定义。其中，搭建验证环境可以参考<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/02_build_env/" target="_blank">验证环境搭建教程</a>，测试覆盖率相关的文档可以参考这两篇：<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/04_cover_line/" target="_blank">行覆盖率</a>、<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/05_cover_func/" target="_blank">功能覆盖率</a>。
2. 测试用例：测试用例是代码成果，定义了用于测试的输入组合，以及预期的输出组合。构建测试用例可以参考<a href="https://open-verify.cc/UnityChipForXiangShan/docs/03_add_test/03_add_test/" target="_blank">测试用例添加教程</a>
3. 验证报告：验证报告是文字成果，包括对环境、测试点和测试用例的介绍，复现代码所需的环境和指令，以及对测试覆盖率等衡量指标的报告。
- 验证报告的书写可以参考这篇教程：<a href="https://open-verify.cc/mlvp/docs/basic/report/" target="_blank">验证报告教程</a>
4. 其他说明：如果运行您的项目需要其他的依赖，可在测试报告或PR中说明

本期任务在<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan验证框架</a>中已经提供了初步的环境，各位也可以自行搭建验证环境和提炼API。

## 任务难度

任务难度是根据理解难度、工作量等因素综合得出的，一般来说难度1～3的任务是简单的任务，4～7的任务难度一般，或许工作量较大，或许需要花费一定时间理解任务隐藏信息，8～10的任务较为困难，一般同时具有较大的工作量和较高的理解难度。

## 奖励信息

最终,根据任务的难度和各位的完成情况，各位将能获得数额不等的奖金。此外，如果为Bitmap模块找出bug并反馈确认后，有机会得到更多奖金。

## 任务详情

由于本期验证的模块和L2TLB耦合，包含大量交互部分，划分为多个子模块并无实际意义，因而需要对整个Bitmap和L2TLB模块搭建验证环境。我们将通过测试完整度（覆盖率等）进行分级，在验证过程中，您将需要按自选的功能点自行划分测试点进行测试，功能点详细描述请参考 [L2TLB-Bitmap 文档](https://open-verify.cc/UnityChipForXiangShan/docs/98_ut/03_memblock/02_bitmap/)。涉及bitmap模块本身的功能点和涉及L2TLB交互的功能点将分别进行标记。Bitmap模块的功能点较为独立，建立优先验证。所有功能点及对应难度如下：
### Bitmap  相关功能验证 

| **功能标识符** | **功能点** | **描述** | **难度** |
|---------------------|--------------------|-----------------------------------------------------------------------|-----|
| BITMAP_001 | Bitmap Cache hit/miss 场景验证 | 设计测试用例覆盖命中和未命中  <br />**排列组合**：跨 bitmap cache line，即miss和hit都有  |1/10|
| BITMAP_002 | Bitmap check 功能验证 | 验证 bitmap check 的正确性  <br />**排列组合**： 跨大于 256K 物理地址空间，即总是miss  |1/10|
| BITMAP_003 | 跨bitmap cache line 场景验证 | 测试跨 cache line 的访问行为  <br />**排列组合**：跨bitmap cache line + 跨 256k 物理地址空间  |1/10|
| BITMAP_004 |BITMAP刷新| 测试csr.mbmc.BCLEAR是否能正常工作 |1/10|

###   TLB 相关功能验证
| 功能标识符 | 功能点 | 覆盖方法描述 | 排列组合描述 | **难度** |
| --- | --- | --- | --- |  --- |
| TLB_001 | ITLB hit/miss 场景验证 | 设计测试用例覆盖 ITLB 命中和未命中 | 4K/2M/1G/512G 页大小  |3/10|
| TLB_002 | DTLB hit/miss 场景验证 | 设计测试用例覆盖 DTLB 命中和未命中 | 4K/2M/1G/512G 页大小 |3/10|
| TLB_003 | L2TLB hit/miss 场景验证 | 设计测试用例覆盖 L2TLB 命中和替换 | 4K/2M/1G/512G 页大小 |3/10|
| TLB_004 | L2TLB 压缩功能验证<br/>注：仅支持一阶段地址转换压缩，最多压缩8项 | 测试TLB 压缩场景下，Bitmap 查询结果是否正确 | TLB 压缩启用 + 4K 页大小  |4/10|

 

### Bitmap Cache 和 TLB 组合相关功能验证 
| 功能标识符 | 功能点 | 覆盖方法描述 | 排列组合描述 | **难度** |
| --- | --- | --- | --- |  --- |
|  TLB_BITMAP_001  | Bitmap与TLB混合命中场景验证 | 组合Bitmap命中与各级TLB命中，验证多级缓存协同 | Bitmap hit + ITLB/DTLB/L2TLB全命中  |3/10|
|  TLB_BITMAP_002  | 全未命中极端场景验证 | 设计冷启动或冲刷缓存后首次访问的全未命中用例 | Bitmap miss + ITLB/DTLB/L2TLB全miss + 触发页表遍历|3/10|
|   TLB_BITMAP_003  | Bitmap跨行与TLB替换场景验证 | 强制Bitmap跨cache line访问并触发TLB替换（如duplicate access或页表更新） | Bitmap跨行 + DTLB miss + L2TLB替换 |3/10|
|  TLB_BITMAP_004  | 重复访问与Cache/TLB交互验证 | 通过相同地址重复访问验证Bitmap/TLB的重复访问优化 | Bitmap重复命中 + ITLB重复命中 + 无替换<br/>Bitmap重复Miss + ITLB重复Miss + 替换 |4/10|




---

### 页表遍历（PTW）相关功能验证
| 功能标识符 | 功能点 | 覆盖方法描述 | 排列组合描述 | **难度** |
| --- | --- | --- | --- |  --- |
| PTW_001 | PTW/HPTW/LLPTW 优先级验证 | 测试多级页表遍历的优先级 | PTW + HPTW 并发  |4/10|
| PTW_002 | PTW 返回异常（access fault）验证 | 模拟 PTW 返回异常的场景 | PTW return af + 跨Page |4/10|
| PTW_003 | PTE 合法性验证 | 测试非法 PTE 的处理 | 非法 PTE + PMP check |4/10|

---

###  异常与重放（Replay）功能验证
| 功能标识符 | 功能点 | 覆盖方法描述 | 排列组合描述 | **难度** |
| --- | --- | --- | --- |  --- |
| REPLAY_001 | 标量 replay 场景验证 | 测试标量指令重放行为 | 标量 replay + access fault |5/10|
| REPLAY_002 | 向量访存 replay 场景验证 | 测试向量指令重放行为 | 向量 replay + 跨MMO |5/10|
| EXCEPT_001 | 异常优先级验证（access/page fault/guest page fault） | 验证异常触发的优先级 | page fault/guest page fault<br/>page table walker 过程中的PMP/bitmap 检测失败<br/>转换之后的物理地址PMP 检测失败 |5/10|


---

###   特权级与扩展功能验证
| 功能标识符 | 功能点 | 覆盖方法描述 | 排列组合描述 | **难度** |
| --- | --- | --- | --- |  --- |
| PRIV_001 | U/S/M 特权级切换验证 | 测试不同特权级下的访问权限 | U/S/M + 4K/2M 页大小 |4/10|
| EXT_001 | H-extension 功能验证 | 测试 H-extension 启用和禁用场景 | H-extension + 跨tlb entry |4/10|
| PMP_001 | PMP check 功能验证 | 测试bitmap 内PMP 权限检查 | PMP Y/N + 跨Page |4/10|


---

###   Fense验证
| 功能标识符 | 功能点 | 覆盖方法描述 | 排列组合描述 | **难度** |
| --- | --- | --- | --- |  --- |
| MISC_001 | Fence 操作验证 | 测试 fence 指令的同步效果 | Fence + 切换Cmode |3/10|


## 报名方式

请填写[报名问卷](https://www.wjx.top/vm/hJJAnOJ.aspx#)参与本期任务，也欢迎加入活动官方qq群：**600480230**。

如有疑问可在qq群中联系群主，或联系万众一芯官方邮箱：unitychip@bosc.ac.cn。
