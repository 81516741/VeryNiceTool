//
//  LDBaseSetTableViewController.m
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDBaseSetTableViewController.h"
#import "LDItemModel.h"
#import "LDItemArowModel.h"
#import "LDItemSwichModel.h"
#import "LDItemGroup.h"
#import "LDTableViewCell.h"
#import "LDPushTableViewController.h"

@implementation LDBaseSetTableViewController

-(NSMutableArray *)groupList{
    
    if (_groupList == nil) {
        
        _groupList = [NSMutableArray array];
        
    }
    return _groupList;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.groupList.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    LDItemGroup * group = self.groupList[section];
    return group.items.count;
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    LDItemGroup * group = self.groupList[section];
    return group.headerText;
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    LDItemGroup * group = self.groupList[section];
    return group.footerText;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LDTableViewCell * cell = [LDTableViewCell cellWithTableView:tableView];
    LDItemGroup * group = self.groupList[indexPath.section];
    
    LDItemModel * item = group.items[indexPath.row];
    
    
    cell.item = item;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    LDItemGroup * group = self.groupList[indexPath.section];
    LDItemModel * item = group.items[indexPath.row];
    
    if (item.function) {
        item.function();
    }
    
    if ([item isKindOfClass:[LDItemArowModel class]]) {
        
        LDItemArowModel * itemArow = (LDItemArowModel *)item;
        if (itemArow.desController) {
            
            UITableViewController * vc = [[itemArow.desController alloc]init];
            
            vc.title = itemArow.title;
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}


-(instancetype)init{
    
    return  [super initWithStyle:UITableViewStyleGrouped];
    
}

@end
