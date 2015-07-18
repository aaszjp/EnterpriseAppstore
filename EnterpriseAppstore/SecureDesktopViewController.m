//
//  SecureDesktopViewController.m
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/8.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "SecureDesktopViewController.h"
#import "SecureDesktopItemView.h"

static NSString * const cellID = @"cellID";
static const NSInteger SecureDesktopRowNumber = 3;
static const NSInteger SecureDesktopColumnNumber = 4;
static const CGFloat SecureDesktopItemSizeHeight = 110.0;

@interface SecureDesktopViewController ()
@property (nonatomic, strong) NSArray *installedApps;
@property (nonatomic, strong) UIImageView *bgiv;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation SecureDesktopViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"已安装应用";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.bgiv];
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate

#pragma mark - Private Method
- (void)initItemWithDataSource:(NSArray *)dataSource {
}

#pragma mark - Getters and Setters
- (UIImageView *)bgiv {
    if (!_bgiv) {
        _bgiv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.png"]];
        _bgiv.frame = self.view.bounds;
    }
    return _bgiv;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 70, ScreenWidth, SecureDesktopItemSizeHeight * SecureDesktopColumnNumber)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

@end
