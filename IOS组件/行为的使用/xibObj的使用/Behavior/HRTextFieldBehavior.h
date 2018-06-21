//
//  HRTextFieldBehavior.h
//  xibObj的使用
//
//  Created by ld on 16/9/14.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LDBehavior.h"

@interface HRTextFieldBehavior : LDBehavior

@property (assign ,nonatomic)IBInspectable NSInteger textLength;
@property (nonatomic,weak)IBOutlet UITextField * textField;

-(BOOL)checkTextField;

@end
