//
//  LDItemArowModel.m
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDItemArowModel.h"
#import "LDItemModel.h"

@implementation LDItemArowModel

-(instancetype)initItemWithIcon:(NSString *)iconName andTitle:(NSString *)title andDesController:(Class)desController{
    
    self.desController = desController;
    return [self initItemWithIcon:iconName andTitle:title];
    
}


+(instancetype)itemWithIcon:(NSString *)iconName andTitle:(NSString *)title andDesController:(Class) desController{
    
    return [[self alloc]initItemWithIcon:iconName andTitle:title];
}

@end
