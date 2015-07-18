//
//  SettingViewController.m
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/8.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "SettingViewController.h"

static const CGFloat SettingHeaderViewHeight = 100.0;
static const CGFloat SettingHeadPortraitsSpace = 18.0;
static const CGFloat SettingUserNameLabelSpace = 10.0;
static const CGFloat SettingUserNameLabelWidth = 200.0;
static const CGFloat SettingUserNameLabelHeight = 20.0;
static const CGFloat SettingTableViewSectionSpace = 4.0;
static NSString * const SettingCellID = @"SettingCellID";

@interface SettingViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation SettingViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegates 
#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingCellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:FontMaxSize];
    switch (indexPath.section) {
        case 0: {
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"update.png"];
                cell.textLabel.text = @"检查更新";
            } else if (indexPath.row == 1) {
                cell.imageView.image = [UIImage imageNamed:@"about.png"];
                cell.textLabel.text = @"关于我们";
            }
        }
            break;
        case 1: {
            if (indexPath.row == 0) {
                cell.imageView.image = [UIImage imageNamed:@"phone.png"];
                cell.textLabel.text = @"帮助";
            } else if (indexPath.row == 1) {
                cell.imageView.image = [UIImage imageNamed:@"test.png"];
                cell.textLabel.text = @"意见反馈";
            }
        }
            break;
        case 2: {
            cell.imageView.image = [UIImage imageNamed:@"logout.png"];
            cell.textLabel.text = @"退出登录";
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section ? SettingTableViewSectionSpace : 2 * SettingTableViewSectionSpace;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return SettingTableViewSectionSpace;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            if (indexPath.row == 0) {
            } else if (indexPath.row == 1) {
            }
        }
            break;
        case 1: {
            if (indexPath.row == 0) {
            } else if (indexPath.row == 1) {
            }
        }
            break;
        case 2: {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"真的退出？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
        }
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud removeObjectForKey:kToken];
        [ud synchronize];
        [self.appDelegate gotoLoginVC];
    }
}

#pragma mark - Private Method

#pragma mark - Getters and Setters
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.topLayoutGuide.length, ScreenWidth, SettingHeaderViewHeight)];
        _headerView.backgroundColor = [UIColor whiteColor];
        //背景
        UIImageView *bgIV = [[UIImageView alloc] initWithFrame:_headerView.bounds];
        bgIV.image = [UIImage imageNamed:@"bluebg.png"];
        [_headerView addSubview:bgIV];
        //头像
        UIImage *headPortraitsImage = [UIImage imageNamed:@"head.png"];
        CGFloat X = SettingHeadPortraitsSpace;
        CGFloat Y = SettingHeaderViewHeight - SettingHeadPortraitsSpace - headPortraitsImage.size.height;
        UIImageView *headIV = [[UIImageView alloc] initWithFrame:CGRectMake(X, Y, headPortraitsImage.size.width, headPortraitsImage.size.height)];
        headIV.image = headPortraitsImage;
        [_headerView addSubview:headIV];
        //用户名
        X += headPortraitsImage.size.width + SettingUserNameLabelSpace;
        Y = CGRectGetMidY(headIV.frame) - SettingUserNameLabelHeight / 2;
        UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(X, Y, SettingUserNameLabelWidth, SettingUserNameLabelHeight)];
        userNameLabel.text = @"Baymax";
        userNameLabel.textAlignment = NSTextAlignmentLeft;
        userNameLabel.font = [UIFont systemFontOfSize:FontMaxSize];
        userNameLabel.textColor = [UIColor whiteColor];
        [_headerView addSubview:userNameLabel];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.topLayoutGuide.length + SettingHeaderViewHeight, ScreenWidth, ScreenHeight - self.topLayoutGuide.length - SettingHeaderViewHeight - self.bottomLayoutGuide.length) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor colorWithHex:@"#F2F2F2"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SettingCellID];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

@end
