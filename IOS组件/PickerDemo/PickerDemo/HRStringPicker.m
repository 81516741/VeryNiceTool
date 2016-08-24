//
//  HRStringPicker.m
//  PickerDemo
//
//  Created by yh on 16/8/23.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRStringPicker.h"

@interface HRStringPicker ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, copy) void(^sureActionBlock)(NSInteger currentIndex);
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property(nonatomic ,strong) NSArray * items;

@end

@implementation HRStringPicker

+(void)showIn:(UIViewController *)vc withItems:(NSArray *)items handle:(void (^)(NSInteger currentIndex))handle
{
    HRStringPicker * select = [[HRStringPicker alloc]init];
    select.items = items;
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

-(void)dealloc
{
    NSLog(@"pickerView被销毁了");
}

#pragma mark - event action

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sureAction:(id)sender
{
    if(self.sureActionBlock) {
      self.sureActionBlock([self.pickView selectedRowInComponent:0]);
    }
    [self cancelAction:nil];
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.items.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.items[row];
}

@end
