---
title: 'Verilator'
date: 2024-01-11T08:47:18+08:00
draft: false
weight: 8
resource_tags: ["工具"]
status: "evergreen"
summary: "Verilator 是一个开源RTL仿真工具"
---

Verilator 官网：<a href="https://www.veripool.org/verilator/" target="_blank">www.veripool.org/verilator/</a>

Verilator 是一个用于硬件描述语言（HDL）Verilog 的开源仿真和综合工具。它能够将 Verilog 代码转换成高性能的C++或SystemC代码，从而实现对硬件设计的仿真和验证。Verilator 通过在C++环境中执行Verilog代码来加速仿真过程，因此相比传统的基于解释器的仿真器，Verilator通常能够获得更快的仿真速度。

Verilator 项目的主要特点包括：

1. 高速仿真：Verilator 能够将 Verilog 代码转换成高性能的C++代码，利用现代计算机的计算能力进行仿真，从而提供更快的仿真速度。
1. 开源免费：Verilator 是一个开源项目，基于GNU通用公共许可证（GPL）发布，因此可以免费使用和修改。
1. 支持多种Verilog特性：Verilator 支持Verilog-1995、Verilog-2001 和 Verilog-2005 的大部分特性，也支持一些SystemVerilog的特性。
1. 跨平台：Verilator 可以在多个操作系统上运行，包括Linux、macOS和Windows。
1. 灵活性：Verilator 提供了许多选项和参数，可以根据用户的需求进行定制，包括优化级别、输出格式等。
1. 与其他工具集成：Verilator 可以与其他EDA工具（如仿真工具、综合工具等）配合使用，实现完整的硬件设计流程。

除去Verilator外，开源的RTL仿真器还有: Icarus、moore、Slang等。开源仿真器对system Verilog的支持程度可以参考：<a href="https://chipsalliance.github.io/sv-tests-results/" target="_blank">https://chipsalliance.github.io/sv-tests-results/</a>

