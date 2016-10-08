//
//  CPADViewController.m
//  TGSDKSampleApp
//
//  Created by 李寅 on 16/1/19.
//  Copyright © 2016年 soulgame. All rights reserved.
//

#import "CPADViewController.h"
#import "TGSDK/TGSDK.h"

@implementation CPADViewController

- (id) initWithScene:(NSString *)scene
{
    self = [super init];
    [self setCpScene:scene];
    [self setCpImagePath:[TGSDK getCPImagePath:scene]];
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return YES; //返回NO表示要显示，返回YES将hiden
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationMaskPortrait);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (void)viewDidLoad
{
    [self setNeedsStatusBarAppearanceUpdate];
    CGRect rect = [[self view] frame];
    float rw = CGRectGetWidth(rect);
    //    float rh = CGRectGetHeight(rect);
    NSData *imageData = [NSData dataWithContentsOfFile:[self cpImagePath]];
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    UIImageView* iv = [[UIImageView alloc] initWithImage:image];
    //    CGSize is = [image size];
    //    float x,y,w,h;
    //    if (is.width > rw) {
    //        x = 0;
    //        w = rw;
    //    } else {
    //        x = (rw - is.width)/2;
    //        w = is.width;
    //    }
    //    if (is.height > rh) {
    //        y = 0;
    //        h = rh;
    //    } else {
    //        y = (rh - is.height)/2;
    //        h = is.height;
    //    }
    //    [iv setFrame:CGRectMake(x, y, w, h)];
    [iv setFrame:rect];
    [iv setContentMode:UIViewContentModeScaleToFill];
    [iv setUserInteractionEnabled:YES];
    UITapGestureRecognizer* ivTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onADClick)];
    [iv addGestureRecognizer:ivTap];
    [[self view] addSubview:iv];
    
    UIButton* closeBtn = [[UIButton alloc] init];
    [closeBtn setFrame:CGRectMake(
                                  rw-50,
                                  10,
                                  40, 40)];
    [closeBtn setBackgroundColor:[UIColor blackColor]];
    [[closeBtn layer] setOpacity:0.8];
    [[closeBtn layer] setMasksToBounds:YES];
    [[closeBtn layer] setCornerRadius:20];
    [[closeBtn titleLabel] setFont:[UIFont systemFontOfSize:32]];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeBtn setTitle:@"X" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(onCloseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:closeBtn];
}

- (void)close
{
    [[UIApplication sharedApplication] setStatusBarHidden:[self statusBarHidden]];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)onCloseButtonClick
{
    [TGSDK reportCPClose:[self cpScene]];
    [self close];
}

- (void)onADClick
{
    [TGSDK reportCPClick:[self cpScene]];
    [self close];
}

@end
