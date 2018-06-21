//
//  ViewController.m
//  设置小红点
//
//  Created by ld on 16/9/9.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "ViewController.h"
#import "UIView+badge.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    if ((self.imageView.badgeNo.integerValue == 0) || self.imageView.badgeNo == nil) {
        [self.imageView show:3 radius:8];
    }else{
        [self.imageView show:0 radius:8];
    }}

@end
