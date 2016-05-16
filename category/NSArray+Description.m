//
//  NSArray+Description.m
//  9.qq对话框
//
//  Created by mac on 15/9/13.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "NSArray+Description.h"

@implementation NSArray (Description)
-(NSString *)descriptionWithLocale:(id)locale{
    
    NSMutableString * strM = [NSMutableString stringWithFormat:@"("];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\n%@",obj];
    }];
    [strM appendFormat:@"\n)"];
    return strM;
    

}
@end
