//
//  HRTextFieldAndButtonBehavior.m
//  xibObj的使用
//
//  Created by ld on 16/9/14.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRTextFieldAndButtonBehavior.h"

@implementation HRTextFieldAndButtonBehavior

/**
 *  注意  self.textFieldsBehavior  这个东西在这里取是一定有值的
 */
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.commitButton.backgroundColor = self.hr_EnabledColor ?: self.commitButton.backgroundColor;
    [self.textFieldsBehavior enumerateObjectsUsingBlock:^(HRTextFieldBehavior * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }];
    [self.selectedButton addTarget:self action:@selector(selectedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self checkCommitButton];
}

-(void)textFieldChange:(UITextField *)textField
{
    [self checkCommitButton];
}
-(void)selectedButtonClick:(UIButton *)button
{
    button.selected = !button.selected;
    [self checkCommitButton];
}
-(void)checkCommitButton
{
    BOOL __block commitButtonEnable = YES;
    [self.textFieldsBehavior enumerateObjectsUsingBlock:^(HRTextFieldBehavior *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        commitButtonEnable = [obj checkTextField] && commitButtonEnable;
        if (!commitButtonEnable) {
            *stop = NO;
        }
    }];
    
    if (self.selectedButton) {
        commitButtonEnable = commitButtonEnable && self.selectedButton.selected;
    }
    
    self.commitButton.enabled = commitButtonEnable;
    self.commitButton.backgroundColor = commitButtonEnable ? self.hr_EnabledColor : self.hr_DisableColor;   
}

-(void)setCommitButton:(UIButton *)commitButton
{
    if (![commitButton isKindOfClass:[UIButton class]]) {
        return;
    }
    _commitButton = commitButton;
}

-(void)setSelectedButton:(UIButton *)selectedButton
{
    if (![selectedButton isKindOfClass:[UIButton class]]) {
        return;
    }
    _selectedButton = selectedButton;
}

@end
