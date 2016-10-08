//
//  TGSDK.h
//  TGSDK
//
//  Created by SunHan on 9/7/15.
//  Copyright (c) 2015 SoulGame. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTGSDKServiceResultErrorInfo @"kTGSDKServiceResultErrorInfo"
typedef void (^TGSDKServiceResultCallBack)(BOOL success, id tag, NSDictionary* result);

typedef enum {
    TGAdPlatformTG,
}TGAdPlatform;

typedef enum {
    TGAdTypeNone,
    TGAdTypeCP,
    TGAdType3rdCP,
    TGAdType3rdPop,
    TGAdType3rdVideo,
    TGADType3rdAward,
    TGAdType3rdNative
}TGAdType;


@protocol TGPreloadADDelegate <NSObject>
@optional
- (void) onPreloadSuccess:(NSString*)result;

- (void) onPreloadFailed:(NSString*)result WithError:(NSError*) error;

- (void) onCPADLoaded:(NSString*) result;

- (void) onVideoADLoaded:(NSString*) result;

@end


@protocol TGADDelegate <NSObject>
@optional
- (void) onShowSuccess:(NSString*)result;

- (void) onShowFailed:(NSString*)result WithError:(NSError*)error;

- (void) onADComplete:(NSString*)result;

- (void) onADClick:(NSString*)result;

- (void) onADClose:(NSString*)result;

@end


@protocol TGRewardVideoADDelegate <TGADDelegate>
@optional
- (void) onADAwardSuccess:(NSString*)result;

- (void) onADAwardFailed:(NSString*)result WithError:(NSError*)error;

@end


@interface TGSDK : NSObject

@property (strong, nonatomic, readonly) NSString *appID;
@property (strong, nonatomic, readonly) NSString *publisherID;
@property (strong, nonatomic, readonly) NSString *channelID;
@property (strong, nonatomic, readonly) NSString *udid;
@property (strong, nonatomic, readonly) NSString *tgid;
@property (strong, nonatomic, readonly) NSString *userRegisterDate;
@property (nonatomic, readonly) BOOL debugEnv;
@property (nonatomic) BOOL enableLog;

+(TGSDK*)sharedInstance;

//初始化函数
+ (void) setDebugModel:(BOOL)debug;

+ (void) initSDK:(NSString*)appid
       channelID:(NSString*)channelid
        callback:(TGSDKServiceResultCallBack)cb;

+(void)initSDK:(NSString*)appID
    publisherID:(NSString*)publisherID
      channelID:(NSString*)channelID
       useCurl:(BOOL)useCurl
     plistPath:(NSString*)plistPath
      callBack:(TGSDKServiceResultCallBack)cb __attribute__((deprecated));

//缺省参数初始化函数
+(void)initSDK:(TGSDKServiceResultCallBack)cb __attribute__((deprecated));

//指定 plist 文件路径的初始化函数
+(void)initSDK:(NSString*)plist
      callBack:(TGSDKServiceResultCallBack)cb __attribute__((deprecated));

+(void)setSDKConfig:(NSString*)val forKey:(NSString*)key;
+(NSString*)getSDKConfig:(NSString*)key;

//平台注册
+(void)userPlatformRegister:(NSString*)userName
                   password:(NSString*)userPassword
                        tag:(id)tag
                   callBack:(TGSDKServiceResultCallBack)cb;

//第三方注册
+(void)userPartnerRegister:(NSString*)puid
                   partner:(NSString*)partner
                       tag:(id)tag
                  callBack:(TGSDKServiceResultCallBack)cb __attribute__((deprecated));

//默认注册 － 暂时不能使用
//+(void)userDefaultRegister:(id)tag callBack:(TGSDKServiceResultCallBack)cb;

//平台登陆
+(void)userPlatformLogin:(NSString*)userName
                password:(NSString*)userPassword
                     tag:(id)tag
                   callBack:(TGSDKServiceResultCallBack)cb;

//第三方登陆
+(void)userPartnerLogin:(NSString*)puid
                partner:(NSString*)partner
                    tag:(id)tag
               callBack:(TGSDKServiceResultCallBack)cb __attribute__((deprecated));

//第三方绑定
//就是登录和注册的合体版本
+(void)userPartnerBind:(NSString*)puid
               partner:(NSString*)partner
                   tag:(id)tag
              callBack:(TGSDKServiceResultCallBack)cb;

/**************************   广告相关  ******************************/

/*游戏在启动、登陆完成后，调用预加载接口进行广告的预加载*/
+(int) isWIFI;
+(void) preloadAd:(id<TGPreloadADDelegate>) delegate;
+(void) preloadAdOnlyWIFI:(id<TGPreloadADDelegate>)delegate;

+(BOOL)couldShowAd:(NSString*)scene;

/*当开始给用户显示广告的时候调用，返回值如果是NSString，则是预加载没有完成或者没有调用预加载，如果返回值是NSData，则是图片的数据。同时发送counter cp_adview*/
+(void)setADDelegate:(id<TGADDelegate>)delegate;
+(void)setRewardVideoADDelegate:(id<TGRewardVideoADDelegate>)delegate;
+(void)showAd: (NSString*)scene;
+(void)reportAdRejected:(NSString*)sceneId;
+(void)showAdScene:(NSString*)scene;

+(NSString*)getCPImagePath:(NSString*)scene;
+(void)showCPView:(NSString*)scene;
+(void)reportCPClick:(NSString*)scene;
+(void)reportCPClose:(NSString*)scene;

/**************************   数据追踪  ******************************/
+ (void)sendCounter:(NSString*)name metaData:(NSDictionary*)md;
+ (void)sendCounter:(NSString*)name metaDataJson:(NSString*)mdJson;
+ (void)paymentCounter:(nonnull NSString*)productId
           WithMethod:(nullable NSString*)method
      AndTransactionId:(nullable NSString*)trans
           AndCurrency:(nullable NSString*)currency
              AndPrice:(float)price
           AndQuantity:(int)quantity
             AndAmount:(float)amount
        AndGoodsAmount:(int)goodsAmount;

@end
