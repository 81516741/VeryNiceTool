//
//  LDTransitioning.h
//  15.自定义uipresentationcontrol
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 LD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface LDTransitioning : NSObject<UIViewControllerTransitioningDelegate>

SingletonH(Transitioning)

@end

//使用提醒
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    FirstViewController * vc1 = [[FirstViewController alloc]init];
//    vc1.modalPresentationStyle= UIModalPresentationCustom;
//    vc1.transitioningDelegate = [LDTransitioning sharedTransitioning];
//    [self presentViewController:vc1 animated:YES
//                     completion:nil];
//}

