---
title: 'Fault'
weight: 99
resource_tags: ["工具"]
# status: "evergreen"
summary: "fault: A Python Embedded Domain-Specific Language for Metaprogramming Portable Hardware Verification Components"
---

[Project Link](https://github.com/leonardt/fault) | [Paper](https://dl.acm.org/doi/10.1007/978-3-030-53288-8_19) 

## Summary:

Fault is a domain-specific language (DSL) based on Python. The language is similar to Chisel, a hardware design language, but with a greater focus on optimizing verification. As hardware designs based on generators become increasingly complex, the number and complexity of functionalities that need to be verified also increase, requiring verification components to be as flexible as their design counterparts. Fault aims to develop a more flexible verification language to generate portable verification components.

## Introduction (Taken from the paper):

The new golden age of computer architecture relies on advances in the design and implementation of computer-aided design (CAD) tools that enhance productivity [11,21]. While hardware generators have become much more powerful in recent years, the capabilities of verification tools have not improved at the same pace [12]. This paper introduces fault, a domain-specific language (DSL) that aims to enable the construction of flexible and portable verification components, thus helping to realize the full potential of hardware generators.

Using flexible hardware generators [1,16] drastically improves the productivity of the hardware design process, but simultaneously increases verification cost. A generator is a program that consumes a set of parameters and produces a hardware module. The scope of the verification task grows with the capabilities of the generator, since more sophisticated generators can produce hardware with varying interfaces and behavior. To reduce the cost of attaining functional coverage of a generator, verification components must be as flexible as their design counterparts. To achieve flexibility, hardware verification languages must provide the metaprogramming facilities found in hardware construction languages [1].

However, flexibility alone is not enough to match the power of generators; verification tools must also enable the construction of portable components. Generators facilitate the development of hardware libraries and promote the integration of components from external sources. Underlying the utility of these libraries is the ability for components to be reused in a diverse set of environments. The dominance of commercial hardware verification tools with strict licensing requirements presents a challenge in the development of portable verification components. To encourage the proliferation of verification libraries, hardware verification languages must design for portability across verification tools. Design for portability will also promote innovation in tools by simplifying the adoption of new technologies, as well as enable new verification methodologies based on unified interfaces to multiple technologies.

This paper presents fault, a domain-specific language (DSL) embedded in Python designed to enable the flexible construction of portable verification components. As an embedded DSL, fault users can employ all of Python’s rich metaprogramming capabilities in the description of verification components. Integration with magma [15], a hardware construction language embedded in Python, is an essential feature of fault that enables full introspection of the hardware circuit under test. By using a staged metaprogramming architecture, fault verification components are portable across a wide variety of open-source and commercial verification tools. A key benefit of this architecture is the ability to provide a unified interface to constrained random and formal verification, enabling engineers to reuse the same component in simulation and model checking environments. fault is actively used by academic and industrial teams to verify digital, mixed-signal, and analog designs for use in research and production chips. This paper demonstrates fault’s capabilities by evaluating the runtime performance of different tools on a variety of applications ranging in complexity from unit tests of a single module to integration tests of a complex design. These experiments leverage fault’s portability by reusing the same source input across separate trials for each target tool.
