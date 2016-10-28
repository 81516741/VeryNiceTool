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
 * 布局子视图
 * 如果给itemH赋值0，则item 长 宽 相等
 */
+(instancetype)configSubItemsIn:(UIView *)desView count:(NSInteger)count col:(NSInteger)col itemH:(CGFloat)itemH margin:(CGFloat)margin startY:(CGFloat)startY fetchItemAtIndex:(UIView * (^)(NSInteger index))fetchItemAtIndex;
/**
 * 自身高度
 */
@property (assign ,nonatomic) CGFloat contentHeight;

@end
