//
//  HRTool.m
//  导航控制器
//
//  Created by ld on 16/9/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRObject.h"

@implementation HRObject

+(instancetype)share
{
    static HRObject * _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HRObject alloc]init];
    });
    return _instance;
}

+(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
  return [[HRObject share].rootNC popViewControllerAnimated:animated];
}
+(NSArray *)popToRootViewControllerAnimated:(BOOL)animated
{
   return [[HRObject share].rootNC popToRootViewControllerAnimated:animated];
}
+(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [[HRObject share].rootNC pushViewController:viewController  animated:animated];
}
@end
