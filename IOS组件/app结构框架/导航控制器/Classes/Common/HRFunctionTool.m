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

+(void)gotoPushVC
{
    [[HRObject share].rootNC pushViewController:[[PushedVC alloc]init] animated:true];
}

@end
