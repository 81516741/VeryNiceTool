//
//  LDHelpTableViewController.m
//  令达网易
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDHelpTableViewController.h"
#import "LDJsonModel.h"
#import "LDItemGroup.h"
#import "LDItemModel.h"
#import "LDItemArowModel.h"
#import "LDWebViewController.h"
#import "LDMainNavigationController.h"

@interface LDHelpTableViewController()

@property(nonatomic, strong) NSArray  * jsonList;

@end



@implementation LDHelpTableViewController

-(NSArray *)jsonList{
    
    if (_jsonList == nil) {
        _jsonList = [LDJsonModel jsonList];
    }
    
    return _jsonList;
}

-(void)viewDidLoad{
    
    NSMutableArray * arrM = [NSMutableArray array];
    
    for (LDJsonModel * json in self.jsonList) {
        
        LDItemArowModel * item = [LDItemArowModel itemWithIcon:nil andTitle:json.title];
        
        [arrM addObject:item];
    }
    
    LDItemGroup * group0 = [[LDItemGroup alloc]init];
    group0.items = arrM;
    group0.headerText = @"帮助";
    [self.groupList addObject:group0];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LDWebViewController * web = [[LDWebViewController alloc]init];
    web.json = self.jsonList[indexPath.row];
    LDMainNavigationController * nav = [[LDMainNavigationController alloc]initWithRootViewController:web];
    
    [self presentViewController:nav animated:NO completion:nil];
    
}

@end
