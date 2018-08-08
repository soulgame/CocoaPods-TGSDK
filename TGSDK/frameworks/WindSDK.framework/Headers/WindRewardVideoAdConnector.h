//
//  WindRewardVideoAdConnector.h
//  WindSDK
//
//  Created by happyelements on 2018/4/9.
//  Copyright © 2018 Codi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WindRewardInfo;
@class WindAdRequest;
@protocol WindRewardVideoAdAdapter;


@protocol WindMediationAdRequest<NSObject>

@optional

- (NSDictionary *)parametes;

- (WindAdRequest *)request;

@end


@protocol WindRewardVideoAdConnector<WindMediationAdRequest>

@optional

- (void)adapterDidSetUpRewardVideoAd:(id<WindRewardVideoAdAdapter>)rewardVideoAdAdapter;

- (void)adapter:(id<WindRewardVideoAdAdapter>)rewardVideoAdAdapter didFailToSetUpRewardVideoAd:(NSError *)error;

- (void)adapterDidAdClick:(id<WindRewardVideoAdAdapter>)adapter;

- (void)adapterDidReceiveRewardVideoAd:(id<WindRewardVideoAdAdapter>)rewardVideoAdAdapter;

- (void)adapterDidStartPlayingRewardVideoAd:(id<WindRewardVideoAdAdapter>)rewardVideoAdAdapter;

- (void)adapterDidCloseRewardVideoAd:(id<WindRewardVideoAdAdapter>)rewardVideoAdAdapter rewardInfo:(WindRewardInfo *)info;

- (void)adapter:(id<WindRewardVideoAdAdapter>)rewardVideoAdAdapter didFailToLoadRewardVideoAdwithError:(NSError *)error;

@end


