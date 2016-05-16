//
//  LDItemGroup.h
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDItemGroup : NSObject

@property(nonatomic, copy) NSString  * headerText;
@property(nonatomic, copy) NSString  * footerText;
@property(nonatomic, strong) NSArray  * items;

@end
