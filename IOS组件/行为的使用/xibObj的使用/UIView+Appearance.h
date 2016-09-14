//
//  UIView+Appearance.h
//  xibObj的使用
//
//  Created by ld on 16/9/14.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Appearance)
@property (nonatomic, strong) IBInspectable UIColor *hr_BorderColor;

@property (nonatomic, assign) IBInspectable CGFloat hr_BorderWidth;

@property (nonatomic, assign) IBInspectable CGFloat hr_CornerRadius;

@property (nonatomic, strong) IBInspectable UIColor *hr_DisableColor;

@property (nonatomic, strong) IBInspectable UIColor *hr_EnabledColor;

+ (instancetype)loadNibView;
@end
