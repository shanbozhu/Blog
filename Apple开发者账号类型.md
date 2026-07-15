---
title: "Apple开发者账号类型"
date: 2019-11-14T14:38:31+08:00
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

## 总结

`APP版本号：6.49.0.1`  
`第几代。第几版。第几次更新。第几次提交`

<table>
    <tr>
        <td><b>账号类型</b></td>
        <td><b>签名证书</b></td>
        <td><b>配置文件</b></td>
        <td><b>版本</b></td>
        <td><b>推送证书</b></td>
        <td><b>Bundle ID</b></td>
        <td><b>支持安装设备数量</b></td>
   </tr>
   <tr>
        <td rowspan="2"><b>公司开发者账号</b>（99美元、申请条件：邓白氏编码）、<b>个人开发者账号</b>（99美元、申请条件：无限制）</td>
        <td>开发（签名）证书（.p12）</td>
        <td>开发配置文件（.mobileprovision）</td>
        <td><b>开发包</b></td>
        <td>开发（环境）推送证书（.p12）</td>
        <td rowspan="2"><div style="width: 60px;">com.baidu.BaiduMobileInfo</div></td>
        <td>100</td>
   </tr>
   <tr>
        <td>发布（签名）证书（.p12）</td>
        <td>发布配置文件（.mobileprovision）</td>
        <td><b>商店包</b></td>
        <td>生产（环境）推送证书（.p12）</td>
        <td>无限制（需 Apple 审核）</td>
   </tr>
    <tr>
        <td rowspan="2"><b>企业开发者账号</b>（299美元、申请条件：邓白氏编码）</td>
        <td>开发（签名）证书（.p12）</td>
        <td>开发配置文件（.mobileprovision）</td>
        <td>企业开发包</td>
        <td>开发（环境）推送证书（.p12）</td>
        <td rowspan="2"><div style="width: 60px;">com.baidu.BaiduMobileInfoEnterprise</div></td>
        <td>100</td>
    </tr>
    <tr>
        <td>发布（签名）证书（.p12）</td>
        <td>发布配置文件（.mobileprovision）</td>
        <td><b>企业</b>商店<b>包</b></td>
        <td>生产（环境）推送证书（.p12）</td>
        <td>无限制（无需 Apple 审核）</td>
    </tr>
</table>

**签名证书**：Xcode 使用，同一开发者账号下的不同 App 的签名证书相同。  
**配置文件**：App 使用，同一开发者账号下的不同 App 的配置文件不同。包含 Bundle Id、授权文件、签名证书（同一开发者账号下只有一个）、设备 UDID（勾选签名证书添加的 100 个设备中的部分或全部设备去支持真机调试）。  
**推送证书**：推送后端使用，同一开发者账号下的不同 App 的推送证书不同。

```
1. 同一开发者账号下只有一个开发（签名）证书和一个发布（签名）证书。
2. 同一开发者账号下注册多个 App，使用同一个签名证书、不同的配置文件、不同的推送证书。

1. 更新签名证书需要更新配置文件，不需要更新推送证书。
2. 可以单独更新配置文件，如 App 添加新设备支持真机调试。
3. 可以单独更新推送证书。
```

## 一、如何从 .p12 证书文件查看证书到期时间

1. 使用 openssl 将 .p12 文件解压到 .pem 文件  
`openssl pkcs12 -in certificate.p12 -out certificate.pem -nodes -legacy`
2. 使用下面命令从 .pem 文件中查看到期时间  
`cat certificate.pem | openssl x509 -noout -enddate`
3. 返回的是格林尼治时间，北京时间需要加 8

## 二、验证 pem 推送证书是否有效

1. 验证开发推送证书  
`openssl s_client -connect api.development.push.apple.com:443 -cert certificate_tomas_daily_dev.pem`
2. 验证发布推送证书  
`openssl s_client -connect api.push.apple.com:443 -cert certificate_tomas_daily_dis.pem`

## 三、查看安装包内的配置文件和授权文件

1. 查看配置文件  
`BaiduTomasApp.ipa -> BaiduTomasApp.zip -> Payload -> BaiduTomasApp.app -> 主工程和扩展工程的 embedded.mobileprovision`
2. 查看授权文件  
`codesign -d --entitlements :- BaiduTomasApp.app`或`mgrep.sh "aps-environment"`

## 四、企业包打印提示

```objective-c
{
    NSString *message = @"点击确认";
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *commit = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:commit];
    [UIWindow.bba_topViewController presentViewController:alert animated:YES completion:nil];
}
```

## 五、p12 证书与 mobileprovision 配置文件在电脑中的位置

1. 安装的 p12 证书的位置  
`钥匙串 -> 登录 -> 我的证书`
2. 安装的 mobileprovision 配置文件的位置  
`~/Library/MobileDevice/Provisioning Profiles`

## 六、证书申请流程

<table>
    <tr>
        <td><b>标题</b></td>
        <td><b>地址</b></td>
        <td><b>网页快照</b></td>
   </tr>
   <tr>
        <td>苹果开发者 certSigningRequest 文件生成流程</td>
        <td>https://www.cnwenhui.cn/html/show-1038.html</td>
        <td><div style="width: 140px;">https://raw.gitcode.com/shanbozhu/Resources/raw/master/image/2024_11_21/2024_11_21_0.png?raw=true</div></td>
   </tr>
   <tr>
        <td>苹果开发者推送证书申请流程</td>
        <td>https://www.cnwenhui.cn/html/show-1037.html</td>
        <td><div style="width: 140px;">https://raw.gitcode.com/shanbozhu/Resources/raw/master/image/2024_11_21/2024_11_21_1.png?raw=true</div></td>
   </tr>
   <tr>
        <td>cer 证书转换 .p12 文件</td>
        <td>https://www.xjx100.cn/news/642584.html?action=onClick</td>
        <td><div style="width: 140px;">https://raw.gitcode.com/shanbozhu/Resources/raw/master/image/2024_11_21/2024_11_21_2.png?raw=true</div></td>
    </tr>
    <tr>
        <td>iOS 推送报错 BadCertificateEnvironment</td>
        <td>https://blog.csdn.net/zWbKingGo/article/details/89186652</td>
        <td><div style="width: 140px;">https://raw.gitcode.com/shanbozhu/Resources/raw/master/image/2024_11_21/2024_11_21_3.png?raw=true</div></td>
    </tr>
</table>

## 七、打包 `ipa` 录屏

[https://pan.baidu.com/s/1q9b8pmNJhFXlhqCVB8c05g?pwd=yq5x](https://pan.baidu.com/s/1q9b8pmNJhFXlhqCVB8c05g?pwd=yq5x)
