//
//  HRTextFieldAndButtonBehavior.h
//  xibObj的使用
//
//  Created by ld on 16/9/14.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "LDBehavior.h"
#import "HRTextFieldBehavior.h"
#import "UIView+Appearance.h"
@interface HRTextFieldAndButtonBehavior : LDBehavior

@property (nonatomic,copy)IBOutletCollection(HRTextFieldBehavior) NSArray * textFieldsBehavior;

@property (nonatomic,weak)IBOutlet UIButton * commitButton;
@property (nonatomic,weak)IBOutlet UIButton * selectedButton;

@end
