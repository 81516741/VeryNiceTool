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
 */
+(instancetype)configSubItemsIn:(UIView *)desView count:(NSInteger)count col:(NSInteger)col itemH:(CGFloat)itemH startY:(CGFloat)startY fetchItemAtIndex:(UIView * (^)(NSInteger index))fetchItemAtIndex;
@end
