//
//  LoginCustomTextField.h
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/9.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginCustomTextField : UIView

@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL secureTextEntry;

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName placeHolder:(NSString *)placeHolder;

@end
