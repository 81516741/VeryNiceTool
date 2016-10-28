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
#import "UIView+Extension.h"

@interface WBCell()
@property (nonatomic,strong) WBContentView * myContentView;
@property (nonatomic,strong) WBContentView * retweetContentView;
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
    //自己的微博内容
    self.myContentView.status = status;
    
    //转发的微博内容
    if (status.retweetedStatus == nil) {
        self.retweetContentView.hidden = true;
        return;
    }
    self.retweetContentView.hidden = false;
    self.retweetContentView.status = status.retweetedStatus;
    self.retweetContentView.y = self.myContentView.height;
    


}

-(WBContentView *)myContentView
{
    if (_myContentView == nil) {
        _myContentView = [[WBContentView alloc]init];
        [self.contentView addSubview:_myContentView];
    }
    return _myContentView;
}

-(WBContentView *)retweetContentView
{
    if (_retweetContentView == nil) {
        _retweetContentView = [[WBContentView alloc]init];
        [self.contentView addSubview:_retweetContentView];
    }
    return _retweetContentView;
}

@end

@interface WBContentView ()

@property (nonatomic,strong) YYLabel * contentLable;
@property (nonatomic,strong) WBImageContainerView * imageContainerView;

@end

@implementation WBContentView

-(void)setStatus:(WBStatus *)status
{
    _status = status;
    //文字内容
    self.contentLable.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        YYTextHighlight *highlight = [text attribute:YYTextHighlightAttributeName atIndex:range.location effectiveRange:NULL];
        //这里的info是在模型里面设置特殊文字颜色的时候加进去的
        NSDictionary *info = highlight.userInfo;
        WBRegexDataModel  * model = info[@"model"];
        HRLog(@"%@",model.content);
    };
    self.contentLable.textLayout = status.textLayout;
    self.contentLable.frame = CGRectMake(0, 0, kContentWidth, status.textHeight);
    
    //图片内容
    self.imageContainerView.status = status;
    self.imageContainerView.frame = CGRectMake(0, status.textHeight, kContentWidth, self.imageContainerView.contentHeight);
    
    self.frame = CGRectMake(kContentXOffsetX, 0, kContentWidth, status.textHeight + status.imageContainerHeight);
}

-(WBImageContainerView *)imageContainerView
{
    if (_imageContainerView == nil) {
        _imageContainerView = [[WBImageContainerView alloc]init];
        [self addSubview:_imageContainerView];
    }
    return _imageContainerView;
}

-(YYLabel *)contentLable
{
    if (_contentLable == nil) {
        _contentLable = [[YYLabel alloc]init];
        _contentLable.numberOfLines = 0;
        _contentLable.displaysAsynchronously = YES;
        _contentLable.ignoreCommonProperties = YES;
        _contentLable.fadeOnAsynchronouslyDisplay = NO;
        _contentLable.fadeOnHighlight = NO;
        [self addSubview:_contentLable];
    }
    return _contentLable;
}

@end


#import "LDGridView.h"
#import "UIImageView+WebCache.h"
@interface WBImageContainerView()
@property (nonatomic,strong) LDGridView * gridView;
@end

@implementation WBImageContainerView

-(void)setStatus:(WBStatus *)status
{
    _status = status;
    NSArray * pics = status.pics;
    [_gridView removeFromSuperview];
    if (pics.count <= 0) {
        self.contentHeight = 0;
        return;
    }
    NSInteger col = status.imageContainerCol(pics.count);
    self.frame = CGRectMake(0, 0, kContentWidth, 0);
    _gridView = [LDGridView configSubItemsIn:self count:pics.count col:col itemH:0 margin:kImageViewMargin startY:0 fetchItemAtIndex:^UIView *(NSInteger index) {
        WBPicture * picture = status.pics[index];
        UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_placeholder"]];
        [imageView sd_setImageWithURL:picture.large.url placeholderImage:[UIImage imageNamed:@"ic_placeholder"]];
        return imageView;
    }];
    _gridView.backgroundColor = RGBAlpha(10, 10, 10, 0.1);
}

@end
