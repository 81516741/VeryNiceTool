//
//  CZProductCell.m
//  网易彩票
//
//  Created by apple on 15-1-9.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZProductCell.h"
#import "LDProductModel.h"

@interface CZProductCell()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation CZProductCell

-(instancetype)initWithFrame:(CGRect)frame{
    NSLog(@"%s",__func__);
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}


-(id)initWithCoder:(NSCoder *)aDecoder{
        NSLog(@"%s",__func__);
    if (self = [super initWithCoder:aDecoder]) {

    }
    
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    // 剪切圆角
#warning awakeFormNid这个方法之后，连线才完成
    self.imgView.layer.cornerRadius = 15;
    self.imgView.layer.masksToBounds = YES;
}


-(void)setProduct:(LDProductModel *)product{
    _product = product;
    
    NSString * icon = [product.icon stringByReplacingOccurrencesOfString:@"@2x.png" withString:@""];
    
    //设置图片
    self.imgView.image = [UIImage imageNamed:icon];

    
    //设置产品的名称
    self.nameLabel.text = product.title;
}
@end
