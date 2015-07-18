//
//  AppCategoryEntity.h
//  EnterpriseAppstore
//
//  Created by hegaokun on 15/7/17.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "BaseEntity.h"

@interface AppCategoryEntity : BaseEntity

@property (nonatomic, copy) NSString *cateid;   //分类编号
@property (nonatomic, copy) NSString *name;     //分类名称

@end
