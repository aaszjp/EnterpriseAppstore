//
//  NSDictionary+JsonString.m
//  EMM
//
//  Created by hegaokun on 15/5/12.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "NSDictionary+JsonString.h"

@implementation NSDictionary (JsonString)

#pragma mark - 将字典转换成Json字符串
- (NSString *)convertToJsonString {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"Error occurred when dictionary convert to data : %@", [error localizedDescription]);
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end
