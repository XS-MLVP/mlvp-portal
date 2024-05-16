---
title: 'MLVP验证框架'
date: 2024-05-16T07:50:23+08:00
weight: 2
resource_tags: ["工具"]
summary: "MLVP验证框架"
---

项目地址：[https://github.com/XS-MLVP/mlvp](https://github.com/XS-MLVP/mlvp)

MLVP (Multi-Language Verification Platform) 是为多语言硬件验证提供的一套基础验证框架，目前支持 python 语言。其在多语言验证工具 picker 所生成的 Python DUT 上提供了更为高级的验证特性，功能包括：

1. 协程支持（async异步运行）
    - 运行协程测试
    - 创建协程任务
    - 创建并使用时钟
2. 覆盖率统计与测试报告生成（基于pytest等）
    - 生成覆盖率报告
        * 代码行覆盖率
        * 功能覆盖率
    - 生成测试报告
        * 测试用例执行结果
    - 多进程支持
3. 日志输出
    MLVP 库内置了一个 logger，并设置好了默认的输出格式，MLVP 中的输出信息都将会通过 logger 进行输出。其中 logger 中还添加了一个 Handler 以便统计各类型日志信息的数量，日志可以设置一个 id 以进行分类。
4. 接口封装链接  
    MLVP 中提供了一个接口类，用于为软件模块的编写提供虚拟接口。用户可以在不获取到 DUT 的情况下，通过定义一个虚拟接口，编写软件模块进行驱动。获取 DUT 后，只需要将 DUT 与虚拟接口进行连接，软件模块即可直接驱动 DUT。这方便了我们定义一组用于完成某个特定功能的接口集合，同时也使得软件模块的编写与 DUT 的具体实现解耦。