//
//  NSDate+Extension.h
//  1.新浪微博
//
//  Created by mac on 15/10/20.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/**把这个格式的字符串 Tue Oct 20 10:03:03 +0800 2015 转成中国的字符串*/
+(NSString *)localDateStingFromSina:(NSString * )string;

/**把这个格式的字符串 Tue Oct 20 10:03:03 +0800 2015 转成date*/
+(NSDate *)localDateFromSina:(NSString * )string;

/**获得 (这个格式2015.10.20 10:26:22) 当前date的字符串*/
+(NSString *)localDateString;

/**获得这个 Tue Oct 20 10:03:03 +0800 2015 格式的字符串*/
+(NSString *)stringWithDate:(NSDate *)date;

/**返回一个字符串，现在时间与格式为EEE MMM dd HH:mm:ss Z yyyy  的 creatDay的时间差*/
+(NSString * )timeIntervalFrom:(NSString *) creatDay;
/**返回一个字符串  格式  EEE MMM dd HH:mm:ss Z yyyy */
+(NSString *)stringWithTimeInterval:(NSTimeInterval)timeInterval;

@end
