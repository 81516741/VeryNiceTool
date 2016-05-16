//
//  LDItemModel.m
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDItemModel.h"

@implementation LDItemModel

-(instancetype)initItemWithIcon:(NSString *)iconName andTitle:(NSString *)title{
    
    if (self = [super init]) {
#warning  我这里开始是直接_title = title 就造成后面LDItemLableModel的设置存储出现问题，因为这么没有调用set方法，后面怎么玩，都没调用
        self.icon = iconName;
        self.title = title;
    }
    return self;
}

+(instancetype)itemWithIcon:(NSString *)iconName andTitle:(NSString *)title{
    
    return [[self alloc]initItemWithIcon:iconName andTitle:title];
}

@end
