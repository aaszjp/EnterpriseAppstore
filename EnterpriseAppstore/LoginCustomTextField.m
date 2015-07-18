//
//  LoginCustomTextField.m
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/9.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "LoginCustomTextField.h"

const CGFloat LoginCustomTextField_TotalHeight = 44.0;
static const CGFloat LoginCustomTextField_Space = 5.0;

@interface LoginCustomTextField ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation LoginCustomTextField

@dynamic text;
@dynamic secureTextEntry;

#pragma mark - Life Cycle

#pragma mark - Public Method
- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName placeHolder:(NSString *)placeHolder {
    self = [super initWithFrame:frame];
    if (self) {
        //图标
        self.imageView = [self imageViewWithImage:[UIImage imageNamed:imageName]];
        [self addSubview:self.imageView];
        //输入框
        self.textField = [self textFieldWithFrame:CGRectMake(self.imageView.frame.origin.x + self.imageView.frame.size.width + LoginCustomTextField_Space, 0, frame.size.width - (self.imageView.frame.origin.x + self.imageView.frame.size.width + LoginCustomTextField_Space), LoginCustomTextField_TotalHeight) placeHolder:placeHolder];
        [self addSubview:self.textField];
        //下划线
        [self addLineAtBottom];
    }
    return self;
}

#pragma mark - Private Method
- (UIImageView *)imageViewWithImage:(UIImage *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(LoginCustomTextField_Space, CGRectGetMidY(self.bounds) - image.size.height / 2, image.size.width, image.size.height)];
    imageView.image = image;
    return imageView;
}

- (UITextField *)textFieldWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder{
    UITextField *tf = [[UITextField alloc] initWithFrame:frame];
    tf.font = [UIFont systemFontOfSize:FontMaxSize];
    tf.placeholder = placeHolder;
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return tf;
}

- (void)addLineAtBottom {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithHex:@"#E0E0E0"];
    [self addSubview:lineView];
}

#pragma mark - Getters and Setters
- (NSString *)text {
    return self.textField.text;
}

- (void)setText:(NSString *)text {
    self.textField.text = text;
}

- (BOOL)secureTextEntry {
    return self.textField.secureTextEntry;
}

- (void)setSecureTextEntry:(BOOL)secureTextEntry {
    self.textField.secureTextEntry = secureTextEntry;
}

@end
