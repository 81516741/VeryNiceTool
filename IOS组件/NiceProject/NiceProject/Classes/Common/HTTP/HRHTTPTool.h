//
//  HRHTTPTool.h
//
//  Created by ld on 16/9/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HRHTTPModel;
@interface HRHTTPTool : NSObject

#define kTextTaskDescription @"kTexttaskDescription"

/**
 * 取消请求
 */
-(void)cancelHTTPTask:(NSString *)taskDescription;
/**
 * 示例
 */
+(void)text:(NSString *)taskDescription dataClass:(Class)dataClass success:(void (^)(HRHTTPModel * responseObject))success failure:(void (^)(HRHTTPModel * responseObject))failure;
@end
