//
//  NSData+ByteOrderCategory.m
//  CCDP
//
//  Created by zxy on 16/4/20.
//  Copyright © 2016年 sun. All rights reserved.
//

#import "NSData+ByteOrderCategory.h"
#import <objc/runtime.h>

@interface NSNumber (ByteOrderCategory)

@property (readonly) const char *ld_objCType;

@end

@implementation NSNumber (ByteOrderCategory)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(numberWithChar:),
            @selector(numberWithShort:),
            @selector(numberWithInt:),
            @selector(numberWithLong:),
            @selector(numberWithLongLong:),
        };
        
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            SEL swizzledSelector = NSSelectorFromString([@"ld_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
            Method originalMethod = class_getClassMethod(self, originalSelector);
            Method swizzledMethod = class_getClassMethod(self, swizzledSelector);
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
    
}

+ (NSNumber *)ld_numberWithChar:(char)value{
    NSNumber *num = [self ld_numberWithChar:value];
    num.ld_objCType = @encode(char);
    return num;
}

+ (NSNumber *)ld_numberWithShort:(short)value{
    NSNumber *num = [self ld_numberWithShort:value];
    num.ld_objCType = @encode(short);
    return num;
}

+ (NSNumber *)ld_numberWithInt:(int)value{
    NSNumber *num = [self ld_numberWithInt:value];
    num.ld_objCType = @encode(int);
    return num;
}

+ (NSNumber *)ld_numberWithLong:(long)value{
    NSNumber *num = [self ld_numberWithLongLong:value];
    num.ld_objCType = @encode(long);
    return num;
}

+ (NSNumber *)ld_numberWithLongLong:(long long)value{
    NSNumber *num = [self ld_numberWithLongLong:value];
    num.ld_objCType = @encode(long long);
    return num;
}

#pragma mark - setter & getter

- (void)setLd_objCType:(const char *)ld_objCType{
    NSString *type = [[NSString alloc] initWithUTF8String:ld_objCType];
    objc_setAssociatedObject(self, @selector(ld_objCType), type, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (const char *)ld_objCType{
    NSString *type = objc_getAssociatedObject(self, _cmd);
    return [type UTF8String] ? [type UTF8String] : "";
}

@end

@implementation NSData (ByteOrderCategory)

+ (NSData *)dataOrderWithValue:(id)value{
    return [self numberConverData:value byteOrder:DataByteOrderBigEndian];
}

+ (NSData *)dataOrderWithValue:(NSNumber *)value
                     byteOrder:(DataByteOrder)order{
    return [self numberConverData:value byteOrder:order];
}

+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue{
    return [self dataOrderWithArray:arrayValue
                    stringEncodeing:NSUTF8StringEncoding
                          byteOrder:DataByteOrderBigEndian];
}

+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue
                stringEncodeing:(NSStringEncoding)encoding{
    
    return [self dataOrderWithArray:arrayValue
                    stringEncodeing:encoding
                          byteOrder:DataByteOrderBigEndian];
}


+ (NSData *)dataOrderWithArray:(NSArray *)arrayValue
                stringEncodeing:(NSStringEncoding)encoding
                      byteOrder:(DataByteOrder)order{
    
    NSMutableData *mtData = [NSMutableData dataWithCapacity:20];
    [arrayValue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            [mtData appendData:[obj dataUsingEncoding:encoding]];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            [mtData appendData:[self numberConverData:obj byteOrder:order]];
        }else if ([obj isKindOfClass:[NSData class]]){
            [mtData appendData:obj];
        }
    }];
    return [NSData dataWithData:mtData];
}

- (int8_t)getInt8WithLocation:(NSInteger)loc{
    int8_t value;
    [self getBytes:&value range:NSMakeRange(loc, sizeof(value))];
    return value;
}

- (int16_t)getInt16WithLocation:(NSInteger)loc swap:(BOOL)swap{
    int16_t value;
    [self getBytes:&value range:NSMakeRange(loc, sizeof(value))];
    if(swap){
        value = CFSwapInt16(value);
    }
    return value;
}

- (int32_t)getInt32WithLocation:(NSInteger)loc swap:(BOOL)swap{
    int32_t value;
    [self getBytes:&value range:NSMakeRange(loc, sizeof(value))];
    if(swap){
        value = CFSwapInt32(value);
    }
    return value;
}

- (long)getLongWithLocation:(NSInteger)loc swap:(BOOL)swap{
    long value;
    [self getBytes:&value range:NSMakeRange(loc, sizeof(value))];
    if(swap){
        if (sizeof(long) == 4) {
            value = CFSwapInt32(value);
        }else{
          value = (long)CFSwapInt64(value);
        }
    }
    return value;
}

- (int64_t)getInt64WithLocation:(NSInteger)loc swap:(BOOL)swap{
    int64_t value;
    [self getBytes:&value range:NSMakeRange(loc, sizeof(value))];
    if(swap){
       value = CFSwapInt64(value);
    }
    return value;
}

+ (NSData *)numberConverData:(NSNumber *)number byteOrder:(DataByteOrder)order{
    
    NSData *data = nil;
    if (strcmp([number ld_objCType], @encode(int8_t)) == 0) {
        data = [self dataWithChar:[number charValue]];
    }else if (strcmp([number ld_objCType], @encode(int16_t)) == 0){
        data = [self dataWithShort:[number shortValue] byteOrder:order];
    }else if (strcmp([number ld_objCType], @encode(int32_t)) == 0){
        data = [self dataWithInt:[number intValue] byteOrder:order];
    }else if (strcmp([number ld_objCType], @encode(long)) == 0){
        data = [self dataWithLong:[number longValue] byteOrder:order];
    }else if (strcmp([number ld_objCType], @encode(int64_t)) == 0){
        data = [self dataWithLongLong:[number longLongValue] byteOrder:order];
    }
    NSAssert(data != nil, @"需扩展添加类型,不能使用long类型");
    
    return data;
}

+ (NSData *)dataWithChar:(int8_t)value{
    NSData *data = [[NSData alloc] initWithBytes:&value length:sizeof(value)];
    return data;
}

+ (NSData *)dataWithShort:(int16_t)value byteOrder:(DataByteOrder)order{
    if(CFByteOrderGetCurrent() != order) value = CFSwapInt16(value);
    NSData *data = [[NSData alloc] initWithBytes:&value length:sizeof(value)];
    return data;
}

+ (NSData *)dataWithInt:(int32_t)value byteOrder:(DataByteOrder)order{
    if(CFByteOrderGetCurrent() != order){
        value = CFSwapInt32(value);
    }
    NSData *data = [[NSData alloc] initWithBytes:&value length:sizeof(value)];
    return data;
}

+ (NSData *)dataWithLong:(long)value byteOrder:(DataByteOrder)order{
    if(CFByteOrderGetCurrent() != order) {
        if(sizeof(long) == 4){
            value = CFSwapInt32(value);
        }else{
            value = (long)CFSwapInt64(value);
        }
    }
    NSData *data = [[NSData alloc] initWithBytes:&value length:sizeof(long)];
    return data;
}

+ (NSData *)dataWithLongLong:(int64_t)value byteOrder:(DataByteOrder)order{
    if(CFByteOrderGetCurrent() != order) value = CFSwapInt64(value);
    NSData *data = [[NSData alloc] initWithBytes:&value length:sizeof(value)];
    return data;
}

@end
