//
//  CPADViewController.h
//  TGSDKSampleApp
//
//  Created by 李寅 on 16/1/19.
//  Copyright © 2016年 soulgame. All rights reserved.
//

#ifndef CPADViewController_h
#define CPADViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CPADViewController : UIViewController

@property(nonatomic) BOOL statusBarHidden;
@property (nonatomic, strong) NSString* cpImagePath;
@property (nonatomic, strong) NSString* cpScene;

- (id) initWithScene:(NSString*) scene;

@end

#endif /* CPADViewController_h */
