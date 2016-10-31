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

// UI
#define kScreenWidth    kScreenBounce.size.width
#define kScreenHeight   kScreenBounce.size.height
#define kScreenBounce   [UIScreen mainScreen].bounds
//颜色
#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//系统
#ifndef kSystemVersion
#define kSystemVersion [[[UIDevice currentDevice]systemVersion] intValue]
#endif

#ifndef kiOS6Later
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif

extern NSString *const kHR;

#endif
