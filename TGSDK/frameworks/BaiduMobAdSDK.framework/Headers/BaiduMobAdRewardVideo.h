//
//  BaiduMobAdRewardVideo.h
//  BaiduMobAdSDK
//
//  Created by Yang,Dingjia on 2018/7/3.
//  Copyright © 2018年 Baidu Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaiduMobAdRewardVideoDelegate.h"


@interface BaiduMobAdRewardVideo : NSObject

/**
 *  委托对象
 */
@property (nonatomic, weak) id <BaiduMobAdRewardVideoDelegate> delegate;

/**
 *  应用的APPID
 */
@property (nonatomic, copy) NSString *publisherId;

/**
 *  设置/获取代码位id
 */
@property (nonatomic, copy) NSString *AdUnitTag;

/**
 *  启动位置信息 如果enable，plist 需要增加NSLocationWhenInUseUsageDescription
 */
@property (nonatomic, assign) BOOL enableLocation;


/**
 *  预加载视频广告，并缓存物料信息到本地。注意广告的展示存在有效期，单次检索后须在一定时间内展示在页面上
 *  建议页面启动即开启preload
 */
- (void)preload;

/**
 *  激励视频广告的展示存在有效期，单次检索后须在一定时间内展示在页面上
 *  返回广告是否过期    YES代表可用，NO代表不可用
 */
- (BOOL)isReady;

/**
 *  展示激励视频，默认RootViewController present
 *  默认使用本地缓存，本地缓存失效则在线请求
 */
- (void)loadAndDisplay;

/**
 *  展示激励视频，使用controller present
 *  默认使用本地缓存，本地缓存失效则在线请求
 */
- (void)loadAndDisplayWithViewController:(UIViewController *)controller;

@end
