//
//  ParamAdapter.m
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/13.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "ParamAdapter.h"
#import "NSDictionary+JsonString.h"
#import "NSString+Extension.h"

@implementation ParamAdapter

+ (NSString *)adaptLoginRequestParamsWithUserName:(NSString *)userName password:(NSString *)password {
    NSDictionary *paramDic = @{@"username":userName,
                               @"password":password,
                               @"ostype":@"iOS"
                               };
    NSString *paramStr = [paramDic convertToJsonString];
    paramStr = [@"json=" stringByAppendingString:paramStr];
    return [NSString stringWithFormat:@"username=%@&password=%@&ostype=%@", userName, password, @"iOS"];
}

+ (NSString *)adaptAppCateListParams {
    NSTimeInterval t = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString *timestamp = [NSString stringWithFormat:@"%ld", (long)t];
    NSArray *array = @[timestamp, [[NSUserDefaults standardUserDefaults] objectForKey:kToken]];
    NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
    NSString *sortedStr = [sortedArray componentsJoinedByString:@""];
    NSString *signature = [sortedStr sha1String];
    NSDictionary *paramDic = @{@"timestamp":timestamp,
                               @"signature":signature,
                               @"userid":[[NSUserDefaults standardUserDefaults] objectForKey:kUserID],
                               };
    NSString *paramStr = [paramDic convertToJsonString];
    return [@"json=" stringByAppendingString:paramStr];
}

@end
