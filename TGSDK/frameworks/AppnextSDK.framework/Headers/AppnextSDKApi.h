//
//  AppnextSDKApi.h
//  AppnextLib
//
//  Created by Eran Mausner on 10/01/2016.
//  Copyright © 2016 Appnext. All rights reserved.
//

@interface AppnextSDKApi : NSObject

#pragma mark - Class methods

/**
 *  Get the version of this library/framework
 *
 *  @return
 */
+ (NSString *) getSDKVersion;

/**
 *  Get the API started get common resourses. This should be called at the start of the application's AppDelegate
 *  in the application:didFinishLaunchingWithOptions: function.
 *
 *  @return
 */
+ (void) startSDKApi;

@end
