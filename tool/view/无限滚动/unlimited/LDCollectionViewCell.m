//
//  LDCollectionViewCell.m
//  0.1无限滚动
//
//  Created by mac on 15/11/5.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDCollectionViewCell.h"

@interface LDCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titlelable;

@property (weak, nonatomic) IBOutlet UIImageView *imageVIew;

@end

@implementation LDCollectionViewCell

-(void)setBlock:(void (^)(UILabel *, UIImageView *))Block{
    
    Block(self.titlelable,self.imageVIew);
}

@end
