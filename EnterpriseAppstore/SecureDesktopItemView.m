//
//  SecureDesktopItemView.m
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/15.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "SecureDesktopItemView.h"

static const CGFloat SecureDesktopContentWidth = 60.0;
static const CGFloat SecureDesktopLabelHeight = 20.0;

@interface SecureDesktopItemView ()
@property (nonatomic, strong) UIButton *appIconBtn;
@property (nonatomic, strong) UILabel *appNameLabel;
@end

@implementation SecureDesktopItemView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        [self addSubview:self.appNameLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.appIconBtn.frame = CGRectMake(0, 0, SecureDesktopContentWidth, SecureDesktopContentWidth);
    self.appNameLabel.frame = CGRectMake(0, 0, SecureDesktopContentWidth, SecureDesktopLabelHeight);
}

#pragma mark - Event Response
- (void)appClicked {
    
}

#pragma mark - Getters and Setters
- (UIButton *)appIconBtn {
    if (!_appIconBtn) {
        _appIconBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_appIconBtn addTarget:self action:@selector(appClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appIconBtn;
}

- (UILabel *)appNameLabel {
    if (!_appNameLabel) {
        _appNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _appNameLabel.textAlignment = NSTextAlignmentCenter;
        _appNameLabel.font = [UIFont systemFontOfSize:FontMinSize];
        _appNameLabel.backgroundColor = [UIColor clearColor];
        _appNameLabel.textColor = [UIColor blackColor];
        _appNameLabel.text = @"微信";
    }
    return _appNameLabel;
}

@end
