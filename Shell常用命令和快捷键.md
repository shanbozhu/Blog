---
title: "Shell常用命令和快捷键"
date: 2019-12-13T16:20:07+08:00
draft: false
---

[TOC]

## 一、shell常用命令

### 1、read

从标准输入文件读取一行数据  
`read -r input`  
`read input`  
从标准输入文件读取一行数据到 `input` 变量。  
`-r`：不会将输入内容中的 `\` 视为转义字符，不加 `-r`，则会视为转义字符。

### 2、<

将 file 文件重定向到标准输入文件  
`cat < file`  
将 file 文件重定向到标准输入文件，然后 `cat` 读取标准输入文件

### 3、touch

新建文件

### 4、mkdir -p

新建目录

### 5、cp -a

复制

### 6、rm -r

删除

### 7、mv

移动、重命名

### 8、ls -al

文件列表

### 9、find

查找文件名  
`find . -name "abc"`

### 10、grep -rin

文件内查找  
`grep -rin abc .`

### 11、grep -rl

文件内查找满足条件的文件名  
`grep -rl abc .`  
`-r`：递归搜索，会进入子目录。  
`-l`：仅输出匹配的文件名，而不是内容。

### 12、sed -i ""

流编辑器
1. 查找当前目录及其子目录中包含字符串 abc 的所有文件。
2. 在这些文件中，将 abc 替换为 def，不包含有空格的文件名。

`` sed -i "" "s/abc/def/g" `grep -rl abc .` ``  
`-i`：表示直接在文件中进行修改。  
`""`：在 macOS 上，"" 是为了兼容 sed，表示不创建备份文件。如果不加，会报错。在 Linux 上可以直接使用 -i 而不需要 ""。  
`s`：sed 的替换命令。  
`/abc/def`：将 abc 替换为 def。  
`/g`：全局替换，替换每一行中的所有 abc，而不仅仅是第一处匹配。

### 13、sed -i.bak

`` sed -i.bak "s/abc/def/g" `grep -rl abc .` ``  
`-i.bak`：如果想保留修改前的文件，可以用 -i.bak 创建备份。

### 14、scp -r

超级拷贝  
`scp -r bobo@172.18.22.111:~/Desktop/abc ./`  
`scp -r ./ bobo@172.18.22.111:~/Desktop/abc`

### 15、ssh

登录远程服务器  
`ssh zhushanbo@relay01.damai.cn`

### 16、sudo su

切换超级用户

### 17、pwd

打印目录

### 18、realpath

打印路径

### 19、cat

查看文件内容

### 20、more

分页查看文件内容

### 21、head

查看文件前 10 行

### 22、tail

查看文件后 10 行

### 23、ln -s

创建软连接  
`ln -s 源文件 目标文件`

### 24、man

查看对应命令的 manpage  
`man ls`

### 25、which

显示命令路径  
`which ls`

### 26、whereis

显示命令路径  
`whereis ls`

### 27、tar

压缩  
`tar zcvf abc.tar.gz abc`  
解压缩  
`tar zxvf abc.tar.gz`

### 28、shutdown

关机  
`shutdown -h now`  
`shutdown -h 20:25`  
`shutdown -h +10`

### 29、halt -p

关机

### 30、history

查看历史命令

### 31、ps aux

查看系统进程

### 32、top

查看资源消耗

### 33、kill -9

关闭进程

### 34、du -sh *

查看文件或目录大小

### 35、df -h

显示磁盘占用

### 36、>

重定向到文件（覆盖）  
`ls > test.log`  
等价于  
`ls 1> test.log`  
即 `ls` 命令的结果由标准输出文件重定向到 `test.log` 文件，注意 `1>` 是标准写法，不可改变，不能在 `1` 和 `>` 之间加空格。

`0`：文件描述符，标准输入（stdin）  
`1`：文件描述符，标准输出（stdout）  
`2`：文件描述符，标准错误输出（stderr）

`command > file 2>&1`  
等价于  
`command &> file`  
`2>&1`：将命令的标准错误输出重定向到标准输出。`2>&1` 是标准写法，不可改变。  
`&>`：将命令的标准输出和标准错误输出都重定向到 file 文件。

`command 2> file`  
将命令的标准错误输出重定向到 file 文件

`command 2>> file`  
将命令的标准错误输出追加到 file 文件

### 37、>>

追加到文件

### 38、chmod

修改文件权限  
`chmod 777 abc`  
`chmod +x abc`  
r = 4，w = 2，x = 1

### 39、apt-get

安装软件  
`apt-get install abc`

### 40、brew

安装软件  
`brew install abc`

### 41、mount

挂载设备  
`mount /dev/cdrom /mnt/cdrom`

### 42、echo

输出  
`echo "hello world"`  
`echo -n "hello world"`  
`echo -e "hello \nworld"`  
-n 不换行，-e 识别转义字符

### 42、|

管道  
`ls | grep abc`  
管道将前一个命令的输出不是写入 `标准输出文件`，而是写入下一个命令的 `标准输入文件`。简言之，**将前一个命令的输出写入 `标准输入文件`**

### 43、date +%s

unix 时间戳

### 44、alias

别名  
`alias ll='ls -al'`

### 45、tree -aN

目录结构

### 46、curl

网络请求  
下载文件：`curl -O http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg`  
断点续传：`curl -O -C - http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg`

`bash -c "$(curl -fsSL http://x.sh)"`  
`-fsSL`：这种组合通常用于脚本中，以确保下载过程安静且可靠，并在失败时返回明确的错误信息。  
`-f`：遇到 HTTP 错误时不输出内容，只返回错误状态码。  
`-s`：静默模式，不显示进度条或错误信息。  
`-S`：在静默模式下显示错误信息。  
`-L`：自动跟随重定向。

### 47、wget

下载  
下载文件：`wget http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg`  
断点续传：`wget -c http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg`

## 二、shell常用快捷键

| 命令      | 操作   |
| -------- | -----: |
|Ctrl + a  |移到命令行首|
|Ctrl + e  |移到命令行尾|
|Ctrl + f  |按字符前移|
|Ctrl + b  |按字符后移|
|Alt + f   |按单词前移|
|Alt + b   |按单词后移|
|Ctrl + u  |从光标处删除至命令行首|
|Ctrl + k  |从光标处删除至命令行尾|
|Ctrl + w  |从光标处删除至单词首|
|Ctrl + d  |删除光标处的字符|
|Ctrl + h  |删除光标前的字符|
|Ctrl + y  |粘贴至光标后|
|Ctrl + r  |逆向搜索命令历史|
|Ctrl + p  |历史中的上一条命令|
|Ctrl + n  |历史中的下一条命令|
|Ctrl + l  |清屏|
|Ctrl + s  |阻止屏幕输出|
|Ctrl + q  |允许屏幕输出|
|Ctrl + c  |取消命令|
|Ctrl + z  |挂起命令|
