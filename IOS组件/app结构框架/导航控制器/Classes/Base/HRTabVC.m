//
//  HRTabVC.m
//  导航控制器
//
//  Created by ld on 16/9/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRTabVC.h"

@interface HRTabVC ()

@end

@implementation HRTabVC

+(instancetype)tabVC:(NSArray<NSString *> *)names titles:(NSArray<NSString *> *)titles imagePres:(NSArray<NSString *> *)imagePres
{
    HRTabVC * tabVC = [[HRTabVC alloc]init];
    for (int i = 0; i < names.count; i ++) {
        Class itemClass = NSClassFromString(names[i]);
        NSAssert(itemClass!=nil, @"中间控制器(%@)不存在",names[i]);
        NSString * title = titles[i];
        NSString * imagePre = imagePres[i];
        UIViewController * vc = [self vc:[[itemClass alloc]init] title:title imagePre:imagePre];
        [tabVC addChildViewController:vc];
    }
    return tabVC;
}

+(UIViewController *)vc:(UIViewController *)vc title:(NSString *)title imagePre:(NSString *)imagePre
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",imagePre]];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imagePre]];
    return vc;
}


@end
