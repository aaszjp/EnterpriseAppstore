//
//  LoginViewController.m
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/9.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginCustomTextField.h"

static const CGFloat LoginBackgroundViewTopSpace = 20.0;
static const CGFloat LoginTextFieldHorizontalSpace = 20.0;
static const CGFloat LoginTextFieldVerticalSpace = 10.0;
static const CGFloat LoginTextFieldTopSpace = 30.0;
static const CGFloat LoginLoginButtonVerticalSpace = 43.0;
static const CGFloat LoginForgotButtonVerticalSpace = 19.0;
static const CGFloat LoginForgotButtonWidth = 80.0;
static const CGFloat LoginForgotButtonHeight = 40.0;
extern const CGFloat LoginCustomTextField_TotalHeight;

@interface LoginViewController () <WebRequestManagerDelegate>
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) LoginCustomTextField *userNameTF;
@property (nonatomic, strong) LoginCustomTextField *passwordTF;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgotBtn;
@property (nonatomic, strong) WebRequestManager *manager;
@end

@implementation LoginViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate
#pragma mark - WebRequestManagerDelegate
- (void)webRequestManager:(WebRequestManager *)manager didFinishedWebRequestWithResponseObj:(id)response andType:(WebRequestType)type {
    if (type == WebRequestTypeLogin) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self endUILoading];
            [self showHudMessage:@"登录成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.appDelegate gotoHomeVC];
            });
        });
    }
}

- (void)webRequestManager:(WebRequestManager *)manager didFailedWebRequestWithMessage:(NSString *)message andType:(WebRequestType)type {
    if (type == WebRequestTypeLogin) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self endUILoading];
            [self showHudMessage:message];
        });
    }
}

#pragma mark - Private Method
- (void)initUI {
    //白色背景
    [self.view addSubview:self.bgView];
    //用户名
    [self.bgView addSubview:self.userNameTF];
    //密码
    [self.bgView addSubview:self.passwordTF];
    //登录
    [self.bgView addSubview:self.loginBtn];
    //忘记密码
    [self.bgView addSubview:self.forgotBtn];
}

#pragma mark - Event Response
- (void)tap:(UITapGestureRecognizer *)tapGR {
    [tapGR.view endEditing:YES];
}

- (void)loginBtnClicked:(UIButton *)button {
    [self.bgView endEditing:YES];
    if ([self.userNameTF.text isEqualToString:@""]) {
        [self showHudMessage:@"请填写用户名"];
        return;
    }
    if ([self.passwordTF.text isEqualToString:@""]) {
        [self showHudMessage:@"请填写密码"];
        return;
    }
    [self startUILoadingWithLoadingText:@"正在登陆..."];
    [self.manager loginWithUserName:self.userNameTF.text password:self.passwordTF.text];
}

- (void)forgotBtnClicked:(UIButton *)button {
    NSLog(@"forgotBtnClicked");
}

#pragma mark - Getters and Setters
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, LoginBackgroundViewTopSpace, ScreenWidth, ScreenHeight - LoginBackgroundViewTopSpace)];
        _bgView.backgroundColor = [UIColor whiteColor];
        //点击手势
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [_bgView addGestureRecognizer:tapGR];
    }
    return _bgView;
}

- (LoginCustomTextField *)userNameTF {
    if (!_userNameTF) {
        _userNameTF = [[LoginCustomTextField alloc] initWithFrame:CGRectMake(LoginTextFieldHorizontalSpace, LoginTextFieldTopSpace, ScreenWidth - 2 * LoginTextFieldHorizontalSpace, LoginCustomTextField_TotalHeight) imageName:@"ico_user.png" placeHolder:@"用户名"];
    }
    return _userNameTF;
}

- (LoginCustomTextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = [[LoginCustomTextField alloc] initWithFrame:CGRectMake(LoginTextFieldHorizontalSpace, LoginTextFieldTopSpace + LoginCustomTextField_TotalHeight + LoginTextFieldVerticalSpace, ScreenWidth - 2 * LoginTextFieldHorizontalSpace, LoginCustomTextField_TotalHeight) imageName:@"ico_password.png" placeHolder:@"密码"];
        _passwordTF.secureTextEntry = YES;
    }
    return _passwordTF;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        UIImage *loginImage = [UIImage imageNamed:@"btn_signup.png"];
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - loginImage.size.width) / 2, self.passwordTF.frame.origin.y + self.passwordTF.frame.size.height + LoginLoginButtonVerticalSpace, loginImage.size.width, loginImage.size.height)];
        [_loginBtn setBackgroundImage:loginImage forState:UIControlStateNormal];
        [_loginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (UIButton *)forgotBtn {
    if (!_forgotBtn) {
        CGFloat X = CGRectGetMaxX(self.loginBtn.frame) - LoginForgotButtonWidth;
        CGFloat Y = CGRectGetMaxY(self.loginBtn.frame) + LoginForgotButtonVerticalSpace;
        _forgotBtn = [[UIButton alloc] initWithFrame:CGRectMake(X, Y, LoginForgotButtonWidth, LoginForgotButtonHeight)];
        [_forgotBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        _forgotBtn.titleLabel.font = [UIFont systemFontOfSize:FontMidSize];
        _forgotBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_forgotBtn setTitleColor:[UIColor colorWithHex:@"#4D85E1"] forState:UIControlStateNormal];
        [_forgotBtn addTarget:self action:@selector(forgotBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgotBtn;
}

- (WebRequestManager *)manager {
    if (!_manager) {
        _manager = [[WebRequestManager alloc] init];
        _manager.delegate = self;
    }
    return _manager;
}

@end
