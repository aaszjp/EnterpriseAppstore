//
//  AllAppsViewController.m
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/8.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "AllAppsViewController.h"
#import "AllAppsCategoryTitleView.h"

static const CGFloat AllAppsTitleViewY = 20.0;
static const CGFloat AllAppsTitleViewHeight = 45.0;

@interface AllAppsViewController () <WebRequestManagerDelegate>
@property (nonatomic, strong) WebRequestManager *manager;
@property (nonatomic, strong) AllAppsCategoryTitleView *titleView;
@property (nonatomic, assign) NSInteger         currentPage;
@end

@implementation AllAppsViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.manager getAppCateList];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.titleView];
    [self addTestBtn];
}

#pragma mark - 测试按钮
- (void)addTestBtn {
    CGFloat X = 100;
    CGFloat Y = 200;
    CGFloat W = 100;
    CGFloat H = 25;
    UIButton *b1 = [[UIButton alloc] initWithFrame:CGRectMake(X, Y, W, H)];
    [b1 setTitle:@"初始化" forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(testBtn:) forControlEvents:UIControlEventTouchUpInside];
    b1.tag = 1;
    [self.view addSubview:b1];
    Y += H;
    UIButton *b2 = [[UIButton alloc] initWithFrame:CGRectMake(X, Y, W, H)];
    [b2 setTitle:@"上一页" forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(testBtn:) forControlEvents:UIControlEventTouchUpInside];
    b2.tag = 2;
    [self.view addSubview:b2];
    Y += H;
    UIButton *b3 = [[UIButton alloc] initWithFrame:CGRectMake(X, Y, W, H)];
    [b3 setTitle:@"下一页" forState:UIControlStateNormal];
    [b3 addTarget:self action:@selector(testBtn:) forControlEvents:UIControlEventTouchUpInside];
    b3.tag = 3;
    [self.view addSubview:b3];
    
}

- (void)testBtn:(UIButton *)button {
    switch (button.tag) {
        case 1:
            self.titleView.titles = @[@"聊天", @"社交", @"影音", @"生活", @"阅读", @"理财", @"新闻", @"工具"];
            break;
        case 2: {
            self.currentPage -= 1;
            [self.titleView setSelectedIndex:self.currentPage];
            break;
        }
        case 3: {
            self.currentPage += 1;
            [self.titleView setSelectedIndex:self.currentPage];
            break;
        }
            
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegates
#pragma mark - WebRequestManagerDelegate
- (void)webRequestManager:(WebRequestManager *)manager didFinishedWebRequestWithResponseObj:(id)response andType:(WebRequestType)type {
    
}

- (void)webRequestManager:(WebRequestManager *)manager didFailedWebRequestWithMessage:(NSString *)message andType:(WebRequestType)type {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (type == WebRequestTypeAppCateList) {
            [self showHudMessage:message];
        }
    });
}

#pragma mark - Getters and Setters
- (WebRequestManager *)manager {
    if (!_manager) {
        _manager = [[WebRequestManager alloc] init];
        _manager.delegate = self;
    }
    return _manager;
}

- (AllAppsCategoryTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[AllAppsCategoryTitleView alloc] initWithFrame:CGRectMake(0, AllAppsTitleViewY, ScreenWidth, AllAppsTitleViewHeight)];
        self.currentPage = 0;
    }
    return _titleView;
}

@end
