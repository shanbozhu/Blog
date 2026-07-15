---
title: "Shell安装必备软件"
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

## 一、安装 Homebrew

Homebrew：简称 `brew`，用于 Mac 软件的安装或卸载。相当于 Linux 的 `apt-get` 软件管理工具。

访问如下地址，使用国内镜像安装 `Homebrew`，序列号选择 `中科大`  
[https://github.com/cunkai/HomebrewCN](https://github.com/cunkai/HomebrewCN)

`Homebrew` 常用命令

```
// 安装包
brew install mysql
// 卸载包
brew uninstall wget
// 显示已安装的包
brew list
// 更新Homebrew自己
brew update
// 更新所有可以升级的软件
brew upgrade
brew upgrade mysql
// 清理不需要的版本及其安装包缓存
brew cleanup
brew cleanup mysql
// 查看brew帮助
brew –help
```

## 二、安装 trash

使用如下命令安装 `trash`，具体参见文档：[https://github.com/ali-rantakari/trash](https://github.com/ali-rantakari/trash)
```
brew install trash
```

```
-> 11 15:06:09
 $ brew install trash
==> Auto-updating Homebrew...
Adjust how often this is run with `$HOMEBREW_AUTO_UPDATE_SECS` or disable with
`$HOMEBREW_NO_AUTO_UPDATE=1`. Hide these hints with `$HOMEBREW_NO_ENV_HINTS=1` (see `man brew`).
==> Fetching downloads for: trash
✔︎ Bottle trash (0.9.2)                                                                       Downloaded   14.2KB/ 14.2KB
==> Pouring trash-0.9.2.arm64_sequoia.bottle.1.tar.gz
==> Caveats
trash is keg-only, which means it was not symlinked into /opt/homebrew,
because macOS provides similar software and installing this software in
parallel can cause all kinds of trouble.

If you need to have trash first in your PATH, run:
  echo 'export PATH="/opt/homebrew/opt/trash/bin:$PATH"' >> /Users/zhushanbo/.bash_profile
==> Summary
🍺  /opt/homebrew/Cellar/trash/0.9.2: 6 files, 84.5KB
==> Running `brew cleanup trash`...
Disable this behaviour by setting `HOMEBREW_NO_INSTALL_CLEANUP=1`.
Hide these hints with `HOMEBREW_NO_ENV_HINTS=1` (see `man brew`).
-> 11 15:07:00
```

在主目录 `~` 下，新建名为 `.bash_profile` 的配置文件，末尾输入如下内容
```
# 别名删除命令进回收站
alias rm='trash -F'
```

PSA：自 macOS 15 Sequoia 版本开始，系统已内置原生垃圾回收命令 `trash`，需要运行如下命令将新安装的 `trash` 命令的路径添加到环境变量中，优先使用新安装的 `trash` 命令。  
`echo 'export PATH="/opt/homebrew/opt/trash/bin:$PATH"' >> /Users/zhushanbo/.bash_profile`

## 三、安装 autojump

使用如下命令安装 `autojump`，具体参见文档：[https://github.com/wting/autojump](https://github.com/wting/autojump)
```
brew install autojump
```

在主目录 `~` 下，新建名为 `.bash_profile` 的配置文件，末尾输入如下内容
```
# 安装 autojump 时的输出提示
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh
```

## 四、安装 cdto

任意目录添加打开终端的入口，需要安装 `cdto`，具体参见文档：[https://github.com/jbtule/cdto](https://github.com/jbtule/cdto)

## 五、安装 qrencode

```
// 安装二维码生成软件
brew install qrencode
// 字符串生成二维码
qrencode -o index.png -s 10 -m 1 "zhushanbo"
```

```
// 安装二维码解析软件
brew install zbar
// 二维码生成字符串
// zbarimg index.png > zhushanbo.txt
zbarimg index.png
```
