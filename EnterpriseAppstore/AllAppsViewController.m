//
//  AllAppsViewController.m
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/8.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "AllAppsViewController.h"

@interface AllAppsViewController () <WebRequestManagerDelegate>
@property (nonatomic, strong) WebRequestManager *manager;

@end

@implementation AllAppsViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.manager getAppCateList];
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
    
}

#pragma mark - Getters and Setters
- (WebRequestManager *)manager {
    if (!_manager) {
        _manager = [[WebRequestManager alloc] init];
        _manager.delegate = self;
    }
    return _manager;
}

@end
