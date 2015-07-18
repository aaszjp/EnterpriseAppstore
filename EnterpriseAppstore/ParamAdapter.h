//
//  ParamAdapter.h
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/13.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParamAdapter : NSObject

+ (NSString *)adaptLoginRequestParamsWithUserName:(NSString *)userName password:(NSString *)password;

+ (NSString *)adaptAppCateListParams;

@end
