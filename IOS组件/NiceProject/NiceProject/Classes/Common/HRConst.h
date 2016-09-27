//
//  HRConst.h
//
//  Created by ld on 16/9/26.
//  Copyright © 2016年 ld. All rights reserved.
//


#ifndef __HRConst__H__
#define __HRConst__H__

#import <Foundation/Foundation.h>

#ifdef DEBUG  // 调试状态
// 打开LOG功能
#define HRLog(...) NSLog(__VA_ARGS__)
#else // 发布状态
// 关闭LOG功能
#define HRLog(...)
#endif

/**
 *  类型（属性类型）
 */
extern NSString *const HRTypeInt;

#endif
