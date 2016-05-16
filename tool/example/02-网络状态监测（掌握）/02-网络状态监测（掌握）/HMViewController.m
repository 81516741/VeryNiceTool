//
//  HMViewController.m
//  02-网络状态监测（掌握）
//
//  Created by apple on 14-9-22.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import "Reachability.h"
#import "HMNetworkTool.h"

@interface HMViewController ()
@property (nonatomic, strong) Reachability *reachability;
@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 监听网络状态发生改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    
    // 获得Reachability对象
    self.reachability = [Reachability reachabilityForInternetConnection];
    // 开始监控网络
    [self.reachability startNotifier];

//    // 1.获得Reachability对象
//    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
//    
//    // 2.获得Reachability对象的当前网络状态
//    NetworkStatus wifiStatus = wifi.currentReachabilityStatus;
//    if (wifiStatus != NotReachable) {
//        NSLog(@"是WIFI");
//    }
}

- (void)dealloc
{
    [self.reachability stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)networkStateChange
{
    NSLog(@"网络状态改变了");
    [self checkNetworkState];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self checkNetworkState];
}

/**
 *  监测网络状态
 */
- (void)checkNetworkState
{
    if ([HMNetworkTool isEnableWIFI]) {
        NSLog(@"WIFI环境");
    } else if ([HMNetworkTool isEnable3G]) {
        NSLog(@"手机自带网络");
    } else {
        NSLog(@"没有网络");
    }
}


@end
