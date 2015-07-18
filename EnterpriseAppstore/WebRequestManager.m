//
//  WebRequestManager.m
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/13.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "WebRequestManager.h"
#import "ParamAdapter.h"


typedef void(^ Succeed)(NSData *data);
typedef void(^ Failure)(NSError *error);


@implementation WebRequestManager

- (void)startRequestWithMethod:(NSString *)methodName forAPI:(NSString *)APIName withParams:(NSString *)params succeed:(Succeed)succeed failure:(Failure)failure {
    NSString *urlStr = [BaseServerUrl stringByAppendingString:APIName];
    NSMutableURLRequest *request;
    if ([methodName isEqualToString:@"GET"]) {
        if ([params isEqualToString:@""]) {
            request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        } else {
            request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@", urlStr, params]]];
        }
    } else if ([methodName isEqualToString:@"POST"]) {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [request setHTTPMethod:methodName];
        [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    } else {
        NSLog(@"请求方法错误！");
        return;
    }
    NSLog(@"url : %@, param : %@", urlStr, params);
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            failure(error);
        } else {
            succeed(data);
        }
    }];
    [dataTask resume];
}

- (void)loginWithUserName:(NSString *)userName password:(NSString *)password {
    NSString *paramStr = [ParamAdapter adaptLoginRequestParamsWithUserName:userName password:password];
    [self startRequestWithMethod:@"GET" forAPI:APINameLogin withParams:paramStr
      succeed:^(NSData *data) {
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"resultDic = %@", resultDic);
        if ([[resultDic objectForKey:@"code"] isEqualToNumber:@(-1)]) {
            //服务器返回失败信息
            NSLog(@"WebRequestTypeLogin_failed : %@", [resultDic objectForKey:@"message"]);
            [self.delegate webRequestManager:self didFailedWebRequestWithMessage:[resultDic objectForKey:@"message"] andType:WebRequestTypeLogin];
        } else if ([[resultDic objectForKey:@"code"] isEqualToNumber:@(0)]) {
            //请求成功
            NSLog(@"WebRequestTypeLogin_succeed");
            NSDictionary *dataDic = [resultDic objectForKey:@"data"];
            NSString *userid = [dataDic objectForKey:@"userid"];
            NSString *token = [dataDic objectForKey:@"token"];
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:userid forKey:kUserID];
            [ud setObject:token forKey:kToken];
            [ud synchronize];
            [self.delegate webRequestManager:self didFinishedWebRequestWithResponseObj:nil andType:WebRequestTypeLogin];
        }
    } failure:^(NSError *error) {
        //网络请求错误信息
        NSLog(@"WebRequestTypeLogin_error = %@", error);
        [self.delegate webRequestManager:self didFailedWebRequestWithMessage:[error localizedDescription] andType:WebRequestTypeLogin];
    }];
}

- (void)getAppCateList {
    NSString *paramStr = [ParamAdapter adaptAppCateListParams];
    [self startRequestWithMethod:@"POST" forAPI:APINameAppCateList withParams:paramStr
      succeed:^(NSData *data) {
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"resultDic = %@", resultDic);
        if ([[resultDic objectForKey:@"code"] isEqualToNumber:@(-1)]) {
            //服务器返回失败信息
            NSLog(@"WebRequestTypeAppCateList_failed : %@", [resultDic objectForKey:@"message"]);
            [self.delegate webRequestManager:self didFailedWebRequestWithMessage:[resultDic objectForKey:@"message"] andType:WebRequestTypeAppCateList];
        } else if ([[resultDic objectForKey:@"code"] isEqualToNumber:@(0)]) {
            //请求成功
            NSLog(@"WebRequestTypeAppCateList_succeed");
            
            [self.delegate webRequestManager:self didFinishedWebRequestWithResponseObj:nil andType:WebRequestTypeAppCateList];
        }
    } failure:^(NSError *error) {
        //网络请求错误信息
        NSLog(@"WebRequestTypeAppCateList_error = %@", error);
        [self.delegate webRequestManager:self didFailedWebRequestWithMessage:[error localizedDescription] andType:WebRequestTypeAppCateList];
    }];
}

@end
