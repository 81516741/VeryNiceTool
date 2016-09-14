//
//  HRCountingButtonBehavior.m
//  xibObj的使用
//
//  Created by ld on 16/9/14.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRCountingButtonBehavior.h"
#import "HRCounting.h"
#import "UIView+Appearance.h"

@interface HRCountingButtonBehavior()

@property (assign ,nonatomic) BOOL isCounting;
@property (nonatomic,copy) NSString * originString;

@end

@implementation HRCountingButtonBehavior

-(void)awakeFromNib
{
    self.hr_EnabledColor = self.hr_EnabledColor?:_eventBtn.backgroundColor;
    [_eventBtn addTarget:self action:@selector(eventBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.textFieldBehaviors enumerateObjectsUsingBlock:^(HRTextFieldBehavior *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }];
    [self checkBtn];
}

-(void)textFieldChange:(UITextField *)textField
{
    [self checkBtn];
}

-(void)checkBtn
{
    BOOL __block eventBtnEnable = YES;
    [self.textFieldBehaviors enumerateObjectsUsingBlock:^(HRTextFieldBehavior *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        eventBtnEnable = eventBtnEnable && [obj checkTextField]&& !self.isCounting;
        if (eventBtnEnable == NO) {
            *stop = YES;
        }
    }];
    self.eventBtn.enabled = eventBtnEnable;
    self.eventBtn.backgroundColor = eventBtnEnable ? self.hr_EnabledColor : self.hr_DisableColor;
}

-(void)eventBtnClick:(UIButton *)btn
{
    btn.enabled = false;
    btn.backgroundColor = self.hr_DisableColor;
    self.originString = btn.titleLabel.text;
    self.isCounting = true;
    [HRCounting counting:self.count owner:self progress:^(NSInteger count, id obj) {
        [btn setTitle:[NSString stringWithFormat:@"还剩(%lds)",(long)count] forState:UIControlStateNormal];
    } complete:^(id obj) {
        btn.backgroundColor = self.hr_EnabledColor;
        btn.enabled = true;
        [btn setTitle:self.originString forState:UIControlStateNormal];
        self.isCounting = false;
    }];
}

-(void)setEventBtn:(UIButton *)eventBtn
{
    if (![eventBtn isKindOfClass:[UIButton class]]) {
        return;
    }
    _eventBtn = eventBtn;
}

@end
