//
//  WBCell.h
//  NiceProject
//
//  Created by ld on 16/10/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatus;

@interface WBCell : UITableViewCell

+(instancetype)cell:(UITableView *)tableView;

@property (nonatomic,strong) WBStatus * status;

@end

