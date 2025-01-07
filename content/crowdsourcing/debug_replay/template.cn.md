---
title: '第一期昆明湖回归测试任务'
date: 2024-01-11T08:47:18+08:00
draft: false
fenbao_tags: ["bug复现","回归测试"]
#website: "/xs-bpu/"
task_closed: false
summary: "根据已发布的bug任务，设计回归测试用例复现bug"
---

{{% pageinfo %}}
UT（单元测试）、IT（集成测试）和 ST（系统测试）是处理器验证的三个关键阶段，它们分别针对验证中的不同层次。其中UT是对处理器设计中的最小功能单元(模块)进行测试，确保其功能符合设计要求。然而在生产实际中，一些模块的bug并非在UT阶段被发现，而是在后续的验证阶段发现并报告的。因此，我们需要在UT中构造测试用例将这些bug复现出来，同时也需要在该bug被修复后的版本重新运行测试用例，确保正确修复了该bug。这个过程也叫做回归测试。
{{% /pageinfo %}}

## 任务简介

本期任务将会提供50(待定)个待回归的bug，各位需要使用我们的提供的工具链(<a href="https://github.com/XS-MLVP/picker" target="_blank">picker</a>,<a href="https://github.com/XS-MLVP/toffee" target="_blank">toffee</a>(可选))，构建测试用例对bug进行回归。对于大多数的bug，我们会提供详细的bug描述，包括bug所在的模块，发生原因，验证环境等，对于部分bug，可能需要您根据描述定位到产生该bug模块或者搭建验证环境。每完成1个bug的回归并向我们的<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">仓库</a>提交PR，我们将提供100元的奖金作为奖励。希望大家能够积极参与并完成任务！

## 测试内容

对每个bug，我们希望您完成如下的工作：

#### 1、环境构建

首先，您需要根据<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan</a>所提供的测试环境，构建测试用例对bug进行回归。

如果bug描述中没有所在模块，需要您自行定位产生模块；如果目标模块下不存在相应的环境，需要您根据规范搭建对应环境，请参考<a href="https://open-verify.cc/UnityChipForXiangShan/docs/01_verfiy_env/" target="_blank">文档</a>中的**准备验证环境**，**添加测试**部分。

#### 2、用例构造

接下来，根据触发bug的原因，构建相应的测试用例。

对于所构建的测试用用例，需要满足以下两方面的内容：

1、在bug修复以前的rtl版本：可以运行该测试用例，且使用该测试用例进行测试将不通过测试（选择bug修复的前一个版本进行测试即可）。

2、在bug修复及以后的rtl版本：可以运行该测试用例，且该测试用例可以通过。

#### 3、提交说明

最后需要您撰写说明，描述该bug所属于哪个模块，简述相关的测试环境和用例，以及如何运行测试。

完成上述工作后，请向我们的仓库提交PR。

## 任务奖励

每完成1个bug的回归并向我们的<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">仓库</a>提交PR，我们将提供100元的奖金作为奖励。

## 待复现bug

对每个bug，我们将提供bug的描述、bug发生的原因，该bug被修复的commit的id以及对应的RTL版本，方便复现者对应到具体的commit。

[出bug的基本原因分析]redirect时发送到RAS模块的Call和ret信号存在问题，RAS实现阻塞的情况下，会误判推测栈阻塞。引起前端阻塞卡死。[修bug涉及的RTL文件，修改前后关键代码对比]无[修bug涉及的chisel文件，修改前后关键代码对比] [图片] [修改后的chisel代码合入版本信息]fix(RAS): correct the Call and Ret signals during redirection, and modify the blocking mechanism of RAS. #3514 
| id | bug描述 | 修复bug的commit id | RTL版本 | 原因 |
| --- | ------ | -------------- | ------ | ------ |
| KMH22-351 | 第一阶段地址翻译为Bare，第二阶段地址翻译为Sv39x4时，报GPF时mtval2为0 | 08ae0d2 | 0828 | onlys2的情况下，L1TLB重填gpaddr的时候计算错误，使用了s1的ppn，应该使用s2的tag ｜
| KMH22-397 | FrontEnd模块: 帕拉丁环境下0828core+tilelink的spec case <gamess_cytosine>核挂死 | | 0828 | redirect时发送到RAS模块的Call和ret信号存在问题，RAS实现阻塞的情况下，会误判推测栈阻塞。引起前端阻塞卡死 |
| KMH22-398 | DCache: 帕拉丁环境下0828core+tilelink的spec case <bwaves>核挂死 | |0828 |在以前的设计中，当 miss_req 不断在 mshr 中等待探测和重放时，refill_req 会阻塞 store_req 和probe_req，从而导致死锁。现在删除无用的阻塞以修复此问题。|
| KMH22-399 | MemoryAccess/MemBlock: 向量拓展 VLE 指令访存异常 | b528775 | 0828core_tilelink | 在支持sv48后，向量访存存在位宽未修改适配,导致运行unit-stride指令时，地址硬编码高位丢失 |
| KMH22-400 | MemoryAccess/L2C: MMIO 和 cacheable 空间的 PCredit未一起仲裁导致PCrdGrant 会丢失 | | 0828 | MMIO 和 cacheable 空间的 PCredit 应该放在一起仲裁MMIO 的 rxrsp 分配到哪一项 MMIO entry 是根据 TxnID 来判断的，但是 PCrdGrant 是没有 TxnID 的按照之前的 PCrdGrant 分配逻辑，如果某一个 transaction 先收到 PCrdGrant 再收到 RetryAck，这个 PCrdGrant 会丢失 |
| KMH22-1547 | MemoryAccess/DTLB: TLB 中的 PLRU 替换算法替换了近期访问的 TLB 项，导致 TLB 的 gpf 处理过程被破坏，引发卡死 | 4fc3a30 | 1128 | L1TLB 不存储物理地址（gpaddr），但在发生虚拟机页面错误（GPF）时，gpaddr 是必须的。在这种情况下，L1TLB 需要发送一个页面表查找（PTW）请求来获取 gpaddr，我们称之为 getGpa。getGpa 机制只能处理一个 GPF TLB 请求（即第一个请求），并且期望相应的 TLB 条目仍然存在于 L1TLB 中。L1TLB 替换使用的是 PLRU（伪最近最少使用）算法，这可能会替换一些未必是最近最少使用的条目。我们发现一个情况，L1TLB 替换了那个 GPF TLB 条目，尽管该条目最近才被访问。这导致了 getGpa 机制中的死锁问题，最终导致整个核心冻结。为了解决这个问题，我们决定在 getGpa 机制工作时（即需要 gpaddr 时）阻止任何无关的 PTW 填充。在解决了这个问题后，我们发现，在某些情况下，其他的 PTW 响应没有被填充，其他 TLB 请求继续响应，触发 PTW 请求并占用 L2TLB 请求路径，阻止了 GPF PTW 请求的响应，最终导致处理器冻结。为了解决这个问题，我们决定在需要 gpaddr 时阻止任何无关的 PTW 请求。|
| KMH22-232 | 在FGPA Linux命令行, 运行spec2006测试集中的 milc_run.sh 脚本: 部分卡死进不了spec测试，部分进入spec不退出" | | | |

