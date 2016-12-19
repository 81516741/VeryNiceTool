//
//  AppDelegate.m
//  NiceProject
//
//  Created by ld on 16/9/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "AppDelegate.h"
#import "HRRootNC.h"
#import "SDWebImageManager.h"
#import "HRDBTool.h"
#import "HRConst.h"
#import "HRWChatApiManager.h"
#import "HRQQApiManager.h"
#import "HRSinaApiManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    HRRootNC * rootNC1 = [HRRootNC rootNC:@[@"Item1",@"Item2",@"Item3"] centerVCTitles:@[@"首页",@"中间",@"最后"] centerVCImagePres:@[@"first",@"second",@"third"] leftVCName:@"LeftVC"];
    self.window.rootViewController = rootNC1;
    [self.window makeKeyAndVisible];

    [HRDBTool createAllTable];
    
    [WXApi registerApp:kWChatAppID withDescription:@"demo 2.0"];
    //向微信注册支持的文件类型
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
    [WXApi registerAppSupportContentFlag:typeFlag];
    

    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kSinaAppKey];

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    
    return [self shouldOpenUrl:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self shouldOpenUrl:url];
}

- (BOOL)shouldOpenUrl:(NSURL *)url
{
    NSString *scheme = url.scheme;
    if ([scheme isEqualToString:kWChatAppID]){
        NSRange range = [url.absoluteString rangeOfString:@"pay"];
        if (range.length > 0) { //微信支付
            return YES;
        } else { //微信
            return [WXApi handleOpenURL:url delegate:[ HRWChatApiManager share]];
        }
        
    } else if ([scheme isEqualToString:kQQAppScheme]){
        [QQApiInterface handleOpenURL:url delegate:[HRQQApiManager share]];
        return [TencentOAuth HandleOpenURL:url];
        
    } else if ([scheme isEqualToString:kSinaAppScheme]){
        return [WeiboSDK handleOpenURL:url delegate:[HRSinaApiManager share]];
    }
    return false;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    
    SDWebImageManager * mag = [SDWebImageManager sharedManager];
    [mag cancelAll];
    [mag.imageCache clearMemory];
}


@end
