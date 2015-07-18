//
//  BaseTabBarController.m
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/9.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

#pragma mark - Life Cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.tabBar.tintColor = [UIColor colorWithHex:@"#3FDFCB"];
        self.tabBar.barTintColor = [UIColor whiteColor];
        self.viewControllers = [self createViewControllersWithTitles:@[@"安全桌面", @"所有应用", @"管理", @"设置"] viewControllers:@[@"SecureDesktopViewController", @"AllAppsViewController", @"ManageViewController", @"SettingViewController"] icons:@[@"ico_home.png", @"ico_APP.png", @"ico_menage.png", @"ico_set.png"]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    BaseNavigationController *baseNavi = self.viewControllers[2];
    baseNavi.tabBarItem.badgeValue = @"6";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method
- (NSArray *)createViewControllersWithTitles:(NSArray *)titles viewControllers:(NSArray *)viewControllers icons:(NSArray *)icons {
    NSMutableArray *vcs = [NSMutableArray array];
    for (int i = 0; i < titles.count; i ++) {
        BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:[[NSClassFromString(viewControllers[i]) alloc] init]];
        navi.tabBarItem = [[UITabBarItem alloc] initWithTitle:titles[i] image:[UIImage imageNamed:icons[i]] tag:i];
        [vcs addObject:navi];
    }
    return [vcs copy];
}

@end
