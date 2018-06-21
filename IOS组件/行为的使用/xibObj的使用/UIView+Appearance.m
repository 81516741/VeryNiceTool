//
//  UIView+Appearance.m
//  xibObj的使用
//
//  Created by ld on 16/9/14.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "UIView+Appearance.h"
#import <objc/runtime.h>

@implementation UIView (Appearance)
- (void)setHr_BorderColor:(UIColor *)hr_BorderColor{
    self.layer.borderColor = hr_BorderColor.CGColor;
}

- (UIColor *)hr_BorderColor{
    return [[UIColor alloc] initWithCGColor:self.layer.borderColor];
}

- (void)setHr_BorderWidth:(CGFloat)hr_BorderWidth{
    self.layer.borderWidth = hr_BorderWidth;
}

- (CGFloat)hr_BorderWidth{
    return self.layer.borderWidth;
}

- (void)setHr_CornerRadius:(CGFloat)hr_CornerRadius{
    self.layer.cornerRadius = hr_CornerRadius;
}

- (CGFloat)hr_CornerRadius{
    return self.layer.cornerRadius;
}

- (void)setHr_DisableColor:(UIColor *)hr_DisableColor{
    objc_setAssociatedObject(self, @selector(hr_DisableColor), hr_DisableColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)hr_DisableColor{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHr_EnabledColor:(UIColor *)hr_EnabledColor{
    objc_setAssociatedObject(self, @selector(hr_EnabledColor), hr_EnabledColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)hr_EnabledColor{
    return objc_getAssociatedObject(self, _cmd);
}

+ (instancetype)loadNibView{
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return [nibView objectAtIndex:0];
}



@end
