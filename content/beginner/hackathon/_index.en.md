---
title: "Getting Started Tutorial"
date: 2025-11-20T15:02:27+08:00
summary: "Guide you to use the 'Million Hearts One Chip' open verification platform and participate in hardware verification from scratch"
weight: 2
home_page_show: true
schedule: 2
Website: "/en/beginner/task/course/"
---

**UCAgent is an automated chip verification AI agent launched by "Million Hearts One Chip" based on large language models.**
UCAgent focuses on unit testing and verification of chip design, which can automatically analyze hardware design, generate test cases, execute verification tasks and generate test reports, **bringing unit-level hardware verification into a new era of intelligence.**

UCAgent Repository: [https://github.com/XS-MLVP/UCAgent](https://github.com/XS-MLVP/UCAgent)

UCAgent User Manual: [https://ucagent.open-verify.cc](https://ucagent.open-verify.cc)

## 1. Capabilities and Features of UCAgent

UCAgent provides complete Agent and LLM interaction logic and integrates rich file operation tools, enabling direct interaction with large language models through standardized APIs. In addition, UCAgent can also collaborate deeply with general agents through the MCP protocol. It has the following three characteristics:

- **100% Automatic Verification per Module**: For simple circuits (approximately 1000 lines of Verilog code or less), UCAgent can achieve 100% automated verification without human intervention; for complex circuits, verification can also be completed through human-machine collaboration.

- **Support for Common Code Agents**: Existing programming AI agents (such as OpenHands, Copilot, Claude Code, Gemini-CLI, Qwen-Code, etc.) **can collaborate deeply with UCAgent through the MCP protocol, achieving better verification results and higher automation levels**.

- **Customizable Workflow**: **UCAgent adopts a flexible verification process configuration mechanism**, where the overall workflow can be configured by users, supporting the addition and removal of processes including main stages, sub-stages, and checkers, **allowing users to adjust verification stages according to different application scenarios and verification requirements.**

<center><img src="workflow.svg" alt="alt" width="70%"/></center>

## 2. Installation and Usage of UCAgent

UCAgent has two modes of use: one is direct use of local CLI with large models; the other is the MCP mode where UCAgent provides MCP-server combined with code agent. In comparison, we recommend the latter. This is because code agents currently have stronger capabilities and can better meet our needs and complete tasks.

First, perform [tool installation](https://ucagent.open-verify.cc/content/01_start/01_installation/) and [quick start](https://ucagent.open-verify.cc/content/01_start/02_quickstart/), then choose a usage mode:

- **MCP Integration Mode (Recommended)**: [https://ucagent.open-verify.cc/content/02_usage/00_mcp/](https://ucagent.open-verify.cc/content/02_usage/00_mcp/)

- **Direct Usage Mode**: [https://ucagent.open-verify.cc/content/02_usage/01_direct/#%E7%9B%B8%E5%85%B3%E6%96%87%E6%A1%A3](https://ucagent.open-verify.cc/content/02_usage/01_direct/#%E7%9B%B8%E5%85%B3%E6%96%87%E6%A1%A3)

The "UCAgent Practical Guide" provides detailed demonstrations of UCAgent's installation, configuration, and usage methods:

<center><iframe src="//player.bilibili.com/player.html?isOutside=true&aid=115501887920813&bvid=BV1rB2FBJEHG&cid=33753466384&p=1&poster=1&autoplay=0" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true" style="width:80%; aspect-ratio: 16/9"></iframe></center>

## 3. UCAgent Trial Cases

Currently, we provide 8 examples for you to try and experience. These include 7 fully automated verification examples and 1 human-machine collaboration example, covering Verilog and Chisel modules. We are continuously adding more cases and welcome your feedback through issues and PRs. (Repository: [https://github.com/XS-MLVP/UCAgent](https://github.com/XS-MLVP/UCAgent))

- **Case Address:** https://github.com/XS-MLVP/UCAgent/tree/main/examples

- **Automated Verification Modules:**

1. Adder: 16 lines of Verilog
2. ALU754: 657 lines of Verilog
3. FSM: 45 lines of Verilog
4. HPerfCounter: 285 lines of Verilog
5. IntegerDivider: 434 lines (Scala source code) + 1024 lines (generated Verilog)
6. Mux: 15 lines of Verilog
7. ShiftRegister: 27 lines of Verilog

- **Human-Machine Collaboration Verification Modules:**

1. DualPort: 115 lines of Verilog
