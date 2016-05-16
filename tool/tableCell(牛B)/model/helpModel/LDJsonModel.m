//
//  LDJsonModel.m
//  令达网易
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDJsonModel.h"

@implementation LDJsonModel

+(instancetype)jsonWithDic:(NSDictionary *)dic{
    
    LDJsonModel * json = [[LDJsonModel alloc]init];
    
    json.title = dic[@"title"];
    json.html = dic[@"html"];
    json.ID = dic[@"id"];
    
    return json;
}

+(NSArray *)jsonList{
    
    NSString * path = [[NSBundle mainBundle]pathForResource:@"help.json" ofType:nil];
    
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    NSArray * arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray * arrM = [NSMutableArray array];
    for (NSDictionary * dic in arr) {
        LDJsonModel * json = [LDJsonModel jsonWithDic:dic];
        [arrM addObject:json];
    }
    
    return arrM;
    
}


@end
