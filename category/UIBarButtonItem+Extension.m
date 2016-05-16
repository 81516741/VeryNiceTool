//
//  UIBarButtonItem+Extension.m
//  1.新浪微博
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+(instancetype)itemWithImage:(NSString *)image selImage:(NSString *)selImage target:(id)target action:(SEL)action{
    
//*****************************设置btn的背景图片*********************
    UIButton * btn = [[UIButton alloc]init];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selImage] forState:UIControlStateHighlighted];
    
#warning 这种方法设置btn的大小很好，记住记住
    btn.size = btn.currentBackgroundImage.size;

    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithCustomView:btn];

    return item;
    
}

@end
