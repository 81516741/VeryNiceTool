//
//  LDPushTableViewController.m
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDPushTableViewController.h"
#import "LDItemModel.h"
#import "LDItemArowModel.h"
#import "LDItemGroup.h"
#import "LDLiveTableViewController.h"

@implementation LDPushTableViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self group0];
    
    
}

-(void)group0{
    
    //第一组数据
    LDItemModel * awards = [[LDItemArowModel alloc]initItemWithIcon:nil andTitle:@"开奖号码推送"];
    
    LDItemModel * animation = [[LDItemArowModel alloc]initItemWithIcon:nil andTitle:@"中奖动画"];
    
    LDItemModel * live = [[LDItemArowModel alloc]initItemWithIcon:nil andTitle:@"比赛直播"  andDesController:[LDLiveTableViewController class]];
    
    LDItemModel * remind = [[LDItemArowModel alloc]initItemWithIcon:nil andTitle:@"购彩定时提醒"];
    
    LDItemGroup * group0 = [[LDItemGroup alloc]init];
    group0.items = @[awards,animation,live,remind];
    
    [self.groupList addObject:group0];
    
}

@end
