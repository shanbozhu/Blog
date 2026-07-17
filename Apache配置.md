---
title: "Apache配置"
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

## 一、安装 Apache

> Mac 自带 Apache 服务，无需重新安装

启动 Apache：`sudo apachectl start`  
重启 Apache：`sudo apachectl restart`

## 二、配置 Apache 访问目录为自定义目录

> Web 默认访问的目录是 `/Library/WebServer/Documents/`，需要修改 `DocumentRoot` 属性，设置访问目录为自定义目录

1. 编辑 `/etc/apache2/httpd.conf` 文件
2. 搜索 `<Directory "/Library/WebServer/Documents">`，修改为如下配置：
```
DocumentRoot "/Users/shanbo/Desktop/Web"
<Directory "/Users/shanbo/Desktop/Web">
    Options Indexes MultiViews
    AllowOverride None
    Require all granted
    Allow from all
    IndexOptions Charset=UTF-8 NameWidth=* IconHeight=20 IconWidth=20
    HeaderName /config/header.html
    ReadmeName /config/footer.html
    IndexIgnore header.html footer.html
</Directory>
```
3. 重启 Apache

## 三、常见问题

1. 遇到访问自定义目录出现 Forbidden 提示  
检查自定义目录的访问权限，将 `everyone` 的权限由 `无访问权限` 修改为 `只读`。
