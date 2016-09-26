//
//  HRTool.m
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

@end
