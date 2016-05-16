//
//  LDItemModel.h
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^Block) ();

@interface LDItemModel : NSObject

@property(nonatomic, copy) Block function;

@property(nonatomic, copy) NSString  * icon;
@property(nonatomic, copy) NSString  * title;
@property(nonatomic, strong) NSString  * detailTitle;

-(instancetype) initItemWithIcon:(NSString *)iconName andTitle:(NSString *)title;
+(instancetype) itemWithIcon:(NSString *)iconName andTitle:(NSString *)title;

@end
