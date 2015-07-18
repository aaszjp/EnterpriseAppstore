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

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (!self || self == nil) {
        return nil;
    }
    /**
     *  kvc方式，默认
     */
    [self setValuesForKeysWithDictionary:dictionary];

    /**
     *  runtime方式，可以用来处理特殊key、value的情况
     */
//    unsigned int count;
//    objc_property_t *properties = class_copyPropertyList([self class], &count);
//    for (int i = 0; i < count; i ++) {
//        const char *property = property_getName(properties[i]);
//        NSString *propertyName = [NSString stringWithCString:property encoding:NSUTF8StringEncoding];
//        [self setValue:[dictionary objectForKey:propertyName] forKey:propertyName];
//    }
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
