//
//  HRSinaApiManager.m
//  NiceProject
//
//  Created by ld on 16/10/31.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRSinaApiManager.h"
@interface HRSinaApiManager()
@property (nonatomic,copy) void(^shareSuccess)();
@property (nonatomic,copy) void(^shareFailure)();
@property (nonatomic,copy) void(^handler)();
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

-(void)sinaLogin:(void (^)())handler
{
    self.handler = handler;
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kSinaAppRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

-(void)sinaShare:(void (^)())success failure:(void (^)())failure
{
    self.shareSuccess = success;
    self.shareFailure = failure;
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kSinaAppRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:self.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
   
}

-(void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])//分享
    {
        WBAuthorizeResponse * authResponse = [(WBSendMessageToWeiboResponse *)response authResponse];
        self.wbtoken = authResponse.accessToken;
        self.wbCurrentUserID = authResponse.userID;
        self.wbRefreshToken = authResponse.refreshToken;
        if (self.shareSuccess) {
            self.shareSuccess();
        }
        return;
    }else if ([response isKindOfClass:WBAuthorizeResponse.class])//登录
    {
        if (self.handler) {
            self.handler();
        }
        return;
    }
    if (self.shareFailure) {
        self.shareFailure();
    }
}

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    if (true)
    {
        message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    }
    
    if (false)//tu pian
    {
        WBImageObject *image = [WBImageObject object];
        image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
        message.imageObject = image;
    }
    
    if (false)//yin pin
    {
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = NSLocalizedString(@"分享网页标题", nil);
        webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
        webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
        webpage.webpageUrl = @"http://sina.cn?a=1";
        message.mediaObject = webpage;
    }
    
    return message;
}

@end
