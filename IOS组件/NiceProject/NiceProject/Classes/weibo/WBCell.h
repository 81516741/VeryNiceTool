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

@property (nonatomic,copy) void(^pictureClick)(NSArray<NSURL *> * picture,NSInteger selectedIndex);
@property (nonatomic,copy) void(^worldsClick)(NSString * worlds);

@end

/**
 * 微博文字内容 和 图片内容的容器
 */
@interface WBContentView : UIView
@property (nonatomic,strong) WBStatus * status;

@property (nonatomic,copy) void(^pictureClick)(NSArray<NSURL *> * picture,NSInteger selectedIndex);
@property (nonatomic,copy) void(^worldsClick)(NSString * worlds);
@end

/**
 * 显示图片的容器
 */
@interface WBImageContainerView : UIView
@property (nonatomic,copy) void(^pictureClick)(NSArray<NSURL *> * picture,NSInteger selectedIndex);
@property (nonatomic,strong) WBStatus * status;
@property (assign ,nonatomic) CGFloat contentHeight;
@end

