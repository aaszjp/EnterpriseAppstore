//
//  BaseViewController.h
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/9.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WebRequestManager.h"

@interface BaseViewController : UIViewController

@property (nonatomic, weak) AppDelegate *appDelegate;

/**
 *  显示加载hud
 *
 *  @param loadingText 加载提示语
 */
- (void)startUILoadingWithLoadingText:(NSString *)loadingText;

/**
 *  结束加载hud
 */
- (void)endUILoading;

/**
 *  以hud方式进行消息提示
 *
 *  @param msg 消息
 */
- (void)showHudMessage:(NSString *)msg;

/**
 *  以alert方式进行消息提示
 *
 *  @param msg 消息
 */
- (void)showAlertMessage:(NSString *)msg;

@end
