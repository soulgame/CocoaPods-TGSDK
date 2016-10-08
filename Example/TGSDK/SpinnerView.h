//
//  SpinnerView.h
//  TGSDK
//
//  Created by 李寅 on 15/12/16.
//  Copyright © 2015年 SoulGame. All rights reserved.
//

#ifndef SpinnerView_h
#define SpinnerView_h

#import <UIKit/UIKit.h>

@interface SpinnerView : UIView <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *tv;
@property (nonatomic,strong) NSArray *tableArray;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic) BOOL showList;
@property (nonatomic) CGFloat tabheight;
@property (nonatomic) CGFloat frameHeight;

- (void) refresh;

@end

#endif /* SpinnerView_h */
