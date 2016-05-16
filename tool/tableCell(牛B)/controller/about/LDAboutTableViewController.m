//
//  LDAboutTableViewController.m
//  令达网易
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDAboutTableViewController.h"
#import "LDItemArowModel.h"
#import "LDItemGroup.h"
#import "ILAboutHeaderView.h"

@interface LDAboutTableViewController ()

@end

@implementation LDAboutTableViewController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self group0];
    
    self.tableView.tableHeaderView = [ILAboutHeaderView aboutHeaderView];
    
}

-(void)group0{
    
    //第一组数据
    LDItemArowModel * push = [[LDItemArowModel alloc]initItemWithIcon:nil andTitle:@"评分支持" ];
    
    LDItemArowModel * shark = [[LDItemArowModel alloc]initItemWithIcon:nil andTitle:@"客服电话"];
    shark.detailTitle = @"053810010";
    
    shark.function =^{
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://053810010"]];
    };
    
    LDItemGroup * group0 = [[LDItemGroup alloc]init];
    group0.items = @[push,shark];
    
    [self.groupList addObject:group0];
    
}

@end
