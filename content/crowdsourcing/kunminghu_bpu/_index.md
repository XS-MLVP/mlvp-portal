---
title: '昆明湖架构（香山）UT验证——BPU'
date: 2024-01-30T15:00:44+08:00
draft: false
summary: "香山昆明湖架构是基于chisel开发的开源高性能第三代香山riscv处理器IP核"
status: "evergreen"
---

# 分支预测基础知识
    TBD

> 可阅读《超标量处理器设计》姚永斌著 第四章分支预测
> 详细介绍了分支预测的相关知识

需要了解的知识点：
1) 分支预测的基本原理
2) 分支指令的方向预测
3) 全局分支历史/局部分支历史
4) 分支指令的目标预测
5) 流水线的基本概念


# 香山分支预测器（BPU）基础设计

## 分支预测块思想

对于RISC-V架构来说，分支指令包含以下几种类型：
1) 条件分支指令 (beq, bne, blt, bge, bltu, bgeu)，对于这类指令，需要预测该指令是否跳转，并记录下他们的跳转地址。
2) 无条件跳转指令 (jal, jalr)，对于这类指令，需要预测该指令的跳转地址。

所幸的是，由于RISC-V架构设计的简介，我们不需要处理条件跳转指令，每一个需要我们预测的跳转指令都是无条件跳转的，这也给我们的设计提供了便利。

拿到一个PC之后，分支预测器可以选择在取指之后，得知这条指令是否是分支指令，如果是该指令是分支指令，那么预测器可以给出分支预测结果，并且对于非间接跳转指令来说可以直接从指令中获取跳转目标，如果不是分支指令则跳过。但是每次都在获取指令之后才能得知是否需要预测，需要的等待时间太长，因此分支预测器还需要提前预测这条指令是否是分支指令，如果是分支指令，还需要给出这条指令的预测结果。

因此对于一般的分支预测器来说，给出一个指定的PC，他们通常会预测出该PC所对应的那一条指令的相关信息，比如这条指令是不是条件分支指令、是不是跳转指令，如果是条件分支指令还会预测出该指令是否跳转，相应的，如果是跳转指令，会预测出该指令的跳转目标。但这样的预测的效率较低，我们需要一条一条的往后预测，导致流水线延迟增大，对于香山这样的高性能处理器来说，我们需要更加高效的预测方法。

相比于每一预测一条指令，香山采用的预测方法是，每一次预测一个指令块，即任意给定一个PC，香山会预测出以这个PC开始的一个分支预测块，这个分支预测块会预测接下来的若干条指令的情况，包括是不是存在分支指令，分支指令的位置在哪里、是否跳转、跳转目标是什么。这样我们就可以一次预测出多条指令，并送往取值单元（IFU），指导IFU进行取值。并且对于IFU来说，它需要考虑缓存行的性能问题，它的一次取值可以根据缓存行的长度取出多条指令，以预测块的形式给出预测结果，也满足了IFU的吞吐效率。下文中会详细描述香山中的预测块结构。

## 多预测器结构

TBD

> 分支预测单元采用一种多级混合预测的架构，其主要组成部分包括 下一行预测器（Next Line Predictor，以下简称 NLP）和 精确预测器（Accurate Predictor，以下简称 APD）。其中，NLP 是一个 uBTB (micro BTB)，APD 由 FTB1、TAGE-SC、ITTAGE、RAS 组成。NLP 提供无空泡的预测，在预测请求的下一拍就可以得到预测结果。APD 各组成部分的延迟在 2~3 拍之间。其中，FTB、TAGE、RAS 的延迟为 2 拍；SC、ITTAGE 的延迟为 3 拍。一次预测会经历三个流水级，每一个流水级都会产生新的预测内容。这些分布于不同流水级的预测器组成了一个覆盖预测器 (overriding predictor)。




## 取值目标队列（FTQ）

![FTQ](https://xiangshan-doc.readthedocs.io/zh-cn/latest/figs/frontend/ftq.svg)

尽管BPU做到了以指令块的形式提供预测结果，IFU也可以一次性取值多条指令。但是他们之间还是会存在性能上的差距，BPU产生预测结果的速度通常是会更快的。因此在BPU与IFU之间被添加了一个取值目标队列（FTQ）作为缓冲，BPU产生的预测结果会暂存到FTQ中去，当IFU空闲时，会从FTQ中获取下一个指令块。但在香山中，FTQ的职能还远不止这些，如上图所示，它还负责向ICache发送预取信息，存储BPU的各类训练信息，负责分析取值模块、后端执行模块中发来的重定向信息、更新信息，还会向BPU发送更新请求，甚至FTB预测器中的基本数据结构——FTB项都是由FTQ来更新的。

因此对于FTQ来说，它承担了BPU几乎所有的对外交互，因此想要理解BPU所发出的信息是怎样被下一级采用的，它是怎样获取更新、重定向请求的，还需要从FTQ开始看起。

FTQ在整体上可以看做一个队列，队列中的每一项存储了多种信息，包括但不限于 当前预测块取值目标信息，BPU在产生这一个预测块时的重定向恢复信息、FTB项、预测器元数据，IFU发回的预译码信息。

### BPU预测结果接口

![Alt text](https://xiangshan-doc.readthedocs.io/zh-cn/latest/figs/frontend/bpu.svg)

如上图所示，香山中的BPU被划分为了三个流水级 s1, s2 及 s3，每个预测器所处的流水级也是有一定差异的。为了效率，香山BPU在第一个流水级便能够产生出简单的预测结果，但这一预测结果仅是从 uFTB 所读出来的数据产生的，后续更高级的预测器还来不及生成精确预测结果。因此在后面的流水级，高级预测器如果发现前一个流水级中预测有错误，便会发出BPU重定向请求（非发往BPU的重定向请求），更新之前预测结果中的错误，FTQ中也会捕获这一请求，并更新之前存储的数据。

具体的细节我们需要从接口中得知。BPU对外预测结果的接口是一个 BranchPredirectionResp 接口，这同时存在于每一个子预测器模块中，那么他的结构是怎样的呢，其中的关键信息如下：

- **s1** s1流水级的分支预测结果
  - **pc** 预测起始 pc
  - **valid** 预测结果是否有效
  - **hasRedirect** 是否需要重定向
  - **ftq_idx** FTQ指针，指向本次预测的FTQ表项
  - **full_pred** 完整的分支预测结果
- **s2** s2流水级的分支预测结果
  - 同上
- **s3** s3流水级的分支预测结果
  - 同上
- **last_stage_\*** 最后一个流水级的输出的、在本次预测中需要发送给 FTQ 保存的信息。

可以看到，对于每个流水级都有一份相同的接口，每个接口中都有着完整的预测结构，还有一些信息来指导FTQ的更新。这种更新是如何完成的呢？首先，FTQ在发往BPU的一个接口(enq_ptr)中指定了一个队列指针(bpuPtr)，指向队列首部的没有使用的表项，因此BPU便知道本轮预测需要写入到FTQ的那个队列项中。当s1预测结果中的valid被置为有效时，FTQ就会根据s1阶段接口中的 FTQ 指针以及完整预测结果，初始化这一队列项中的各种信息。

当预测进行到后续阶段，例如s2阶段，如果发现之前的预测结果是错误的，那么 s2 阶段会同时将 valid 和 hasRedirect 置位有效，FTQ会根据s2的预测结果和FTQ指针来更新相应FTQ项。当s1, s2, s3阶段信息存在多个有效时，FTQ会以s3, s2, s1的优先级从中选取一个，来更新FTQ项。

最后 last_stage_* 相关的信息，会在s3阶段valid置高时被FTQ存储。

### BPU重定向接口

无论再精确的分支预测器也不总是正确的，这种不正确会导致后续流水线中填充错误的指令，因此需要有一种机制来纠正这种错误，这种机制就是重定向。指令在被后端执行模块执行时，这条指令真正的行为才会被确定，因此在这个时候，后端执行模块如果发现分支预测错误，就会发出重定向请求，让处理器的状态恢复到执行错误指令之前的状态，对于我们来说，只需要关注BPU和FTQ在重定向时是怎样恢复状态的即可。但是如果每次都需要等到后端执行才可以检测出错误，会造成大量的性能损失，因此香山处理器中会在IFU取到指令之后对指令进行简单分析，检测出最基本的预测错误。具体的过程是这样的，FTQ向IFU发送取指请求之后，会等待IFU返回预译码信息（预译码是IFU对指令的简单解码，例如是否是跳转指令、跳转的目标是什么），FTQ会将预译码信息写回到对应FTQ项中的某个字段，同时会分析预译码信息，如果发现预测错误，便会生成一个IFU重定向请求。

来自后端执行模块的重定向请求不需要不需要FTQ生成，是直接由后端发往FTQ进行处理。FTQ会将生成的IFU重定向请求与后端重定向请求转发到BPU的重定向接口中去，如果二者在同一周期有效，那么FTQ会选择转发后端重定向请求。

一个重定向请求的结构是这样的（只列出关键信息）

- **valid**: 重定向信息是否有效
- **ftqIdx**: 重定向对应的FTQ项索引
- **ftqOffset**: 错误预测的跳转指令在本预测块的索引
- **level**: 重定向级别
- **cfiUpdate** 控制流信息
  - **pc**: 错误预测的跳转指令的pc
  - **pd**: 错误预测的跳转指令的预译码信息
    - **valid** 是否有效
    - **isRVC** 是否是压缩指令
    - **brType** 分支类型
    - **isCall** 是否是call指令
    - **isRet** 是否是ret指令
  - **predTaken**: 预测信息读出的 块内是否存在生效的控制流指令
  - **target**: 正确的的跳转目标
  - **taken**: 块内是否存在生效的控制流指令
  - **isMisPred**: 是否存在错误预测的跳转指令

重定向发生时，FTQ会根据重定向信息更新内部相关状态，同时会将FTQ指针恢复到重定向信息中所制定的FTQ项上，重定向请求也会转发到BPU以便BPU恢复状态。

> 这里重定向需要的恢复信息好像在提交接口中给出？具体怎么工作的还不清楚
> 接口中的信息是根据IFU重定向分析得来的，还有很多没有用到的接口。也不清楚后端重定向用到了什么接口，是否相同，需要进一步确认


由于BPU的提交需要首先理解BPU预测块结构，BPU的提交过程会在后文中详细介绍。

## 分支预测块结构

理解了BPU是怎样给出预测结果的，但目前为止还不清楚，一个完整的预测结果是怎样的，又是怎样被BPU存储的，究竟一个分支预测块中包含了哪些信息，才能指导后续模块进行连续的取值的呢？这一部分将详细讲述香山中的分支预测块结构。

### FTB项

FTB项是香山中分支预测块的核心数据结构，它存储了产生一个分支预测块所需要的信息，BPU在进行预测时，初始的分支预测块首先由一个读出的FTB项生成，然后这一分支预测块会传递到后续的预测器中，由后续的预测器读取其中的信息，并且生成相应的预测结果。

因此理解想要理解分支预测块的结构，首先需要理解FTB项的结构。一个FTB项便对应了一个分支预测块，它的结构如下：

- **valid** FTB表项是否有效
- **brSlots** 可记录一条分支指令的信息
  - **offset** 该Slot中指令相对于预测块起始地址的偏移
  - **lower** 跳转目标地址的低位
  - **tarStat** 跳转后的pc高位是否进退位
  - **sharing** 分支指令分享了该 slot
  - **valid** brSlots有效位
- **tailSlot** 可记录块内第二条分支指令 或 一条无条件跳转/间接跳转指令
  - 同上
- **pftAddr** 具体用途还不清楚(文档：当前预测块如果不跳转，下一条指令的PC)
- **carry** (文档：ftb_entry 中当前预测块不跳转的下一个 pc 预测地址进位)
- **isCall** 预测块内包含call指令
- **isRet** 预测块内包含ret指令
- **isJalr** 预测块内包含jalr指令
- **last_may_be_rvi_call** 预测结果预测块末尾可能为一个RVI类型的call指令信号
- **always_taken** 该预测块中的每个分支指令是否总是被预测为 taken

首先需要明确一个信息，无论是分支预测块和FTB项，他们可以容纳的指令数量都被指定为一个特定的上限（一般是4条rvi指令），这样如果我们需要记录分支预测块内的某一条指令的位置，就可以使用一个固定长度的位向量，来指定这条指令相对于预测块起始地址的偏移。

决定一个分支预测块的执行流程最重要的其中的分支指令信息，对于其余的指令，我们都视为普通指令，不影响程序的执行流。因此FTB项中定义了两种类型的分支指令槽(slot)——brSlots和tailSlot 来存储分支预测块中的分支指令。目前香山版本中brSlots只含有一个Slot，tailSlot是一个单独的Slot，总计含有两个Slot。在每个Slot中，我们会记录一条分支指令相对于预测块起始地址的偏移，还会记录下他的跳转目标地址。

我们知道，RISC-V中的分支指令一共有两种类型，条件分支和无条件跳转。因此对于一个分支预测块来说，最多只会拥有一条无条件跳转指令，因为每当执行到这一条指令，程序的执行流就发生改变了，后续的指令都不会被执行了，因此我们定义了一种类型的slot叫做tailSlot，专门用来存储这一条无条件跳转指令，而对于条件分支指令则将他存储在brSlots中。tailSlot正如其名，他是整个预测块中的最后一个slot，因为一旦填充无条件跳转指令，后面无论是条件分支指令，还是无条件跳转指令，我们都不关心了。但是在无条件跳转指令之前的指令，我们需要关心是否存在条件分支指令，因为条件分支指令既有可能跳转，也有可能不跳转，在这里需要记录下条件分支指令的相关信息。

考虑一种情况，如果从预测块起始PC开始直到最大预测长度，都没有出现无条件跳转指令，反而出现了两条条件分支指令，这样一来，tailSlot空闲，而第二条条件分支指令又无法存储，这样就会造成空间的浪费。在这里使用了一种方法，设置一个标记sharing，我们可以直接将第二条分支指令直接存储到tailSlot中，并将sharing标记为真，表示第二条条件分支指令共享了无条件跳转指令的tailSlot。

预测块中isCall, isRet, isJalr这几个字段是为tailSlot服务的，如果tailSlot中记录的是无条件跳转指令，这几个字段会进一步指示该跳转指令的类型。在FTB项中还有一个字段always_taken，用来记录每一个Slot中存储的条件分支指令是否总是被预测为跳转，如果是的话，后续的预测器可以直接采用这一预测结果。

通过FTB项，我们就能够得知一个分支预测块中的指令情况，包括分支指令的位置、类型等，这些信息会交给后续的预测器，由后续的预测器来预测更为精确的跳转目标、是否跳转等信息。

### 分支预测块（完整的分支预测结果）

理解了FTB项，也就理解了绝大部分完整预测结果的结构了。在这里直接给出完成预测结果的接口定义：

- **br_taken_mask** 分支预测结果，每个分支(slot)对应一个 bit，表示该分支是否被预测为 taken
- **slot_valids** slot有效位，表示 ftb 项中的每个 slot 是否有效
- **targets** 每个slot对应的跳转目标地址
- **jalr_target** 本预测块中的 jalr 的跳转目标
- **offsets** 每个slot中的指令相对于预测块起始地址的偏移
- **fallThroughAddr** 具体用途还不清楚（文档：当前预测块不跳转的下一个 pc）
- **fallThroughErr** 具体用途还不清楚(文档：预测出的下一个顺序取指地址是否存在错误)
- **is_jal** 预测块内包含jal指令
- **is_jalr** 预测块内包含jalr指令
- **is_call** 预测块内包含call指令
- **is_ret** 预测块内包含ret指令
- **last_may_be_rvi_call** 预测结果预测块末尾可能为一个RVI类型的call指令信号
- **is_br_sharing** 最后一个slot (tailSlot) 中存储的是条件分支指令信号
- **hit** FTB表项是否命中

可以看出存储的信息基本相同，两个Slot被拆分成了单独的信号：`slot_valids`, `targets`, `offsets`, `is_br_sharing` 等，另外增加了若干字段例如 `br_taken_mask`, `jar_target` 便于后续预测器提供精确预测结果。另外 `hit` 表示FTB项是否命中，这对于FTQ的更新也有重大用途，如果此轮预测没有FTB项命中，下一轮FTQ将会新生成一个FTB项返回给BPU。

### FTB 项的更新

TBD

> FTB项由FTQ块生成和更新

## BPU的提交接口

TBD






# BPU 接口整理

## BPU 模块整体对外接口 (PredirectIO)

接口定义: `src/main/scala/xiangshan/frontend/BPU.scala`

PredirectIO 是分支预测器整体的对外接口，它主要处理了分支预测器（BPU）与取值目标缓冲（FTQ）之间的交互，主要包含以下几个部分：

- **bpu_to_ftq**: BPU 向 FTQ 发送的信息，主要用于 BPU 向 FTQ 发送分支预测结果
  - 接口类型： `BpuToFtqIO`
  - 信号列表：
    - **resp**: BPU 向 FTQ 发送的信息
      - 接口类型：`DecoupledIO(new BpuToFtqBundle())`
        - `BpuToFtqBundle` 继承自 `BranchPredictionResp`，没有额外的信号
      - 信号列表：详见 (`BranchPredictionResp`)
        - **s1** s1流水级的分支预测结果
        - **s2** s2流水级的分支预测结果
        - **s3** s3流水级的分支预测结果
        - **last_stage_meta** 最后一个流水级的输出的预测器元数据
        - **last_stage_spec_info** 最后一个流水级的输出的重定向时需要的信息
        - **last_stage_ftb_entry** 最后一个流水级的输出的FTB表项
- **ftq_to_bpu**: FTQ 向 BPU 发送的信息，主要用于处理重定向及更新请求
  - 接口类型： `FtqToBpuIO`
  - 信号列表：
    - **redirect**: FTQ 向 BPU 发送的重定向请求
      - 接口类型： `Valid(new BranchPredictionRedirect)`
      - 接口列表：详见（`BranchPredictionRedirect`）
    - **update**: FTQ 向 BPU 发送的更新请求
      - 接口类型：`Valid(new BranchPredictionUpdate)`
      - 接口列表：详见（`BranchPredictionUpdate`）
    - **enq_ptr**: FTQ发送给BPU的FTQ指针，告诉BPU下一次需要写到哪个FTQ表项
      - 接口类型：`FtqPtr`
      - 接口列表：详见（`FtqPtr`）
- **ctrl**: BPU 控制信号，主要用于控制各预测器的使能
  - 接口类型：`BPUCtrl`
  - 接口列表：
    - **ubtb_enable**: UBTB使能
    - **btb_enable**: BTB使能
    - **bim_enable**: BIM使能
    - **tage_enable**: TAGE使能
    - **sc_enable**: SC使能
    - **ras_enable**: RAS使能
    - **loop_enable**: LOOP使能
- **reset_vector**: 重置向量，reset 时 BPU 的 pc 会被重置为该值
  - 接口类型：`UInt(PAddrBits.W)`

## 全局分支预测信息 (BranchPredictionResp)

接口定义: `src/main/scala/xiangshan/frontend/FrontendBundle.scala`

该接口定义了分支预测器预测的所有结果信息，包含了每一阶段的预测结果，以及最后一个流水级输出的相关信息。

- **s1** s1流水级的分支预测结果
- **s2** s2流水级的分支预测结果
- **s3** s3流水级的分支预测结果
  - 接口类型：`BranchPredictionBundle`
  - 信号列表：详见（`BranchPredictionBundle`）
- **last_stage_meta** 最后一个流水级的输出的预测器元数据。是一个位向量，由每个预测器生成、解析其中的数据
  - 接口类型：`UInt(MaxMetaLength.W)`
  - 信号列表：详见（`BranchPredictionMeta`）
- **last_stage_spec_info** 最后一个流水级的输出的重定向时需要的信息
  - 接口类型：`Ftq_Redirect_SRAMEntry`
  - 接口列表：详见（`Ftq_Redirect_SRAMEntry`）
- **last_stage_ftb_entry** 最后一个流水级的输出的FTB表项
  - 接口类型：`FtqEntry`
  - 接口列表：详见（`FtqEntry`）
- **topdown_info** 性能分析相关信息，RTL中无需考虑

## 单流水级分支预测结果 (BranchPredictionBundle)

接口定义: `src/main/scala/xiangshan/frontend/FrontendBundle.scala`

该接口定义了每个流水级对外输出的分支预测结果信息，

- **pc** 预测起始 pc
  - 接口类型：`Vec(numDup, UInt(VAddrBits.W))` numDup仅为寄存器复制，其中信号完全相同
- **valid** 预测结果是否有效
  - 接口类型：`Vec(numDup, Bool())`
- **hasRedirect** 是否需要重定向
  - 接口说明：只有s2, s3阶段会重定向，重定向发生时本阶段预测结果会覆盖之前流水级的结果
  - 接口类型：`Vec(numDup, Bool())`
- **ftq_idx** FTQ指针，指向该阶段对应预测信息的FTQ表项
  - 接口类型：`new FtqPtr`
  - 接口列表：详见（`FtqPtr`）
- **full_pred** 完整的分支预测结果
  - 接口类型：`Vec(numDup, new FullBranchPrediction)`
  - 接口列表：详见（`FullBranchPrediction`）

## 完整的分支预测结果 (FullBranchPrediction)

接口定义: `src/main/scala/xiangshan/frontend/FrontendBundle.scala`

该接口定义了完整的分支预测结果，每流水级预测结果中都会包含该接口。

- **br_taken_mask** 分支预测结果，每个分支(slot)对应一个 bit，表示该分支是否被预测为 taken
  - 接口类型：`Vec(numBr, Bool())`
- **slot_valids** slot有效位，表示 ftb 项中的每个 slot 是否有效
  - 接口类型：`Vec(totalSlot, Bool())`
- **targets** 每个slot对应的跳转目标地址
  - 接口类型：`Vec(totalSlot, UInt(VAddrBits.W))`
- **jalr_target** 本预测块中的 jalr 的跳转目标
  - 接口类型：`UInt(VAddrBits.W)`
- **offsets** 每个slot中的指令相对于预测块起始地址的偏移
  - 接口类型：`Vec(totalSlot, UInt(log2Ceil(PredictWidth).W))`
- **fallThroughAddr** 具体用途还不清楚（文档：当前预测块不跳转的下一个 pc）
  - 接口类型：`UInt(VAddrBits.W)`
- **fallThroughErr** 具体用途还不清楚(文档：预测出的下一个顺序取指地址是否存在错误)
  - 接口类型：`Bool()`
- **is_jal** 预测块内包含jal指令
  - 接口类型：`Bool()`
- **is_jalr** 预测块内包含jalr指令
  - 接口类型：`Bool()`
- **is_call** 预测块内包含call指令
  - 接口类型：`Bool()`
- **is_ret** 预测块内包含ret指令
  - 接口类型：`Bool()`
- **last_may_be_rvi_call** 预测结果预测块末尾可能为一个RVI类型的call指令信号
  - 接口类型：`Bool()`
- **is_br_sharing** 最后一个slot (tailSlot) 中存储的是条件分支指令信号
  - 接口类型：`Bool()`
- **hit** FTB表项是否命中
  - 接口类型：`Bool()`

## FTB表项 (FtqEntry)

接口定义: `src/main/scala/xiangshan/frontend/FTB.scala`

FTB表项是分支预测器的核心数据结构，FTB项可被用于生成完整预测结果

- **valid** FTB表项是否有效
  - 接口类型：`Bool()`
- **brSlots** 可记录一条分支指令的信息
  - 接口类型：`Vec(numBrSlot, new FtbSlot(BR_OFFSET_LEN))`
    - numBrSlot = 1
  - 接口列表：详见（`FtbSlot`）
- **tailSlot** 可记录块内第二条分支指令 或 一条无条件跳转/间接跳转指令
  - 接口类型：`new FtbSlot(JMP_OFFSET_LEN, Some(BR_OFFSET_LEN))`
    - JMP_OFFSET_LEN = 20
    - BR_OFFSET_LEN = 12
  - 接口列表：详见（`FtbSlot`）
- **pftAddr** 具体用途还不清楚(文档：当前预测块如果不跳转，下一条指令的PC)
  - 接口类型：`UInt(log2Up(PredictWidth).W)`
- **carry** (文档：ftb_entry 中当前预测块不跳转的下一个 pc 预测地址进位)
  - 接口类型：`Bool()`
- **isCall** 预测块内包含call指令
  - 接口类型：`Bool()`
- **isRet** 预测块内包含ret指令
  - 接口类型：`Bool()`
- **isJalr** 预测块内包含jalr指令
  - 接口类型：`Bool()`
- **last_may_be_rvi_call** 预测结果预测块末尾可能为一个RVI类型的call指令信号
  - 接口类型：`Bool()`
- **always_taken** 该预测块中的每个分支指令是否总是被预测为 taken
  - 接口类型：`Vec(numBr, Bool())`

## FTB表项中的分支指令信息 (FtbSlot)

接口定义: `src/main/scala/xiangshan/frontend/FTB.scala`

该接口定义了 FTB 表项中 Slot

- **offset** 该Slot中指令相对于预测块起始地址的偏移
  - 接口类型：`UInt(log2Ceil(PredictWidth).W)`
- **lower** 跳转目标地址的低位
  - 接口说明：这里设置lower为12为或20位，因为分支指令的寻址能力为12位，而跳转指令的寻址能力为20位
  - 接口类型：`UInt(offsetLen.W)`
- **tarStat** 跳转后的pc高位是否进退位
  - 接口说明：为 Slot 存 offset，所以地址计算时 pc 加上 offset 可能产生进/退位，加上不进/退位的共三种情况，编码为 2 bit
  - 接口类型：`UInt(TAR_STAT_SZ.W)`
    - TAR_STAT_SZ = 2
- **sharing** br 分享了 jal 的 slot
  - 接口类型：`Bool()`
- **valid** brSlots有效位
  - 接口类型：`Bool()`

## 分支预测更新（BranchPredictionUpdate）

接口定义: `src/main/scala/xiangshan/frontend/FrontendBundle.scala`

该接口定义了分支预测器的更新请求，主要用于更新分支预测器的状态。

- **pc** 更新请求的pc (预测块起始地址)
  - 接口类型：`UInt(VAddrBits.W)`
- **spec_info** FTQ存储的redirect信息
  - 接口类型：`new SpeculativeInfo`
  - 接口列表：详见（`SpeculativeInfo`）
- **ftb_entry** 更新后的ftb项
  - 接口类型：`new FTBEntry()`
  - 接口列表：详见（`FTBEntry`）
- **cfi_idx** 控制流指令索引
  - 接口类型：`ValidUndirectioned(UInt(log2Ceil(PredictWidth).W))`
- **br_taken_mask** 预测块内每个slot内指令是否跳转
  - 接口类型：`Vec(numBr, Bool())`
- **br_committed** 预测块内每个slot内指令是否提交
  - 接口类型：`Vec(numBr, Bool())`
- **jmp_taken** 是否是跳转指令被触发
  - 接口类型：`Bool()`
- **mispred_mask** 预测块内每个slot内指令是否预测错误
  - 接口类型：`Vec(numBr+1, Bool())`
- **pred_hit** ftb项的是否命中
  - 接口类型：`Bool()`
- **false_hit** ftb项是否错误命中（命中了但是预测错误）
  - 接口类型：`Bool()`
- **new_br_insert_pos** 新生效的br插入位置
  - 接口类型：`Vec(numBr, Bool())`
- **old_entry** 旧的ftb项
  - 接口类型：`Bool()`
- **meta** ftq项对应的bpu meta信息
  - 接口类型：`UInt(MaxMetaLength.W)`
- **full_target** 预测块的跳转目标（下一个预测块的起始地址）
  - 接口类型：`UInt(VAddrBits.W)`
- **from_stage** 信息是从bpu哪个阶段得来的
  - 接口类型：`UInt(2.W)`
- **ghist** 未使用
  - 接口类型：`UInt(HistoryLength.W)`

## 分支预测重定向（BranchPredictionRedirect）

接口定义: `src/main/scala/xiangshan/frontend/FrontendBundle.scala`

该接口定义了分支预测器的重定向请求，主要用于重定向分支预测器的状态。

- **isRVC**
- **robIdx**
- **ftqIdx** 重定向对应的ftq索引
  - 接口类型：`new FtqPtr`
  - 接口列表：详见（`FtqPtr`）
- **ftqOffset** 预测错误的跳转指令索引
  - 接口类型：`UInt(log2Up(PredictWidth).W)`
- **level** 重定向级别
- **interrupt**
- **cfiUpdate** 控制流信息
  - 接口类型：`CfiUpdateInfo`
  - 接口列表（部分）：
    - **pc** 预测错误的跳转指令的pc
      - 接口类型：`UInt(VAddrBits.W)`
    - **pd** 预测错误的跳转指令的预测码信息
      - 接口类型：`UInt(PredictWidth.W)`
    - **predTaken** 预测信息中读出的 预测块是否有跳转
      - 接口类型：`Bool()`
    - **target** 跳转指令的跳转目标
      - 接口类型：`UInt(VAddrBits.W)`
    - **taken** 根据预译码分析得来的：预测块是否有跳转
      - 接口类型：`Bool()`
    - **isMisPred** 是否误预测 (含有预测错误的跳转指令)
      - 接口类型：`Bool()`

## 子分支预测器接口 (BasePredictorIO)

接口定义: `src/main/scala/xiangshan/frontend/BPU.scala`

每个子分支预测器都需要实现该接口，该接口定义了子分支预测器的输入输出接口。

- **reset_vector** 重置向量，reset 时 BPU 的 pc 会被重置为该值
  - 接口类型：`UInt(PAddrBits.W)`
- **in** BPU 向子分支预测器发送的信息
  - 接口类型：`DecoupledIO(new BasePredictorInput)`
  - 信号列表：
    - **s0_pc** s0流水级的pc
      - 接口类型：`Vec(numDup, UInt(VAddrBits.W))`
    - **folded_hist** 全局折叠历史信息
      - 接口类型：`Vec(numDup, new AllFoldedHistories(foldedGHistInfos))`
      - 信号列表：详见（`AllFoldedHistories`）
    - **ghist** 全局分支历史信息
      - 接口类型：`UInt(HistoryLength.W)`
- **out** 子分支预测器向 BPU 发送的信息
  - 接口类型：`new BasePredictorOutput` 继承自 `BranchPredictionResp`
  - 信号列表：详见（`BranchPredictionResp`）
- **ctrl** BPU 控制信号，主要用于控制各预测器的使能
  - 接口类型：`BPUCtrl`
  - 接口列表：
    - **ubtb_enable**: UBTB使能
    - **btb_enable**: BTB使能
    - **bim_enable**: BIM使能
    - **tage_enable**: TAGE使能
    - **sc_enable**: SC使能
    - **ras_enable**: RAS使能
    - **loop_enable**: LOOP使能
- **s0_fire** s0阶段握手成功信号
  - 接口类型：`Vec(numDup, Bool())`
- **s1_fire** s1阶段握手成功信号
  - 接口类型：`Vec(numDup, Bool())`
- **s2_fire** s2阶段握手成功信号
  - 接口类型：`Vec(numDup, Bool())`
- **s3_fire** s3阶段握手成功信号
  - 接口类型：`Vec(numDup, Bool())`
- **s2_redirect** s2阶段重定向信号
  - 接口类型：`Vec(numDup, Bool())`
- **s3_redirect** s3阶段重定向信号
  - 接口类型：`Vec(numDup, Bool())`
- **s1_ready** s1阶段是否准备好接收信息
  - 接口类型：`Bool()`
- **s2_ready** s2阶段是否准备好接收信息
  - 接口类型：`Bool()`
- **s3_ready** s3阶段是否准备好接收信息
  - 接口类型：`Bool()`
- **update** BPU 向子分支预测器发送的更新请求
  - 接口类型：`Valid(new BranchPredictionUpdate)`
  - 信号列表：详见（`BranchPredictionUpdate`）
- **redirect** BPU 向子分支预测器发送的重定向请求
  - 接口类型：`Valid(new BranchPredictionRedirect)`
  - 信号列表：详见（`BranchPredictionRedirect`）
