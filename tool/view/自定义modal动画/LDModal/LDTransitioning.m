//
//  LDTransitioning.m
//  15.自定义uipresentationcontrol
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 LD. All rights reserved.
//

#import "LDTransitioning.h"
#import "LDpresentationController.h"
#import "LDAnimatedTransitioning.h"

@implementation LDTransitioning

SingletonM(Transitioning)

/**返回dismiss动画对象*/
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    LDAnimatedTransitioning * an = [[LDAnimatedTransitioning alloc]init];
    an.present = NO;
    return an;
    
}
/**返回present动画对象*/
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    LDAnimatedTransitioning * an = [[LDAnimatedTransitioning alloc]init];
    an.present = YES;
    return an;
    
}

/**返回由哪个presentation管理modal事件*/
- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
    
    return [[LDpresentationController alloc]initWithPresentedViewController:presented presentingViewController:presenting];
   
}

@end
