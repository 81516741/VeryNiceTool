//
//  WBCell.m
//  NiceProject
//
//  Created by ld on 16/10/26.
//  Copyright © 2016年 ld. All rights reserved.
//

#import "WBCell.h"
#import "WBModel.h"
#import "YYLabel.h"
#import "HRConst.h"
#import "NSAttributedString+YYText.h"

@interface WBCell()

@property (nonatomic,strong) YYLabel * contentLable;

@end

@implementation WBCell

+(instancetype)cell:(UITableView *)tableView
{
    static NSString * ID = @"WBCELL";
    WBCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WBCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)setStatus:(WBStatus *)status
{
    _status = status;
    self.contentLable.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        YYTextHighlight *highlight = [text attribute:YYTextHighlightAttributeName atIndex:range.location effectiveRange:NULL];
        NSDictionary *info = highlight.userInfo;
        WBRegexDataModel  * model = info[@"model"];
        HRLog(@"%@",model.content);
    };
    self.contentLable.textLayout = status.textLayout;
    self.contentLable.frame = CGRectMake(20, 0, kScreenWidth - 40, status.textHeight);
}

-(YYLabel *)contentLable
{
    if (_contentLable == nil) {
        _contentLable = [[YYLabel alloc]init];
        _contentLable.numberOfLines = 0;
        [self.contentView addSubview:_contentLable];
    }
    return _contentLable;
}

@end
