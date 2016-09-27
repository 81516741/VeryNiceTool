//
//  HRHTTPManager.h
//
//  Created by ld on 16/9/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRHTTPModel.h"

@interface HRHTTPManager : NSObject
/**
 * 单例
 */
+ (instancetype)shared;
/**
 * 发送HTTP网络请求
 */
-(void)sendMessage:(HRHTTPModel *)message success:(void (^)(HRHTTPModel * responseObject))success failure:(void (^)(HRHTTPModel * responseObject))failure;
/**
 * 取消请求
 */
-(void)cancelHTTPTask:(NSString *)taskDescription;
@end
