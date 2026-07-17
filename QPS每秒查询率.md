---
title: "QPS每秒查询率"
date: 2019-05-21T17:31:25+08:00
draft: false
---

<style>
    pre {
        word-wrap: break-word;
        white-space: pre-wrap !important;
        overflow-wrap: break-word;
    }
    code, tt {
        white-space: pre-wrap !important;
        word-break: break-all;
        overflow-wrap: break-word;
    }
</style>

[TOC]

## 一、原理

- 峰值时间：每天 80% 的访问集中在 20% 的时间里，这 20% 的时间叫做峰值时间
- QPS：每秒查询率，即峰值时间每秒请求数
- 公式：`(总 PV 数 * 80%) / (每天秒数 * 20%) = QPS`
- 机器：`QPS / 单台机器的 QPS = 需要的机器数`

## 二、案例

1. `300w PV` 的请求需要多少 QPS？  
`(3000000 * 0.8) / (86400 * 0.2) = 139(QPS)`
2. 如果一台机器的 QPS 是 58，需要几台机器来支持？  
`139 / 58 = 3 台`

参考文档：[https://www.cnblogs.com/dearflt/p/13097880.html](https://www.cnblogs.com/dearflt/p/13097880.html)
