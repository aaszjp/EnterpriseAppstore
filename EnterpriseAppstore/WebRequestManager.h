//
//  WebRequestManager.h
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/13.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WebRequestType) {
    WebRequestTypeLogin,
    WebRequestTypeAppCateList
};

@class WebRequestManager;

@protocol WebRequestManagerDelegate <NSObject>
@required
- (void)webRequestManager:(WebRequestManager *)manager didFinishedWebRequestWithResponseObj:(id)response andType:(WebRequestType)type;
- (void)webRequestManager:(WebRequestManager *)manager didFailedWebRequestWithMessage:(NSString *)message andType:(WebRequestType)type;

@end

@interface WebRequestManager : NSObject

@property (nonatomic, weak) id <WebRequestManagerDelegate> delegate;

//登录
- (void)loginWithUserName:(NSString *)userName password:(NSString *)password;

//应用分类
- (void)getAppCateList;

@end
