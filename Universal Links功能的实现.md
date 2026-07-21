---
title: "Universal Link功能的实现"
date: 2019-07-09T15:21:53+08:00
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

## 一、Universal Link 是干什么的

通用链接是 Apple 在 iOS 9 引入的一个新功能，是通过传统 HTTP 链接来启动 App 的技术。可以使用相同的网址打开网站和 App。通过唯一的网址，就可以链接到 App 中具体的页面，如果用户没有安装 App 则链接到对应的普通网页。

## 二、Universal Link 怎么实现

主要有如下三步：

### 1、苹果开发者中心配置

登录开发者账号，在 `Identifiers -> AppIDs` 找到自己的 App ID，打开 Associated Domains 服务。

![](https://raw.gitcode.com/shanbozhu/Resources/raw/master/image/2019_7_9/2019_7_9_0.png?raw=true)

### 2、服务端配置

2.1 新建名为 `apple-app-site-association` 的 json 文件，不能加 `.json` 后缀。

2.2 编辑该文件，内容格式如下，注意不能更改其格式和字段名称。
```json
{
    "applinks":
    {
        "apps": [],
        "details": [
            {
                "appID": "FFJNMLHK32.cn.damai.iphone",
                "paths": ["*"]
            }
        ]
    }
}
```
appID：由前缀和 ID 两部分组成，可以在开发者中心中的 `Identifiers -> AppIDs` 中点击对应的 App ID 查看

![](https://raw.gitcode.com/shanbozhu/Resources/raw/master/image/2019_7_9/2019_7_9_1.png?raw=true)

paths：对应域名中的路径，用于匹配可以跳转到 App 的特定链接

2.3 把配置好的 `apple-app-site-association` 文件上传到服务器该域名的根目录下。

2.4 点击 [https://www.damai.cn/apple-app-site-association](https://www.damai.cn/apple-app-site-association) 验证 `apple-app-site-association` 文件是否上传成功

### 3、xcode 配置

3.1 要用 Apple Developer Program members 的账号登录 Xcode，个人账号或未登录则看不到 Associated Domains 选项

3.2 找到工程的 `Capabilities -> Associated Domains`，打开此功能，在 Domains 中添加支持跳转的域名，域名的格式为 `applinks:www.damai.cn`

![](https://raw.gitcode.com/shanbozhu/Resources/raw/master/image/2019_7_9/2019_7_9_2.png?raw=true)

3.3 在 AppDelegate 中实现方法，在该方法内可以实现跳转到具体页面的操作
```objective-c
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler {
    NSURL *url = userActivity.webpageURL;
    NSLog(@"url.absoluteString = %@", url.absoluteString);

    return YES;
}
```

3.4 所有操作均已完成  
备忘录内点击 [https://www.damai.cn/xx](https://www.damai.cn/xx) 链接可以直接唤起 App，验证功能正常。
```
调用场景：
1. Universal Link：Safari 浏览器、系统相机、备忘录、网页跨域点击。
2. URL Schema：Safari 浏览器、系统相机、备忘录、自家 APP 点击、自家 APP 内网页点击（调用端能力，在调用 openURL 打开）、非自家 APP 内网页点击（引导至 Safari 打开）。
```

## 三、Universal Link 注意事项

1. 域名需要 SSL 证书，也就是需要支持 https 协议。
2. 对 json 文件的请求仅在 App 安装时请求一次，以后除非 App 更新或重新安装，否则不会在每次打开 App 时请求 `apple-app-site-association`。如果第一次请求时网络连接出了问题，apple 会缓存请求，等待有网的时候再去请求。
3. 从 iOS 9.2 开始，若当前网页的 domain 与跳转的 Universal Link 的 domain 相同则不会工作，必须要跨域才生效。
