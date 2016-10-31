//
//  HRWChatApiManager.m
//  NiceProject
//
//  Created by ld on 16/10/31.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRWChatApiManager.h"
#import "HRObject.h"
#include "HRConst.h"
@implementation HRWChatApiManager

+(instancetype)share
{
    static HRWChatApiManager * _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HRWChatApiManager alloc]init];
    });
    return _instance;
}

#pragma  mark - 微信登录
+(void)wchatLogin
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
    req.state = @"123" ;

    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

-(void) onResp:(BaseResp*)resp
{
    
    if ([resp isKindOfClass:[SendAuthResp class]]){
        SendAuthResp * authResp = (SendAuthResp *)resp;
        HRLog(@"%@",authResp);
    }
}

#pragma mark - 微信分享
- (void)shareToWXScene:(int)wxScene image:(UIImage *)image
{
    WXMediaMessage *message = [[WXMediaMessage alloc] init];
    WXImageObject *imageObj = [[WXImageObject alloc] init];
    [message setThumbImage:image];
    imageObj.imageData = UIImageJPEGRepresentation(image, 1);
    message.mediaObject = imageObj;
    [self shareToWXScene:wxScene message:message];
}

- (void)shareToWXScene:(int)wxScene message:(WXMediaMessage *)message
{
    if (wxScene == WXSceneSession) {

    } else {

    }
//    if([WXApi isWXAppInstalled]){
//        return;
//    }
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = wxScene;
    BOOL isSuccess = [WXApi sendReq:req];
    if (!isSuccess) {
        
    }
}
@end
