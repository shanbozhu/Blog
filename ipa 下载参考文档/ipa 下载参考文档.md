[TOC]

## ipa 下载参考文档

https://github.com/JohnxAI/ipa-download  
https://github.com/beer-psi/ipatool.ts  
https://github.com/majd/ipatool  
https://zhuanlan.zhihu.com/p/2050135468772168505

## 安装 ipa 下载工具

`brew install ipatool`

## 下载 ipa

`ipatool search 支付宝`  
`ipatool purchase -b com.alipay.iphoneclient`  
`ipatool download -i 333206289`

## 查看 plist 文件中的 schema

`plutil -p Info.plist | grep -A 5 "CFBundleURLSchemes"`

## 查看 entitlements 文件

`codesign -d --entitlements :- NewsLite.app`

`com.apple.developer.associated-domains`

`apple-app-site-association`