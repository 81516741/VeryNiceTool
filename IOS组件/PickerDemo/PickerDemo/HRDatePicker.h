//
//  HRDatePicker.h
//
//  Created by zxy on 8/15/16.
//  Copyright © 2016 sun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRDatePicker : UIViewController

+(void)showIn:(UIViewController *)vc handle:(void(^)(UIDatePicker *picker)) handle;

@end
