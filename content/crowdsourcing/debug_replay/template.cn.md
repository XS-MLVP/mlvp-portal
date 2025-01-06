---
title: '第一期昆明湖回归测试任务'
date: 2024-01-11T08:47:18+08:00
draft: false
fenbao_tags: ["bug复现","回归测试"]
#website: "/xs-bpu/"
task_closed: false
summary: "根据已发布的bug任务，设计回归测试用例复现bug"
---

{{% pageinfo %}}
UT（单元测试）、IT（集成测试）和 ST（系统测试）是处理器验证的三个关键阶段，它们分别针对验证中的不同层次。其中UT是对处理器设计中的最小功能单元(模块)进行测试，确保其功能符合设计要求。然而在生产实际中，一些模块的bug并非在UT阶段被发现，而是在后续的验证阶段发现并报告的。因此，我们需要在UT中构造测试用例将这些bug复现出来，同时也需要在该bug被修复后的版本重新运行测试用例，确保正确修复了该bug。这个过程也叫做回归测试
{{% /pageinfo %}}

## 任务简介

本期任务将会提供50(待定)个待回归的bug，各位需要使用我们的提供的工具链(<a href="https://github.com/XS-MLVP/picker" target="_blank">picker</a>,<a href="https://github.com/XS-MLVP/toffee" target="_blank">toffee</a>(可选))，构建测试用例对bug进行回归。对于大多数的bug，我们会提供详细的bug描述，包括bug所在的模块，发生原因，验证环境等，对于部分bug，可能需要您根据描述定位到产生该bug模块或者搭建验证环境。每完成1个bug的回归并向我们的<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">仓库</a>提交PR，我们将提供100元的奖金作为奖励。希望大家能够积极参与并完成任务！

## 测试内容

对每个bug，我们希望您完成如下的工作：

#### 1、环境构建

首先，您需要根据<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">UnityChipForXiangShan</a>所提供的测试环境，构建测试用例对bug进行回归。

如果bug描述中没有所在模块，需要您自行定位产生模块；如果目标模块下不存在相应的环境，需要您根据规范搭建对应环境，请参考<a href="https://open-verify.cc/UnityChipForXiangShan/docs/01_verfiy_env/" target="_blank">文档</a>中的准备验证环境，添加测试部分。

#### 2、用例构造

接下来，根据触发bug的原因，构建相应的测试用例。

对于所构建的测试用用例，需要满足以下两方面的内容：

1、在bug修复以前的rtl版本：可以运行该测试用例，且使用该测试用例进行测试将不通过测试（选择bug修复的前一个版本进行测试即可）。

2、在bug修复及以后的rtl版本：可以运行该测试用例，且该测试用例可以通过。

#### 3、提交说明

最后需要您撰写说明，描述该bug所属于哪个模块，简述相关的测试环境和用例，以及如何运行测试。

完成上述工作后，请向我们的仓库提交PR。

## 任务奖励

每完成1个bug的回归并向我们的<a href="https://github.com/XS-MLVP/UnityChipForXiangShan" target="_blank">仓库</a>提交PR，我们将提供100元的奖金作为奖励。

## 待复现bug

对每个bug，我们将提供bug的描述、bug发生的原因，该bug被修复的commit的id以及对应的RTL版本，方便复现者对应到具体的commit。

以下是本期的bug描述（等待更新）：

| id | bug描述 | 修复bug的commit id | RTL版本 | 原因 ｜
| --- | ------ | -------------- | ------ | ------ |
| TBD | TBD | TBD | TBD | TBD ｜