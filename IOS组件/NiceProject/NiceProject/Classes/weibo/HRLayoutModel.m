//
//  HRLayoutModel.m
//  NiceProject
//
//  Created by ld on 16/10/27.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "HRLayoutModel.h"
#import "HRConst.h"
#import "WBModel.h"

@implementation HRLayoutModel


@end


/*
 将每行的 baseline 位置固定下来，不受不同字体的 ascent/descent 影响。
 注意，Heiti SC 中，    ascent + descent = font size，
 但是在 PingFang SC 中，ascent + descent > font size。
 所以这里统一用 Heiti SC (0.86 ascent, 0.14 descent) 作为顶部和底部标准，保证不同系统下的显示一致性。
 间距仍然用字体默认
 */
@interface HRTextLinePositionModifier()
{
    CGFloat _lineHeightMultiple; //行距倍数
}

@end

@implementation HRTextLinePositionModifier

+(instancetype)defaultModifier
{
    HRTextLinePositionModifier *modifier = [[HRTextLinePositionModifier alloc]init];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:16];
    modifier.paddingTop = 3;
    modifier.paddingBottom = 8;
    return modifier;
}

- (instancetype)init {
    self = [super init];
    
    if (kiOS9Later) {
        _lineHeightMultiple = 1.34;   // for PingFang SC
    } else {
        _lineHeightMultiple = 1.3125; // for Heiti SC
    }
    
    return self;
}

- (void)modifyLines:(NSArray *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    
    CGFloat ascent = _font.pointSize * 0.86;
    
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row  * lineHeight;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    HRTextLinePositionModifier * modifier = [self.class new];
    modifier->_font = _font;
    modifier->_paddingTop = _paddingTop;
    modifier->_paddingBottom = _paddingBottom;
    modifier->_lineHeightMultiple = _lineHeightMultiple;
    return modifier;
}

- (CGFloat)heightForLineCount:(NSUInteger)lineCount
{
    if (lineCount == 0) return 0;
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}
@end

