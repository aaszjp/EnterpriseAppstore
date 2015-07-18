//
//  NSString+Extension.h
//  EMM
//
//  Created by hegaokun on 15/5/13.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSString *)sha1String;
- (NSString *)base64String;
- (NSString *)decodeBase64String;
- (NSString *)cleanString;
- (NSDictionary *)convertFromJsonStringToDictionary;

@end
