//
//  HRQQApiManager.m
//  NiceProject
//
//  Created by ld on 16/10/31.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRQQApiManager.h"
#import "HRConst.h"

@interface HRQQApiManager()
//第三方登录
@property (nonatomic,copy) void(^QQLoginUserInfo)(APIResponse *);
@property (nonatomic,copy) void(^QQLoginSuccess)();
@property (nonatomic,copy) void(^QQLoginFailure)(QQLoginFailure);

@property (nonatomic,copy) void(^QQShareSuccess)();
@property (nonatomic,copy) void(^QQShareFailure)(NSString *);

@end

@implementation HRQQApiManager

+(instancetype)share
{
    static HRQQApiManager * _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HRQQApiManager alloc]init];
        _instance.tencentOAuth =
        [[TencentOAuth alloc]initWithAppId:kQQAppID andDelegate:_instance];
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
    [manager.tencentOAuth authorize:permissions inSafari:NO];
}

- (void)tencentDidLogin  // 登录成功后的回调
{
    /** Access Token凭证，用于后续访问各开放接口 */
    if (_tencentOAuth.accessToken) {
        //获取用户信息。 调用这个方法后，qq的sdk会自动调用
        [_tencentOAuth getUserInfo];
        if (self.QQLoginSuccess) {
            self.QQLoginSuccess();
            self.QQLoginSuccess = nil;
        }
        
    }else{
        NSLog(@"accessToken 没有获取成功");
        if (self.QQLoginFailure) {
            self.QQLoginFailure(QQLoginFailureNoToken);
            self.QQLoginFailure = nil;
        }
        
    }
}
- (void)tencentDidNotLogin:(BOOL)cancelled  // 登录失败后的回调
{
    if (cancelled) {
        NSLog(@" 用户点击取消按键,主动退出登录");
        if (self.QQLoginFailure) {
            self.QQLoginFailure(QQLoginFailureCancel);
            self.QQLoginFailure = nil;
        }
    }else{
        NSLog(@"其他原因， 导致登录失败");
        if (self.QQLoginFailure) {
            self.QQLoginFailure(QQLoginFailureOtherReason);
            self.QQLoginFailure = nil;
        }
    }
}
- (void)tencentDidNotNetWork  // 登录时网络有问题的回调
{
    NSLog(@"没有网络了");
    if (self.QQLoginFailure) {
        self.QQLoginFailure(QQLoginFailureNoNet);
        self.QQLoginFailure = nil;
    }
}

- (void)getUserInfoResponse:(APIResponse*) response
{
    NSLog(@" response %@",response);
    if (self.QQLoginUserInfo) {
        self.QQLoginUserInfo(response);
        self.QQLoginUserInfo = nil;
    }
}

#pragma mark - QQ分享
+(void)QQShare:(QQShareType)tencent title:(NSString *)title des:(NSString *)des image:(id)image url:(NSString *)url success:(void(^)())success failure:(void(^)(NSString * message))failure
{
    HRQQApiManager * manager = [HRQQApiManager share];
    manager.QQShareSuccess = success;
    manager.QQShareFailure = failure;
    
    QQApiNewsObject *newsObj;
    if ([image isKindOfClass:[NSString class]]) {
        newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:des previewImageURL:[NSURL URLWithString:image]];
    }else if ([image isKindOfClass:[UIImage class]]){
        newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:des previewImageData:UIImageJPEGRepresentation(image, 1)];
    }
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    
    QQApiSendResultCode resultCode;
    if (tencent == QQShareTypeFriend) {
        resultCode = [QQApiInterface sendReq:req];
    }else{
        resultCode = [QQApiInterface SendReqToQZone:req];
    }
}

- (void)onResp:(QQBaseResp *)resp
{
    if ([resp.result isEqualToString:@"0"]) {//成功
        self.QQShareSuccess();
        self.QQShareSuccess = nil;
    }
    else if ([resp.result isEqualToString:@"-4"]){//取消
        self.QQShareFailure(@"分享取消");
        self.QQShareFailure = nil;
    }
    else{//失败
        self.QQShareFailure(@"分享失败");
        self.QQShareFailure = nil;
    }

}
- (void)onReq:(QQBaseReq *)req
{
    
}
- (void)isOnlineResponse:(NSDictionary *)response
{
    
}


@end
