//
//  HRDBTool.m
//  NiceProject
//
//  Created by ld on 16/10/29.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRDBTool.h"
#import "FMDB.h"
#import "HRConst.h"

//announcement表的两个管理者
static FMDatabase *_imageDB=nil;
static FMDatabaseQueue *_imageDBQueue=nil;


static NSString * const kImageTable = @"image_table";
static NSString * const kImage      = @"image";
static NSString * const kImageURL   = @"image_url";

@interface HRDBTool()
@end

@implementation HRDBTool
#pragma  mark - 关于创建的方法
+(void)createAllTable
{
    [HRDBTool createImageDataBase];
    [HRDBTool creatImageDataTable];
    HRLog(@"%@",kImageFilePath);
}

+(void)createImageDataBase
{
    _imageDB = [FMDatabase databaseWithPath:kImageFilePath];
    _imageDBQueue = [FMDatabaseQueue databaseQueueWithPath:kImageFilePath];
}

+(void)creatImageDataTable
{
    if (!_imageDB){
        [HRDBTool createImageDataBase];
    }
    if (![_imageDB open]){
        return;
    }
    NSMutableString * sqlit = [NSMutableString string];
    [sqlit appendFormat:@"CREATE TABLE IF NOT EXISTS %@(",kImageTable];
    [sqlit appendFormat:@"id INTEGER PRIMARY KEY AUTOINCREMENT,"];
    [sqlit appendFormat:@"%@ TEXT,",kImageURL];
    [sqlit appendFormat:@"%@ TEXT)",kImage];
    
    BOOL state1 = [_imageDB executeUpdate:sqlit];
    if (state1) {
        HRLog(@"创建image_table---成功");
    } else {
        HRLog(@"创建image_table---失败");
    }
    [_imageDB close];
}

@end

@implementation HRImageDBTool

#pragma  mark - 插入字段的方法
+(void)insert:(UIImage *)image url:(NSString *)url
{
    NSData * data = UIImagePNGRepresentation(image);
    NSString * imageString = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    [_imageDBQueue inDatabase:^(FMDatabase *db) {
        [db open];
        NSMutableString * sqlit = [NSMutableString string];
        [sqlit appendFormat:@"INSERT INTO %@",kImageTable];
        [sqlit appendFormat:@"(%@,%@) ",kImageURL,kImage];
        [sqlit appendFormat:@"values('%@','%@')",url,imageString];
        BOOL state = [db executeUpdate:sqlit];
        if (state) {
            HRLog(@"image_table插入数据---成功");
        } else {
            HRLog(@"image_table插入数据---失败");
        }
        [db close];
    }];
}

#pragma  mark - 获取表相关属性的方法
+(UIImage *)imageStringWithURL:(NSString *)url
{
    [_imageDB open];
    FMResultSet *result=[_imageDB executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = '%@'", kImageTable,kImageURL,url]];
    while (result.next) {
        NSString * imageString = [result stringForColumn:kImage];
        NSData * imageData = [[NSData alloc]initWithBase64EncodedString:imageString options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage * image = [UIImage imageWithData:imageData];
        if (image) {
            HRLog(@"%@查询图片成功",kImageTable);
            return image;
        }
    }
    HRLog(@"%@查询图片失败",kImageTable);
    return nil;
    
}

#pragma  mark - 删除表中的记录
+(void)deleteImageWithURL:(NSString *)url
{
    [_imageDBQueue inDatabase:^(FMDatabase *db) {
        [db open];
        NSMutableString * sqlit = [NSMutableString string];
        [sqlit appendFormat:@"DELETE FROM %@ ",kImageTable];
        [sqlit appendFormat:@"WHERE %@ = %@",kImageURL,url];
        BOOL state = [db executeUpdate:sqlit];
        if (state) {
            HRLog(@"image_table删除数据---成功");
        } else {
            HRLog(@"image_table删除数据---失败");
        }
        [db close];
    }];
}


#pragma  mark - 更新表的方法
+(void)updateImageTable:(UIImage *)image url:(NSString *)url
{
    NSData * data = UIImagePNGRepresentation(image);
    NSString * imageString = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [_imageDBQueue inDatabase:^(FMDatabase *db) {
        [db open];
        NSMutableString * sqlit = [NSMutableString string];
        [sqlit appendFormat:@"UPDATE %@ SET ",kImageTable];
        [sqlit appendFormat:@"%@ = %@ ",kImage,imageString];
        [sqlit appendFormat:@"WHERE %@ = %@",kImageURL,url];
        BOOL state = [db executeUpdate:sqlit];
        if (state) {
            HRLog(@"image_table更新数据---成功");
        } else {
            HRLog(@"image_table更新数据---失败");
        }
        [db close];
    }];
}


@end
