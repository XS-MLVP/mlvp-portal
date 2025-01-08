---
title: '第一期昆明湖回归测试任务'
date: 2024-01-11T08:47:18+08:00
draft: false
fenbao_tags: ["bug复现","回归测试"]
#website: "/xs-bpu/"
task_closed: false
summary: "根据已发布的bug任务，设计回归测试用例复现bug"
---


>UT（单元测试）、IT（集成测试）和 ST（系统测试）是处理器验证的三个关键阶段，它们分别针对验证中的不同层次。其中UT是对处理器设计中的最小功能单元(模块)进行测试，确保其功能符合设计要求。然而在生产实际中，一些模块的bug并非在UT阶段被发现，而是在后续的验证阶段发现并报告的。因此，我们需要在UT中构造测试用例将这些bug复现出来，同时也需要在该bug被修复后的版本重新运行测试用例，确保正确修复了该bug。这个过程也叫做回归测试。


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


<style>
/* 样式 */
.table-container {
    margin: 20px auto;
    width: 90%; /* 占页面总宽度的90% */
    border-collapse: collapse;
    table-layout: fixed; /* 固定列宽 */
}

.table-container th,
.table-container td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
    position: relative;
}

.table-container th {
    background-color: #f2f2f2;
}

.table-container .id-column {
    width: 11ch; /* 至少12个字符宽 */
}

.table-container .commit-column {
    width: 10ch; /* commit id 列稍短 */
}

.table-container .rtl-column {
    width: 9ch; /* RTL版本列稍短 */
}

.table-container .description-column,
.table-container .reason-column {
    width: 35%; /* bug描述和原因列稍长 */
}

.table-container .issue-column {
    width: 8ch; /* RTL版本列稍短 */
}

.table-container .ellipsis {
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    max-width: 100%; /* 限制内容溢出 */
    cursor: pointer;
}

.table-container .tooltip {
    visibility: hidden;
    position: absolute;
    background-color: #555;
    color: #fff;
    text-align: center;
    border-radius: 4px;
    padding: 5px;
    z-index: 1;
    bottom: 125%; /* 显示在单元格上方 */
    left: 50%;
    transform: translateX(-50%);
    opacity: 0;
    transition: opacity 0.3s;
    max-width: 300px;
    word-wrap: break-word;
}

.table-container .ellipsis:hover .tooltip {
    visibility: visible;
    opacity: 1;
}
</style>

<table class="table-container">
    <thead>
        <tr>
            <th class="id-column">id</th>
            <th class="description-column">bug描述</th>
            <th class="commit-column">commit id</th>
            <th class="rtl-column">RTL版本</th>
            <th class="reason-column">原因</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="id-column">KMH22-242</td>
            <td class="description-column">
                <div class="ellipsis">
                    访存发生misalign
                    <span class="tooltip">访存发生misalign</span>
                </div>
            </td>
            <td class="commit-column">052738a</td>
            <td class="rtl-column">0803</td>
            <td class="reason-column">
                <div class="ellipsis">
                    访存发生misalign时，未传递gpa，导致出错
                    <span class="tooltip">访存发生misalign时，未传递gpa，导致出错</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-351</td>
            <td class="description-column">
                <div class="ellipsis">
                    L1TLB重填gpaddr的时候计算错误
                    <span class="tooltip">L1TLB重填gpaddr的时候计算错误</span>
                </div>
            </td>
            <td class="commit-column">08ae0d2</td>
            <td class="rtl-column">nan</td>
            <td class="reason-column">
                <div class="ellipsis">
                    第一阶段地址翻译为Bare，第二阶段地址翻译为Sv39x4时，报GPF时mtval2为0，onlys2的情况下，L1TLB重填gpaddr的时候计算错误，使用了s1的ppn，应该使用s2的tag
                    <span class="tooltip">第一阶段地址翻译为Bare，第二阶段地址翻译为Sv39x4时，报GPF时mtval2为0，onlys2的情况下，L1TLB重填gpaddr的时候计算错误，使用了s1的ppn，应该使用s2的tag</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-397</td>
            <td class="description-column">
                <div class="ellipsis">
                    RAS误判推测栈阻塞。引起前端阻塞卡死
                    <span class="tooltip">RAS误判推测栈阻塞。引起前端阻塞卡死</span>
                </div>
            </td>
            <td class="commit-column"></td>
            <td class="rtl-column">0828</td>
            <td class="reason-column">
                <div class="ellipsis">
                    redirect时发送到RAS模块的Call和ret信号存在问题，RAS实现阻塞的情况下，会误判推测栈阻塞。引起前端阻塞卡死
                    <span class="tooltip">redirect时发送到RAS模块的Call和ret信号存在问题，RAS实现阻塞的情况下，会误判推测栈阻塞。引起前端阻塞卡死</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-398</td>
            <td class="description-column">
                <div class="ellipsis">
                    miss_req 不断在 mshr 中等待探测和重放时，refill_req 会阻塞 store_req 和probe_req，从而导致死锁
                    <span class="tooltip">miss_req 不断在 mshr 中等待探测和重放时，refill_req 会阻塞 store_req 和probe_req，从而导致死锁</span>
                </div>
            </td>
            <td class="commit-column">be007c1</td>
            <td class="rtl-column">0828</td>
            <td class="reason-column">
                <div class="ellipsis">
                    在以前的设计中，当 miss_req 不断在 mshr 中等待探测和重放时，refill_req 会阻塞 store_req 和probe_req，从而导致死锁。
现在删除无用的阻塞以修复此问题
                    <span class="tooltip">在以前的设计中，当 miss_req 不断在 mshr 中等待探测和重放时，refill_req 会阻塞 store_req 和probe_req，从而导致死锁。
现在删除无用的阻塞以修复此问题</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-399</td>
            <td class="description-column">
                <div class="ellipsis">
                    unit-stride 地址硬编码 39 位，改成 Sv48 后高位丢失
                    <span class="tooltip">unit-stride 地址硬编码 39 位，改成 Sv48 后高位丢失</span>
                </div>
            </td>
            <td class="commit-column">b528775</td>
            <td class="rtl-column">0828</td>
            <td class="reason-column">
                <div class="ellipsis">
                    在支持sv48后，向量访存存在位宽未修改适配的情况
                    <span class="tooltip">在支持sv48后，向量访存存在位宽未修改适配的情况</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-400</td>
            <td class="description-column">
                <div class="ellipsis">
                    MMIO 和 cacheable 空间的 PCredit 未放在一起仲裁导致PCrdGrant 丢失
                    <span class="tooltip">MMIO 和 cacheable 空间的 PCredit 未放在一起仲裁导致PCrdGrant 丢失</span>
                </div>
            </td>
            <td class="commit-column"></td>
            <td class="rtl-column">0828</td>
            <td class="reason-column">
                <div class="ellipsis">
                    MMIO 和 cacheable 空间的 PCredit 应该放在一起仲裁MMIO 的 rxrsp 分配到哪一项 MMIO entry 是根据 TxnID 来判断的，但是 PCrdGrant 是没有 TxnID 的按照之前的 PCrdGrant 分配逻辑，如果某一个 transaction 先收到 PCrdGrant 再收到 RetryAck，这个 PCrdGrant 会丢失
                    <span class="tooltip">MMIO 和 cacheable 空间的 PCredit 应该放在一起仲裁MMIO 的 rxrsp 分配到哪一项 MMIO entry 是根据 TxnID 来判断的，但是 PCrdGrant 是没有 TxnID 的按照之前的 PCrdGrant 分配逻辑，如果某一个 transaction 先收到 PCrdGrant 再收到 RetryAck，这个 PCrdGrant 会丢失</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-1547</td>
            <td class="description-column">
                <div class="ellipsis">
                    TLB 中的 PLRU 替换算法替换了近期访问的 TLB 项，导致 TLB 的 gpf 处理过程被破坏，引发卡死
                    <span class="tooltip">TLB 中的 PLRU 替换算法替换了近期访问的 TLB 项，导致 TLB 的 gpf 处理过程被破坏，引发卡死</span>
                </div>
            </td>
            <td class="commit-column">4fc3a30</td>
            <td class="rtl-column">1128</td>
            <td class="reason-column">
                <div class="ellipsis">
                    L1TLB 不存储物理地址（gpaddr），但在发生虚拟机页面错误（GPF）时，gpaddr 是必须的。在这种情况下，L1TLB 需要发送一个页面表查找（PTW）请求来获取 gpaddr，我们称之为 getGpa。getGpa 机制只能处理一个 GPF TLB 请求（即第一个请求），并且期望相应的 TLB 条目仍然存在于 L1TLB 中。L1TLB 替换使用的是 PLRU（伪最近最少使用）算法，这可能会替换一些未必是最近最少使用的条目。我们发现一个情况，L1TLB 替换了那个 GPF TLB 条目，尽管该条目最近才被访问。这导致了 getGpa 机制中的死锁问题，最终导致整个核心冻结。为了解决这个问题，我们决定在 getGpa 机制工作时（即需要 gpaddr 时）阻止任何无关的 PTW 填充。在解决了这个问题后，我们发现，在某些情况下，其他的 PTW 响应没有被填充，其他 TLB 请求继续响应，触发 PTW 请求并占用 L2TLB 请求路径，阻止了 GPF PTW 请求的响应，最终导致处理器冻结。为了解决这个问题，我们决定在需要 gpaddr 时阻止任何无关的 PTW 请求
                    <span class="tooltip">L1TLB 不存储物理地址（gpaddr），但在发生虚拟机页面错误（GPF）时，gpaddr 是必须的。在这种情况下，L1TLB 需要发送一个页面表查找（PTW）请求来获取 gpaddr，我们称之为 getGpa。getGpa 机制只能处理一个 GPF TLB 请求（即第一个请求），并且期望相应的 TLB 条目仍然存在于 L1TLB 中。L1TLB 替换使用的是 PLRU（伪最近最少使用）算法，这可能会替换一些未必是最近最少使用的条目。我们发现一个情况，L1TLB 替换了那个 GPF TLB 条目，尽管该条目最近才被访问。这导致了 getGpa 机制中的死锁问题，最终导致整个核心冻结。为了解决这个问题，我们决定在 getGpa 机制工作时（即需要 gpaddr 时）阻止任何无关的 PTW 填充。在解决了这个问题后，我们发现，在某些情况下，其他的 PTW 响应没有被填充，其他 TLB 请求继续响应，触发 PTW 请求并占用 L2TLB 请求路径，阻止了 GPF PTW 请求的响应，最终导致处理器冻结。为了解决这个问题，我们决定在需要 gpaddr 时阻止任何无关的 PTW 请求</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-1572</td>
            <td class="description-column">
                <div class="ellipsis">
                    Xvisor无法正确处理gpf，造成死循环
                    <span class="tooltip">Xvisor无法正确处理gpf，造成死循环</span>
                </div>
            </td>
            <td class="commit-column">e3e0af7</td>
            <td class="rtl-column">1108</td>
            <td class="reason-column">
                <div class="ellipsis">
                    L1TLB增加了跨页时gpaddr的处理逻辑，但仅考虑了DTLB的情况，没有考虑到ITLB并不适用fullva等相关通路，使得例外时错误地传递了0作为htval。xvisor的例外处理程序依赖于htval来处理GPF例外，错误的htval使其卡死
                    <span class="tooltip">L1TLB增加了跨页时gpaddr的处理逻辑，但仅考虑了DTLB的情况，没有考虑到ITLB并不适用fullva等相关通路，使得例外时错误地传递了0作为htval。xvisor的例外处理程序依赖于htval来处理GPF例外，错误的htval使其卡死</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-1786</td>
            <td class="description-column">
                <div class="ellipsis">
                    RTL在某些不可能修改向量状态的指令仍然将vs设置为dirty
                    <span class="tooltip">RTL在某些不可能修改向量状态的指令仍然将vs设置为dirty</span>
                </div>
            </td>
            <td class="commit-column">547d96a</td>
            <td class="rtl-column">1119</td>
            <td class="reason-column">
                <div class="ellipsis">
                    do not set vs.dirty for some type of vecInsts
                    <span class="tooltip">do not set vs.dirty for some type of vecInsts</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-1824</td>
            <td class="description-column">
                <div class="ellipsis">
                    vset不应该响应时钟中断，而vset被标记为了interrupt_safe
                    <span class="tooltip">vset不应该响应时钟中断，而vset被标记为了interrupt_safe</span>
                </div>
            </td>
            <td class="commit-column">493f6e1</td>
            <td class="rtl-column">1119</td>
            <td class="reason-column">
                <div class="ellipsis">
                    修改 vset不响应时钟中断
                    <span class="tooltip">修改 vset不响应时钟中断</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-1844</td>
            <td class="description-column">
                <div class="ellipsis">
                    前端跨页取指令时例外处理错误
                    <span class="tooltip">前端跨页取指令时例外处理错误</span>
                </div>
            </td>
            <td class="commit-column">547d96a</td>
            <td class="rtl-column">1203</td>
            <td class="reason-column">
                <div class="ellipsis">
                    应该是ebsin的问题
                    <span class="tooltip">应该是ebsin的问题</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-1872</td>
            <td class="description-column">
                <div class="ellipsis">
                    vecExcpInfo.valid在中断来临时错误更新
                    <span class="tooltip">vecExcpInfo.valid在中断来临时错误更新</span>
                </div>
            </td>
            <td class="commit-column">7876e67</td>
            <td class="rtl-column">1203</td>
            <td class="reason-column">
                <div class="ellipsis">
                    Rob 中，`vecExcpInfo.valid := exceptionHappen && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`。当该信号为高电平时，代表需要处理向量访存相关异常。此时，`backend`下的一个子模块`vecExcpMod`会进入一个状态机，暂时阻塞指令进入`Dispatch`。然而，当发生中断时，`exceptionHappen`也会为高电平，此时`exceptionDataRead`中的数据为无效数据。如果无效数据恰好导致`vecExcpInfo.valid`为高电平，则会使`vecExcpMod`模块错误地阻塞指令进入`Dispatch`，导致卡死。因此需要给该信号的赋值排除掉中断的情形，改为`vecExcpInfo.valid := exceptionHappen && !intrEnable && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`即可
                    <span class="tooltip">Rob 中，`vecExcpInfo.valid := exceptionHappen && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`。当该信号为高电平时，代表需要处理向量访存相关异常。此时，`backend`下的一个子模块`vecExcpMod`会进入一个状态机，暂时阻塞指令进入`Dispatch`。然而，当发生中断时，`exceptionHappen`也会为高电平，此时`exceptionDataRead`中的数据为无效数据。如果无效数据恰好导致`vecExcpInfo.valid`为高电平，则会使`vecExcpMod`模块错误地阻塞指令进入`Dispatch`，导致卡死。因此需要给该信号的赋值排除掉中断的情形，改为`vecExcpInfo.valid := exceptionHappen && !intrEnable && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`即可</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-1947 </td>
            <td class="description-column">
                <div class="ellipsis">
                    中断时，vecExcpInfo.valid被错误更新，导致vecExcpInfo.bits可能为未初始化的值，导致x态传播或随机卡死。
                    <span class="tooltip">中断时，vecExcpInfo.valid被错误更新，导致vecExcpInfo.bits可能为未初始化的值，导致x态传播或随机卡死。</span>
                </div>
            </td>
            <td class="commit-column">7876e67</td>
            <td class="rtl-column">nan</td>
            <td class="reason-column">
                <div class="ellipsis">
                    `vecExcpInfo.valid := exceptionHappen && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`。当该信号为高电平时，代表需要处理向量访存相关异常。此时，`backend`下的一个子模块`vecExcpMod`会进入一个状态机，暂时阻塞指令进入`Dispatch`。然而，当发生中断时，`exceptionHappen`也会为高电平，此时`exceptionDataRead`中的数据为无效数据。如果无效数据恰好导致`vecExcpInfo.valid`为高电平，则会使`vecExcpMod`模块错误地阻塞指令进入`Dispatch`，导致卡死。因此需要给该信号的赋值排除掉中断的情形，改为`vecExcpInfo.valid := exceptionHappen && !intrEnable && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`即可
                    <span class="tooltip">`vecExcpInfo.valid := exceptionHappen && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`。当该信号为高电平时，代表需要处理向量访存相关异常。此时，`backend`下的一个子模块`vecExcpMod`会进入一个状态机，暂时阻塞指令进入`Dispatch`。然而，当发生中断时，`exceptionHappen`也会为高电平，此时`exceptionDataRead`中的数据为无效数据。如果无效数据恰好导致`vecExcpInfo.valid`为高电平，则会使`vecExcpMod`模块错误地阻塞指令进入`Dispatch`，导致卡死。因此需要给该信号的赋值排除掉中断的情形，改为`vecExcpInfo.valid := exceptionHappen && !intrEnable && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`即可</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-1957</td>
            <td class="description-column">
                <div class="ellipsis">
                    nan
                    <span class="tooltip">nan</span>
                </div>
            </td>
            <td class="commit-column">fad7803</td>
            <td class="rtl-column">1203</td>
            <td class="reason-column">
                <div class="ellipsis">
                    nan
                    <span class="tooltip">nan</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-1971</td>
            <td class="description-column">
                <div class="ellipsis">
                    vecExceptionFlag标记位置位条件出错
                    <span class="tooltip">vecExceptionFlag标记位置位条件出错</span>
                </div>
            </td>
            <td class="commit-column">99baa88</td>
            <td class="rtl-column">1209</td>
            <td class="reason-column">
                <div class="ellipsis">
                    nan
                    <span class="tooltip">nan</span>
                </div>
            </td>
        </tr><tr>
            <td class="id-column">KMH22-242</td>
            <td class="description-column">
                <div class="ellipsis">
                    访存发生misalign时，未传递gpa，导致出错
                    <span class="tooltip">访存发生misalign时，未传递gpa，导致出错</span>
                </div>
            </td>
            <td class="commit-column">052738a</td>
            <td class="rtl-column">nan</td>
            <td class="reason-column">
                <div class="ellipsis">
                    自测试，修复一些涉及到翻译获取gpaddr以及gpaddr传递的bug
                    <span class="tooltip">自测试，修复一些涉及到翻译获取gpaddr以及gpaddr传递的bug</span>
                </div>
            </td>
        </tr>
</tbody>
</table>

