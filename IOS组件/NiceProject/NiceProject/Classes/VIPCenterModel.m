//
//  VIPCenterModel.m
//  Gmcchh
//
//  Created by ld on 16/9/22.
//  Copyright © 2016年 KingPoint. All rights reserved.
//

#import "VIPCenterModel.h"
#import "YYModel.h"

@implementation VIPCenterModel

@end

@implementation VIPCenterRegisterObj

@end

@implementation VIPCenterMenberObj

//替换变量名字，返回的字段 name 和 levelName都可以赋值给LevelName，
//都可以赋值好像没什么用
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"LevelName"  : @[@"name",@"levelName"]};
}
//数组里面装是什么类型的对象
-(void)setPrivilege:(NSArray *)privilege
{
    _privilege = [NSArray yy_modelArrayWithClass:[VIPCenterPrivilege class] json:privilege];
}

@end

@implementation VIPCenterPrivilege


@end

@implementation VIPRegistVIPModel


@end
