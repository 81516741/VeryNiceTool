//
//  LDTableViewCell.h
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LDItemModel;
@interface LDTableViewCell : UITableViewCell

@property(nonatomic, strong) LDItemModel  * item;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
