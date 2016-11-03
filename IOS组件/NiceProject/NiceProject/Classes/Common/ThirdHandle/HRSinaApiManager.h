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
 * 描述加图片分享
 */
+(void)sinaShareText:(NSString *)text image:(UIImage *)image success:(void(^)())success failure:(void(^)(NSString * message))failure;

//分享完后，保存的几个参数
@property (nonatomic,strong) NSString * wbtoken;
@property (nonatomic,strong) NSString * wbCurrentUserID;
@property (nonatomic,strong) NSString * wbRefreshToken;
@end
