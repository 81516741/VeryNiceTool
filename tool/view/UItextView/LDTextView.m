//
//  LDComposeView.m
//  1.新浪微博
//
//  Created by mac on 15/10/21.
//  Copyright (c) 2015年 LD. All rights reserved.
//

#import "LDTextView.h"

@interface LDTextView ()

@property(nonatomic, weak) UILabel  * placeholderLable;

@end

@implementation LDTextView

-(UILabel *)placeholderLable{
    if (_placeholderLable == nil) {
        
        UILabel * label  = [[UILabel alloc]init];
        _placeholderLable =label;
        [self addSubview:label];
    }
    
    return _placeholderLable;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alwaysBounceVertical = YES;
        self.placeholderLable.text = @"请输入内容...";
        self.placeholderLable.textColor = [UIColor grayColor];
        self.font = [UIFont systemFontOfSize:18];
        self.placeholderLable.font = self.font;
        self.placeholderLable.numberOfLines = 0;
        
  
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
        
        
        
    }
    return self;
}



-(void)textChange{
    
    self.placeholderLable.hidden = self.hasText;
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -设置尺寸
-(void)layoutSubviews{
    
    CGFloat marginX = 8;
    CGFloat marginY = 6;
    CGFloat lableH = self.height;
    CGFloat lableW = self.width - 2 * marginX;
    self.placeholderLable.width = lableH;
    self.placeholderLable.height = lableW;
    
    CGSize lableSize = [self.placeholderLable.text sizeOftextWith:CGSizeMake(lableW, lableH) andUIFont:self.font];
    
    self.placeholderLable.frame = (CGRect){{marginX,marginY},lableSize};
    
 
}

#pragma mark - 重写set方法是为了使占位符实时刷新
-(void)setPlaceholder:(NSString *)placeholder{
    
    _placeholder = placeholder;
    self.placeholderLable.text = placeholder;
    [self textChange];
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor{
    
    _placeholderColor = placeholderColor;
    self.placeholderLable.textColor = placeholderColor;
    [self textChange];
}

-(void)setFont:(UIFont *)font{
    
    [super setFont:font];
    
    self.placeholderLable.font = font;
    [self textChange];
}

-(void)setText:(NSString *)text{
    
    [super setText:text];
    
    [self textChange];

}

-(void)setAttributedText:(NSAttributedString *)attributedText{
    
    [super setAttributedText:attributedText];
    [self textChange];
    
}
@end
