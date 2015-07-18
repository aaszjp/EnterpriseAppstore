//
//  NSString+Extension.m
//  EMM
//
//  Created by hegaokun on 15/5/13.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

#pragma mark - sha1加密
- (NSString *)sha1String {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSString *)base64String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *output = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return output;
}

- (NSString *)decodeBase64String {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *output = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return output;
}

- (NSString *)cleanString {
    NSString *output = [self stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    output = [output stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    output = [output stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    output = [output stringByReplacingOccurrencesOfString:@" " withString:@""];
    return output;
}

#pragma mark - 将Json字符串转换成字典
- (NSDictionary *)convertFromJsonStringToDictionary {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if (error) {
        NSLog(@"Error occurred when jsonData convert to dictionary : %@", [error localizedDescription]);
        return nil;
    }
    return dic;
}

@end
