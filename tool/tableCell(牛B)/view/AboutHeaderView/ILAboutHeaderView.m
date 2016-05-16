//
//  ILAboutHeaderView.m
//  ItheimaLottery
//
//  Created by yz on 14-8-17.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "ILAboutHeaderView.h"

@implementation ILAboutHeaderView

+ (instancetype)aboutHeaderView
{
    return [[NSBundle mainBundle] loadNibNamed:@"ILAboutHeaderView" owner:nil options:nil][0];
}

@end
