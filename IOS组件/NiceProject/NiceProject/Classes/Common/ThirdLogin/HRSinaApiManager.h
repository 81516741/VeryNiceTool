//
//  HRSinaApiManager.h
//  NiceProject
//
//  Created by ld on 16/10/31.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"


#define kSinaAppKey             @"3299513026"
#define kSinaAppScheme          @"wb3299513026"
#define kSinaAppRedirectURI     @"http://gd.10086.cn/"

@interface HRSinaApiManager : NSObject<WeiboSDKDelegate>
+(instancetype)share;
/**
 * 登录
 */
-(void)sinaLogin:(void (^)())success failure:(void (^)())failure; //这个登录有问题，官方的demo也一样

/**
 * 分享
 */
-(void)sinaShare:(void (^)())success failure:(void (^)())failure;

//分享完后，保存的几个参数
@property (nonatomic,strong) NSString * wbtoken;
@property (nonatomic,strong) NSString * wbCurrentUserID;
@property (nonatomic,strong) NSString * wbRefreshToken;
@end
