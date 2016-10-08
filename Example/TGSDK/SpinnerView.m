//
//  SpinnerView.m
//  TGSDK
//
//  Created by 李寅 on 15/12/16.
//  Copyright © 2015年 SoulGame. All rights reserved.
//

#import "SpinnerView.h"

@implementation SpinnerView

-(id)initWithFrame:(CGRect)frame
{
    if (frame.size.height < 200) {
        [self setFrameHeight:200];
    }else{
        [self setFrameHeight:frame.size.height];
    }
    [self setTabheight:[self frameHeight] - 30];
    
    frame.size.height = 30.0f;
    
    self=[super initWithFrame:frame];
    
    if(self){
        [self setShowList:NO]; //默认不显示下拉框
        
        [self setTv:[[UITableView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 0)]];
        [self tv].delegate = self;
        [self tv].dataSource = self;
        [self tv].backgroundColor = [UIColor grayColor];
        [self tv].separatorColor = [UIColor lightGrayColor];
        [self tv].hidden = YES;
        [self addSubview:[self tv]];
        
        [self setTextField:[[UITextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)]];
        [[self textField] setDelegate:self];
        [self textField].borderStyle=UITextBorderStyleRoundedRect;//设置文本框的边框风格
        [[self textField] addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventAllTouchEvents];
        [self addSubview:[self textField]];
        
    }
    return self;
}


-(void)dropdown{
    [[self textField] resignFirstResponder];
    if ([self showList] || [[self tableArray] count] == 0) {//如果下拉框已显示，什么都不做
        return;
    }else {//如果下拉框尚未显示，则进行显示
        
        CGRect sf = self.frame;
        sf.size.height = [self frameHeight];
        
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        [self tv].hidden = NO;
        [self setShowList:YES];//显示下拉框
        
        CGRect frame = [self tv].frame;
        frame.size.height = 0;
        [self tv].frame = frame;
        frame.size.height = [self tabheight];
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        [self tv].frame = frame;
        [UIView commitAnimations];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self tableArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[self tableArray] objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self textField].text = [[self tableArray] objectAtIndex:[indexPath row]];
    [self setShowList:NO];
    [self tv].hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = [self tv].frame;
    frame.size.height = 0;
    [self tv].frame = frame;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}


- (void)refresh
{
    [[self tv] reloadData];
}

@end
