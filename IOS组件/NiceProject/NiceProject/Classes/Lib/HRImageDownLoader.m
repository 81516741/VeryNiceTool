//
//  HRImageDownLoader.m
//  NiceProject
//
//  Created by ld on 16/12/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRImageDownLoader.h"
#import "HRDBTool.h"

@interface HRImageDownLoader()
@property (nonatomic,strong) NSMutableDictionary * taskCache;
@end

@implementation HRImageDownLoader
+(instancetype)share
{
    static HRImageDownLoader * _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HRImageDownLoader alloc]init];
    });
    return _instance;
}

-(void)downLoadImageWithUrl:(NSString *)urlStr progress:(void (^)(NSData * data,BOOL complete))progress
{
    if (self.taskCache[urlStr] != nil) {
        hr_ImageLoader_Log(@"正在下载");
        return;
    }
    if ([HRImageDBTool imageStringWithURL:urlStr] != nil) {
        progress(UIImagePNGRepresentation([HRImageDBTool imageStringWithURL:urlStr]),YES);
        hr_ImageLoader_Log(@"已经下载过了");
        return;
    }
    NSURL * url = [NSURL URLWithString:urlStr];
    // 使用代理方法需要设置代理,但是session的delegate属性是只读的,要想设置代理只能通过这种方式创建session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:self
                                                     delegateQueue:[[NSOperationQueue alloc] init]];
    
    // 创建任务(因为要使用代理方法,就不需要block方式的初始化了)
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:url]];
    task.progressBlock = progress;
    task.urlStr = urlStr;
    self.taskCache[urlStr] = task;
    // 启动任务
    [task resume];
}

// 1.接收到服务器的响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    // 允许处理服务器的响应，才会继续接收服务器返回的数据
    completionHandler(NSURLSessionResponseAllow);
}

// 2.接收到服务器的数据（可能调用多次）
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    // 处理每次接收的数据
    [dataTask.receivedDatas appendData:data];
    dispatch_sync(dispatch_get_main_queue(), ^{
        if (dataTask.progressBlock) {
            dataTask.progressBlock(dataTask.receivedDatas,NO);
        }
    });
}

// 3.请求成功或者失败（如果失败，error有值）
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    // 请求完成,成功或者失败的处理
    UIImage * image = [UIImage imageWithData:task.receivedDatas];
    if (image != nil) {
        [HRImageDBTool insert:image url:task.urlStr];
    }
    dispatch_sync(dispatch_get_main_queue(), ^{
        if (task.progressBlock) {
            task.progressBlock(task.receivedDatas,NO);
        }
    });
    [self.taskCache removeObjectForKey:task.urlStr];
}

-(void)clearImageCache
{
    [HRImageDBTool deleteImageWithURL:nil];
}

-(NSMutableDictionary *)taskCache
{
    if (_taskCache == nil) {
        _taskCache = @{}.mutableCopy;
    }
    return _taskCache;
}

@end
#import <objc/runtime.h>
@implementation NSURLSessionTask (hr_image)

-(void)setProgressBlock:(void (^)(NSData *, BOOL))progressBlock
{
    objc_setAssociatedObject(self, @selector(progressBlock), progressBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void (^)(NSData *, BOOL))progressBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setReceivedDatas:(NSMutableData *)receivedDatas
{
    objc_setAssociatedObject(self, @selector(receivedDatas), receivedDatas, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableData *)receivedDatas
{
    if (objc_getAssociatedObject(self, _cmd) == nil) {
        NSMutableData * data = [NSMutableData data];
        objc_setAssociatedObject(self, _cmd, data, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setUrlStr:(NSString *)urlStr
{
    objc_setAssociatedObject(self, @selector(urlStr), urlStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)urlStr
{
    return objc_getAssociatedObject(self, _cmd);
}
@end
