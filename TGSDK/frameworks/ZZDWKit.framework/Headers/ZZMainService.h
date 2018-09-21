//
//  ZZMainService.h
//  ZZDWKit
//
//  Created by xuhuize on 2018/3/13.
//  Copyright © 2018年 至真. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZMainService : NSObject

+(instancetype)defaultService;
//wifi状态下IO速度阀值,单位kb/s
@property(nonatomic)float IOWifiSpeedDif;
//wwan状态下IO速度阀值,单位kb/s
@property(nonatomic)float IOWwanSpeedDif;
//wifi状态下DW速度阀值,单位kb/s
@property(nonatomic)float DWWifiSpeedDif;
//wwan状态下DW速度阀值,单位kb/s
@property(nonatomic)float DWWwanSpeedDif;

/**
 开启服务
 */
-(void)start;

/**
 关闭服务
 */
-(void)stop;

+(NSString*)notificationName;

@end
