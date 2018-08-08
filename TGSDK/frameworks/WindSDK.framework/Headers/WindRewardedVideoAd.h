//
//  WindRewardedVideoAd.h
//  WindSDK
//
//  Created by happyelements on 2018/4/8.
//  Copyright © 2018 Codi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WindAdRequest;
@class WindRewardInfo;

NS_ASSUME_NONNULL_BEGIN

@protocol WindRewardedVideoAdDelegate<NSObject>

//加载成功
-(void)onVideoAdLoadSuccess:(NSString * _Nullable)placementId;

//开始播放
-(void)onVideoAdPlayStart:(NSString * _Nullable)placementId;

//点击
-(void)onVideoAdClicked:(NSString * _Nullable)placementId;

//完成（奖励）
- (void)onVideoAdClosedWithInfo:(WindRewardInfo * _Nullable)info placementId:(NSString * _Nullable)placementId;

//错误
-(void)onVideoError:(NSError *)error placementId:(NSString * _Nullable)placementId;



@end



@interface WindRewardedVideoAd : NSObject

@property (nonatomic,weak) id<WindRewardedVideoAdDelegate> delegate;

@property (nonatomic,assign, readonly, getter=isReady) BOOL ready;

+ (instancetype)sharedInstance;

- (BOOL)loadRequest:(WindAdRequest *)request withPlacementId:(NSString * _Nullable)placementId;

- (BOOL)playAd:(UIViewController *)controller options:(NSDictionary * _Nullable)options error:( NSError *__autoreleasing _Nullable *_Nullable)error;


@end

NS_ASSUME_NONNULL_END
