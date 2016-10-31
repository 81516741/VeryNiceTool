//
//  HRQQApiManager.m
//  NiceProject
//
//  Created by ld on 16/10/31.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRQQApiManager.h"

@interface HRQQApiManager()
//第三方登录
@property (nonatomic,strong) TencentOAuth * tencentOAuth;
@property (nonatomic,copy) void(^QQLoginUserInfo)(APIResponse *);
@property (nonatomic,copy) void(^QQLoginSuccess)();
@property (nonatomic,copy) void(^QQLoginFailure)(QQLoginFailure);

@end

@implementation HRQQApiManager

+(instancetype)share
{
    static HRQQApiManager * _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HRQQApiManager alloc]init];
    });
    return _instance;
}

#pragma mark - qq第三方登录
+(void)QQLoginSuccess:(void(^)())success failure:(void(^)(QQLoginFailure))failure userInfo:(void(^)(APIResponse *))userInfo
{
    HRQQApiManager * manager = [HRQQApiManager share];
    manager.QQLoginSuccess = success;
    manager.QQLoginFailure = failure;
    manager.QQLoginUserInfo = userInfo;
    NSArray* permissions = [NSArray arrayWithObjects:
                            kOPEN_PERMISSION_GET_USER_INFO,
                            kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                            kOPEN_PERMISSION_ADD_ALBUM,
                            kOPEN_PERMISSION_ADD_ONE_BLOG,
                            kOPEN_PERMISSION_ADD_SHARE,
                            kOPEN_PERMISSION_ADD_TOPIC,
                            kOPEN_PERMISSION_CHECK_PAGE_FANS,
                            kOPEN_PERMISSION_GET_INFO,
                            kOPEN_PERMISSION_GET_OTHER_INFO,
                            kOPEN_PERMISSION_LIST_ALBUM,
                            kOPEN_PERMISSION_UPLOAD_PIC,
                            kOPEN_PERMISSION_GET_VIP_INFO,
                            kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                            nil];
    manager.tencentOAuth =
    [[TencentOAuth alloc]initWithAppId:kQQAppID andDelegate:manager];
    [manager.tencentOAuth authorize:permissions inSafari:NO];
}

- (void)tencentDidLogin  // 登录成功后的回调
{
    /** Access Token凭证，用于后续访问各开放接口 */
    if (_tencentOAuth.accessToken) {
        //获取用户信息。 调用这个方法后，qq的sdk会自动调用
        [_tencentOAuth getUserInfo];
        if ([HRQQApiManager share].QQLoginSuccess) {
            [HRQQApiManager share].QQLoginSuccess();
        }
        
    }else{
        NSLog(@"accessToken 没有获取成功");
        if ([HRQQApiManager share].QQLoginFailure) {
            [HRQQApiManager share].QQLoginFailure(QQLoginFailureNoToken);
        }
        
    }
}
- (void)tencentDidNotLogin:(BOOL)cancelled  // 登录失败后的回调
{
    if (cancelled) {
        NSLog(@" 用户点击取消按键,主动退出登录");
        if ([HRQQApiManager share].QQLoginFailure) {
            [HRQQApiManager share].QQLoginFailure(QQLoginFailureCancel);
        }
    }else{
        NSLog(@"其他原因， 导致登录失败");
        if ([HRQQApiManager share].QQLoginFailure) {
            [HRQQApiManager share].QQLoginFailure(QQLoginFailureOtherReason);
        }
    }
}
- (void)tencentDidNotNetWork  // 登录时网络有问题的回调
{
    NSLog(@"没有网络了");
    if ([HRQQApiManager share].QQLoginFailure) {
        [HRQQApiManager share].QQLoginFailure(QQLoginFailureNoNet);
    }
}

- (void)getUserInfoResponse:(APIResponse*) response
{
    NSLog(@" response %@",response);
    if ([HRQQApiManager share].QQLoginUserInfo) {
        [HRQQApiManager share].QQLoginUserInfo(response);
    }
}


@end
