---
title: "Git常用命令"
date: 2019-05-21T19:33:39+08:00
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

## 一、常用命令

### 1.1 克隆**远程仓库**到**本地**（下载远程仓库）

`git clone https://github.com/shanbozhu/shanbozhu.github.io.git`

### 1.2 将**工作区**文件添加到**暂存区**

添加到暂存区

`git add .`

### 1.3 将**暂存区**文件提交到**本地仓库**

提交到本地

`git commit -m "message"`

### 1.4 将**本地仓库**推送到**远程**

推送到远程

`git push`

### 1.5 拉取**远程**更新到**本地**

`git pull`

或

--rebase 以变基的形式拉取

`git pull --rebase`

## 二、其他命令

### 2.1 切换分支

如果本地有就切本地，如果本地没有则从远程拉取；如果远程有就从远程拉取，如果远程也没有则丢弃

`git checkout test`

### 2.2 新建分支

新建 test 分支，但不切换到该分支

`git branch test`

### 2.3 查看本地分支

`git branch`

### 2.3 查看远程分支

`git branch -r`

### 2.4 删除本地分支

`git branch -D test`

### 2.5 将其他分支的提交合并到当前分支

1. 连续的 commit id 合并，不包含 `b041ff5a643b7b1f5c590dc1a368f956ccc3df94` 节点

`git cherry-pick b041ff5a643b7b1f5c590dc1a368f956ccc3df94`

`git cherry-pick b041ff5a643b7b1f5c590dc1a368f956ccc3df94..79aaa3a9071c2040d602a60bc6e41303c1039bee`

2. `aae729b78088e10af0f589e51a560f388cde3d6d` 是一个合并节点

`git cherry-pick aae729b78088e10af0f589e51a560f388cde3d6d -m 1`

### 2.6 合并分支

合并 test 分支到当前分支，不使用快进生成一个新的合并节点

`git merge test --no-ff`

### 2.7 变基分支

变基 test 分支到当前分支，**变基也是合并的意思**

`git rebase test`

### 2.8 查看分支状态

`git status`

### 2.9 修改提交信息

更正上一次提交

`git commit --amend`

### 2.10 修改冲突风格

**diff3 风格**或 **merge 风格（默认）**  
参考文档：  
https://blog.csdn.net/Mrrr_Li/article/details/125300057  
https://blog.csdn.net/weixin_34062329/article/details/92570957  
https://www.zhihu.com/question/27507789/answer/2233901143

`git config --global merge.conflictstyle diff3`

`git config --global merge.conflictstyle merge`

### 2.11 查看远程仓库地址

`git remote -v`

### 2.12 增加远程仓库地址

一个本地仓库可以对应多个远程仓库地址

`git remote add origin1 https://github.com/shanbozhu/TestOC.git`

### 2.13 删除远程仓库地址

`git remote remove origin1`

### 2.14 删除缓存，去除 git 管理

去除 git 管理，添加 file 到 `.gitignore` 忽略文件

`git rm -r --cached file`

### 2.15 跟踪远程分支

本地当前分支跟踪远程分支

`git branch -u origin/lite/master`

或

`git branch --set-upstream-to=origin/lite/master`

### 2.16 丢弃工作区的更改

`git checkout -- .`

### 2.17 丢弃暂存区的更改，回到工作区

`git reset HEAD .`

### 2.18 丢弃工作区和暂存区的更改

`git reset --hard`

## 三、使用场景

### 3.1 变基其他分支到当前分支
```
1. git rebase test
2. git status
3. 解决冲突
4. git add -u
5. git rebase --continue
```

### 3.2 变基最后三次提交为一次提交

> b041ff5a643b7b1f5c590dc1a368f956ccc3df94 为倒数第四次提交的 commit id

```
1. git log
2. git rebase -i b041ff5a643b7b1f5c590dc1a368f956ccc3df94
3. 修改第二、三次提交的 pick 为 squash 或 s，保存退出
4. 删除第二、三次提交的提交信息，保存退出
```

## 四、Sourcetree 问题解决

### 4.1 对 GitHub 使用 git push 时提示用户名、密码错误

`Sourcetree` -> `偏好设置...` -> `高级` -> `对 URL 的默认用户名其中不包括` -> 删除 `github.com` 一栏 -> Sourcetree 重新执行 `git push` -> Sourcetree 弹框提示 `输入用户名和密码` -> 输入用户名 `shanbozhu@gmail.com`，输入密码 `个人token` -> 点击 ok，推送成功。

### 4.2 如何添加文件到 `.gitignore` 全局忽略文件

1. 通过命令行修改：打开全局忽略文件 `~/.gitignore_global` -> 添加需要去除 git 管理的文件到该文件中。会对所有 git 项目生效。
2. 通过 Sourcetree 修改：`Sourcetree` -> `偏好设置...` -> `Git` -> `全局忽略列表` -> `编辑文件`。
