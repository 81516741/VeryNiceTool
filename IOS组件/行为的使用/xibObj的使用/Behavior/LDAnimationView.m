//
//  LDAnimationView.m
//  xibObj的使用
//
//  Created by yh on 16/8/22.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LDAnimationView.h"

@interface LDRotationView ()

@property (nonatomic,assign) NSInteger  rotationCount;

@end

@implementation LDRotationView

-(void)setAnimationView:(UIView *)animationView
{
    self.rotationCount = 0;
    _animationView = animationView;
    animationView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(animation)];
    [animationView addGestureRecognizer:tap];
}

-(void)animation
{
    
    [UIView animateWithDuration:1 animations:^{
        _rotationCount ++ ;
        self.animationView.transform = CGAffineTransformMakeRotation(M_PI * _rotationCount);
    } completion:^(BOOL finished) {
        if (_rotationCount % 2 == 0) {
            self.animationView.transform = CGAffineTransformIdentity;
            self.rotationCount = 0;
        }
        
    }];
    
    
}
@end
