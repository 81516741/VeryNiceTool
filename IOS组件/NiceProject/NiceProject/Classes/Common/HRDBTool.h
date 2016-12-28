//
//  HRDBTool.h
//  NiceProject
//
//  Created by ld on 16/10/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//announcement表的存储路径
#define  kImageFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"hr_image_db.sqlite"]


#ifdef DEBUG
#define hr_ImageLoader_Log(...) NSLog(__VA_ARGS__)
#else
#define hr_ImageLoader_Log(...)
#endif

@interface HRDBTool : NSObject
/**
 *  创建所有的table
 */
+(void)createAllTable;

@end

@interface HRImageDBTool : NSObject
// 图片的增删改查
+(void)insert:(UIImage *)image url:(NSString *)url;
+(void)deleteImageWithURL:(NSString *)url;
+(void)updateImageTable:(UIImage *)image url:(NSString *)url;
+(UIImage *)imageStringWithURL:(NSString *)url;
@end
