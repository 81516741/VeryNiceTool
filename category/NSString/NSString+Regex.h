//
//  NSString+Regex.h
//  CarDealer
//
//  Created by yh on 16/4/11.
//  Copyright © 2016年 yh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)
/**
 * 是否是电话号码
 */
+(BOOL)isPhoneNumOf:(NSString *)phoneNum;
-(BOOL)isPhoneNum;
/**
 * 是否是邮箱
 */
+(BOOL)isEmailOf:(NSString *)email;
-(BOOL)isEmail;
/**
 * 是否是QQ号码
 */
+(BOOL)isQQOf:(NSString *)QQ;
-(BOOL)isQQ;

/**
 * 是否是一个长度为lenth的阿拉伯数字
 */
+(BOOL)isNum:(NSString *)num ofLenth:(int)lenth;

/**
 * 正则一个字符串
 */
+(BOOL)regexNum:(NSString *)num byRegex:(NSString *)regex;
@end
