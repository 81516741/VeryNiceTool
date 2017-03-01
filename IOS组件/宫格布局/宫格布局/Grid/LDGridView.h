//
//  LDGridView.h
//  宫格布局
//
//  Created by ld on 16/9/8.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDGridView : UIView


/**
 布局宫格
 @param itemcount        总的item的个数
 @param col              宫格有多少列
 @param itemHeight       每个宫格的高度 值<=0 则item的宽高相等
 @param fetchItemAtIndex 获取item
 */
- (void)configItemsByItemCount:(NSInteger)itemcount column:(NSInteger)col itemHeight:(CGFloat)itemHeight fetchItemAtIndex:(UIView * (^)(NSInteger index))fetchItemAtIndex;

/**
 相邻item之间的距离，需在布局宫格方法之前设置
 */
@property (assign ,nonatomic) CGFloat itemMargin;

/**
 总的高度，需在布局宫格方法之后才会有值
 */
@property (assign ,nonatomic) CGFloat gridViewHeight;

@end
