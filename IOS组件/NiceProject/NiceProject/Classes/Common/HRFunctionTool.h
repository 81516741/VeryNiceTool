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

+(BOOL)gotoFunction:(NSString *)function;

@end
