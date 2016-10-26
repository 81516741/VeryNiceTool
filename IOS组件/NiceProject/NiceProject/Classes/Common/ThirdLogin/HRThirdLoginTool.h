//
//  HRThirdLoginTool.h
//  NiceProject
//
//  Created by ld on 16/10/25.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>

typedef NS_ENUM(NSInteger,QQLoginFailure){
    QQLoginFailureCancel,
    QQLoginFailureNoNet,
    QQLoginFailureNoToken,
    QQLoginFailureOtherReason
};
@interface HRThirdLoginTool : NSObject<TencentSessionDelegate>
/**
 *  单例
 */
+(instancetype)share;
/**
 * success只是表示登录成功，并不代表回去用户信息成功
 */
+(void)QQLoginSuccess:(void(^)())success failure:(void(^)(QQLoginFailure failure))failure userInfo:(void(^)(APIResponse * userInfo))userInfo;
@end
