//
//  BaseEntity.h
//  GAMECO
//
//  Created by hegaokun on 15/6/12.
//  Copyright (c) 2015年 cn.edu.ustc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XmlNode.h"
#import "XmlResolve.h"

@interface BaseEntity : NSObject

- (instancetype)initWithNode:(XmlNode*) node;

@end
