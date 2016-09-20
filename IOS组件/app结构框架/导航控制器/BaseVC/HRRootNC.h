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

+(instancetype)rootNC;
+(instancetype)rootNC:(NSArray<NSString *> *)centerVCNames centerVCTitles:(NSArray<NSString *> *)titles centerVCImagePres:(NSArray<NSString *> *)imagePres leftVCName:(NSString *)name
@end
