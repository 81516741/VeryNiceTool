//
//  HRCounting.h
//  xibObj的使用
//
//  Created by ld on 16/9/14.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRCounting : NSObject
/**
 *  倒计时
 *
 *  @param count    记时数
 *  @param owner    持有者 有才可以取消(一个持有者只能有一个定时器，否则只可以取消最后一个定时器)
 *  @param progress 进度回调
 *  @param complete 计时器完成的回调
 */
+ (void)counting:(NSInteger)count owner:(id)owner progress:(void(^)(NSInteger count,HRCounting * counting))progress complete:(void(^)(HRCounting * counting))complete;
/**
 *  取消倒计时
 *  注意同一个持有者只有最后一个创建的timer可以调用此方法取消
 *  @param owner 持有者
 */
+(void)cancelInOwner:(id)owner;
/**
 *  取消倒计时
 */
-(void)cancel;
@end
