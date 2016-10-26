//
//  HRFunctionTool.m
//
//  Created by ld on 16/9/20.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRFunctionTool.h"
#import "HRObject.h"

#import "PushedVC.h"

@implementation HRFunctionTool

#pragma  mark - *****导航控制器的 push 和 pop 功能******
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

#pragma mark - ************功能跳转**********
+(BOOL)loginComplete:(BOOL(^)())complete
{
    if ([HRObject share].isLogin) {
        if (complete) {
           return complete();
        }
    }else{
        //把complete赋值给登录控制器，并跳转到登录控制器
    }
    return false;
}

+(BOOL)gotoFunction:(NSString *)function needLogin:(BOOL)needLogin
{
    //如果需要登陆
    if (needLogin) {
        [HRFunctionTool loginComplete:^{
            return [HRFunctionTool gotoFunction:function];
        }];
    }else{
       return [HRFunctionTool gotoFunction:function];
    }
    
    return false;
}

+(BOOL)gotoFunction:(NSString *)function
{
    if ([function isEqualToString:kFunctionText])
    {
        [HRFunctionTool pushViewController:[[PushedVC alloc] init] animated:true];
        return true;
    }
    return false;
}

@end
