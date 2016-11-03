//
//  HRSinaApiManager.m
//  NiceProject
//
//  Created by ld on 16/10/31.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRSinaApiManager.h"
#import "HRConst.h"

@interface HRSinaApiManager()
@property (nonatomic,copy) void(^shareSuccess)();
@property (nonatomic,copy) void(^shareFailure)(NSString *);
@property (nonatomic,copy) void(^loginSuccess)();
@property (nonatomic,copy) void(^loginFailure)();
@end
@implementation HRSinaApiManager

+(instancetype)share
{
    static HRSinaApiManager * _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HRSinaApiManager alloc]init];
    });
    return _instance;
}

#pragma mark - 分享
+(void)sinaShareText:(NSString *)text image:(UIImage *)image success:(void(^)())success failure:(void(^)(NSString * message))failure
{
    if (![WeiboSDK isWeiboAppInstalled]) {
        if (failure) {
            failure(@"未安装微博");
        };
        return;
    }
    [HRSinaApiManager share].shareSuccess = success;
    [HRSinaApiManager share].shareFailure = failure;
    //创建消息对象
    WBMessageObject *message = [WBMessageObject message];
    //--文字
    message.text = text;
    //--图片
    WBImageObject *imageObject = [WBImageObject object];
    imageObject.imageData = UIImageJPEGRepresentation(image, 0.1);
    message.imageObject = imageObject;
    
    //发送消息的
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kSinaAppRedirectURI;
    authRequest.scope = @"all";
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message authInfo:authRequest access_token:[HRSinaApiManager share].wbtoken];
    request.userInfo = @{@"key":@"value"};
    [WeiboSDK sendRequest:request];
}

-(void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])//分享
    {
        WBAuthorizeResponse * authResponse = [(WBSendMessageToWeiboResponse *)response authResponse];
        self.wbtoken = authResponse.accessToken;
        self.wbCurrentUserID = authResponse.userID;
        self.wbRefreshToken = authResponse.refreshToken;
        
        if (response.statusCode == WeiboSDKResponseStatusCodeSuccess) {
            if (self.shareSuccess) {
                self.shareSuccess();
                self.shareSuccess = nil;
            }
            
        } else if (response.statusCode == WeiboSDKResponseStatusCodeUserCancel) {
            if (self.shareFailure) {
                self.shareFailure(@"分享取消");
                self.shareFailure = nil;
            }
            
        } else {
            if (self.shareFailure) {
                self.shareFailure(@"分享失败");
                self.shareFailure = nil;
            }
        }
        return;
    }else if ([response isKindOfClass:WBAuthorizeResponse.class])//登录授权
    {
        HRLog(@"授权");
    }
}
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}
@end
