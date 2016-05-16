//
//  savePreference.m
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "savePreference.h"

@implementation savePreference

+(void)saveValue:(id)value forKey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults]setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)getValueForKey:(NSString *)key{
    
    return [[NSUserDefaults standardUserDefaults]valueForKey:key];
}

@end
