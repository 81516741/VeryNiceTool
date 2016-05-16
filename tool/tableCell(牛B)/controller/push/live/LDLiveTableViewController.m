//
//  LDLiveTableViewController.m
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDLiveTableViewController.h"
#import "LDItemModel.h"
#import "LDItemArowModel.h"
#import "LDItemLableModel.h"
#import "LDItemGroup.h"

@interface LDLiveTableViewController ()

@property(nonatomic, strong) LDItemLableModel  * itemStart;

@end

@implementation LDLiveTableViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self group0];
    
    [self group1];
    
    [self group2];
    
}


-(void)group0{
    
    //第1组数据
    LDItemModel * game = [[LDItemArowModel alloc]initItemWithIcon:nil andTitle:@"提醒我关注比赛"];
    LDItemGroup * group0 = [[LDItemGroup alloc]init];
    group0.items = @[game];
    
    [self.groupList addObject:group0];
    
}

-(void)group1{
    
    //第2组数据
    LDItemLableModel * startTime = [[LDItemLableModel alloc]initItemWithIcon:nil andTitle:@"开始时间"];
    
    self.itemStart = startTime;
    
    if (!startTime.lableText.length) startTime.lableText = @"09:00";
    
    startTime.function = ^{
      
        UITextField * textField = [[UITextField alloc]init];
        
        UIDatePicker * pick = [[UIDatePicker alloc]init];
        
        pick.datePickerMode = UIDatePickerModeTime;
        
        pick.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        
        NSDateFormatter * dateF = [[NSDateFormatter alloc]init];
        dateF.dateFormat = @"HH:mm";
        
        pick.date = [dateF dateFromString:@"01:00"];
        
        [pick addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
        
        textField.inputView = pick;
        [textField becomeFirstResponder];
        
        [self.view addSubview:textField];
        
    };
  
    LDItemGroup * group1 = [[LDItemGroup alloc]init];
    
    group1.headerText = @"相信我你就可以赢得整个世界";
    group1.footerText = @"你现在是不是觉得自己无所不能啦，要的就是这样的感觉，belive yourself，you can  do  anything  you never thought you can achieve it";
    group1.items = @[startTime];
    
    [self.groupList addObject:group1];
    
}

-(void)valueChange:(UIDatePicker *)pick{
    
    NSDateFormatter * dateF = [[NSDateFormatter alloc]init];
    dateF.dateFormat = @"HH:mm";
    
    self.itemStart.lableText = [dateF stringFromDate:pick.date];
    
    [self.tableView reloadData];
}

-(void)group2{
    
    //第3组数据
    LDItemLableModel * endTime = [[LDItemLableModel alloc]initItemWithIcon:nil andTitle:@"结束时间"];
    endTime.lableText = @"00:00";
    
    LDItemGroup * group2 = [[LDItemGroup alloc]init];
    group2.items = @[endTime];
    
    [self.groupList addObject:group2];
    
}



@end
