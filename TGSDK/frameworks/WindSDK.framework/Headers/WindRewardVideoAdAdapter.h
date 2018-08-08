//
//  WindRewardVideoAdAdapter.h
//  WindSDK
//
//  Created by happyelements on 2018/4/9.
//  Copyright © 2018 Codi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WindRewardVideoAdConnector;

// Your adapter must conform to this protocol to provide reward based video ads.
@protocol WindRewardVideoAdAdapter<NSObject>

- (instancetype)initWithWADRewardVideoAdConnector:(id<WindRewardVideoAdConnector>)connector;

- (void)setup;

- (void)loadAd;

- (void)presentRewardVideoAdWithViewController:(UIViewController *)controller options:(NSDictionary *)options error:(NSError * _Nullable __autoreleasing *)error;

@end




