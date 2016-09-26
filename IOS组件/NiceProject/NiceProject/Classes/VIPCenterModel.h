//
//  VIPCenterModel.h
//  Gmcchh
//
//  Created by ld on 16/9/22.
//  Copyright © 2016年 KingPoint. All rights reserved.
//

#import <Foundation/Foundation.h>

//申请会员用的模型
@interface VIPRegistVIPModel:NSObject
/**
 000	操作成功
 001	系统繁忙
 100	登陆超时
 */
@property (nonatomic,copy) NSString * result;
/**
 * 和粉弹框 或者 ...
 */
@property (nonatomic,copy) NSString * desc;

@end



@interface VIPCenterPrivilege : NSObject
/**
 * 福利描述
 */
@property (nonatomic,copy) NSString * desc;
/**
 * icon图片
 */
@property (nonatomic,copy) NSString * image;
/**
 * 索引
 */
@property (nonatomic,copy) NSString * index;
/**
 * 福利标题
 */
@property (nonatomic,copy) NSString * title;
/**
 * 需要跳转的网页的url
 */
@property (nonatomic,copy) NSString * url;
@end




//是会员
@interface VIPCenterMenberObj : NSObject
/**
 * 会员相应等级的名称
 */
@property (nonatomic,copy) NSString * LevelName;
/**
 * 会员等级
 */
@property (nonatomic,copy) NSString * memberLevel;
/**
 * 会员描述
 */
@property (nonatomic,copy) NSString * memberDesc;
/**
 * 会员的权益 和 特惠 里面装的是模型数组
 */
@property (nonatomic,strong) NSArray  * privilege;
@end




//申请会员界面模型
@interface VIPCenterRegisterObj : NSObject
/**
 * 申请会员的条件 -html
 */
@property (nonatomic,copy) NSString * levelDesc;
/**
 * 申请会员的好处 -html
 */
@property (nonatomic,copy) NSString * privilegeDesc;
@property (nonatomic,copy) NSString * levelName;
@end




//查询会员返回的数据模型
@interface VIPCenterModel : NSObject
/**
 * 是否是会员
 */
@property (nonatomic,copy) NSString * isMember;

@property (nonatomic,copy) NSString * desc;
@property (nonatomic,copy) NSString * result;

@property (nonatomic,strong) VIPCenterRegisterObj * registObj;
@property (nonatomic,strong) VIPCenterMenberObj * memberObj;
@end



