//
//  HRFunctionTool.h
//
//  Created by ld on 16/9/20.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kFunctionText @"kFunctionText"

@interface HRFunctionTool : NSObject

//********导航控制器的 push 和 pop *******
+(UIViewController *)popViewControllerAnimated:(BOOL)animated;
+(NSArray *)popToRootViewControllerAnimated:(BOOL)animated;
+(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
//*******************************************

/**
 * 跳转功能
 * function 功能标示
 * needLogin 是否需要登陆
 */
+(BOOL)gotoFunction:(NSString *)function needLogin:(BOOL)needLogin;

@end
