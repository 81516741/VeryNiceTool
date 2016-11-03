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

typedef NS_ENUM(NSInteger,WChatShareType){
    WChatShareTypeFriend,
    WChatShareTypeCircle
};
@interface HRWChatApiManager : NSObject<WXApiDelegate>
+(instancetype)share;
+(void)wchatLogin;

+(void)WChatShare:(WChatShareType)type title:(NSString *)title des:(NSString *)des image:(id)image url:(NSString *)url success:(void(^)())success failure:(void(^)(NSString * message))failure;

@end
