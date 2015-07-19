//
//  AllAppsCategoryTitleView.h
//  EnterpriseAppstore
//
//  Created by 甄健鹏 on 15/7/19.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AllAppsCategoryTitleView;

@protocol AllAppsCategoryTitleViewDelegate <NSObject>

- (void)allAppsCategoryTitleView:(AllAppsCategoryTitleView *)allAppsCategoryTitleView didSelectItemAtIndex:(NSInteger)index;

@end

@interface AllAppsCategoryTitleView : UIScrollView

@property (nonatomic, weak) id <AllAppsCategoryTitleViewDelegate> ctvDelegate;
@property (nonatomic, strong) NSArray *titles;

- (void)setSelectedIndex:(NSInteger)index;

@end
