//
//  LDProductModel.m
//  令达网易
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDProductModel.h"

@implementation LDProductModel

-(instancetype)initProductWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        self.title = dic[@"title"];
        self.ID = dic[@"id"];
        self.url = dic[@"url"];
        self.icon = dic[@"icon"];
        self.customUrl = dic[@"customUrl"];
    }
    
    return self;
}

+(instancetype)productWithDic:(NSDictionary *)dic{
    return [[self alloc]initProductWithDic:dic];
}

+(NSArray *)productList{
    NSString * path = [[NSBundle mainBundle]pathForResource:@"products.json" ofType:nil];
    
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray * arrM = [NSMutableArray array];
    for (NSDictionary * dic in arr) {
        LDProductModel * product = [LDProductModel productWithDic:dic];
        [arrM addObject:product];
    }
    return arrM;
}

@end
