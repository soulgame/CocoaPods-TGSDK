
# Get Start For iOS 1.6.5

## 1、导入 TGSDK 到工程

### 使用 CocoaPods

如果你使用 [CocoaPods](https://cocoapods.org/) 来管理你 iOS 工程的依赖，那么 TGSDK 同样支持 CocoaPods，你可以按照如下方法来引入 TGSDK

首先将 Yomob 私有的 Spes 库加入到 CocoaPods，执行命令如下

```
pod repo add soulgame https://github.com/soulgame/Soulgame-Specs.git
```

然后将 TGSDK 作为依赖引入你的项目

```
platform :ios, '8.0'
use_frameworks!

target 'MyApp' do
  source 'https://github.com/soulgame/Soulgame-Specs.git'
  pod 'TGSDK', '~> 1.6.5'
end
```

### 调整编译设置

在 `Build Settings ----> Other Linker Flags` 设置项目中增加 `-ObjC` 配置项。

### Cocos2d-x 工程设置

如果你是 cocos2d-x 工程，通过 cocoapods 引入 TGSDK 后需要调整的编译配置有四处，都需要加入

```
$(inherited)
```

具体做法如图：

<center>
<img src="http://ojwssyn3p.bkt.clouddn.com/cocopods-tgsdk-search-path.png" alt="cocoapods cocos2d-x 设置1" />
<img src="http://ojwssyn3p.bkt.clouddn.com/cocopods-tgsdk-other-linker-flag.png" alt="cocoapods cocod2d-x 设置2" />
</center>
