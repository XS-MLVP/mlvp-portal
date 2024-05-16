---
title: 'ChiselVerify'
weight: 98
resource_tags: ["工具"]
# status: "evergreen"
summary: "ChiselVerify： 用于Chisel的硬件验证库"
---

[项目地址](https://github.com/chiselverify/chiselverify) | [论文1链接](https://ieeexplore.ieee.org/abstract/document/9599869) | [论文2链接](https://www.sciencedirect.com/science/article/pii/S0141933122002666)

## **总结：**

ChiselVerify是一个用于Chisel的硬件验证库。该库受通用验证方法（UVM）启发，但通过利用Scala的简洁性和对面向对象和函数式编程的支持来实现。ChiselVerify支持基于覆盖率导向和约束随机验证（CRV）流程，具有比UVM中可用功能更多的特性。该工作更类似使用scala优化的UVM。

## **介绍（翻译自论文1 Intro）：**

在过去几年中，硬件设计变得越来越复杂。对高性能计算系统的增加需求导致了对特定领域硬件加速器的更大需求。这些加速器的设计通常很复杂，它们的开发耗时且容易出错。为了应对这种增加的时间约束，我们可以借鉴软件开发趋势，如敏捷软件开发，并适应敏捷硬件开发。为了将数字电路描述移至更类似于软件的高级语言，引入了Chisel，这是一种Scala嵌入式硬件构建语言。

硬件设计主要由传统的硬件描述语言（HDLs）Verilog和VHDL以及较新的SystemVerilog主导。但是，虽然SystemVerilog确实通过为验证添加面向对象的特性来扩展了Verilog，但其硬件描述流程仍与Verilog相同。因此，它不适用于敏捷开发流程。Chisel试图通过提供对函数式和面向对象编程的全面支持来解决这些问题。然而，Chisel缺少高效的验证工具，相应的ChiselTest软件包中的功能也受到限制。

因此，我们选择以Chisel和ChiselTest为基础，并旨在提升数字设计的工具水平。我们开发了一个受通用验证方法（UVM）启发的验证框架，但通过利用Scala的简洁性和对面向对象和函数式编程的支持来实现。我们的框架ChiselVerify支持基于覆盖率导向和约束随机验证（CRV）流程，具有比UVM中可用功能更多的特性。

作为展示，我们验证了一个工业用例，一个小顶堆，利用ChiselVerify尽可能少的验证代码行数来检查小顶堆的许多特性。

本文的主要贡献是ChiselVerify，一个用于硬件设计的开源验证库。

