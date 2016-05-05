//
//  NSString+Regex.m
//  CarDealer
//
//  Created by yh on 16/4/11.
//  Copyright © 2016年 yh. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (Regex)

+(BOOL)isEmailOf:(NSString *)email
{
    NSString *regex = @"^([a-zA-Z0-9_\\.\\-])+\\@(([a-zA-Z0-9])+\\.)+([a-zA-Z0-9]{2,4})+$";
    return [NSString regexNum:email byRegex:regex];
}
-(BOOL)isEmail
{
    return [NSString isEmailOf:self];
}
+(BOOL)isPhoneNumOf:(NSString *)phoneNum
{
    NSString *regex = @"^1[3,5,8][0-9]{9}$";
    return [NSString regexNum:phoneNum byRegex:regex];
}
-(BOOL)isPhoneNum
{
    return [NSString isPhoneNumOf:self];
}
+(BOOL)isQQOf:(NSString *)QQ
{
    NSString *regex = @"^[1-9]\\d{4,10}";
    return [NSString regexNum:QQ byRegex:regex];
}
-(BOOL)isQQ
{
    return [NSString isQQOf:self];
}
+(BOOL)isNum:(NSString *)num ofLenth:(int)lenth
{
    NSString *regex = [NSString stringWithFormat:@"\\d{%d}$",lenth];
    
    return [NSString regexNum:num byRegex:regex] && num.length == lenth;
}

+(BOOL)regexNum:(NSString *)num byRegex:(NSString *)regex
{
    NSError *err = nil;
    NSRegularExpression *regexExp = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&err];
    NSTextCheckingResult * isMatch = [regexExp firstMatchInString:num options:0 range:NSMakeRange(0, [num length])];
    return isMatch;
}
@end
