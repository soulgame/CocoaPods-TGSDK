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

@interface TGSDKViewController () <UITextFieldDelegate, TGPreloadADDelegate, TGADDelegate, TGRewardVideoADDelegate, TGBannerADDelegate>

@property (weak, nonatomic) IBOutlet UITextField *sceneInput;
@property (weak, nonatomic) SpinnerView *sceneSpinner;
@property (strong, nonatomic) NSMutableDictionary *sceneMap;

@end

@implementation TGSDKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setSceneSpinner:[[SpinnerView alloc] initWithFrame:CGRectMake(20, 52, 200, 100)]];
    [self sceneSpinner].textField.placeholder = @"Click PreloadAd Please";
    [[self view] addSubview:[self sceneSpinner]];
    
    [TGSDK setDebugModel:YES];
    [TGSDK initialize:@"hP7287256x5z1572E5n7" callback:^(BOOL success, id tag, NSDictionary *result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showLog:@"TGSDK init finished" message:@"TGSDK init finished"];
        });
    }];
    
    [TGSDK setBanner:@"banner0" Config:TGBannerLarge
                   x:0 y:self.view.frame.size.height-110
               width:self.view.frame.size.width height:90 Interval:30];
    [TGSDK setBanner:@"banner1" Config:TGBannerLarge
                   x:0 y:self.view.frame.size.height-220
               width:self.view.frame.size.width height:90 Interval:30];
    [TGSDK setBanner:@"banner2" Config:TGBannerLarge
                   x:0 y:self.view.frame.size.height-330
               width:self.view.frame.size.width height:90 Interval:30];
    
    [TGSDK setADDelegate:self];
    [TGSDK setRewardVideoADDelegate:self];
    [TGSDK setBannerDelegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSString *sceneid = [[self sceneMap] objectForKey:[[self sceneSpinner] textField].text];
    if ([TGSDK couldShowAd:sceneid]) {
        if ([[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
            [TGSDK showAd:sceneid];
            return;
        }
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"播放广告" message:[NSString stringWithFormat:@"确定要播放广告【%@】吗？", sceneid] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
                [TGSDK showAd:sceneid];

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
- (IBAction)onShowTestView:(id)sender {
    NSString *sceneid = [[self sceneMap] objectForKey:[[self sceneSpinner] textField].text];
    [TGSDK showTestView:sceneid];
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
- (IBAction)closeBanner:(id)sender {
    NSString *sceneid = [[self sceneMap] objectForKey:[[self sceneSpinner] textField].text];
    [TGSDK closeBanner:sceneid];
}
    
- (void)showLog:(NSString*)title message:(NSString*)message {
    NSLog(@"[showLog] %@ : %@", title, message);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

    
    
    
// ------------------------ TGPreloadADDelegate ------------------------
- (void) onPreloadSuccess:(NSString*)result
{
    [self showAlert:@"onPreloadSuccess" message:[NSString stringWithFormat:@"%@ preload success", (result?result:@"nil")]];
    if (result && [result length] > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *sceneArray = [result componentsSeparatedByString:@","];
            [self setSceneMap:[NSMutableDictionary dictionaryWithCapacity:[sceneArray count]]];
            for (NSString* sid in sceneArray) {
                [TGSDK showAdScene:sid];
                [[self sceneMap] setObject:sid
                                    forKey:[NSString stringWithFormat:@"%@(%@)", [TGSDK getSceneNameById:sid], [sid substringToIndex:4]]];
            }
            [[self sceneSpinner] setTableArray:[[self sceneMap] allKeys]];
            [[[self sceneSpinner] textField] setPlaceholder:@"Select a Scene ID"];
            [[self sceneSpinner] refresh];
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


    
    
// ------------------------ TGADDelegate ------------------------
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

    
// ------------------------ TGRewardVideoADDelegate ------------------------
- (void) onADAwardSuccess:(NSString*)result
{
    [self showAlert:@"onADAwardSuccess" message:@"onADAwardSuccess"];
}

- (void) onADAwardFailed:(NSString*)result WithError:(NSError *)error
{
    [self showAlert:@"onADAwardFailed" message:@"onADAwardFailed"];
}
    
    
// ------------------------ TGBannerADDelegate ------------------------
- (void) onBanner:(NSString* _Nonnull)scene Loaded:(NSString* _Nonnull)result {
    [self showLog:[NSString stringWithFormat:@"onBanner: %@ Loaded", scene] message:scene];
    
}
    
- (void) onBanner:(NSString* _Nonnull)scene Failed:(NSString* _Nonnull)result WithError:(NSError* _Nullable)error {
    [self showAlert:[NSString stringWithFormat:@"onBanner: %@ Failed", scene]
            message:[NSString stringWithFormat: @"You could call [TGSDK closeBanner:@\"%@\"]; to close banner and retry to show banner AD again", scene]];
}
    
- (void) onBanner:(NSString* _Nonnull)scene Click:(NSString* _Nonnull)result {
    [self showLog:[NSString stringWithFormat:@"onBanner: %@ Click", scene] message:scene];
}
    
- (void) onBanner:(NSString* _Nonnull)scene Close:(NSString* _Nonnull)result {
    [self showLog:[NSString stringWithFormat:@"onBanner: %@ Close", scene] message:result];
}


@end
