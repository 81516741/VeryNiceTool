//
//  LockView.h
//  17.手势解锁
//
//  Created by mac on 15/9/21.
//  Copyright © 2015年 LD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^Block) (NSString *);

@interface LockView : UIView

@property(nonatomic, copy) Block block;

@end
