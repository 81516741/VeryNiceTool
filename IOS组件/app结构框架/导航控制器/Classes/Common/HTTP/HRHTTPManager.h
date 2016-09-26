//
//  HRHTTPManager.h
//
//  Created by ld on 16/9/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HRHTTPModel.h"

@interface HRHTTPManager : NSObject
+ (instancetype)shared;
-(void)sendMessage:(HRHTTPModel *)message success:(void (^)(HRHTTPModel *))success failure:(void (^)(HRHTTPModel *))failure;
@end
