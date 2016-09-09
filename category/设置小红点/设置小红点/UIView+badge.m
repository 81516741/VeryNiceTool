//
//  UIView+badge.m
//  设置小红点
//
//  Created by ld on 16/9/9.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "UIView+badge.h"
#import <objc/runtime.h>

static NSString * kBadgeViewKey = @"kBadgeViewKey";

@implementation UIView (badge)


-(void)show:(NSString *)badgeNo radius:(CGFloat)radius
{
    self.badgeNo = badgeNo;
    self.radius = @(radius);
    HRBadgeView * badgeView;
    if (!(badgeView = objc_getAssociatedObject(self, @selector(show:radius:)))) {
        badgeView = [[HRBadgeView alloc]initWithFrame:CGRectMake(self.bounds.size.width-25, -25, 50, 50)];
        badgeView.backgroundColor = [UIColor clearColor];
        [self addSubview:badgeView];
        objc_setAssociatedObject(self,@selector(show:radius:), badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [badgeView setNeedsDisplay];
}

-(void)hideBadgeNo
{
    [self show:nil radius:0];
}

-(void)setBadgeNo:(NSString *)badgeNo
{
    objc_setAssociatedObject(self,@selector(badgeNo), badgeNo, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)badgeNo
{
   return objc_getAssociatedObject(self, _cmd);
}

-(void)setRadius:(NSNumber *)radius
{
    objc_setAssociatedObject(self,@selector(radius), radius, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber *)radius
{
    return objc_getAssociatedObject(self, _cmd);
}

@end

@implementation HRBadgeView

//画badge提示红点和数字
-(void)drawRect:(CGRect)rect
{
    CGFloat radius = [self.superview.radius floatValue];
    NSString * badgeNo = self.superview.badgeNo;
    if (!badgeNo || badgeNo.integerValue <= 0) return;
    if (badgeNo.intValue < 10 && badgeNo.intValue > 0 ) {
        UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.size.width * 0.5 - radius, rect.size.height * 0.5 - radius, radius * 2, radius * 2)];
        [[UIColor redColor]setFill];
        [path fill];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[NSFontAttributeName] = [UIFont systemFontOfSize:(15 * radius/9)];
        dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
        [badgeNo drawAtPoint:CGPointMake(rect.size.width * 0.5 - radius * 0.5, rect.size.height * 0.5 - radius) withAttributes:dic];
    }else if (badgeNo.intValue > 10 && badgeNo.intValue < 100){
        NSLog(@"%f",radius);
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.size.width * 0.5 - radius - 5, rect.size.height * 0.5 - radius, radius * 2 + 12, radius * 2) cornerRadius:radius];
        [[UIColor redColor]setFill];
        [path fill];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[NSFontAttributeName] = [UIFont systemFontOfSize:(15 * radius/9)];
        dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
        [badgeNo drawAtPoint:CGPointMake(rect.size.width * 0.5 - radius * 0.5 -2.5, rect.size.height * 0.5 - radius) withAttributes:dic];
        
    }else{
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(rect.size.width * 0.5 - radius - 5, rect.size.height * 0.5 - radius, radius * 2 + 14, radius * 2) cornerRadius:radius];
        [[UIColor redColor]setFill];
        [path fill];
        NSMutableDictionary * dic = [NSMutableDictionary dictionary];
        dic[NSFontAttributeName] = [UIFont systemFontOfSize:(14 * radius/9)];
        dic[NSForegroundColorAttributeName] = [UIColor whiteColor];
        [@"99+" drawAtPoint:CGPointMake(rect.size.width * 0.5 - radius * 0.5 - 3.5, rect.size.height * 0.5 - radius) withAttributes:dic];
    }
}

@end
