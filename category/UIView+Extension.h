//
//  UIView+Extension.h
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

//------------------修改获取view尺寸的----------------------
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (assign ,nonatomic) CGFloat trail;//尾部
@property (assign ,nonatomic) CGFloat bottom;
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
//------------------修改获取view尺寸的----------------------


/**
 *  显示小红点
 *
 *  @param index               view里面的需要显示小红点item的位置
 *  @param itemCount           view里面的需要显示小红点item的个数
 *  @param centerXOffsetInItem view里面的需要显示小红点item的偏离中心位置x的偏移量
 *  @param yOffsetInItem       view里面的需要显示小红点item的偏离顶部位置y的偏移量
 */
- (void)showBadgeInItemAtIndex:(NSUInteger)index itemCount:(NSUInteger)itemCount centerXOffsetInItem:(CGFloat)centerXOffsetInItem yOffsetInItem:(CGFloat)yOffsetInItem;
//隐藏小红点
- (void)hideBadgeFromItemAtIndex:(NSUInteger)index;

/**
 添加target对像,监听点击事件
 */
-(void)addTarget:(id)target sel:(SEL)sel;

@end
