//
//  NSData+ByteOrderCategory.h
//  CCDP
//
//  Created by zxy on 16/4/20.
//  Copyright © 2016年 sun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DataByteOrderBigEndian    = 0,
    DataByteOrderLittleEndian = 1,
} DataByteOrder;

@interface NSData (ByteOrderCategory)

/**
 *  将NSNumber、NSArray对象转成 DataByteOrder  的 NSData
 *
 *  @param value 可以是NSNumber、NSArray。
 *       NSArray支持NSNumber、NSData、NSString
 *       NSString默认NSUTF8StringEncoding转化成NSData
 *
 *  @return 返回 DataByteOrder 字节序
 *  默认转成大端，因为ios的cup是小端(1)通过系统方法获得的值也是1
 */
+ (NSData *)dataOrderWithValue:(NSNumber *)value;

+ (NSData *)dataOrderWithValue:(NSNumber *)value
                     byteOrder:(DataByteOrder)order;

+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue;

+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue
                stringEncodeing:(NSStringEncoding)encoding;

+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue
                stringEncodeing:(NSStringEncoding)encoding
                      byteOrder:(DataByteOrder)order;

- (int8_t)getInt8WithLocation:(NSInteger)loc;

- (int16_t)getInt16WithLocation:(NSInteger)loc swap:(BOOL)swap;
// long 类型在32位下是4字节  64位下是8字节，底层已经做了处理
- (long)getLongWithLocation:(NSInteger)loc swap:(BOOL)swap;

- (int32_t)getInt32WithLocation:(NSInteger)loc swap:(BOOL)swap;

- (int64_t)getInt64WithLocation:(NSInteger)loc swap:(BOOL)swap;

@end
