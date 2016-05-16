//
//  LDCollectionViewCell.h
//  0.1无限滚动
//
//  Created by mac on 15/11/5.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LDCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) void(^Block)(UILabel * ,UIImageView *) ;

@end
