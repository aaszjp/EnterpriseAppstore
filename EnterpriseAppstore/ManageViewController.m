//
//  ManageViewController.m
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/9.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "ManageViewController.h"

static const CGFloat ManageSegmentedControlTopSpace = 40.0;
static const CGFloat ManageSegmentedControlLeftSpace = 30.0;
static const CGFloat ManageSegmentedControlHeight = 30.0;

@interface ManageViewController ()
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *mainSV;
@end

@implementation ManageViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.segmentedControl];
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

#pragma mark - Getters and Setters
- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"可更新", @"卸载"]];
        _segmentedControl.frame = CGRectMake(ManageSegmentedControlLeftSpace, ManageSegmentedControlTopSpace, ScreenWidth - 2 * ManageSegmentedControlLeftSpace, ManageSegmentedControlHeight);
        _segmentedControl.tintColor = [UIColor whiteColor];
        _segmentedControl.selectedSegmentIndex = 0;
    }
    return _segmentedControl;
}


@end
