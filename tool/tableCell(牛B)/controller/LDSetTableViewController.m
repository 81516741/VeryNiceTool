//
//  LDSetTableViewController.m
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDSetTableViewController.h"
#import "LDItemModel.h"
#import "LDItemArowModel.h"
#import "LDItemSwichModel.h"
#import "LDItemGroup.h"
#import "LDTableViewCell.h"
#import "LDPushTableViewController.h"
#import "LDHelpTableViewController.h"
#import "LDProductCollectionViewController.h"
#import "LDSharTableViewController.h"
#import "LDAboutTableViewController.h"



@implementation LDSetTableViewController

-(void)viewDidLoad{

    [super viewDidLoad];
    
    [self group0];
    
    [self group1];
    
}

-(void)group0{
    
    //第一组数据
    LDItemArowModel * push = [[LDItemArowModel alloc]initItemWithIcon:@"MorePush" andTitle:@"推送和提醒" andDesController:[LDPushTableViewController class]];
    LDItemSwichModel * shark = [[LDItemSwichModel alloc]initItemWithIcon:@"handShake" andTitle:@"摇一摇"];
    LDItemSwichModel * voice = [[LDItemSwichModel alloc]initItemWithIcon:@"sound_Effect" andTitle:@"声音和效果"];
    LDItemGroup * group0 = [[LDItemGroup alloc]init];
    group0.items = @[push,shark,voice];
    
    [self.groupList addObject:group0];
    
}

-(void)group1{
    //第二组数据
    LDItemArowModel * check = [[LDItemArowModel alloc]initItemWithIcon:@"MoreUpdate" andTitle:@"检查新版本"];

    //帮助这里是个网页，需要这个功能就自己完善json数据
    LDItemArowModel * help = [[LDItemArowModel alloc]initItemWithIcon:@"MoreHelp" andTitle:@"帮助"];
    
    LDItemArowModel * share = [[LDItemArowModel alloc]initItemWithIcon:@"MoreShare" andTitle:@"分享" andDesController:[LDSharTableViewController class]];
    LDItemArowModel * messege = [[LDItemArowModel alloc]initItemWithIcon:@"MoreMessage" andTitle:@"查看消息"];
    
    //这个功能有用到collectioncell，这里需要json数据
    LDItemArowModel * product = [[LDItemArowModel alloc]initItemWithIcon:@"MoreNetease" andTitle:@"产品推荐"];
    
    //关于的headerview是从xib加载的，图片随便自己换
    LDItemArowModel * about = [[LDItemArowModel alloc]initItemWithIcon:@"MoreAbout" andTitle:@"关于" andDesController:[LDAboutTableViewController class]];
    LDItemGroup * group1 = [[LDItemGroup alloc]init];
    group1.headerText = @"我是最聪明的，ios舍我其谁哈哈哈哈哈，family is my precious";
    group1.items = @[check,help,share,messege,product,about];
    
    [self.groupList addObject:group1];
    
    
}




@end
