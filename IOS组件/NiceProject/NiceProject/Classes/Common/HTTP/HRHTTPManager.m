//
//  HRHTTPManager.m
//
//  Created by ld on 16/9/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRHTTPManager.h"
#import "AFHTTPSessionManager.h"
#import "HRConst.h"

@interface HRHTTPManager()

@property (nonatomic,strong)  AFHTTPSessionManager * HTTPManager;

@end

@implementation HRHTTPManager

-(void)sendMessage:(HRHTTPModel *)message success:(void (^)(HRHTTPModel *))success failure:(void (^)(HRHTTPModel *))failure
{
    switch (message.httpType) {
        case HRHTTPTypeGet:
            [self getMessage:message success:success failure:failure];
            break;
        case HRHTTPTypePost:
            [self postMessage:message success:success failure:failure];
            break;
        default://默认get
            [self getMessage:message success:success failure:failure];
            break;
    }
    
}

-(void)getMessage:(HRHTTPModel *)message success:(void (^)(HRHTTPModel *))success failure:(void (^)(HRHTTPModel *))failure
{
    NSURLSessionDataTask * task = [self.HTTPManager GET:message.url parameters:message.parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        message.data = responseObject;
        @try {
            success(message);
        } @catch (NSException *exception) {
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        message.errorOfAFN = error;
        @try {
            failure(message);
        } @catch (NSException *exception) {
        }
    }];
    task.taskDescription = message.taskDescription;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;

}

-(void)postMessage:(HRHTTPModel *)message success:(void (^)(HRHTTPModel *))success failure:(void (^)(HRHTTPModel *))failure
{
    NSURLSessionDataTask * task = [self.HTTPManager POST:message.url parameters:message.parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        message.data = responseObject;
        @try {
            success(message);
        } @catch (NSException *exception) {
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        message.errorOfAFN = error;
        @try {
            failure(message);
        } @catch (NSException *exception) {
        }
    }];
    task.taskDescription = message.taskDescription;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
}


-(void)cancelHTTPTask:(NSString *)taskDescription
{
    for (NSURLSessionDataTask * task in self.HTTPManager.tasks) {
        if ([task.taskDescription isEqualToString:taskDescription]) {
            [task cancel];
        }
    }
}


#pragma mark - 单例的初始方法
static HRHTTPManager * _instance;
+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        _instance.HTTPManager = [AFHTTPSessionManager manager];
        [_instance.HTTPManager.requestSerializer setTimeoutInterval:20];
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}


@end
