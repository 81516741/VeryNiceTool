//
//  NSString+hr_Extension.m
//  NiceProject
//
//  Created by ld on 16/11/2.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "NSString+hr_Extension.h"

@implementation NSString (hr_Extension)

@end

#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)

@implementation NSString (hr_Emoji)

+ (NSString *)emojiWithIntCode:(int)intCode {
    int symbol = EmojiCodeToSymbol(intCode);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return string;
}

- (NSString *)emoji
{
    return [NSString emojiWithStringCode:self];
}

+ (NSString *)emojiWithStringCode:(NSString *)stringCode
{
    char *charCode = (char *)stringCode.UTF8String;
    int intCode = (int)strtol(charCode, NULL, 16);
    return [self emojiWithIntCode:intCode];
}

// 判断是否是 emoji表情
- (BOOL)isEmoji
{
    BOOL returnValue = NO;
    
    const unichar hs = [self characterAtIndex:0];
    // surrogate pair
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                returnValue = YES;
            }
        }
    } else if (self.length > 1) {
        const unichar ls = [self characterAtIndex:1];
        if (ls == 0x20e3) {
            returnValue = YES;
        }
    } else {
        // non surrogate
        if (0x2100 <= hs && hs <= 0x27ff) {
            returnValue = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            returnValue = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            returnValue = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            returnValue = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            returnValue = YES;
        }
    }
    
    return returnValue;
}
@end

@implementation NSString (hr_World)
@dynamic linkValue,fileSize,documentPath,cachesPath,tempPath;
-(CGSize)sizeOftextWith :(CGSize)size andFont:(CGFloat)font{
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}

-(CGSize) sizeOftextWith:(CGSize) size andUIFont:(UIFont *) uiFont{
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:uiFont} context:nil].size;
}

-(NSString *)linkValue{
    
    NSRange startRG = [self rangeOfString:@">"];
    NSRange endRG = [self rangeOfString:@"</"];
    NSRange valueRG = NSMakeRange(startRG.location + 1, endRG.location-startRG.location -1);
    
    return [NSString stringWithFormat:@" 来自%@",[self substringWithRange:valueRG]];
    
    
}

- (NSInteger)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}

-(NSString *)documentPath
{
    return  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:self.lastPathComponent];
}
-(NSString *)cachesPath
{
    return  [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:self.lastPathComponent];
}
-(NSString *)tempPath
{
    return  [NSTemporaryDirectory() stringByAppendingPathComponent:self.lastPathComponent];
}

//获取一张指定颜色和大小的图片
-(UIImage *)imageWithBgColor:(UIColor *)color size:(CGSize)size{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

//这个是用来获取一个文字图片的，文字多大，图片就多大
-(UIImage *)createImageWithColor:(UIColor * )color worlds:( NSString *)worlds worldsColor:(UIColor * )worldsColor font:(CGFloat)font
{
    //    [ UIFont fontWithName : @"Arial-BoldMT" size : font ]
    NSDictionary * attributesDic = @{ NSFontAttributeName :[ UIFont systemFontOfSize:font], NSForegroundColorAttributeName :worldsColor};
    
    CGRect worldsRect = [worlds boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil];
    
    UIImage *image = [self imageWithBgColor:color size:worldsRect.size];
    
    UIGraphicsBeginImageContextWithOptions (image.size, NO , 0.0 );
    
    [image drawAtPoint:CGPointMake(0,0)];
    
    // 获得一个位图图形上下文
    
    CGContextRef context= UIGraphicsGetCurrentContext();
    
    CGContextDrawPath (context, kCGPathStroke );
    
    // 画 打败了多少用户
    
    [worlds drawAtPoint : CGPointMake (0,(image.size.height - font)*0.5) withAttributes :attributesDic];
    
    // 返回绘制的新图形
    
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return newImage;
}

@end


@implementation NSString (hr_Regex)

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
    return isMatch.range.length > 0;
}

- (void)enumeStringsMatchedByRegex:(NSString *)regex usingBlock:(void (^)(NSString *  matchedString, NSRange matchedRange,BOOL *stop))block
{
    
    BOOL stop = false;
    BOOL found = false;
    NSString * selfString = self;
    NSString * matchString = nil;
    NSRange preRange = NSMakeRange(NSNotFound, 0);
    if (selfString == nil) {
        return;
    }
    while (!stop) {
        NSError *error = NULL;
        NSRegularExpression *regexEx = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
        NSRange searchRange;
        if (preRange.location == NSNotFound) {
            searchRange = NSMakeRange(0, selfString.length);
        }else{
            NSInteger startPosition = preRange.location + preRange.length;
            searchRange = NSMakeRange(startPosition, selfString.length - startPosition);
        }
        NSTextCheckingResult *result = [regexEx firstMatchInString:selfString options:0 range:searchRange];
        if (result) {
            matchString = [selfString substringWithRange:result.range];
            block(matchString,result.range,&stop);
            preRange = result.range;
            found = true;
            stop = false;
        }else{
            stop = true;
        }
    }
}

- (void)enumeStringsPartsByRegex:(NSString *)regex usingBlock:(void (^)(NSString *  part, NSRange partRange,BOOL *stop))block
{
    BOOL stop = false;
    BOOL found = false;
    NSString * selfString = self;
    NSRange preRange = NSMakeRange(NSNotFound, 0);
    if (selfString == nil) {
        return;
    }
    
    while (!stop) {
        NSError *error = NULL;
        NSRegularExpression *regexEx = [NSRegularExpression regularExpressionWithPattern:regex options:NSRegularExpressionCaseInsensitive error:&error];
        NSRange searchRange;
        if (preRange.location == NSNotFound) {
            searchRange = NSMakeRange(0, selfString.length);
        }else{
            NSInteger startPosition = preRange.location + preRange.length;
            searchRange = NSMakeRange(startPosition, selfString.length - startPosition);
        }
        NSTextCheckingResult *result = [regexEx firstMatchInString:selfString options:0 range:searchRange];
        if (result) {
            stop = false;
            if (preRange.location == NSNotFound) {
                //第一次匹配到
                if (result.range.location > 0) {
                    block([selfString substringToIndex:result.range.location],NSMakeRange(0, result.range.location),NULL);
                }
            }else{
                NSInteger stringRangeLocation = preRange.location + preRange.length;
                NSInteger stringRangeLength = result.range.location - stringRangeLocation;
                NSRange stringRange = NSMakeRange(stringRangeLocation, stringRangeLength);
                NSString * string = [selfString substringWithRange:stringRange];
                block(string,stringRange,&stop);
            }
            found = true;
            preRange = result.range;
        }else{
            stop = true;
        }
    }
    
    if (!found) {
        block(selfString,NSMakeRange(0, selfString.length),NULL);
    }else{
        NSInteger startPosition = preRange.location + preRange.length;
        NSInteger length = selfString.length - startPosition;
        NSRange range = NSMakeRange(startPosition,length );
        if (length > 0) {
            block([selfString substringWithRange:range],range,NULL);
        }
    }
}

@end
