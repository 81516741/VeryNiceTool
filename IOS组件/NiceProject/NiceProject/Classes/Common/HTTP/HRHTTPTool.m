//
//  HRHTTPTool.m
//
//  Created by ld on 16/9/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRHTTPTool.h"
#import "HRHTTPModel.h"
#import "HRHTTPManager.h"
#import "HRConst.h"
#import "YYModel.h"

@implementation HRHTTPTool

+(void)textTagTask:(int32_t)tagTask dataClass:(Class)dataClass success:(void (^)(HRHTTPModel *))success failure:(void (^)(HRHTTPModel *))failure{
    
    HRHTTPModel * message = [HRHTTPModel new];
    message.httpType = HRHTTPTypeGet;
    message.tagTask = tagTask;
    message.url = @"url";
    message.dataClass = dataClass;
    NSMutableDictionary * paramasDic = [NSMutableDictionary dictionary];
    [paramasDic setObject:@"value" forKey:@"key"];
    message.parameters = paramasDic;
    
    //JSON文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"text.json" ofType:nil];
    //加载JSON文件
    NSData *data = [NSData dataWithContentsOfFile:path];
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    message.data = [dataClass yy_modelWithDictionary:obj];
    success(message);
    
    //**************真实走下面****************//
//    [[HRHTTPManager shared]sendMessage:message success:^(HRHTTPModel *model) {
//        if ([model.data[@"status"] integerValue] == 0) {
//            HRLog(@"获取数据成功");
//            //JSON文件的路径
//            NSString *path = [[NSBundle mainBundle] pathForResource:@"text.json" ofType:nil];
//            
//            //加载JSON文件
//            NSData *data = [NSData dataWithContentsOfFile:path];
//            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//            model.data = [dataClass yy_modelWithDictionary:obj];
//            success(model);
//        }else{
//            HRLog(@"获取数据失败,失败原因\n:%@",model.errorOfMy);
//            model.errorOfMy = model.data[@"error"];
//            failure(model);
//            
//        }
//        
//    } failure:^(HRHTTPModel *model) {
//        HRLog(@"获取数据失败,失败原因\n:%@",model.errorOfAFN);
//        failure(model);
//    }];
}

@end
