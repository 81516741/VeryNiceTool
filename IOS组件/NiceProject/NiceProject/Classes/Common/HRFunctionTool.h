//
//  HRFunctionTool.h
//
//  Created by ld on 16/9/20.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRFunctionTool : NSObject

//********导航控制器的 push 和 pop *******
+(UIViewController *)popViewControllerAnimated:(BOOL)animated;
+(NSArray *)popToRootViewControllerAnimated:(BOOL)animated;
+(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated;
//*******************************************

+(void)gotoPushVC;


@end
