//
//  HRCountingButtonBehavior.h
//  xibObj的使用
//
//  Created by ld on 16/9/14.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LDBehavior.h"
#import "HRTextFieldBehavior.h"

@interface HRCountingButtonBehavior : LDBehavior

@property (nonatomic,copy) IBOutletCollection(HRTextFieldBehavior) NSArray * textFieldBehaviors;

@property (assign ,nonatomic)IBInspectable NSInteger count;

@property (nonatomic,weak)IBOutlet UIButton * eventBtn;

@end
