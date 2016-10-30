//
//  LDGridView.m
//  宫格布局
//
//  Created by ld on 16/9/8.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LDGridView.h"

@implementation LDGridView

+(instancetype)configSubItemsIn:(UIView *)desView count:(NSInteger)count col:(NSInteger)col itemH:(CGFloat)itemH margin:(CGFloat)margin startY:(CGFloat)startY fetchItemAtIndex:(UIView * (^)(NSInteger index))fetchItemAtIndex
{
    NSInteger rowCount = (count-1)/col + 1;
    CGFloat itemW= (desView.frame.size.width - (col - 1) * margin)/col ;
    itemH = itemH > 0 ? itemH : itemW;
    CGFloat contentHeight = (margin + itemH) * rowCount - margin;
    LDGridView * gridView = [[LDGridView alloc]initWithFrame:CGRectMake(0, startY, desView.bounds.size.width,contentHeight)];
    [desView addSubview:gridView];
    for (int i=0; i<count; i++) {
        int tmpRow = i/col;
        int tmpColum = i%col;
        CGRect itemFrame = CGRectMake(tmpColum * (itemW + margin), tmpRow * (itemH + margin), itemW, itemH);
        if (fetchItemAtIndex) {
            UIView *sView = fetchItemAtIndex(i);
            if (sView) {
                sView.frame = itemFrame;
                [gridView addSubview:sView];
            }
        }
    }
    gridView.contentHeight = contentHeight;
    return gridView;
}

@end
