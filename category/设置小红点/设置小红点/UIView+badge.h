//
//  UIView+badge.h
//  设置小红点
//
//  Created by ld on 16/9/9.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (badge)

@property (nonatomic,copy) NSString * badgeNo;
@property (nonatomic,strong) NSNumber * radius;

//显示 和 隐藏badge
-(void)show:(NSInteger)badgeNo radius:(CGFloat)radius;


@end

@interface HRBadgeView : UIView
@end
