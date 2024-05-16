---
title: 'Picker多语言转换工具'
date: 2024-05-16T07:50:23+08:00
weight: 1
cover_image: "picker.jpg"
resource_tags: ["工具"]
# status: "evergreen"
summary: "Picker多语言转换工具"
---

picker项目地址: [https://github.com/XS-MLVP/picker](https://github.com/XS-MLVP/picker)

picker是一个芯片验证辅助工具，其目标是将RTL设计验证模块(.v/.scala/.sv)进行封装并自动提供其他高级语言可以操作的Pin Level接口，以支持使用高级语言进行芯片验证。

其他编程语言包括 c++ (原生支持), python(已支持), java(WIP), golang(WIP), scala(WIP) 等编程语言接口。

该辅助工具让用户可以基于现有的软件测试框架，例如 pytest、junit、TestNG、go test等，进行芯片UT验证。

基于picker进行验证具有如下优点：

1. 不依赖RTL代码。当设计经过picker转换并封装后，原始的设计文件(.v)被转化成了二进制文件(.so)，无需原始设计文件仍然可以修改测试程序并运行。
2. 减少编译时间。当DUT(Design Under Test)稳定时，只需要编译一次（打包成so）。
3. 用户面广。提供的编程接口多，可覆盖不同语言的开发者（传统IC验证与System Verilog强相关）。
4. 可使用软件生态丰富。能使用python, java, golang等高级语言的软件生态及特性，实现功能更简单。
5. 后端灵活。基于DPI与后端仿真器通信，同一套验证代码可以在VCS，Verilator等仿真器上运行。
