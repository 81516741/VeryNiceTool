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
+(void)getAppointListByStartPageNum:(NSString *)pageNum maxDataCount:(NSString *)maxDataCount tagTask:(int32_t)tagTask dataClass:(Class)dataClass success:(void (^)(HRHTTPModel *))success failure:(void (^)(HRHTTPModel *))failure;
@end
