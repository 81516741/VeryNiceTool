//
//  LDItemArowModel.h
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDItemModel.h"

@interface LDItemArowModel : LDItemModel

@property(nonatomic, strong) Class  desController;

-(instancetype)initItemWithIcon:(NSString *)iconName andTitle:(NSString *)title andDesController:(Class) desController;

+(instancetype)itemWithIcon:(NSString *)iconName andTitle:(NSString *)title andDesController:(Class) desController;

@end
