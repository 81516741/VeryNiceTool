//
//  HRRootNC.h
//  导航控制器
//
//  Created by ld on 16/9/19.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKNavigationController.h"

@interface HRRootNC : KKNavigationController

/**
 *  创建根控制器
 *
 *  @param centerVCNames 1.抽屉中心所有子控制类名数组
 *  @param titles        2.抽屉中心所有子控制的标题
 *  @param imagePres     3.抽屉中心所有子控制的图片前缀
 *  @param leftVCName    4.抽屉左边控制器的类名
 *  注意: (1)1，2，3数组的个数需一致
 *       (2) 图片后缀需为:_normal 和 _selected
 */
+(instancetype)rootNC:(NSArray<NSString *> *)centerVCNames centerVCTitles:(NSArray<NSString *> *)titles centerVCImagePres:(NSArray<NSString *> *)imagePres leftVCName:(NSString *)leftVCName;
@end
