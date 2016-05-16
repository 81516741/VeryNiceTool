//
//  LDProductModel.h
//  令达网易
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDProductModel : NSObject

@property(nonatomic, copy) NSString  * title;
@property(nonatomic, copy) NSString  * ID;
@property(nonatomic, copy) NSString  * url;
@property(nonatomic, copy) NSString  * icon;
@property(nonatomic, copy) NSString  * customUrl;

-(instancetype)initProductWithDic:(NSDictionary *)dic;
+(instancetype)productWithDic:(NSDictionary * )dic;
+(NSArray *)productList;

@end
