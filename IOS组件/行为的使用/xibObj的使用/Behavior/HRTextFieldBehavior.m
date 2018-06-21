//
//  HRTextFieldBehavior.m
//  xibObj的使用
//
//  Created by ld on 16/9/14.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRTextFieldBehavior.h"

@interface HRTextFieldBehavior ()
@property (nonatomic,strong) NSArray * checkSel;
@end

@implementation HRTextFieldBehavior

-(void)setTextField:(UITextField *)textField
{
    if (![textField isKindOfClass:[UITextField class]]) {
        return;
    }
    _textField = textField;
    self.checkSel = @[NSStringFromSelector(@selector(checkTextFieldLength:))];
    [textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
}

-(void)textFieldChange:(UITextField *)textField
{
    [self.checkSel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:NSSelectorFromString(obj) withObject:textField];
        #pragma clang diagnostic pop
    }];
}

-(BOOL)checkTextFieldLength:(UITextField *)textField
{
    if (textField.text.length >= self.textLength) {
        textField.text = [textField.text substringToIndex:self.textLength];
        return YES;
    }
    return NO;
}

-(BOOL)checkTextField
{
    BOOL __block result = YES;
    [self.checkSel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        result = [self performSelector:NSSelectorFromString(obj) withObject:_textField] && result;
#pragma clang diagnostic pop
        if (result == NO) {
            *stop = NO;
        }
    }];
    return result;
}
@end
