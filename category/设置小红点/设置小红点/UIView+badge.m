//
//  UIView+badge.m
//  设置小红点
//
//  Created by ld on 16/9/9.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "UIView+badge.h"
#import <objc/runtime.h>

#define BADGE_RADIUS 9
static NSString * kBadgeViewKey = @"kBadgeViewKey";

@implementation UIView (badge)

-(void)setBadgeNo:(NSString *)badgeNo
{
    objc_setAssociatedObject(self,@selector(badgeNo), badgeNo, OBJC_ASSOCIATION_COPY_NONATOMIC);
    HRBadgeView * badgeView;
    if (!(badgeView = objc_getAssociatedObject(self, &kBadgeViewKey))) {
        badgeView = [[HRBadgeView alloc]initWithFrame:CGRectMake(self.bounds.size.width-25, -25, 50, 50)];
        badgeView.backgroundColor = [UIColor clearColor];
        [self addSubview:badgeView];
         objc_setAssociatedObject(self,&kBadgeViewKey, badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [badgeView setNeedsDisplay];
}

-(NSString *)badgeNo
{
   return objc_getAssociatedObject(self, _cmd);
}

@end

@implementation HRBadgeView

//画badge提示红点和数字
-(void)drawRect:(CGRect)rect
{
    NSString * badgeNo = self.superview.badgeNo;
    if (!badgeNo || badgeNo.integerValue <= 0) return;
    if (badgeNo.intValue < 10 && badgeNo.intValue > 0 ) {
        UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.size.width * 0.5 - BADGE_RADIUS, rect.size.height * 0.5 - BADGE_RADIUS, BADGE_RADIUS * 2, BADGE_RADIUS * 2)];
        [[UIColor redColor]setFill];
        [path fill];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
        [badgeNo drawAtPoint:CGPointMake(rect.size.width * 0.5 - 4.5, rect.size.height * 0.5 - 9) withAttributes:dic];
    }else if (badgeNo.intValue > 10 && badgeNo.intValue < 100){
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.size.width * 0.5 - BADGE_RADIUS - 5, rect.size.height * 0.5 - BADGE_RADIUS, BADGE_RADIUS * 2 + 10, BADGE_RADIUS * 2) cornerRadius:BADGE_RADIUS];
        [[UIColor redColor]setFill];
        [path fill];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
        [badgeNo drawAtPoint:CGPointMake(rect.size.width * 0.5 - 8, rect.size.height * 0.5 - 9) withAttributes:dic];
        
    }else{
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.size.width * 0.5 - BADGE_RADIUS - 5, rect.size.height * 0.5 - BADGE_RADIUS, BADGE_RADIUS * 2 + 10, BADGE_RADIUS * 2) cornerRadius:BADGE_RADIUS];
        [[UIColor redColor]setFill];
        [path fill];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[NSFontAttributeName] = [UIFont systemFontOfSize:14];
        dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
        [@"99+" drawAtPoint:CGPointMake(rect.size.width * 0.5 - 12, rect.size.height * 0.5 - 9) withAttributes:dic];
    }
}

@end
