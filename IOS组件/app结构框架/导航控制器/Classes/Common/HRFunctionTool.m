//
//  HRFunctionTool.m
//  导航控制器
//
//  Created by ld on 16/9/20.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRFunctionTool.h"
#import "HRObject.h"

#import "PushedVC.h"

@implementation HRFunctionTool

//********导航控制器的 push 和 pop *******
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
//*******************************************

+(void)gotoPushVC
{
    [[HRObject share].rootNC pushViewController:[[PushedVC alloc]init] animated:true];
}

@end
