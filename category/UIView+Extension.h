//
//  UIView+Extension.h
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

- (CGFloat)maxX;

-(CGFloat)maxY;

- (CGFloat)minX;

-(CGFloat)minY;

- (void)showBadgeInItemAtIndex:(NSUInteger)index itemCount:(NSUInteger)itemCount centerXOffsetInItem:(CGFloat)centerXOffsetInItem yOffsetInItem:(CGFloat)yOffsetInItem;   //显示小红点

- (void)hideBadgeFromItemAtIndex:(NSUInteger)index; //隐藏小红点

@end
