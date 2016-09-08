//
//  LDGridView.m
//  宫格布局
//
//  Created by ld on 16/9/8.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LDGridView.h"

@implementation LDGridView

+(instancetype)configSubItemsIn:(UIView *)desView count:(NSInteger)count col:(NSInteger)col itemH:(CGFloat)itemH startY:(CGFloat)startY fetchItemAtIndex:(UIView * (^)(NSInteger index))fetchItemAtIndex
{
    LDGridView * gridView = [[LDGridView alloc]initWithFrame:CGRectMake(0, startY, [UIScreen mainScreen].bounds.size.width, itemH *(count + (col-1)/col))];
    [desView addSubview:gridView];
    CGFloat itemW= gridView.frame.size.width/col;
    for (int i=0; i<count; i++) {
        int tmpRow = i/col;
        int tmpColum = i%col;
        CGRect itemFrame = CGRectMake(tmpColum * itemW, tmpRow * itemH, itemW, itemH);
        if (fetchItemAtIndex) {
            UIView *sView = fetchItemAtIndex(i);
            if (sView) {
                sView.frame = itemFrame;
                [gridView addSubview:sView];
            }
        }
    }
    return gridView;
}

@end
