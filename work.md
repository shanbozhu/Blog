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

## git merge

```
git merge develop/combo/450_silkworm_0629 --no-ff -m "【功能】优化小蚕一期做任务相关逻辑，存储任务中间状态"

git merge develop/7.00.31 --no-ff --no-commit -m "【功能】提供无他相机 sdk"
```

## pod 发布相关命令

### 公共仓库

```
# 删除公共仓库源 trunk 上的具体 pod 组件版本
pod trunk delete MentaVlionBaseSDK 7.00.33

# 列出本地 pod 源
pod repo list

# 发布 pod 组件到公共仓库源 trunk
pod trunk push #{sdk_name}.podspec --verbose --allow-warnings --skip-import-validation --synchronous
```

### 私有仓库

```
# 添加本地 pod 源，别名为 Menta
pod repo add Menta https://github.com/mentasdk/menta-specs.git

# 发布 pod 组件到私有仓库源 Menta
# 找到本机名为 Menta 的 Specs 仓库，把这个 podspec 发布到它对应的远程 Git 仓库。因此你需要有该远程仓库的写入权限。
pod repo push Menta #{sdk_name}.podspec --verbose --allow-warnings --skip-import-validation

# 删除 Menta 私有仓库源上的具体 pod 组件版本
cd ~/.cocoapods/repos/Menta
git pull --ff-only

git rm -r MentaVlionBaseSDK/7.00.33
git commit -m "Remove MentaVlionBaseSDK 7.00.33"
git push

# 删除本地 pod 源
pod repo remove Menta
```

## 发布 pod 组件到私有仓库源 Menta

```
bundle exec fastlane ios PublishMultipleSDKs \
  merge_adapters:"MentaFunLinkAdapter,MentaJiaTouAdapter,MentaQimingAdapter,MentaLTMBAdapter,MentaWangMaiAdapter" \
  build_only:true \
  use_private_repo:true
```

## SDK 仅打包、不上传 GitHub（podspec）、不上传 Aliyun（framework）

```
bundle exec fastlane ios PublishSingleSDK \
  sdk_name:MentaVlionBaseSDK \
  pod_version:7.00.33 \
  build_only:true
```

```
bundle exec fastlane ios PublishMultipleSDKs build_only:true
```

## SDK 仅打包、Adapter 聚合

```
bundle exec fastlane ios PublishMultipleSDKs \
  merge_adapters:"MentaFunLinkAdapter,MentaJiaTouAdapter,MentaQimingAdapter,MentaLTMBAdapter,MentaWangMaiAdapter" \
  build_only:true
```

```
bundle exec fastlane ios PublishMultipleSDKs \
  merge_adapters:"MentaFunLinkAdapter,MentaJiaTouAdapter,MentaQimingAdapter,MentaLTMBAdapter,MentaWangMaiAdapter" \
  publish_merged_adapters:true \
  build_only:true
```

```
bundle exec fastlane ios PublishSingleSDK \
  sdk_name:MentaVlionAdapter \
  pod_version:7.00.33 \
  merge_adapters:"MentaFunLinkAdapter,MentaJiaTouAdapter,MentaQimingAdapter,MentaLTMBAdapter,MentaWangMaiAdapter" \
  build_only:true
```

## IPA 仅打包、不上传蒲公英、不发送钉钉群通知

```
bundle exec fastlane ios build build_only:true
```

## IPA 打包、上传蒲公英、发送钉钉群通知

```
bundle exec fastlane ios build \
  pgyer_update_description:"<br> 1. 版本号：7.01.00 <br> 2. 修复地理位置经纬度 lat、lon、long 字段的数据类型错误问题，需要传入 NSNumber 类型"
```

## 静态 XCFramework 组件聚合

```bash
./scripts/merge_binary_components.py \
  --aggregate MentaUnifiedSDK \
  --component MentaVlionAdapter \
  --component MentaVlionSDK \
  --component MentaVlionBaseSDK
```

## SDK 前缀替换脚本 - 更新为「莱特」前缀

```
python3 scripts/replace_component_prefixes.py \
  --prefix MentaVlionSDK=LTMBV \
  --product-name MentaVlionSDK=LTMB_Vlion_AdSDK \
  --prefix MentaVlionBaseSDK=LTMBB \
  --product-name MentaVlionBaseSDK=LTMB_VlionBase_AdSDK \
  --prefix MentaUnifiedSDK=LTMBU \
  --product-name MentaUnifiedSDK=LTMB_VlionUnified_AdSDK \
  --prefix MentaVlionAdapter=LTMBA \
  --product-name MentaVlionAdapter=LTMB_VlionAdapter_AdSDK \
  --bundle-name LTMBBaseResources \
  --bundle-resource-prefix lm_ \
  --apply
```

## App 逻辑体积差分脚本

```
scripts/measure_app_size.sh \
  --with-component ./packages/WithComponent.ipa \
  --without-component ./packages/WithoutComponent.ipa \
  --component ComponentA
```

## 查看单个文件的实际字节数

```
stat -f '%z' /Users/zhushanbo/Desktop/11/Menta-iOS_Example.ipa
```
