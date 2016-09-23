//
//  HRTabVC.h
//  导航控制器
//
//  Created by ld on 16/9/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HRTabVC : UITabBarController

+(instancetype)tabVC:(NSArray<NSString *> *)names titles:(NSArray<NSString *> *)titles imagePres:(NSArray<NSString *> *)imagePres;


@end
