//
//  savePreference.h
//  19.网易彩票重做1
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface savePreference : NSObject

+(void)saveValue:(id)value forKey:(NSString *)key;

+(id)getValueForKey:(NSString *)key;

@end
