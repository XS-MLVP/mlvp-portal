---
title: 'Picker：A Multilingual Verification Tool'
date: 2024-05-16T07:50:23+08:00
weight: 1
cover_image: "picker.jpg"
resource_tags: ["Tools"]
# status: "evergreen"
summary: "A Multilingual Verification Tool"
---


Picker Project Link: [https://github.com/XS-MLVP/picker](https://github.com/XS-MLVP/picker)

Picker is a chip verification assistant tool designed to encapsulate RTL design verification modules (.v/.scala/.sv) and automatically provide Pin Level interfaces that can be operated by other high-level languages, enabling chip verification using high-level languages.

Picker supports interfaces for various programming languages, including C++ (natively supported), Python (supported), Java (work in progress), Golang (work in progress), Scala (work in progress), and others.

This assistant tool allows users to perform chip UT verification based on existing software testing frameworks such as pytest, JUnit, TestNG, and Go test.

Benefits of using Picker for verification include:

1. No dependence on RTL code. After the design is converted and encapsulated by Picker, the original design files (.v) are converted into binary files (.so), allowing modifications to test programs and execution without the original design files.
2. Reduced compilation time. When the Design Under Test (DUT) is stable, compilation (packaging into .so) only needs to be done once.
3. Wide user interface. Provides multiple programming interfaces to cover developers from different languages (traditional IC verification is strongly related to System Verilog).
4. Rich software ecosystem usability. Leveraging the rich features of high-level languages such as Python, Java, and Golang, simplifying functionality implementation.
5. Flexible backend. Communicates with backend simulators via DPI, allowing the same set of verification code to run on simulators such as VCS, Verilator, etc.