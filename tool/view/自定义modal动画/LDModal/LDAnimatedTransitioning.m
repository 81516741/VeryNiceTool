//
//  LDAnimatedTransitioning.m
//  15.自定义uipresentationcontrol
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 LD. All rights reserved.
//

#import "LDAnimatedTransitioning.h"
#import "UIView+Extension.h"
const CGFloat duringTime = 1;

@implementation LDAnimatedTransitioning


/**设置动画时长*/
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    
    return duringTime;
    
}

/**设置动画方式*/
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    //若果是展示
    if (self.isPresent) {
        
        //根据key取得view
        UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        //动画走起
        toView.layer.transform = CATransform3DMakeRotation(M_PI_2, toView.width, toView.height, 0);
        [UIView animateWithDuration:duringTime animations:^{
            
            toView.layer.transform = CATransform3DMakeRotation(0, toView.width, toView.height, 0);
            
        } completion:^(BOOL finished) {
            //完成后一定要设置，动画结束了，要不然ui界面无法接受事件
            [transitionContext completeTransition:YES];
            
        }];
    //如果是dismiss
    }else{
        
        UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];

        [UIView animateWithDuration:duringTime animations:^{
            
            fromView.layer.transform = CATransform3DMakeRotation(M_PI_2, fromView.width, fromView.height, 0);
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES];
        }];
        
    }
    
    
}

@end
