//
//  HRObject.h
//  导航控制器
//
//  Created by ld on 16/9/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRRootNC.h"
#import "HRItemNC.h"
#import "HRSideMenuVC.h"

@interface HRObject : NSObject
/**
 *  window的根控制器的导航控制器
 */
@property (nonatomic,strong) HRRootNC * rootNC;
/**
 *  单例
 */
+(instancetype)share;

//导航控制器的 push 和 pop
+(UIViewController *)popViewControllerAnimated:(BOOL)animated;
+(NSArray *)popToRootViewControllerAnimated:(BOOL)animated;
+(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
@end
