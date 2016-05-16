//
//  LDSearchBarTextField.m
//  1.新浪微博
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDSearchBarTextField.h"
#import "UIView+Extension.h"

@implementation LDSearchBarTextField

+(instancetype)searchBar{
    
    LDSearchBarTextField * titleView = [[LDSearchBarTextField alloc]init];
    titleView.placeholder = @"请输入要搜索的内容";
    titleView.background = [UIImage imageNamed:@"searchbar_textfield_background"];

    titleView.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    titleView.leftView.size = CGSizeMake(30, 30);
    titleView.leftView.contentMode = UIViewContentModeCenter;
    titleView.leftViewMode = UITextFieldViewModeAlways;
    
    
    return titleView;
}

@end
