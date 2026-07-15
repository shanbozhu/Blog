<h1 style="text-align:center; font-family:Times New Roman; color:black;">
    基于宿主调试 iOS SDK 源码方案
</h1>

## 0. 前提

### 宿主方：ipa 构建设置，确保开启了调试符号

release 一般是默认开启的，debug 需要手动开启
```
DEBUG_INFORMATION_FORMAT = dwarf-with-dsym
GCC_GENERATE_DEBUGGING_SYMBOLS = YES
```

### SDK 方：校验宿主提供的 ipa 和对应 dSYM 的 UUID，确认是否一致

```bash
xcrun dwarfdump --uuid \
  /Users/zhushanbo/Desktop/123/TestOC.app/TestOC

xcrun dwarfdump --uuid \
  /Users/zhushanbo/Desktop/123/TestOC.app.dSYM/Contents/Resources/DWARF/TestOC
```

### SDK 方：运行宿主 App，打开任意 Xcode 工程，通过 `debug -> attach to process`，选择宿主 App 的进程，打开 lldb 控制台

## 1. 加载符号

```bash
(lldb) target symbols add "/Users/zhushanbo/Desktop/123/TestOC.app.dSYM"
```

## 2. 查询符号源文件路径

```bash
(lldb) image lookup -v -n "-[PBMineSDKController tapClick:]"
```

## 3. 映射源码

```bash
(lldb) settings set target.source-map \
  "/Users/zhushanbo/Desktop/GitCodeBundle2/PBMineSDK" \
  "/Users/zhushanbo/Desktop/GitCodeBundle2/PBMineSDK"

(lldb) settings set target.source-map \
  "/CI上的SDK源码路径" \
  "/你本地的SDK源码路径"
```

## 4. 设置断点

```bash
Objective-C：
(lldb) breakpoint set --name "-[PBMineSDKController tapClick:]"
(lldb) breakpoint set --file PBMineSDKController.m --line 57

Swift：
(lldb) breakpoint set --name "PBMineSDK.SomeClass.someMethod()"
```

## 5. 查看断点
```bash
breakpoint list
```

## 6. 开始调试

在宿主 App 中运行，触发断点，会自动跳转至本地 SDK 源码。
