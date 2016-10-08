//
//  ViewController.m
//  TGSDKSampleApp
//
//  Created by SunHan on 9/7/15.
//  Copyright (c) 2015 SoulGame. All rights reserved.
//

#import "TGSDKViewController.h"
#import "TGSDK.h"
#import "SpinnerView.h"
#import "CPADViewController.h"

@interface TGSDKViewController () <UITextFieldDelegate, TGPreloadADDelegate, TGRewardVideoADDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textInput;
@property (weak, nonatomic) IBOutlet UITextField *sceneInput;
@property (weak, nonatomic) SpinnerView *sceneSpinner;

@end

@implementation TGSDKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSceneSpinner:[[SpinnerView alloc] initWithFrame:CGRectMake(20, 190, 200, 100)]];
    [self sceneSpinner].textField.placeholder = @"Click PreloadAd Please";
    [[self view] addSubview:[self sceneSpinner]];
    
    [TGSDK setDebugModel:YES];
    
    [TGSDK initialize:@"sampleapp" callback:^(BOOL success, id tag, NSDictionary *result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showAlert:@"TGSDK init finished" message:@"TGSDK init finished"];
        });
    }];
    [TGSDK setADDelegate:self];
    [TGSDK setRewardVideoADDelegate:self];
    self.textInput.text = @"tguser";
    self.textInput.delegate = self;
    //[TGSDK initSDK:@"app001ios" publisherID:@"1024" channelID:@"2048"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onPlatformRegister:(id)sender {
    [TGSDK userPlatformRegister:self.textInput.text
                       password:@"1"
                            tag:@"sdk_test_platformRegister"
                       callBack:^(BOOL success, id tag, NSDictionary* result){
                           if(success){
                               [self showAlert:@"TGRegister" message:[NSString stringWithFormat:@"user id:%@", result[@"id"]]];
                           }else{
                               [self showAlert:@"TGRegister" message:[NSString stringWithFormat:@"fail:%@", result[kTGSDKServiceResultErrorInfo]]];
                           }
    }];
}


- (IBAction)onPlatformLogin:(id)sender {
    [TGSDK userPlatformLogin:self.textInput.text
                    password:@"1"
                         tag:@"sdk_test_platformLogin"
                    callBack:^(BOOL success, id tag, NSDictionary* result){
                        if(success){
                            [self showAlert:@"TGLogin" message:[NSString stringWithFormat:@"user id:%@", result[@"id"]]];
                        }else{
                            [self showAlert:@"TGLogin" message:[NSString stringWithFormat:@"fail:%@", result[kTGSDKServiceResultErrorInfo]]];
                        }
                    }];
}



- (IBAction)onPartnerBind:(id)sender {
    [TGSDK userPartnerBind:self.textInput.text
                    partner:@"default"
                        tag:@"sdk_test_partnerRegister"
                   callBack:^(BOOL success, id tag, NSDictionary* result){
                       if(success){
                           [self showAlert:@"3rdBind" message:[NSString stringWithFormat:@"user id:%@", result[@"id"]]];
                       }else{
                           [self showAlert:@"3rdBind" message:[NSString stringWithFormat:@"fail:%@", result[kTGSDKServiceResultErrorInfo]]];
                       }
                   }];
}

- (IBAction)onPreloadAd:(id)sender {
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        [TGSDK preloadAd:self];
        return;
    }
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"预加载广告" message:@"需要只在 WiFi 环境才加载广告吗？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"只在 WiFi 时" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [TGSDK preloadAdOnlyWIFI:self];
    }];
    [alert addAction:yesAction];
    UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"无所谓" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [TGSDK preloadAd:self];
    }];
    [alert addAction:noAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self presentedViewController] == nil) {
            [self presentViewController:alert animated:YES completion:nil];
        }
    });
}

- (IBAction)onShowAd:(id)sender {
    NSString *sceneid = [[self sceneSpinner] textField].text;
    if (!sceneid || [sceneid length] == 0) {
        sceneid = [[self textInput] text];
    }
    if ([TGSDK couldShowAd:sceneid]) {
        if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
            [TGSDK showAd:sceneid];
            return;
        }
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"播放广告" message:[NSString stringWithFormat:@"确定要播放广告【%@】吗？", sceneid] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString* cpImagePath = [TGSDK getCPImagePath:sceneid];
            if (cpImagePath) {
                UIAlertController* cpAlert = [UIAlertController alertControllerWithTitle:@"CP 广告" message:[NSString stringWithFormat:@"手动播放还是自动播放？"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* tgsdkPlayAction = [UIAlertAction actionWithTitle:@"自动播放" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [TGSDK showAd:sceneid];
                }];
                [cpAlert addAction:tgsdkPlayAction];
                UIAlertAction* cpPlayAction = [UIAlertAction actionWithTitle:@"手动播放" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    CPADViewController *cpView = [[CPADViewController alloc] initWithScene:sceneid];
                    [cpView setStatusBarHidden:[[UIApplication sharedApplication] isStatusBarHidden]];
                    [[UIApplication sharedApplication] setStatusBarHidden:YES];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if ([self presentedViewController] == nil) {
                            [TGSDK showCPView:sceneid];
                            [self presentViewController:cpView animated: YES completion:nil];
                        }
                    });
                }];
                [cpAlert addAction:cpPlayAction];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([self presentedViewController] == nil) {
                        [self presentViewController:cpAlert animated:YES completion:nil];
                    }
                });
            } else {
                [TGSDK showAd:sceneid];
            }
        }];
        [alert addAction:yesAction];
        UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [TGSDK reportAdRejected:sceneid];
        }];
        [alert addAction:noAction];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self presentedViewController] == nil) {
                [self presentViewController:alert animated:YES completion:nil];
            }
        });
    } else {
        [self showAlert:@"showAd" message:@"[TGSDK couldShowAd return false"];
    }
}

- (void)showAlert:(NSString*)title message:(NSString*)message {
    [self showLog:title message:message];
    if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        return;
    }
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    dispatch_async(dispatch_get_main_queue(), ^(){
        if ([self presentedViewController] == nil) {
            [self presentViewController:alert animated:YES completion:nil];
        }
    });
}

- (void)showLog:(NSString*)title message:(NSString*)message {
    NSLog(@"[showLog] %@ : %@", title, message);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void) onPreloadSuccess:(NSString*)result
{
    [self showAlert:@"onPreloadSuccess" message:[NSString stringWithFormat:@"%@ preload success", (result?result:@"nil")]];
    if (result && [result length] > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *sceneArray = [result componentsSeparatedByString:@","];
            [[self sceneSpinner] setTableArray:sceneArray];
            [[[self sceneSpinner] textField] setPlaceholder:@"Select a Scene ID"];
            [[self sceneSpinner] refresh];
            for (NSString* sid in sceneArray) {
                [TGSDK showAdScene:sid];
            }
        });
    }
}

- (void) onPreloadFailed:(NSString*)result WithError:(NSString*) error
{
    [self showAlert:@"onPreloadFailed" message:@"onPreloadFailed"];
}

- (void) onCPADLoaded:(NSString *)result
{
    [self showLog:@"onCPADLoaded" message:result];
}

- (void) onVideoADLoaded:(NSString *)result
{
    [self showLog:@"onVedioADLoaded" message:result];
}


- (void) onShowSuccess:(NSString*)result
{
    [self showLog:@"onShowSuccess" message:@"onShowSuccess"];
}

- (void) onShowFailed:(NSString*)result WithError:(NSString*) error
{
    [self showAlert:@"onShowFailed" message:@"onShowFailed"];
}

- (void) onADComplete:(NSString*)result {
    [self showLog:@"onADComplete" message:result];
}

- (void) onADClick:(NSString*)result
{
    [self showLog:@"onADClick" message:@"onADClick"];
}

- (void) onADClose:(NSString*)result
{
    [TGSDK showAdScene:[[self sceneSpinner] textField].text];
    [self showLog:@"onADClose" message:@"onADClose"];
}

- (void) onADAwardSuccess:(NSString*)result
{
    [self showAlert:@"onADAwardSuccess" message:@"onADAwardSuccess"];
}

- (void) onADAwardFailed:(NSString*)result WithError:(NSError *)error
{
    [self showAlert:@"onADAwardFailed" message:@"onADAwardFailed"];
}

@end
