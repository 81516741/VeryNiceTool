//
//  HRThirdLoginTool.m
//  NiceProject
//
//  Created by ld on 16/10/25.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRThirdLoginTool.h"

@interface HRThirdLoginTool()
//qq第三方登录
@property (nonatomic,strong) TencentOAuth * tencentOAuth;
@property (nonatomic,copy) void(^QQLoginUserInfo)(APIResponse *);
@property (nonatomic,copy) void(^QQLoginSuccess)();
@property (nonatomic,copy) void(^QQLoginFailure)(QQLoginFailure);

@end

@implementation HRThirdLoginTool

+(instancetype)share
{
    static HRThirdLoginTool * _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HRThirdLoginTool alloc]init];
    });
    return _instance;
}

#pragma mark - qq第三方登录
+(void)QQLoginSuccess:(void(^)())success failure:(void(^)(QQLoginFailure))failure userInfo:(void(^)(APIResponse *))userInfo
{
    HRThirdLoginTool * tool = [HRThirdLoginTool share];
    tool.QQLoginSuccess = success;
    tool.QQLoginFailure = failure;
    tool.QQLoginUserInfo = userInfo;
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
    tool.tencentOAuth =
    [[TencentOAuth alloc]initWithAppId:@"100809973" andDelegate:tool];
    [tool.tencentOAuth authorize:permissions inSafari:NO];
}

- (void)tencentDidLogin  // 登录成功后的回调
{
    /** Access Token凭证，用于后续访问各开放接口 */
    if (_tencentOAuth.accessToken) {
        //获取用户信息。 调用这个方法后，qq的sdk会自动调用
        [_tencentOAuth getUserInfo];
        if ([HRThirdLoginTool share].QQLoginSuccess) {
            [HRThirdLoginTool share].QQLoginSuccess();
        }
        
    }else{
        NSLog(@"accessToken 没有获取成功");
        if ([HRThirdLoginTool share].QQLoginFailure) {
            [HRThirdLoginTool share].QQLoginFailure(QQLoginFailureNoToken);
        }
        
    }
}
- (void)tencentDidNotLogin:(BOOL)cancelled  // 登录失败后的回调
{
    if (cancelled) {
        NSLog(@" 用户点击取消按键,主动退出登录");
        if ([HRThirdLoginTool share].QQLoginFailure) {
            [HRThirdLoginTool share].QQLoginFailure(QQLoginFailureCancel);
        }
    }else{
        NSLog(@"其他原因， 导致登录失败");
        if ([HRThirdLoginTool share].QQLoginFailure) {
            [HRThirdLoginTool share].QQLoginFailure(QQLoginFailureOtherReason);
        }
    }
}
- (void)tencentDidNotNetWork  // 登录时网络有问题的回调
{
     NSLog(@"没有网络了");
    if ([HRThirdLoginTool share].QQLoginFailure) {
        [HRThirdLoginTool share].QQLoginFailure(QQLoginFailureNoNet);
    }
}

- (void)getUserInfoResponse:(APIResponse*) response
{
    NSLog(@" response %@",response);
    if ([HRThirdLoginTool share].QQLoginUserInfo) {
        [HRThirdLoginTool share].QQLoginUserInfo(response);
    }
}

@end
