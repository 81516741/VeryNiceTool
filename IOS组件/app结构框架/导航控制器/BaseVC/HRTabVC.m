//
//  HRTabVC.m
//  导航控制器
//
//  Created by ld on 16/9/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRTabVC.h"
#import "Item1.h"
#import "Item2.h"
#import "Item3.h"

@interface HRTabVC ()

@end

@implementation HRTabVC

+(instancetype)tabVC
{
    HRTabVC * tabVC = [[HRTabVC alloc]init];
    UIViewController * item1 = [self vc:[[Item1 alloc]init] title:@"item1" imagePre:@"first"];
    UIViewController * item2 = [self vc:[[Item2 alloc]init] title:@"item2" imagePre:@"second"];
    UIViewController * item3 = [self vc:[[Item3 alloc]init] title:@"item3" imagePre:@"third"];
    [tabVC setViewControllers:@[item1,item2,item3]];
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
