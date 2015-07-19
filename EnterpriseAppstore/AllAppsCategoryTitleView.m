//
//  AllAppsCategoryTitleView.m
//  EnterpriseAppstore
//
//  Created by 甄健鹏 on 15/7/19.
//  Copyright (c) 2015年 AAS. All rights reserved.
//

#import "AllAppsCategoryTitleView.h"


//箭头指示图
@interface IndicatorView : UIView

@property (nonatomic, strong) UIImageView *indicatorIV;

@end

@implementation IndicatorView {
    CGFloat _imageWidth;
    CGFloat _imageHeight;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:@"#3692FC"];
        UIImage *image = [UIImage imageNamed:@"sanj.png"];
        _imageWidth = image.size.width;
        _imageHeight = image.size.height;
        CGFloat X = frame.size.width / 2 - _imageWidth / 2;
        CGFloat Y = frame.size.height - _imageHeight;
        self.indicatorIV = [[UIImageView alloc] initWithFrame:CGRectMake(X, Y, _imageWidth, _imageHeight)];
        self.indicatorIV.image = image;
        [self addSubview:self.indicatorIV];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    CGRect indicatorFrame = self.indicatorIV.frame;
    indicatorFrame.origin.x = frame.size.width / 2 - _imageWidth / 2;
    indicatorFrame.origin.y = frame.size.height - _imageHeight;
    self.indicatorIV.frame = indicatorFrame;
}

@end




static const NSInteger DefaultMaxVisibleTitles = 5;
static const CGFloat DefaultTitleLabelWidth = 60.0;
static const CGFloat AnimationDuration = 0.25;

@interface AllAppsCategoryTitleView () {
    CGFloat _titleLabelWidth;
    CGFloat _centerLabelHorizontalSpace;//按钮显示在屏幕中间时，距离屏幕左边缘的距离
}

@property (nonatomic, strong) IndicatorView *indicator;
@property (nonatomic, strong) NSMutableArray *titleLabels;
@property (nonatomic, strong) UILabel *defaultLabel;

@end

@implementation AllAppsCategoryTitleView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:@"#3692FC"];
        self.indicator = [[IndicatorView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.indicator];
        self.defaultLabel = [self createTitleLabelWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) title:@"全部"];
        self.defaultLabel.tag = 0;
        [self.titleLabels addObject:self.defaultLabel];
        [self addSubview:self.defaultLabel];
        [self setContentSize:CGSizeMake(frame.size.width, frame.size.height)];
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

#pragma mark - Event Response

#pragma mark - Public Methods
- (void)setSelectedIndex:(NSInteger)index {
    CGRect frame = self.indicator.frame;
    frame.origin.x = index * _titleLabelWidth;
    [UIView animateWithDuration:AnimationDuration animations:^{
        self.indicator.frame = frame;
    }];
    /**
     *  算法：当前的title横坐标大于中间值，滑动后是否到达右边界，是则不滑动，否则滑动到中间值
     *       当前的title横坐标小于中间值，直接滑动到左边界
     */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(AnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (frame.origin.x > _centerLabelHorizontalSpace) {
            CGFloat deltaX = MIN(frame.origin.x - _centerLabelHorizontalSpace, (self.titles.count + 1) * _titleLabelWidth - ScreenWidth);
            [UIView animateWithDuration:AnimationDuration animations:^{
                self.contentOffset = CGPointMake(deltaX, 0);
            }];
        }
        else {
            [UIView animateWithDuration:AnimationDuration animations:^{
                self.contentOffset = CGPointMake(0, 0);
            }];
        }
    });
}

#pragma mark - Private Methods 
- (UILabel *)createTitleLabelWithFrame:(CGRect)frame title:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    [label setBackgroundColor:[UIColor clearColor]];
    label.text = title;
    label.font = [UIFont systemFontOfSize:FontMidSize];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
    [label addGestureRecognizer:tap];
    label.userInteractionEnabled = YES;
    return label;
}

- (void)labelTap:(UITapGestureRecognizer *)tapGR {
    UILabel *label = (UILabel *)tapGR.view;
    [self setSelectedIndex:label.tag];
}

#pragma mark - Getters and Setters
- (NSMutableArray *)titleLabels {
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (void)setTitles:(NSArray *)titles {
    if (_titles != titles) {
        _titles = titles;
    }
    _titleLabelWidth = _titles.count + 1 > DefaultMaxVisibleTitles ? DefaultTitleLabelWidth : ScreenWidth / (_titles.count + 1);
    _centerLabelHorizontalSpace = (ScreenWidth - _titleLabelWidth) / 2;
    CGFloat h = self.defaultLabel.bounds.size.height;
    for (int i = 0; i < _titles.count + 1; i ++) {
        if (i == 0) {
            CGRect frame = self.defaultLabel.frame;
            frame.size.width = _titleLabelWidth;
            self.defaultLabel.frame = frame;
            self.indicator.frame = frame;
        }
        else {
            UILabel *label = [self createTitleLabelWithFrame:CGRectMake(i * _titleLabelWidth, 0, _titleLabelWidth, h) title:_titles[i - 1]];
            label.tag = i;
            [self.titleLabels addObject:label];
            [self addSubview:label];
        }
    }
    self.contentSize = CGSizeMake((_titles.count + 1) * _titleLabelWidth, h);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
