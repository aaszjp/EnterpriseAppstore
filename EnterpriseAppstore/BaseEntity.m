//
//  BaseEntity.m
//  GAMECO
//
//  Created by hegaokun on 15/6/12.
//  Copyright (c) 2015年 cn.edu.ustc. All rights reserved.
//

#import "BaseEntity.h"
#import <objc/runtime.h>

@implementation BaseEntity

- (instancetype)initWithNode:(XmlNode*) node {
    if (!node || node == nil) {
        return nil;
    }
    self = [super init];
    if (!self || self == nil) {
        return nil;
    }
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++) {
        const char *property = property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithCString:property encoding:NSUTF8StringEncoding];
        NSRange range = [propertyName rangeOfString:@"Height"];
        if (range.location == NSNotFound) {
            id value = [node getNodeValue:propertyName] ? [node getNodeValue:propertyName] : @"";
            [self setValue:value forKey:propertyName];
        }
    }
    return self;
}

- (NSString *)description {
    NSString *str = [NSString stringWithFormat:@"%@ = ", NSStringFromClass([self class])];
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++) {
        const char *property = property_getName(properties[i]);
        NSString *propertyName = [NSString stringWithCString:property encoding:NSUTF8StringEncoding];
        str = [str stringByAppendingFormat:@"%@:%@", propertyName, [self valueForKey:propertyName]];
        str = (i < count - 1) ? [str stringByAppendingString:@", "] : str;
    }
    
    return str;
}

@end
