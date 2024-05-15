---
title: 'ChiselVerify'
date: 2024-05-14T08:47:18+08:00
draft: false
weight: 7
resource_tags: ["Tools"]
# status: "evergreen"
summary: "ChiselVerify: A Hardware Verification Library for Chisel"
---

[Project link](https://github.com/chiselverify/chiselverify) | [Paper 1](https://ieeexplore.ieee.org/abstract/document/9599869) | [Paper 2](https://www.sciencedirect.com/science/article/pii/S0141933122002666)

## **Summary:**

ChiselVerify is a hardware verification library for Chisel. Inspired by the Universal Verification Methodology (UVM), this library is implemented by leveraging Scala's conciseness and support for both object-oriented and functional programming. ChiselVerify supports coverage-oriented and constrained random verification (CRV) flows, with more features than those available in UVM. This work is akin to an UVM optimized using Scala.

## **Introduction (from [Paper 1](https://ieeexplore.ieee.org/abstract/document/9599869)):**

Over the past several years, hardware design has grown to be ever more complex. The increased demand for highperformance computing systems has lead to a larger need for domain-specific hardware accelerators. The design of these accelerators is often complex, and their development is time-consuming and error-prone. In order to combat this added time-constraint, we can learn from software development trends such as agile software development, and adapt to agile hardware development. Chisel, a Scala-embedded hardware construction language, was introduced in order to move digital circuit description to a more software-like high-level language.

Hardware design is dominated by the traditional hardware description languages (HDLs), Verilog and VHDL, and the more recent System Verilog. But while System Verilog does extend Verilog with object-oriented features for verification, its hardware description flow remains the same as with Verilog. Thus, it does not fit an agile development flow. Chisel attempts to solve these issues by providing full support for functional and object-oriented programming. However, Chisel is missing efficient verification tools with limited functionality available in the corresponding ChiselTest package.

As such, we choose to base our work on Chisel and ChiselTest, and aim to raise the tooling level for a digital design. We have developed a verification framework inspired by the Universal Verification Method (UVM), but implemented by leveraging Scala's conciseness and support for both object-oriented and functional programming. Our framework, Chi-selVerify, supports both coverage-oriented and constrained random verification (CRV) flows with more features than those available in UVM.

As a showcase, we have verified an industrial use case, a min-heap, utilizing ChiselVerify to check as many features of the min-heap with as few lines of verification code as possible.

The main contribution of this paper is ChiselVerify 1, an open-source verification library for hardware designs.

The paper is organized into 6 sections. Section II describes related work. Section III describes background on hardware verification. Section IV describes our solution for enabling verification in Chisel, namely ChiselVerify. Section V explores ChiselVerify on an industry-provided use case. Section VI concludes.
