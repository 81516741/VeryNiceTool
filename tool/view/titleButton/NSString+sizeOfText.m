//
//  NSString+sizeOfText.m
//  9.qq对话框
//
//  Created by mac on 15/9/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "NSString+sizeOfText.h"

@implementation NSString (sizeOfText)

-(CGSize)sizeOftextWith :(CGSize)size andFont:(CGFloat)font{
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}

@end
