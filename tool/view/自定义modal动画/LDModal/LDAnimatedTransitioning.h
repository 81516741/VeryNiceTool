//
//  LDAnimatedTransitioning.h
//  15.自定义uipresentationcontrol
//
//  Created by mac on 15/11/18.
//  Copyright © 2015年 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDAnimatedTransitioning : NSObject<UIViewControllerAnimatedTransitioning>
//用来标记当前是展示还是dismiss
@property(nonatomic, assign, getter=isPresent) BOOL present;

@end
