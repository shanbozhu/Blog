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

## 如何通过 cocoapods 发布源码？

通过 CocoaPods 发布源码主要分为发布到**公有仓库（Trunk）** 和发布到**私有仓库（Private Repo）** 两种场景。以下是完整的发布流程指南：

### 一、 准备工作
1. **注册账号（仅公有库需要）**：通过终端注册一个 CocoaPods 账号，系统会向你的邮箱发送确认邮件，按提示确认即可。
   ```bash
   pod trunk register 邮箱地址 '用户名' --verbose
   ```
2. **创建代码仓库**：在 GitHub 或 GitLab 上创建一个远程仓库，并将你的源码推送到该仓库。

### 二、 创建并配置 Podspec 文件
每个 Pod 库必须有且仅有一个 `.podspec` 描述文件，文件名需与库名一致。
1. **生成模板**：
   ```bash
   pod spec create 你的库名
   ```
2. **编辑关键字段**：打开生成的 `.podspec` 文件，填写库的详细信息，包括名称、版本号、源码位置、依赖关系等。常见配置示例：
   ```ruby
   s.name         = "你的库名"
   s.version      = "1.0.0"
   s.summary      = "一句话介绍项目"
   s.homepage     = "你的GitHub仓库地址"
   s.license      = "MIT"
   s.author       = { "你的名字" => "你的邮箱" }
   s.source       = { :git => "你的Git仓库地址.git", :tag => s.version.to_s }
   s.source_files = "你的库名/Classes/**/*.{h,m}"
   ```

### 三、 打 Tag 并验证
1. **打标签**：代码提交到远程仓库后，必须打一个 Tag，且 **Tag 版本号必须与 `.podspec` 中的 `s.version` 保持一致**。
   ```bash
   git tag 1.0.0
   git push --tags
   ```
2. **本地验证**：验证 podspec 文件的有效性，确保没有 Error。如果有非致命的警告，可以加上 `--allow-warnings` 参数。
   ```bash
   pod lib lint 你的库名.podspec --allow-warnings --verbose
   ```

### 四、 发布源码
根据需求选择发布到公有库或私有库：

#### 1. 发布到公有库（Trunk）
验证通过后，执行以下命令将库推送到官方 Specs 仓库：
```bash
pod trunk push 你的库名.podspec --allow-warnings
```
出现 "Tell your friends!" 提示即表示发布成功。

#### 2. 发布到私有库
私有库需要先在内部 Git 平台创建一个空的 Specs 仓库，并将其添加到本地：
```bash
pod repo add 私有Specs仓库名 私有Specs仓库的Git地址
```
验证通过后，将 podspec 推送到你的私有 Specs 仓库：
```bash
pod repo push 私有Specs仓库名 你的库名.podspec --allow-warnings --verbose
```

### 五、 验证与使用
1. **搜索验证**：发布成功后，可通过以下命令搜索（如果搜不到，可尝试执行 `pod repo update` 更新本地源，或删除本地缓存 `rm ~/Library/Caches/CocoaPods/search_index.json` 后重试）。
   ```bash
   pod search 你的库名
   ```
2. **集成使用**：
   - **公有库**：直接在项目的 `Podfile` 中添加 `pod '你的库名'` 并执行 `pod install`。
   - **私有库**：需在 `Podfile` 顶部添加私有源地址 `source '私有Specs仓库的Git地址'`，然后再引用组件。

**💡 开发期小贴士**：在开发私有库的过程中，为了避免频繁修改代码后反复打 Tag 和 `pod update`，可以在 `Podfile` 中使用本地路径引用：`pod '你的库名', :path => '~/本地/绝对路径'`。


## 如何通过 cocoapods 发布二进制？

通过 CocoaPods 发布二进制组件，核心思路是将源码预先编译为静态库（`.a`）、动态库（`.framework`）或通用框架（`.xcframework`），然后将其托管到 Git 或私有服务器，并通过修改 `.podspec` 文件让 CocoaPods 拉取二进制文件而非源码。

以下是完整的二进制发布流程指南：

### 一、 制作二进制包
你需要将源码编译为支持真机和模拟器的二进制文件。目前业界推荐使用 `xcodebuild` 和 `lipo` 工具，或直接生成官方推荐的 `.xcframework` 格式。

**1. 分别编译真机与模拟器版本**
```bash
# 编译真机版本 (Release)
xcodebuild archive \
-project YourProject.xcodeproj \
-scheme YourScheme \
-configuration Release \
-sdk iphoneos \
-archivePath "build/YourLib-iOS" \
SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

# 编译模拟器版本 (Release)
xcodebuild archive \
-project YourProject.xcodeproj \
-scheme YourScheme \
-configuration Release \
-sdk iphonesimulator \
-archivePath "build/YourLib-Simulator" \
SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES
```

**2. 合并为通用 Framework 或 XCFramework**
*   **传统方式（使用 lipo 合并）**：
    ```bash
    # 创建通用目录并拷贝真机产物
    mkdir -p build/YourLib-Universal
    cp -R build/YourLib-iOS.xcarchive/Products/Library/Frameworks/YourLib.framework build/YourLib-Universal/
    
    # 合并二进制文件
    lipo -create \
    build/YourLib-iOS.xcarchive/Products/Library/Frameworks/YourLib.framework/YourLib \
    build/YourLib-Simulator.xcarchive/Products/Library/Frameworks/YourLib.framework/YourLib \
    -output build/YourLib-Universal/YourLib.framework/YourLib
    ```
*   **现代方式（推荐生成 XCFramework）**：
    ```bash
    xcodebuild -create-xcframework \
    -framework build/YourLib-iOS.xcarchive/Products/Library/Frameworks/YourLib.framework \
    -framework build/YourLib-Simulator.xcarchive/Products/Library/Frameworks/YourLib.framework \
    -output build/YourLib.xcframework
    ```

### 二、 托管二进制文件
将上一步生成的二进制包（`.framework` 或 `.xcframework`）上传到可访问的存储位置：
1. **Git 仓库**：将二进制文件推送到一个新的 Git 仓库，或当前源码仓库的特定分支/Tag 中。
2. **静态资源服务器**：上传至公司内部的 OSS、CDN 或静态文件服务器，获取一个稳定的下载 URL。

### 三、 配置并发布 Podspec
编写或修改 `.podspec` 文件，将 `source_files` 替换为指向二进制文件和头文件的配置。

**1. 基础配置示例（以 Framework 为例）**
```ruby
Pod::Spec.new do |s|
  s.name         = "YourLib"
  s.version      = "1.0.0"
  s.summary      = "YourLib 二进制版本"
  s.homepage     = "你的项目主页"
  s.license      = "MIT"
  s.author       = { "你的名字" => "你的邮箱" }
  
  # 指向二进制包所在的 Git 仓库或 Tag
  s.source       = { :git => "二进制包Git地址.git", :tag => s.version.to_s }
  
  # 声明二进制文件路径（相对于下载的源码根目录）
  s.vendored_frameworks = "YourLib.framework"
  
  # 声明头文件路径
  s.public_header_files = "YourLib.framework/Headers/*.h"
  
  # 如果依赖其他库，需在此声明
  s.dependency 'SomeOtherLib'
end
```

**2. 验证与发布**
与发布源码类似，验证无误后推送到公有或私有 Specs 仓库：
```bash
# 验证
pod lib lint YourLib.podspec --allow-warnings --verbose

# 发布到公有或私有库
pod trunk push YourLib.podspec --allow-warnings
# 或
pod repo push 私有Specs仓库名 YourLib.podspec --allow-warnings
```

### 四、 进阶实践：源码与二进制平滑切换
在实际工程化中，为了兼顾“集成时的编译速度”和“本地调试的便利性”，通常会结合 CocoaPods 插件来实现源码与二进制的无缝切换。常见的方案包括：

1. **双私有源方案（如 `cocoapods-bin`）**：维护两个私有源，一个存源码，一个存预编译的二进制文件。在 `pod install` 时自动选择下载二进制，开发者修改代码时可一键切回源码。
2. **本地缓存复用方案（如 `cocoapods-sled`）**：无需预编译，插件会拦截 `pod install` 流程，自动将 Xcode 编译产生的缓存（DerivedData）提取并缓存到本地。下次安装时直接复用，实现源码与二进制的丝滑切换。
3. **Subspec 隔离方案**：在同一个 `.podspec` 中定义两个 subspec（如 `Source` 和 `Binary`），通过在 `Podfile` 中指定不同的 subspec 来手动切换依赖。

**⚠️ 注意事项**：
*   **宏定义失效**：预编译后的二进制中，依赖 `DEBUG` 等宏定义的代码会被固化。建议将宏逻辑挪到运行时处理，或避免跨模块使用宏。
*   **Swift 支持**：如果使用 Swift 编写，合并 Framework 时务必同时拷贝合并 `swiftmodule` 目录，否则集成方会报错。