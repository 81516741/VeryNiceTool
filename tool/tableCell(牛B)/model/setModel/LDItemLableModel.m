//
//  LDItemLableModel.m
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDItemLableModel.h"
#import "savePreference.h"


@implementation LDItemLableModel

-(void)setLableText:(NSString *)lableText{
    
    _lableText = lableText;
    
    [savePreference saveValue:lableText forKey:self.title];

    
}

-(void)setTitle:(NSString *)title{
    
    [super setTitle:title];
    
    _lableText = [savePreference getValueForKey:self.title];
    
}

@end
