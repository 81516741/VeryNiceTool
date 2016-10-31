//
//  HRWChatApiManager.h
//  NiceProject
//
//  Created by ld on 16/10/31.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

#define kWChatAppID     @"wxbcd4101ffb8bee27"


@interface HRWChatApiManager : NSObject<WXApiDelegate>
+(instancetype)share;
+(void)wchatLogin;
@end
