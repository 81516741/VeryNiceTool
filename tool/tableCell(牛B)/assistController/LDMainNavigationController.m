//
//  LDMainNavigationController.m
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDMainNavigationController.h"

@implementation LDMainNavigationController

+(void)initialize{
    
    //设置导航条的属性
    UINavigationBar * bar = [UINavigationBar appearanceWhenContainedIn:[LDMainNavigationController class], nil];

    
    [bar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    [bar setTitleTextAttributes:@{
                                  NSForegroundColorAttributeName : [UIColor whiteColor]
                                  }];
    [bar setTintColor:[UIColor whiteColor]];
    
    
    //设置返回按钮的图片，和barbuttonitem的属性
    UIBarButtonItem * btnItem = [UIBarButtonItem appearanceWhenContainedIn:[LDMainNavigationController class], nil];
    
    [btnItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    
#warning 这个是用来设置btnItem的返回按钮背景图片的，由于下面的图片太丑，就不用了
//    [btnItem setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    
//    [btnItem setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

@end
