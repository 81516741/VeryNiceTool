//
//  TextView.h
//  宫格布局
//
//  Created by ld on 16/9/8.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextView : UIView

+(void)showIn:(UIView *)desView models:(NSArray *)models itemH:(CGFloat)itemH col:(NSInteger)col startY:(CGFloat)startY itemClick:(void(^)(NSInteger index))itemClick;
//这个是模型暂时用string占位
@property (nonatomic,strong) NSString * model;
@end
