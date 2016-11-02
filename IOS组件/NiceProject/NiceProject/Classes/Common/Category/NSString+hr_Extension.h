//
//  NSString+hr_Extension.h
//  NiceProject
//
//  Created by ld on 16/11/2.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (hr_Extension)

@end



@interface NSString (hr_Emoji)
/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithIntCode:(int)intCode;

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;
- (NSString *)emoji;

/**
 *  是否为emoji字符
 */
- (BOOL)isEmoji;
@end



@interface NSString (hr_World)

/**获取字符串的size*/
-(CGSize) sizeOftextWith:(CGSize) size andFont:(CGFloat) font;

/**获取字符串的size*/
-(CGSize) sizeOftextWith:(CGSize) size andUIFont:(UIFont *) uiFont;

/**获取link连接字符串的文字部分*/
@property(nonatomic ,copy) NSString * linkValue;
/**
 *  计算当前文件\文件夹的内容大小 单位B
 */
@property(nonatomic ,assign) NSInteger fileSize;
/**
 *  获取documentPath
 */
@property(nonatomic ,copy) NSString * documentPath;
/**
 *  获取cachesPath
 */
@property(nonatomic ,copy) NSString * cachesPath;
/**
 *  获取tempPath
 */
@property(nonatomic ,copy) NSString * tempPath;

/**
 *  文字转图片
 */
-(UIImage *)createImageWithColor:(UIColor * )color worlds:( NSString *)worlds worldsColor:(UIColor * )worldsColor font:(CGFloat)font;
@end


@interface NSString (hr_Regex)
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


//下面的这两个方法执行效率比较慢，不适合大量数据，大量数据建议用RegexKitLite
/**
 * 获取与正则regex匹配的所有文字部分 及其 对应的范围
 */
- (void)enumeStringsMatchedByRegex:(NSString *)regex usingBlock:(void (^)(NSString *  matchedString, NSRange matchedRange,BOOL *stop))block;
/**
 *  获取用正则regex分割的所有文字部分 及其 对应的范围
 */
- (void)enumeStringsPartsByRegex:(NSString *)regex usingBlock:(void (^)(NSString *  part, NSRange partRange,BOOL *stop))block;
@end
