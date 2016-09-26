//
//  HRHTTPTool.h
//
//  Created by ld on 16/9/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HRHTTPModel;

@interface HRHTTPTool : NSObject
/**
 * 示例
 */
+(void)textTagTask:(int32_t)tagTask dataClass:(Class)dataClass success:(void (^)(HRHTTPModel * responseObject))success failure:(void (^)(HRHTTPModel * responseObject))failure;
@end
