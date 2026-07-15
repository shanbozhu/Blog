---
title: "Charles配置"
date: 2019-05-22T11:28:09+08:00
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

## 一、Charles 使用

1. **Install Charles Root Certificate**

> 新设备安装 Charles 根证书

```
1. Charles 安装根证书至移动设备：
   Help -> SSL Proxying -> Install Charles Root Certificate on a Mobile Device or Remote Browser
2. 设备的 WiFi 设置中，输入 Charles 的 IP 地址和端口号
3. 设备的 Safari 访问以下地址，下载安装 Charles 证书：
   http://chls.pro/ssl
   备用地址：http://www.charlesproxy.com/getssl
4. 从 iOS10 设备开始，需要按照以下操作信任 Charles 证书：
   设置 -> 通用 -> 关于本机 -> 证书信任设置
```
扫码安装证书

![](https://raw.gitcode.com/shanbozhu/Resources/raw/master/image/2025_07_07/2025_07_07_0.png?raw=true)

2. **Access Control Setting**

> 新设备连接 Charles 代理时，无需 Charles 允许

```
1. Charles 设置：Proxy -> Access Control Setting...
2. IP Range 输入以下 IP 地址：
   0.0.0.0/0 和 ::/0
```

3. **SSL Proxying Settings**

> 配置地址，允许使能 SSL 代理

```
1. Charles 设置：Proxy -> SSL Proxying Settings...
2. 勾选 Enable SSL Proxying
3. Include 输入以下内容，允许所有地址使能 SSL 代理：
   *
4. Exclude 输入以下内容，排除指定地址使能 SSL 代理：
   *.apple.com 和 *.mzstatic.com
```

4. **Charles Settings —— Viewers**

![](https://raw.gitcode.com/shanbozhu/Resources/raw/master/image/2025_07_11/2025_07_11_0.png?raw=true)

5. **Charles Rewrite 的各种用法实例详解**

地址：[https://blog.csdn.net/yaoliang_cui/article/details/127809235](https://blog.csdn.net/yaoliang_cui/article/details/127809235)

截图：[https://raw.gitcode.com/shanbozhu/Resources/raw/master/image/2025_07_10/2025_07_10_0.png?raw=true](https://raw.gitcode.com/shanbozhu/Resources/raw/master/image/2025_07_10/2025_07_10_0.png?raw=true)

## 二、常见问题

1. Charles 突然无法抓包  
答：Charles 安装的证书有效期只有一年，到期后需要重置证书。具体步骤如下：

```
1. Charles 重置根证书：
   Help -> SSL Proxying -> Reset Charles Root Certificate... -> Reset
2. Charles 重新安装根证书至电脑：
   Help -> SSL Proxying -> Install Charles Root Certificate
3. 在电脑钥匙串信任 Charles 根证书
4. Charles 重新安装根证书至移动设备
```

Charles 证书在钥匙串中的位置：
![](https://raw.gitcode.com/shanbozhu/Resources/raw/master/image/2025_07_07/2025_07_07_1.png?raw=true)
