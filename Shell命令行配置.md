---
title: "Shell命令行配置"
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

## 一、替换默认 shell

首先将 shell 字体设置为 `16` 号，窗口大小设置为 `110 * 35`，然后将 mac 默认 shell 替换为 `bash`，输入如下命令
```
chsh -s /bin/bash
```

## 二、命令补全

> 在主目录（~）下，新建名为 `.inputrc` 的隐藏文件，末尾输入如下内容
```
# 支持模糊搜索和不区分大小写
set show-all-if-ambiguous on
set completion-ignore-case on
TAB: menu-complete
```

## 三、修改命令行提示符

> 在主目录（~）下，新建名为 `.bash_profile` 的隐藏文件，末尾输入如下内容
```shell
# 命令行提示符
function git_branch {
    branch="`git branch 2>/dev/null | grep "^\*" | sed -e "s/^\*\ //"`"
    if [ "${branch}" != "" ];then
        if [ "${branch}" = "(no branch)" ];then
            branch="(`git rev-parse --short HEAD`...)"
        fi
        echo " ($branch)"
    fi
}
function DesktopDirname {
    branch="`git branch 2>/dev/null | grep "^\*" | sed -e "s/^\*\ //"`"
    if [ "${branch}" != "" ];then
        path=`pwd`
        array=(${path//// })
        name=${array[3]}
        echo " $name"
    fi
}
function currentTime {
    time=$(date "+%H:%M:%S")
    echo " $time"
}
export PS1='\[\033[01;34m\]-> \[\033[01;36m\]\W\[\033[01;36m\]$(DesktopDirname)\[\033[01;32m\]$(git_branch)\[\033[01;36m\]$(currentTime)\n\[\033[01;34m\] \$\[\033[00m\] '
```

## 四、修改 shell 环境变量

```shell
export PATH="/Users/zhushanbo/myshells:$PATH"
#alias mqrencode='/Users/zhushanbo/myshells/mqrencode.sh'
```

## 五、配置 vim

> 在主目录（~）下配置 vim，输入如下命令
```
# vim.tar.gz 是打包的 vim 的配置文件
tar zxvf vim.tar.gz
```
