
# Get Start For iOS 1.6.4

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
  pod 'TGSDK', '~> 1.6.4'
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

## 2、初始化 TGSDK

从 [Yomob官方网站](http://yomob.com/) 为产品注册好账户后，你将会从网站得到你的产品对应的 `AppID`  使用这个参数来初始化 TGSDK

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [TGSDK initialize:@"Your application ID from yomob"
             callback:^(BOOL success, id tag, NSDictionary* result){
    }];
    [TGSDK preloadAd:nil];
    return YES;
}
```

## 3、预加载广告资源

为了有充裕的时间来加载广告资源，建议尽早调用预加载 API 来开始广告的加载工作。甚至你可以在初始化 TGSDK 的同时就开始调用广告预加载 API 来预加载广告。
　
```
[TGSDK preloadAd:nil];
```

## 4、播放广告

通过 [Yomob 官方网站](http://yomob.com/) 为注册的应用建立广告场景，获得相应的广告场景 ID 后，通过场景 ID 参数来判断广告是否已经准备好，如果对应场景的广告已经准备好，则可以调用播放 API 来播放对应场景的广告。

```
if ([TGSDK couldShowAd:@"Your scene id from Yomob") {
    [TGSDK showAd:@"Your scene id from Yomob"];
}
```

## 5、高级用法

### 开启 Debug 模式

开启 debug 模式后可以看到更多 Log 输出，方便定位遇到的问题。但需要注意

>**在生产环境请勿使用 Debug 模式，另外，如果需要启动 Debug 模式，请在调用初始化 API 前设置 Debug 模式的开启**

```
[TGSDK setDebugModel:YES];
```

### 设置广告预加载事件监听

你可以通过一个 `delegate` 来对广告的加载过程进行监控。

```
@protocol TGPreloadADDelegate <NSObject>
@optional

// 广告预加载调用成功
- (void) onPreloadSuccess:(NSString*)result;

// 广告预加载调用失败
- (void) onPreloadFailed:(NSString*)result WithError:(NSError*) error;

// 静态插屏广告已就绪
- (void) onCPADLoaded:(NSString*) result;

// 视频广告已就绪
- (void) onVideoADLoaded:(NSString*) result;

@end

```

在调用预加载 API 时传入 `delegate` 来对预加载过程进行监控

```
[TGSDK preloadAd:id<TGPreloadADDelegate> delegate];
```

### 设置广告播放行为事件监听

在广告播放过程中可以通过一个 `delegate` 来监控广告播放过程中产生的一系列事件。

```
@protocol TGADDelegate <NSObject>
@optional

// 广告开始播放
- (void) onShowSuccess:(NSString*)result;

// 广告播放失败
- (void) onShowFailed:(NSString*)result WithError:(NSError*)error;

// 广告播放完成
- (void) onADComplete:(NSString*)result;

// 用户点击了广告，正在跳转到其他页面
- (void) onADClick:(NSString*)result;

// 广告关闭
- (void) onADClose:(NSString*)result;

@end

@protocol TGRewardVideoADDelegate <TGADDelegate>
@optional

// 奖励广告条件达成，可以向用户发放奖励
- (void) onADAwardSuccess:(NSString*)result;

// 奖励广告条件未达成，无法向用户发放奖励
- (void) onADAwardFailed:(NSString*)result WithError:(NSError*)error;

@end

```

通过下列 API 来设置广告行为监控的 `delegate`

```
[TGSDK setADDelegate:id<TGADDelegate> delegate];

[TGSDK setRewardVideoADDelegate:id<TGRewardVideoADDelegate> delegate];
```

### 上报用户观看广告行为

为了让我们更好的分析用户观看广告的行为，优化广告投放，增加产品的广告收益，我们建议在产品中通过 API 主动上报一些关于用户观看广告行为的数据，来帮助我们给予用户更好的广告体验。

#### 上报广告展示行为

<center>
<img width="50%" height="50%" src="http://o7zgfxfza.bkt.clouddn.com/TGSDK1.4.0ios%E4%B8%8A%E6%8A%A5%E5%B9%BF%E5%91%8A%E5%B1%95%E7%A4%BA%E8%A1%8C%E4%B8%BA.png" alt="TGSDK iOS 上报广告展示行为" />
</center>

如图所示，当用户通过产品 UI 明确意识到产品即将发生广告播放的行为，或是产品通过 UI 展现了让用户选择是否播放广告的控件，例如图示的产品展示了广告播放按钮让用户选择是否通过播放广告来获得收益时，请上报告知 TGSDK 这种行为

```
[TGSDK showAdScene:@"Your scene ID from Yomob"];
```

#### 上报用户拒绝观看广告行为

<center>
<img width="50%" height="50%" src="http://o7zgfxfza.bkt.clouddn.com/TGSDK1.4.0ios%E6%8B%92%E7%BB%9D%E6%92%AD%E6%94%BE%E5%B9%BF%E5%91%8A%E7%9A%84%E8%A1%8C%E4%B8%BA.png" alt="TGSDK iOS 拒绝观看广告的行为" />
</center>

如图所示，当用户在明确意识到接下来要发生的广告播放行为的情况下，明确选择拒绝或放弃了这次广告播放，例如，当用户在图示的产品中明确看到了通过观看广告获得收益的播放按钮 UI，但是还是明确选择了 Give Up 放弃，那么请上报这个行为告知 TGSDK

```
[TGSDK reportAdRejected:@"Your scene id from Yomob"];
```