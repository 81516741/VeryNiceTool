//
//  HRImageDownLoader.h
//  NiceProject
//
//  Created by ld on 16/12/28.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HRImageDownLoader : NSObject<NSURLSessionDelegate>
+(instancetype)share;
-(void)downLoadImageWithUrl:(NSString *)urlStr progress:(void (^)(NSData * data,BOOL complete))progress;
-(void)clearImageCache;
@end

@interface NSURLSessionTask (hr_image)
@property (nonatomic,copy) void(^progressBlock)(NSData *,BOOL);
@property (nonatomic,strong) NSMutableData * receivedDatas;
@property (nonatomic,copy) NSString * urlStr;

@end
