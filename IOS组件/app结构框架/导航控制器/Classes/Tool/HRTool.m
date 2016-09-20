//
//  HRTool.m
//  导航控制器
//
//  Created by ld on 16/9/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRTool.h"

@implementation HRTool

+(instancetype)share
{
    static HRTool * _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HRTool alloc]init];
    });
    return _instance;
}

+(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
  return [[HRTool share].rootNC popViewControllerAnimated:animated];
}
+(NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
   return [[HRTool share].rootNC popToRootViewControllerAnimated:animated];
}
+(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[HRTool share].rootNC pushViewController:viewController  animated:animated];
}
@end
