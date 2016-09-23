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
 *  window的根控制器(抽屉)
 */
@property (nonatomic,strong) HRSideMenuVC * menuVC;
/**
 *  单例
 */
+(instancetype)share;

@end
