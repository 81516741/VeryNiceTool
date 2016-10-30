//
//  UIView+Extension.m
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "UIView+Extension.h"
#import <objc/message.h>
#import <objc/runtime.h>

#define LDViewTouchDeliver(target,sel) ((void (*)(id,SEL,UIView *))objc_msgSend)((id)target,sel,self)

@implementation UIView (Extension)
@dynamic trail,bottom,cornerRadius;

-(void)setCor:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = true;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

-(CGFloat)trail
{
    return self.x + self.width;
}

-(CGFloat)bottom
{
    return self.y + self.height;
}
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

-(CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)minX
{
    return CGRectGetMinX(self.frame);
}

-(CGFloat)minY{
    return CGRectGetMinY(self.frame);
}


//显示小红点
- (void)showBadgeInItemAtIndex:(NSUInteger)index itemCount:(NSUInteger)itemCount centerXOffsetInItem:(CGFloat)centerXOffsetInItem yOffsetInItem:(CGFloat)yOffsetInItem{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 4;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色
    
    //确定小红点的位置 大小
    float perWidth = [UIScreen mainScreen].bounds.size.width / itemCount;
    badgeView.frame = CGRectMake(perWidth *index + perWidth * 0.5 + centerXOffsetInItem, yOffsetInItem, 8.0, 8.0);
    
    [self addSubview:badgeView];
}

//隐藏小红点
- (void)hideBadgeFromItemAtIndex:(NSUInteger)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

//移除小红点
- (void)removeBadgeOnItemIndex:(NSUInteger)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}


-(void)addTarget:(id)target sel:(SEL)sel
{
    [self addGuesture];
    self.target = target;
    self.sel = sel;
}

-(void)clickHandler:(void (^)(UIView *))handler
{
    [self addGuesture];
    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)addGuesture
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = true;
}

-(void)tap
{
    if ([self.target respondsToSelector:self.sel]) {
        LDViewTouchDeliver(self.target, self.sel);
    }
    void (^handler)(UIView *) = objc_getAssociatedObject(self, @selector(clickHandler:));
    if (handler) {
        handler(self);
    }
}

-(id)target
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setTarget:(id)target
{
    objc_setAssociatedObject(self, @selector(target), target, OBJC_ASSOCIATION_RETAIN);
}

-(SEL)sel
{
    return NSSelectorFromString(objc_getAssociatedObject(self, _cmd));
}

-(void)setSel:(SEL)sel
{
    objc_setAssociatedObject(self,@selector(sel),NSStringFromSelector(sel), OBJC_ASSOCIATION_RETAIN);
}

-(void)setObj:(id)obj
{
    objc_setAssociatedObject(self, @selector(obj), obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)obj
{
   return objc_getAssociatedObject(self, _cmd);
}

@end
