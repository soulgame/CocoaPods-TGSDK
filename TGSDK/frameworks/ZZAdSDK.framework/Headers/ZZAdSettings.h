//
//  ZZAdSetting.h
//  ZZAdSDK
//
//  Created by xuhuize on 2017/4/16.
//  Copyright © 2017年 xuhuize. All rights reserved.
//

@class ZZAdConfig;

@interface ZZAdSettings : NSObject

/**
 初始化SDK:
 设置app广告的通用配置，注意调用该接口之后才能去加载广告
 注意:如果想判断当前网络环境是否是欧盟国家，请调用setConfig:andInitSDKFinishBlock:
 @param adConfig 广告配置
 */
+(void)setConfig:(ZZAdConfig*_Nonnull)adConfig;

+(ZZAdConfig*_Nullable)currentConfig;

/**
 授权GDPR协议:SDK可以获取部分的设备信息;默认是授权的
 注意:如果要调用该方法，该方法的调用一定要放在方法+setConfig:之前
 */
+(void)grantConsentForGDPR;

/**
 拒绝授权GDPR协议:SDK不可以获取部分的设备信息;默认是授权的
 注意:如果要调用该方法，该方法的调用一定要放在方法+setConfig:之前
 */
+(void)revokeConsentForGDPR;

+(void)closeConsole;

+(void)enableConsole;


@end
