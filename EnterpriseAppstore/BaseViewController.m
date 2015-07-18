//
//  BaseViewController.m
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/9.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "BaseViewController.h"
#import <MBProgressHUD.h>

@interface BaseViewController ()
@property (nonatomic, strong) MBProgressHUD *loadingHud;
@end

@implementation BaseViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:@"#3692FC"];
    self.appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Parent Method
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - Public Method
- (void)startUILoadingWithLoadingText:(NSString *)loadingText {
    self.loadingHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.loadingHud.mode = MBProgressHUDModeIndeterminate;
    self.loadingHud.labelText = loadingText;
    self.loadingHud.removeFromSuperViewOnHide = YES;
}

- (void)endUILoading {
    [self.loadingHud hide:YES];
    self.loadingHud = nil;
}

- (void)showHudMessage:(NSString *)msg {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}

- (void)showAlertMessage:(NSString *)msg {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [av show];
}

#pragma mark - Getters and Setters


@end
