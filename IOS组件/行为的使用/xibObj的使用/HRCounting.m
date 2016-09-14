//
//  HRCounting.m
//  xibObj的使用
//
//  Created by ld on 16/9/14.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRCounting.h"
#import <objc/runtime.h>

@implementation HRCounting

+(void)counting:(NSInteger)count owner:(id)owner progress:(void (^)(NSInteger, id))progress complete:(void (^)(id))complete
{
    HRCounting * counting = [[HRCounting alloc]init];
    __block NSInteger timeout = count; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)),1.0*NSEC_PER_SEC, 0); //每秒执行
    objc_setAssociatedObject(owner, @selector(cancelInOwner:), _timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if(complete){
                  complete(counting);
                }
            });
        }else{
            timeout--;
            dispatch_async(dispatch_get_main_queue(), ^{
                if(progress){
                  progress(timeout,counting);  
                }
            });
        }
    });
    dispatch_resume(_timer);
}

+(void)cancelInOwner:(id)owner
{
    dispatch_source_t _timer = objc_getAssociatedObject(owner, _cmd);
    dispatch_source_cancel(_timer);
}

-(void)dealloc
{
    NSLog(@"定时器被销毁了");
}

@end
