//
//  LDGridView.m
//  宫格布局
//
//  Created by ld on 16/9/8.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LDGridView.h"

@implementation LDGridView

- (void)configItemsByItemCount:(NSInteger)itemcount column:(NSInteger)col itemHeight:(CGFloat)itemHeight fetchItemAtIndex:(UIView * (^)(NSInteger index))fetchItemAtIndex
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat itemW= (self.frame.size.width - (col - 1) * self.itemMargin)/col ;
    itemHeight = itemHeight > 0 ? itemHeight : itemW;
    for (int i=0; i<itemcount; i++) {
        int tmpRow = i/col;
        int tmpColum = i%col;
        CGRect itemFrame = CGRectMake(tmpColum * (itemW + self.itemMargin), tmpRow * (itemHeight + self.itemMargin), itemW, itemHeight);
        if (fetchItemAtIndex) {
            UIView *sView = fetchItemAtIndex(i);
            if (sView) {
                sView.frame = itemFrame;
                [self addSubview:sView];
            }
        }
    }
    NSInteger rowCount = (itemcount-1)/col + 1;
    self.gridViewHeight = rowCount * (itemHeight + self.itemMargin) - self.itemMargin;
}

@end
