//
//  ZQDatePickerSelect.m
//  CCDP
//
//  Created by zxy on 8/15/16.
//  Copyright © 2016 sun. All rights reserved.
//

#import "HRDatePicker.h"

@interface HRDatePicker ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, copy) void(^sureActionBlock)(UIDatePicker *picker);

@end

@implementation HRDatePicker

+(void)showIn:(UIViewController *)vc handle:(void(^)(UIDatePicker *picker)) handle
{
    HRDatePicker * select = [[HRDatePicker alloc]init];
    select.sureActionBlock = handle;
    [vc presentViewController:select animated:YES completion:nil];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

#pragma mark - event action
- (IBAction)cancelAction:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sureAction:(id)sender {
    if(self.sureActionBlock) self.sureActionBlock(self.datePicker);
    [self cancelAction:nil];
}

@end
