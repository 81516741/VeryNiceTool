//
//  HRLayoutModel.h
//  NiceProject
//
//  Created by ld on 16/10/27.
//  Copyright © 2016年 ld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYLabel.h"

@interface HRLayoutModel : NSObject

@end


/**
 文本 Line 位置修改
 将每行文本的高度和位置固定下来，不受中英文/Emoji字体的 ascent/descent 影响
 */
@interface HRTextLinePositionModifier : NSObject <YYTextLinePositionModifier>
/**
 * // 基准字体 (例如 Heiti SC/PingFang SC)
 */
@property (nonatomic, strong) UIFont *font;
/**
 * 文本顶部留白
 */
@property (nonatomic, assign) CGFloat paddingTop;
/**
 * 文本底部留白
 */
@property (nonatomic, assign) CGFloat paddingBottom;
/**
 * 行间距
 */
@property (assign ,nonatomic) CGFloat lineSpace;

/**
 * 文本的高度
 */
- (CGFloat)heightForLineCount:(NSUInteger)lineCount;
/**
 * 默认设置的一个modifier，可以自行修改属性
 */
+ (instancetype)defaultModifier;
@end
