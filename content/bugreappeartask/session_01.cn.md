---
title: '回归验证第一期：第三代香山(昆明湖）Bug用例复现(进行中)'
date: 2024-01-11T08:47:18+08:00
draft: false
fenbao_tags: ["Bug复现","回归测试"]
#website: "/xs-bpu/"
task_closed: false
status: "Continuing"
home_page_show: true
Weight: 10
summary: "根据已发布的Bug任务，设计回归测试用例复现Bug"
schedule: 2
desc: '第1期：共18个待回归BUG'
---


>UT（单元测试）、IT（集成测试）和 ST（系统测试）是处理器验证的三个关键阶段，它们分别针对验证中的不同层次。其中UT是对处理器设计中的最小功能单元(模块)进行测试，确保其功能符合设计要求。然而在生产实际中，一些模块的Bug并非在UT阶段被发现，而是在后续的验证阶段发现并报告的。因此，我们需要在UT中构造测试用例将这些Bug复现出来，同时也需要在该Bug被修复后的版本重新运行测试用例，确保正确修复了该Bug。这个过程也叫做回归测试。


## 任务简介

本期任务将会提供18个待回归的Bug，参与者需使用指定工具链(<a href="https://github.com/XS-MLVP/picker" target="_blank">picker</a>,<a href="https://github.com/XS-MLVP/toffee" target="_blank">toffee</a>(可选))，构建测试用例对Bug进行回归。

对于大多数的Bug，我们会提供详细的Bug描述，包括Bug所在的模块，发生原因，如何复现等，对于部分Bug，可能需要根据描述自行定位相关模块或搭建验证环境。根据工作量的不同，会获得不同等级的奖金。每完成1个Bug的回归并向<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan</a>仓库提交Pull Request(PR)，将获得100元的奖金作为奖励，若贡献bug验证基础环境，可以获得额外奖励。希望大家能够积极参与并完成任务！([点击此处](https://www.wjx.top/vm/ryUKH5T.aspx)填写报名表即可报名。)

## 测试内容

对每个Bug，需要您完成如下的工作：

#### 1、环境构建

首先，根据<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan</a>提供的测试环境，构建测试用例对Bug进行回归。

- 若描述中未明确模块，需要自行定位相关模块。
- 若仓库中目标模块不存在验证环境，请参考<a href="https://open-verify.cc/UnityChipForXiangShan/docs/01_verfiy_env/" target="_blank">文档</a>中的**准备验证环境**，**添加测试**部分，按照规范搭建验证环境。

#### 2、用例构造

接下来，根据触发Bug的原因，构建相应的测试用例。此次任务会给您提供**出现Bug的RTL**和**修复该Bug的commit日期**

对于所构建的测试用用例，需要满足以下两方面的内容：

1. 在出现Bug的RTL：可以运行该测试用例，且运行该测试用例进行测试不通过。

2. 在<a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs" target="_blank">仓库</a>下载commit日期后的RTL：可以运行该测试用例，且该测试用例可以通过。

#### 3、提交说明

最后撰写说明，描述该Bug所属于哪个模块，简述相关的测试环境和用例，以及如何运行测试。

完成上述工作后，将PR提交至<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan</a>仓库。

## 任务奖励

每完成1个Bug的回归并向<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan</a>仓库提交PR，对于第一个接受的PR，将获得100元的奖金作为奖励，若贡献bug验证基础环境，可以获得额外奖励。

## 待复现Bug

对于每个Bug，以下表格列出了对应的任务id、Bug描述、产生原因、出现Bug的RTL版本以及修复的commit日期等信息。更多详细内容可看issue或<a href="https://iz9a87wn37.feishu.cn/base/GmASbpeYcagtmGsE9WncMqwDnhb?from=from_copylink"  target="_blank">任务详情</a>。

注：**Commit**：点击可跳转至修复该Bug的commit页面；**RTL**：点击可下载出现Bug时的RTL。
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
    width: 12ch; /* commit id 列稍短 */
}

.table-container .rtl-column {
    width: 9ch; /* RTL版本列稍短 */
}

.table-container .description-column,
.table-container .reason-column {
    width: 35%; /* Bug描述和原因列稍长 */
}

.table-container .issue-column {
    width: 8ch; /* RTL版本列稍短 */
}

.table-container .index-column {
    width: 6ch; /* RTL版本列稍短 */
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
            <th class="index-column">序号</th>
            <th class="id-column">任务id</th>
            <th class="description-column">Bug描述</th>
            <th class="commit-column">Commit</th>
            <th class="rtl-column">RTL</th>
            <th class="reason-column">原因</th>
            <th class="issue-column">issue</th>
            <th class="issue-column">贡献人</th>
        </tr>
    </thead>
    <tbody>
<tr><td class="index-column">1</td><td class="id-column">KMH22-242</td><td class="description-column"><div class="ellipsis">访存发生misalign，未传递gpa，导致出错<span class="tooltip">访存发生misalign，未传递gpa，导致出错</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/052738a" target="_blank">2024-09-12</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024080301/openxiangshan-kmh-a061b23-24080301.tar.gz" target="_blank">24080301</a></td><td class="reason-column"><div class="ellipsis">访存发生misalign时，未传递gpa，导致出错<span class="tooltip">访存发生misalign时，未传递gpa，导致出错</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/15" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">2</td><td class="id-column">KMH22-118</td><td class="description-column"><div class="ellipsis"> dcsr中stopcount和stoptime功能未实现 <span class="tooltip"> dcsr中stopcount和stoptime功能未实现 </span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/1e49aee" target="_blank">2024-11-14</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024080301/openxiangshan-kmh-a061b23-24080301.tar.gz" target="_blank">24080301</a></td><td class="reason-column"><div class="ellipsis">未实现 dcsr中stopcount和stoptime功能，在设计代码中实现<span class="tooltip">未实现 dcsr中stopcount和stoptime功能，在设计代码中实现</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/16" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">3</td><td class="id-column">KMH22-351</td><td class="description-column"><div class="ellipsis">L1TLB重填gpaddr的时候计算错误<span class="tooltip">L1TLB重填gpaddr的时候计算错误</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/08ae0d2" target="_blank">2024-09-04</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024082801/openxiangshan-kmh-19bd5ff8-24082801.tar.gz" target="_blank">24082801</a></td><td class="reason-column"><div class="ellipsis">第一阶段地址翻译为Bare，第二阶段地址翻译为Sv39x4时，报GPF时mtval2为0，onlys2的情况下，L1TLB重填gpaddr的时候计算错误，使用了s1的ppn，应该使用s2的tag<span class="tooltip">第一阶段地址翻译为Bare，第二阶段地址翻译为Sv39x4时，报GPF时mtval2为0，onlys2的情况下，L1TLB重填gpaddr的时候计算错误，使用了s1的ppn，应该使用s2的tag</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/17" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">4</td><td class="id-column">KMH22-397</td><td class="description-column"><div class="ellipsis">RAS误判推测栈阻塞。引起前端阻塞卡死<span class="tooltip">RAS误判推测栈阻塞。引起前端阻塞卡死</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/c776f0d" target="_blank">2024-09-10</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024082801/openxiangshan-kmh-19bd5ff8-24082801.tar.gz" target="_blank">24082801</a></td><td class="reason-column"><div class="ellipsis">redirect时发送到RAS模块的Call和ret信号存在问题，RAS实现阻塞的情况下，会误判推测栈阻塞。引起前端阻塞卡死<span class="tooltip">redirect时发送到RAS模块的Call和ret信号存在问题，RAS实现阻塞的情况下，会误判推测栈阻塞。引起前端阻塞卡死</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/18" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">5</td><td class="id-column">KMH22-398</td><td class="description-column"><div class="ellipsis">miss_req 不断在 mshr 中等待探测和重放时，refill_req 会阻塞 store_req 和probe_req，从而导致死锁<span class="tooltip">miss_req 不断在 mshr 中等待探测和重放时，refill_req 会阻塞 store_req 和probe_req，从而导致死锁</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/be007c1" target="_blank">2024-09-04</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024082801/openxiangshan-kmh-19bd5ff8-24082801.tar.gz" target="_blank">24082801</a></td><td class="reason-column"><div class="ellipsis">在以前的设计中，当 miss_req 不断在 mshr 中等待探测和重放时，refill_req 会阻塞 store_req 和probe_req，从而导致死锁。
现在删除无用的阻塞以修复此问题<span class="tooltip">在以前的设计中，当 miss_req 不断在 mshr 中等待探测和重放时，refill_req 会阻塞 store_req 和probe_req，从而导致死锁。
现在删除无用的阻塞以修复此问题</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/19" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">6</td><td class="id-column">KMH22-399</td><td class="description-column"><div class="ellipsis">unit-stride 地址硬编码 39 位，改成 Sv48 后高位丢失<span class="tooltip">unit-stride 地址硬编码 39 位，改成 Sv48 后高位丢失</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/b528775" target="_blank">2024-09-16</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024082801/openxiangshan-kmh-19bd5ff8-24082801.tar.gz" target="_blank">24082801</a></td><td class="reason-column"><div class="ellipsis">在支持sv48后，向量访存存在位宽未修改适配的情况<span class="tooltip">在支持sv48后，向量访存存在位宽未修改适配的情况</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/20" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">7</td><td class="id-column">KMH22-400</td><td class="description-column"><div class="ellipsis">MMIO 和 cacheable 空间的 PCredit 未放在一起仲裁导致PCrdGrant 丢失<span class="tooltip">MMIO 和 cacheable 空间的 PCredit 未放在一起仲裁导致PCrdGrant 丢失</span></div></td><td class="commit-column">TBD</td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024082801/openxiangshan-kmh-19bd5ff8-24082801.tar.gz" target="_blank">24082801</a></td><td class="reason-column"><div class="ellipsis">MMIO 和 cacheable 空间的 PCredit 应该放在一起仲裁MMIO 的 rxrsp 分配到哪一项 MMIO entry 是根据 TxnID 来判断的，但是 PCrdGrant 是没有 TxnID 的按照之前的 PCrdGrant 分配逻辑，如果某一个 transaction 先收到 PCrdGrant 再收到 RetryAck，这个 PCrdGrant 会丢失<span class="tooltip">MMIO 和 cacheable 空间的 PCredit 应该放在一起仲裁MMIO 的 rxrsp 分配到哪一项 MMIO entry 是根据 TxnID 来判断的，但是 PCrdGrant 是没有 TxnID 的按照之前的 PCrdGrant 分配逻辑，如果某一个 transaction 先收到 PCrdGrant 再收到 RetryAck，这个 PCrdGrant 会丢失</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/21" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">8</td><td class="id-column">KMH22-1547</td><td class="description-column"><div class="ellipsis">TLB 中的 PLRU 替换算法替换了近期访问的 TLB 项，导致 TLB 的 gpf 处理过程被破坏，引发卡死<span class="tooltip">TLB 中的 PLRU 替换算法替换了近期访问的 TLB 项，导致 TLB 的 gpf 处理过程被破坏，引发卡死</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/4fc3a30" target="_blank">2024-12-02</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024103001/openxiangshan-kmh-7a8dfe4f-24103001.tar.gz" target="_blank">24103001</a></td><td class="reason-column"><div class="ellipsis">L1TLB 不存储物理地址（gpaddr），但在发生虚拟机页面错误（GPF）时，gpaddr 是必须的。在这种情况下，L1TLB 需要发送一个页面表查找（PTW）请求来获取 gpaddr，我们称之为 getGpa。getGpa 机制只能处理一个 GPF TLB 请求（即第一个请求），并且期望相应的 TLB 条目仍然存在于 L1TLB 中。L1TLB 替换使用的是 PLRU（伪最近最少使用）算法，这可能会替换一些未必是最近最少使用的条目。我们发现一个情况，L1TLB 替换了那个 GPF TLB 条目，尽管该条目最近才被访问。这导致了 getGpa 机制中的死锁问题，最终导致整个核心冻结。为了解决这个问题，我们决定在 getGpa 机制工作时（即需要 gpaddr 时）阻止任何无关的 PTW 填充。在解决了这个问题后，我们发现，在某些情况下，其他的 PTW 响应没有被填充，其他 TLB 请求继续响应，触发 PTW 请求并占用 L2TLB 请求路径，阻止了 GPF PTW 请求的响应，最终导致处理器冻结。为了解决这个问题，我们决定在需要 gpaddr 时阻止任何无关的 PTW 请求<span class="tooltip">L1TLB 不存储物理地址（gpaddr），但在发生虚拟机页面错误（GPF）时，gpaddr 是必须的。在这种情况下，L1TLB 需要发送一个页面表查找（PTW）请求来获取 gpaddr，我们称之为 getGpa。getGpa 机制只能处理一个 GPF TLB 请求（即第一个请求），并且期望相应的 TLB 条目仍然存在于 L1TLB 中。L1TLB 替换使用的是 PLRU（伪最近最少使用）算法，这可能会替换一些未必是最近最少使用的条目。我们发现一个情况，L1TLB 替换了那个 GPF TLB 条目，尽管该条目最近才被访问。这导致了 getGpa 机制中的死锁问题，最终导致整个核心冻结。为了解决这个问题，我们决定在 getGpa 机制工作时（即需要 gpaddr 时）阻止任何无关的 PTW 填充。在解决了这个问题后，我们发现，在某些情况下，其他的 PTW 响应没有被填充，其他 TLB 请求继续响应，触发 PTW 请求并占用 L2TLB 请求路径，阻止了 GPF PTW 请求的响应，最终导致处理器冻结。为了解决这个问题，我们决定在需要 gpaddr 时阻止任何无关的 PTW 请求</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/22" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">9</td><td class="id-column">KMH22-1572</td><td class="description-column"><div class="ellipsis">Xvisor无法正确处理gpf，造成死循环<span class="tooltip">Xvisor无法正确处理gpf，造成死循环</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/e3e0af7" target="_blank">2024-11-14</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024110801/openxiangshan-kmh-fbdb359d-24110801.tar.gz" target="_blank">24110801</a></td><td class="reason-column"><div class="ellipsis">L1TLB增加了跨页时gpaddr的处理逻辑，但仅考虑了DTLB的情况，没有考虑到ITLB并不适用fullva等相关通路，使得例外时错误地传递了0作为htval。xvisor的例外处理程序依赖于htval来处理GPF例外，错误的htval使其卡死<span class="tooltip">L1TLB增加了跨页时gpaddr的处理逻辑，但仅考虑了DTLB的情况，没有考虑到ITLB并不适用fullva等相关通路，使得例外时错误地传递了0作为htval。xvisor的例外处理程序依赖于htval来处理GPF例外，错误的htval使其卡死</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/23" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">10</td><td class="id-column">KMH22-1786</td><td class="description-column"><div class="ellipsis">RTL在某些不可能修改向量状态的指令仍然将vs设置为dirty<span class="tooltip">RTL在某些不可能修改向量状态的指令仍然将vs设置为dirty</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/547d96a" target="_blank">2024-12-01</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024111901/openxiangshan-kmh-3b733a2b-24111901.tar.gz" target="_blank">24111901</a></td><td class="reason-column"><div class="ellipsis">do not set vs.dirty for some type of vecInsts<span class="tooltip">do not set vs.dirty for some type of vecInsts</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/24" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">11</td><td class="id-column">KMH22-1824</td><td class="description-column"><div class="ellipsis">vset不应该响应时钟中断，而vset被标记为了interrupt_safe<span class="tooltip">vset不应该响应时钟中断，而vset被标记为了interrupt_safe</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/493f6e1" target="_blank">2024-12-07</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024111901/openxiangshan-kmh-3b733a2b-24111901.tar.gz" target="_blank">24111901</a></td><td class="reason-column"><div class="ellipsis">修改 vset不响应时钟中断<span class="tooltip">修改 vset不响应时钟中断</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/25" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">12</td><td class="id-column">KMH22-1844</td><td class="description-column"><div class="ellipsis">前端跨页取指令时例外处理错误<span class="tooltip">前端跨页取指令时例外处理错误</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/547d96a" target="_blank">2024-12-01</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024112601/openxiangshan-kmh-3956160f-24112601.tar.gz" target="_blank">24112601</a></td><td class="reason-column"><div class="ellipsis">应该是ebsin的问题<span class="tooltip">应该是ebsin的问题</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/26" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">13</td><td class="id-column">KMH22-1861</td><td class="description-column"><div class="ellipsis">非 V 模式下读取 vsie/vsip 和 V 模式下读取 sie/sip 的问题<span class="tooltip">非 V 模式下读取 vsie/vsip 和 V 模式下读取 sie/sip 的问题</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/e9ba7f2" target="_blank">2024-12-06</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024120301/openxiangshan-kmh-2e5ebf51-24120301.tar.gz" target="_blank">24120301</a></td><td class="reason-column"><div class="ellipsis">当主机发生 VS 中断时，VM 会发生 S 中断。因此中断号需要同步。修复非 V 模式下读取 vsie/vsip 和 V 模式下读取 sie/sip 的问题。我们通过写入 mstatus/sstatus/vsstatus 的相应位来启用中断，因此我们需要在写入它们时更新 xtopi。徐泽凡L1TLB 尽管已经采取措施在 need_gpf 时请求阻止 ptw 回填，但在 need_gpf 即将拉高时未能阻止卡点进入的 ptw 回填请求<span class="tooltip">当主机发生 VS 中断时，VM 会发生 S 中断。因此中断号需要同步。修复非 V 模式下读取 vsie/vsip 和 V 模式下读取 sie/sip 的问题。我们通过写入 mstatus/sstatus/vsstatus 的相应位来启用中断，因此我们需要在写入它们时更新 xtopi。徐泽凡L1TLB 尽管已经采取措施在 need_gpf 时请求阻止 ptw 回填，但在 need_gpf 即将拉高时未能阻止卡点进入的 ptw 回填请求</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/27" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">14</td><td class="id-column">KMH22-1872</td><td class="description-column"><div class="ellipsis">vecExcpInfo.valid在中断来临时错误更新<span class="tooltip">vecExcpInfo.valid在中断来临时错误更新</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/7876e67" target="_blank">2024-12-06</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024120301/openxiangshan-kmh-2e5ebf51-24120301.tar.gz" target="_blank">24120301</a></td><td class="reason-column"><div class="ellipsis">Rob 中，`vecExcpInfo.valid := exceptionHappen && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`。当该信号为高电平时，代表需要处理向量访存相关异常。此时，`backend`下的一个子模块`vecExcpMod`会进入一个状态机，暂时阻塞指令进入`Dispatch`。然而，当发生中断时，`exceptionHappen`也会为高电平，此时`exceptionDataRead`中的数据为无效数据。如果无效数据恰好导致`vecExcpInfo.valid`为高电平，则会使`vecExcpMod`模块错误地阻塞指令进入`Dispatch`，导致卡死。因此需要给该信号的赋值排除掉中断的情形，改为`vecExcpInfo.valid := exceptionHappen && !intrEnable && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`即可<span class="tooltip">Rob 中，`vecExcpInfo.valid := exceptionHappen && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`。当该信号为高电平时，代表需要处理向量访存相关异常。此时，`backend`下的一个子模块`vecExcpMod`会进入一个状态机，暂时阻塞指令进入`Dispatch`。然而，当发生中断时，`exceptionHappen`也会为高电平，此时`exceptionDataRead`中的数据为无效数据。如果无效数据恰好导致`vecExcpInfo.valid`为高电平，则会使`vecExcpMod`模块错误地阻塞指令进入`Dispatch`，导致卡死。因此需要给该信号的赋值排除掉中断的情形，改为`vecExcpInfo.valid := exceptionHappen && !intrEnable && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`即可</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/28" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">15</td><td class="id-column">KMH22-1947 </td><td class="description-column"><div class="ellipsis">中断时，vecExcpInfo.valid被错误更新，导致vecExcpInfo.bits可能为未初始化的值，导致x态传播或随机卡死。<span class="tooltip">中断时，vecExcpInfo.valid被错误更新，导致vecExcpInfo.bits可能为未初始化的值，导致x态传播或随机卡死。</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/7876e67" target="_blank">2024-12-06</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024101101/openxiangshan-kmh-ecac006d-24101101.tar.gz" target="_blank">24101101</a></td><td class="reason-column"><div class="ellipsis">`vecExcpInfo.valid := exceptionHappen && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`。当该信号为高电平时，代表需要处理向量访存相关异常。此时，`backend`下的一个子模块`vecExcpMod`会进入一个状态机，暂时阻塞指令进入`Dispatch`。然而，当发生中断时，`exceptionHappen`也会为高电平，此时`exceptionDataRead`中的数据为无效数据。如果无效数据恰好导致`vecExcpInfo.valid`为高电平，则会使`vecExcpMod`模块错误地阻塞指令进入`Dispatch`，导致卡死。因此需要给该信号的赋值排除掉中断的情形，改为`vecExcpInfo.valid := exceptionHappen && !intrEnable && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`即可<span class="tooltip">`vecExcpInfo.valid := exceptionHappen && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`。当该信号为高电平时，代表需要处理向量访存相关异常。此时，`backend`下的一个子模块`vecExcpMod`会进入一个状态机，暂时阻塞指令进入`Dispatch`。然而，当发生中断时，`exceptionHappen`也会为高电平，此时`exceptionDataRead`中的数据为无效数据。如果无效数据恰好导致`vecExcpInfo.valid`为高电平，则会使`vecExcpMod`模块错误地阻塞指令进入`Dispatch`，导致卡死。因此需要给该信号的赋值排除掉中断的情形，改为`vecExcpInfo.valid := exceptionHappen && !intrEnable && exceptionDataRead.bits.vstartEn && exceptionDataRead.bits.isVecLoad && !exceptionDataRead.bits.isEnqExcp`即可</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/29" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">16</td><td class="id-column">KMH22-1957</td><td class="description-column"><div class="ellipsis">IF 在特定预取冲刷时未能同步冲刷 ITLB，导致 ITLB 陷入 need_gpf 状态而等不到之前的请求<span class="tooltip">IF 在特定预取冲刷时未能同步冲刷 ITLB，导致 ITLB 陷入 need_gpf 状态而等不到之前的请求</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/fad7803" target="_blank">2024-12-09</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024120301/openxiangshan-kmh-2e5ebf51-24120301.tar.gz" target="_blank">24120301</a></td><td class="reason-column"><div class="ellipsis">IF 在特定预取冲刷时未能同步冲刷 ITLB，导致 ITLB 陷入 need_gpf 状态而等不到之前的请求<span class="tooltip">IF 在特定预取冲刷时未能同步冲刷 ITLB，导致 ITLB 陷入 need_gpf 状态而等不到之前的请求</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/30" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">17</td><td class="id-column">KMH22-1968</td><td class="description-column"><div class="ellipsis">使用了错误idx来选择ecc<span class="tooltip">使用了错误idx来选择ecc</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/98d2aaa" target="_blank">2024-12-12</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024120901/openxiangshan-kmh-fad7803d-24120901.tar.gz" target="_blank">24120901</a></td><td class="reason-column"><div class="ellipsis">使用了错误idx来选择ecc<span class="tooltip">使用了错误idx来选择ecc</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/31" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
<tr><td class="index-column">18</td><td class="id-column">KMH22-1971</td><td class="description-column"><div class="ellipsis">vecExceptionFlag标记位置位条件出错<span class="tooltip">vecExceptionFlag标记位置位条件出错</span></div></td><td class="commit-column"><a href="https://github.com/OpenXiangShan/XiangShan/commit/99baa88" target="_blank">2025-01-13</a></td><td class="rtl-column"><a href="https://github.com/XS-MLVP/UnityChipXiangShanRTLs/releases/download/2024120901/openxiangshan-kmh-fad7803d-24120901.tar.gz" target="_blank">24120901</a></td><td class="reason-column"><div class="ellipsis">vecExceptionFlag标记位置位条件出错<span class="tooltip">vecExceptionFlag标记位置位条件出错</span></div></td><td class="issue-column"><a href="https://github.com/XS-MLVP/UnityChipForXiangShan/issues/32" target="_blank">链接</a></td><td class="issue-column">-</td></tr>
</tbody>
</table>

