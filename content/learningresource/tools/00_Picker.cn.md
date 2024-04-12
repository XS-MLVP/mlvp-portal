---
title: 'Picker多语言转换工具'
date: 2024-01-11T08:47:18+08:00
draft: false
weight: 10
cover_image: "picker.jpg"
resource_tags: ["工具"]
status: "evergreen"
summary: "Picker多语言转换工具"
---

picker项目地址：<a href="https://github.com/XS-MLVP/picker">https://github.com/XS-MLVP/picker</a>

picker是一个芯片验证辅助工具，其目标是将RTL设计验证模块(.v/.scala/.sv)进行封装，并使用其他编程语言暴露Pin-Level的操作，未来计划支持自动化的Transaction-Level原语生成。

其他编程语言包括 c++ (原生支持), python(已支持), java(todo), golang(todo) 等编程语言接口。

该辅助工具让用户可以基于现有的软件测试框架，例如 pytest、junit、TestNG、go test等，进行芯片UT验证。

基于picker进行验证具有如下优点：

1. 不泄露RTL设计。经过picker转换后，原始的设计文件(.v)被转化成了二进制文件(.so)，脱离原始设计文件后，依旧可进行验证，且验证者无法获取RTL源代码。
1. 减少编译时间。当DUT(Design Under Test)稳定时，只需要编译一次（打包成so）。
1. 用户面广。提供的编程接口多，可覆盖不同语言的开发者（传统IC验证，只用System Verilog）。
1. 可使用软件生态丰富。能使用python3, java, golang等生态。
