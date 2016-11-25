//
//  UIView+HRTransition.m
//  转场动画
//
//  Created by ld on 16/11/25.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "UIView+hr_Transition.h"

@implementation UIView (hr_Transition)

- (void)addLayerTransitionWith:(HRLayerTransitionType)type subtype:(HRLayerTransitionSubtype)subtype {
    
    NSString *transitionType;
    
    switch (type) {
            
        case 0:
            transitionType = kCATransitionFade;
            break;
        case 1:
            transitionType = kCATransitionMoveIn;
            break;
        case 2:
            transitionType = kCATransitionPush;
            break;
        case 3:
            transitionType = kCATransitionReveal;
            break;
        case 4:
            transitionType = @"cube";
            break;
        case 5:
            transitionType = @"suckEffect";
            break;
        case 6:
            transitionType = @"oglFlip";
            break;
        case 7:
            transitionType = @"rippleEffect";
            break;
        case 8:
            transitionType = @"pageCurl";
            break;
        case 9:
            transitionType = @"pageUnCurl";
            break;
        case 10:
            transitionType = @"cameraIrisHollowOpen";
            break;
        case 11:
            transitionType = @"cameraIrisHollowClose";
            break;
            
        default:
            break;
    }
    
    /* 更多特效，使用时有被苹果审核拒绝的可能
     
     以下API效果请慎用
     spewEffect 新版面在屏幕下方中间位置被释放出来覆盖旧版面.
     genieEffect 旧版面在屏幕左下方或右下方被吸走, 显示出下面的新版面
     unGenieEffect 新版面在屏幕左下方或右下方被释放出来覆盖旧版面.
     twist 版面以水平方向像龙卷风式转出来.
     tubey 版面垂直附有弹性的转出来.
     swirl 旧版面360度旋转并淡出, 显示出新版面.
     charminUltra 旧版面淡出并显示新版面.
     zoomyIn 新版面由小放大走到前面, 旧版面放大由前面消失.
     zoomyOut 新版面屏幕外面缩放出现, 旧版面缩小消失.
     oglApplicationSuspend 像按”home” 按钮的效果.
     
     */
    
    NSString *transitionSubtype;
    
    switch (subtype) {
        case 0:
            transitionSubtype = kCATransitionFromRight;
            break;
        case 1:
            transitionSubtype = kCATransitionFromLeft;
            break;
        case 2:
            transitionSubtype = kCATransitionFromTop;
            break;
        case 3:
            transitionSubtype = kCATransitionFromBottom;
            break;
        default:
            break;
    }
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.type = transitionType;
    transition.subtype = transitionSubtype;
    
    [self.layer addAnimation:transition forKey:@"transition"];
    NSLog(@"%@",transitionType);
    
}

- (void)addViewAnimationTransition:(UIViewAnimationTransition)transition AnimationCurve:(UIViewAnimationCurve)curve {
    
    UIViewAnimationTransition animationTranstion = transition;
    [UIView animateWithDuration:1 animations:^{
        [UIView setAnimationCurve:curve];
        [UIView setAnimationTransition:animationTranstion forView:self cache:YES];
    }];
}


@end
