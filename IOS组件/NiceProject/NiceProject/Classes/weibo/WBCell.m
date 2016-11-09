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
#import "UIView+hr_Extension.h"

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
    self.myContentView.worldsClick = self.worldsClick;
    self.myContentView.pictureClick = self.pictureClick;
    self.myContentView.status = status;
    //转发的微博内容
    if (status.retweetedStatus == nil) {
        self.retweetContentView.hidden = true;
        return;
    }
    self.retweetContentView.worldsClick = self.worldsClick;
    self.retweetContentView.pictureClick = self.pictureClick;
    self.retweetContentView.hidden = false;
    self.retweetContentView.status = status.retweetedStatus;
    self.retweetContentView.y = self.myContentView.height;
    self.retweetContentView.backgroundColor = RGBAlpha(10, 10, 10, 0.1);
    


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
    __weak typeof(self) selfWeak = self;
    self.frame = CGRectMake(0, 0, kScreenWidth, status.textHeight + status.imageContainerHeight);
    //文字内容
    self.contentLable.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
        YYTextHighlight *highlight = [text attribute:YYTextHighlightAttributeName atIndex:range.location effectiveRange:NULL];
        //这里的info是在模型里面设置特殊文字颜色的时候加进去的
        NSDictionary *info = highlight.userInfo;
        WBRegexDataModel  * model = info[@"model"];
        if (selfWeak.worldsClick) {
            selfWeak.worldsClick(model.content);
        }
        HRLog(@"%@",model.content);
    };
    self.contentLable.textLayout = status.textLayout;
    self.contentLable.frame = CGRectMake(kContentXOffsetX, 0, kContentWidth, status.textHeight);
    
    //图片内容
    self.imageContainerView.pictureClick = self.pictureClick;
    self.imageContainerView.status = status;
    self.imageContainerView.frame = CGRectMake(kContentXOffsetX, status.textHeight, kContentWidth, status.imageContainerHeight);
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
#import "UIImageView+hr_SDWeb.h"

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
    self.frame = CGRectMake(kContentXOffsetX, 0, kContentWidth, 0);
    __weak typeof(self) selfWeak = self;
    _gridView = [LDGridView configSubItemsIn:self count:pics.count col:col itemH:0 margin:kImageViewMargin startY:0 fetchItemAtIndex:^UIView *(NSInteger index) {
        WBPicture * picture = status.pics[index];
        UIImageView * imageView = [UIImageView hr_imageView:picture.large.url placeHolder:[UIImage imageNamed:@"ic_placeholder"] modes:@[NSRunLoopCommonModes]];
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds = YES;
        [imageView clickHandler:^(UIView *view) {
            NSMutableArray * picURLs = @[].mutableCopy;
            for (WBPicture * picture in status.pics) {
                [picURLs addObject:picture.large.url];
            }
            if (selfWeak.pictureClick) {
                selfWeak.pictureClick(picURLs,index);
            }
        }];
        return imageView;
    }];
    _gridView.backgroundColor = RGBAlpha(10, 10, 10, 0.1);
}

@end
