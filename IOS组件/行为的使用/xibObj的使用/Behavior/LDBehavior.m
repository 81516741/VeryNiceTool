//
//  LDBehavior.m
//  Behavior的使用
//
//  Created by yh on 16/8/22.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LDBehavior.h"
#import <objc/runtime.h>

@implementation LDBehavior

- (void)setOwner:(id)owner
{
    if (_owner != owner) {
        [self releaseLifetimeFromObject:_owner];
        _owner = owner;
        [self bindLifetimeToObject:_owner];
    }
}

- (void)bindLifetimeToObject:(id)object
{
    objc_setAssociatedObject(object, (__bridge void *)self, self,   OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)releaseLifetimeFromObject:(id)object
{
    objc_setAssociatedObject(object, (__bridge void *)self, nil,    OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
