//
//  HRQQApiManager.h
//  NiceProject
//
//  Created by ld on 16/10/31.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#define kQQAppID         @"100809973"
#define kQQAppScheme    @"tencent100809973"


typedef NS_ENUM(NSInteger,QQLoginFailure){
    QQLoginFailureCancel,
    QQLoginFailureNoNet,
    QQLoginFailureNoToken,
    QQLoginFailureOtherReason
};

typedef NS_ENUM(NSInteger,QQShareType){
    QQShareTypeFriend,
    QQShareTypeZone
};



@interface HRQQApiManager : NSObject<TencentSessionDelegate,QQApiInterfaceDelegate>
/**
 *  单例
 */
+(instancetype)share;
@property (nonatomic,strong) TencentOAuth * tencentOAuth;
/**
 * success只是表示登录成功，并不代表获取用户信息成功
 */
+(void)QQLoginSuccess:(void(^)())success failure:(void(^)(QQLoginFailure failure))failure userInfo:(void(^)(APIResponse * userInfo))userInfo;
/**
 * 分享一条新闻的形式分享出去
 */
+(void)QQShare:(QQShareType)tencent title:(NSString *)title des:(NSString *)des image:(id)image url:(NSString *)url success:(void(^)())success failure:(void(^)(NSString * message))failure;

@property (assign ,nonatomic) QQShareType shareType;

@end
