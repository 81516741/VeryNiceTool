//
//  HRStringPicker.h
//  PickerDemo
//
//  Created by yh on 16/8/23.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRStringPicker : UIViewController

+(void)showIn:(UIViewController *)vc withItems:(NSArray *)items handle:(void(^)(NSInteger currentIndex)) handle;

@end
