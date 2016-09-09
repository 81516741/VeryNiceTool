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
    if (!self.imageView.badgeNo) {
        [self.imageView show:@"311" radius:8];
    }else{
        [self.imageView hideBadgeNo];
    }
}

@end
