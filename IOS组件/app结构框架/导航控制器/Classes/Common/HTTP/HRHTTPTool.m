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

@implementation HRHTTPTool

+(void)getAppointListByStartPageNum:(NSString *)pageNum maxDataCount:(NSString *)maxDataCount tagTask:(int32_t)tagTask dataClass:(Class)dataClass success:(void (^)(HRHTTPModel *))success failure:(void (^)(HRHTTPModel *))failure{
    HRHTTPModel * message = [HRHTTPModel new];
    message.httpType = HRHTTPTypeGet;
    message.tagTask = tagTask;
    message.url = @"";
    message.dataClass = dataClass;
    NSMutableDictionary * paramasDic = [NSMutableDictionary dictionary];
    [paramasDic setObject:@"" forKey:@"strUserID"];
    [paramasDic setObject:@"" forKey:@"strCarID"];
    [paramasDic setObject:maxDataCount forKey:@"strPageSize"];
    [paramasDic setObject:pageNum forKey:@"strPageNum"];
    message.parameters = paramasDic;
    [[HRHTTPManager shared]sendMessage:message success:^(HRHTTPModel *model) {
        if ([model.data[@"status"] integerValue] == 0) {
            HRLog(@"获取数据成功");
            //字典转模型，可选择MJ
//            model.data = [dataClass mj_objectArrayWithKeyValuesArray:model.data[@"orders"]];
            success(model);
        }else{
            HRLog(@"获取数据失败,失败原因\n:%@",model.errorOfMy);
            model.errorOfMy = model.data[@"error"];
            failure(model);
            
        }
        
    } failure:^(HRHTTPModel *model) {
        HRLog(@"获取数据失败,失败原因\n:%@",model.errorOfAFN);
        failure(model);
    }];
}

@end
