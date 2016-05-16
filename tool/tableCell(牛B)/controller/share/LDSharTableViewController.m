//
//  LDSharTableViewController.m
//  令达网易
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDSharTableViewController.h"
#import "LDItemArowModel.h"
#import "LDItemGroup.h"
#import <MessageUI/MessageUI.h>

@interface LDSharTableViewController ()

@end

@implementation LDSharTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self group0];
}

-(void)group0{
    
    //第一组数据
    LDItemArowModel * push = [[LDItemArowModel alloc]initItemWithIcon:@"MorePush" andTitle:@"新浪微博"];
    LDItemArowModel * shark = [[LDItemArowModel alloc]initItemWithIcon:@"handShake" andTitle:@"短信分享"];
    
    
    shark.function = ^{
        
       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://10086"]];
   
    };
    
    LDItemArowModel * voice = [[LDItemArowModel alloc]initItemWithIcon:@"sound_Effect" andTitle:@"邮件分享"];
    
    voice.function = ^{
      
        NSURL *url = [NSURL URLWithString:@"mailto://10010@qq.com"];
        [[UIApplication sharedApplication] openURL:url];


        
    };
    
    LDItemGroup * group0 = [[LDItemGroup alloc]init];
    
    group0.items = @[push,shark,voice];
    
    [self.groupList addObject:group0];
    
}





@end
