//
//  LDJsonModel.h
//  令达网易
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDJsonModel : NSObject

@property(nonatomic, copy) NSString  * title;
@property(nonatomic, copy) NSString  * html;
@property(nonatomic, copy) NSString  * ID;

+(instancetype)jsonWithDic:(NSDictionary *)dic;
+(NSArray *)jsonList;
@end
