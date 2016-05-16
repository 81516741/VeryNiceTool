//
//  LDHomeButton.m
//  1.新浪微博
//
//  Created by mac on 15/10/12.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDHomeButton.h"


@implementation LDHomeButton



+(instancetype)buttonwithTitle:(NSString *)title{
    
    LDHomeButton * button = [[LDHomeButton alloc]init];
    
    //图片
    [button setImage:[UIImage imageNamed:@"timeline_icon_more_highlighted"] forState:UIControlStateNormal];
    button.imageView.contentMode = UIViewContentModeCenter;
    
#warning 一定要按状态设置，不然设置不了
    //文字
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
#warning 黑体的设置方法
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    
    //调整button的image和title的位置，分别计算出文字和image占的大小
    CGSize sizeTitle = [button.titleLabel.text sizeOftextWith:CGSizeMake(300, 0) andFont:16];
    CGSize sizeImage = button.imageView.image.size;
    button.frame = CGRectMake(0, 0, (sizeTitle.width+sizeImage.width+20), 30);//这里+20 后面的+15  -15 是调出来的，这样最好看
    button.imageEdgeInsets = UIEdgeInsetsMake(0,sizeTitle.width+15, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0,-sizeImage.width-15, 0, 0);
    return button;
}


-(void)setHighlighted:(BOOL)highlighted{
    
}

@end
